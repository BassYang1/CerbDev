<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<%
dim page,rows,sidx,sord,isExport
dim strControllerId,strDepartmentId,strProperty,startTime,endTime
dim strExportControllerid,strExportPeroperty,strExportWhere,strExportOrderby
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strControllerId = trim(request.QueryString("ControllerId"))
strDepartmentId = trim(request.QueryString("DepartmentId"))
strProperty = trim(request.QueryString("Property"))
if strDepartmentId = "" then strDepartmentId = "0" end if

startTime = request.QueryString("startTime")
endTime = request.QueryString("endTime")
isExport = request.QueryString("isExport")

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "RecordID" end if
if sord = "" then sord ="asc" end if
Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

strWhere = ""
strExportWhere=""
if startTime = "" then startTime = "1900-01-01" end if
if endTime = "" then endTime = "2050-01-01" end if

strWhere = strWhere & " BrushTime between '"&startTime&"' and '"&endTime&"' "

if strControllerId <> "" and strControllerId <> "0" then 	'0 为所有设备
	strWhere = strWhere & " and Controllerid in ("&strControllerId&") "
	strExportControllerid = strControllerId
else
	strExportControllerid = "-1"
end if

strSearchOn = request.QueryString("search")
If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")
	'If (strField = "ControllerId" Or strField = "ControllerNumber" Or strField = "ControllerName" Or strField = "Location" Or strField = "ServerIP" ) Then
	if strWhere = "" then 
		strWhere = " "
	else
		strWhere = strWhere & " and "
	end if
	strWhere = strWhere & GetSearchSQLWhereForReport(strField,strSearchOper,strFieldData)
	strExportWhere = " where "&GetSearchSQLWhereForReport(strField,strSearchOper,strFieldData)
	'取有访问权限的部门
	if strUserId<>"1" then '1 为admin用户
		strWhere = strWhere & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
		strExportWhere = strExportWhere & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if 	
Else

	if strDepartmentId = "0" then 	'0 我的记录  	-1 所有部门
		strWhere = strWhere & " and Employeeid in ("&session("EmId")&") "
		strExportWhere = " where Employeeid in ("&session("EmId")&") "
	elseif strDepartmentId = "-1" then 
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " and (DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			strWhere = strWhere & " or Employeeid in ("&session("EmId")&")  )"
			strExportWhere = " where (DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			strExportWhere = strExportWhere & " or Employeeid in ("&session("EmId")&")  )"
		end if 	
	else
		'strWhere = strWhere & " and DepartmentId in (select DepartmentID from departments where DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID='"&strDepartmentId&"')) "
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strWhere = strWhere & " and DepartmentId in ("&strDepartmentId&") "
		strExportWhere = " where DepartmentId in ("&strDepartmentId&") "
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			strExportWhere = strExportWhere & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
		end if 	
	end if

End If

'属性
strExportPeroperty=""
if strProperty <> "" and strProperty <> "-1" then 	'-1为所有非法属性
	strWhere = strWhere & " and Property in ("&strProperty&") "
	strExportPeroperty = " Property in ("&strProperty&") "
else
	strWhere = strWhere & " and Property > 0 " '所有非法
	strExportPeroperty = " Property > 0 " 
end if

'server.ScriptTimeout=9000
fConnectADODB()
dim a
set a=new JSONClass
'a.Sqlstring="select B.RecordID,D.DepartmentName,Name,Employees.Number,B.Card,CONVERT(Nvarchar(10),Brushtime,121) as Brushtime,CONVERT(Nvarchar(10),Brushtime,108) as Brushtime1,property from BrushCardAcs B left join Employees on (B.EmployeeId=Employees.EmployeeId or B.Card=Employees.Card) left join Departments D on Employees.DepartmentID = D.DepartmentID where B.RecordID>0 "&strWhere&" "&"order by "& sidx & " " & sord

set a.dbconnection=conn
Dim arr(11)
strSQL = " RecordID,DepartmentId,Name,Number,Card,CONVERT(CHAR(10),Brushtime,121) as Brushtime1,CONVERT(CHAR(10),Brushtime,108) as Brushtime2,Controllerid,Property,Door  "
if sidx = "DepartmentName" then 
	strOrderBy = "DepartmentId"
	strExportOrderby = "DepartmentId"
elseif sidx = "Location" then 
	strOrderBy = "Controllerid"
	strExportOrderby = "Controllerid"
elseif sidx = "Brushtime1" then 
	strOrderBy = "Brushtime"
	strExportOrderby = "Brushtime1"
elseif sidx = "Brushtime2" then 
	strOrderBy = "Brushtime2"
	strExportOrderby = "Brushtime2"
else
	strOrderBy = sidx
	strExportOrderby = sidx
end if

if sidx = "RecordID" or sidx = "DepartmentName" or sidx = "Location" then 
	strOrderType = "int"
elseif sidx = "Card" then 
	strOrderType = "bigint"
else 
	strOrderType = "Varchar"
end if

if sord = "asc" then 
	orderType = 0	'0升序列 asc，1降序 desc
else
	orderType = 1	'0升序列 asc，1降序 desc
end if
strCondition=strWhere
'JSON显示的字段及顺序
strShowField = " TB.RecordID,D.DepartmentName,TB.Name,TB.Number,TB.Card,"
strShowField = strShowField & "C.location+(Case TB.Door When '1' Then (Case when C.CardReader1 is not null then '('+isnull(ltrim(C.DoorLocation1),'')+ ','+isnull(ltrim(substring(C.CardReader1,charindex('-',C.CardReader1)+1,len(C.CardReader1))),'') +')' else '' end) "
strShowField = strShowField & "when '2' then ((Case when C.CardReader2 is not null then '('+(case isnull(ltrim(left(C.DoorType,1)),'') when '0' then isnull(ltrim(C.DoorLocation1),'') else isnull(ltrim(C.DoorLocation2),'') end )+','+isnull(ltrim(substring(C.CardReader2,charindex('-',C.CardReader2)+1,len(C.CardReader2))),'') +')' else '' end)) else '' end) as location "
strShowField = strShowField & ",TB.Brushtime1,TB.Brushtime2,TB.Property "
'分页后再与其它表关联
strJoinTable = " left join Controllers C on TB.Controllerid = C.ControllerId left Join Departments D on TB.DepartmentID=D.DepartmentID "		
arr(0) = "V_BrushCardACS_Illegal" 	'@tblName
arr(1) = "RecordID"					'@fldName
arr(2) = strSQL						'@listFldName
arr(3) = strOrderBy					'@orderFldName
arr(4) = strOrderType					'@orderFldType
arr(5) = rows							'@PageSize
arr(6) = page						'@PageIndex
arr(7) = orderType						'@OrderType
arr(8) = strCondition					'@strWhere
arr(9) = strShowField						'@strShowField
arr(10) = strJoinTable						'@strJoinTable

'Response.Cookies("ExportData")=strExportSql
strExportWhere=strExportWhere&" Order by "&strExportOrderby&" "&sord
Session("exportdata")="acsillegal|6|"&startTime&"|"&endtime&"|"&strExportControllerid&"|"&strExportPeroperty&"|"&strExportWhere&"|"&"BrushCardACS"

response.Write(a.GetJSONByProc("dbo.pPagePROCTables",arr,11))
'end if

'conn.close()
'set conn = nothing
fCloseADO()

%>
