<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<%
dim page,rows,sidx,sord,isExport
dim strControllerId,strDepartmentId,strProperty,startTime,endTime
dim strExportControllerid,strExportPeroperty,strExportWhere,strExportOrderby,strExportSQL
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strControllerId = trim(request.QueryString("ControllerId"))
strDepartmentId = trim(request.QueryString("DepartmentId"))
strProperty = trim(request.QueryString("Property"))

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
strExportWhere=" where "
if startTime = "" then startTime = "1900-01-01" end if
if endTime = "" then endTime = "2050-01-01" end if

strWhere = strWhere & " OccurTime between '"&startTime&"' and '"&endTime&"' "
strExportWhere = strExportWhere & " OccurTime between '"&startTime&"' and '"&endTime&"' "

if strControllerId <> "" and strControllerId <> "0" then 	'0 为所有设备
	strWhere = strWhere & " and Controllerid in ("&strControllerId&") "
	strExportWhere = strExportWhere & " and TB.Controllerid in ("&strControllerId&") "
end if

'取有访问权限的设备
'if strUserId<>"1" then '1 为admin用户
'	strWhere = strWhere & " and Controllerid in (select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 ) "
'	strExportWhere = strExportWhere & " and TB.Controllerid in (select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 ) "
'end if 

'server.ScriptTimeout=9000
fConnectADODB()
dim a
set a=new JSONClass
'a.Sqlstring="select B.RecordID,D.DepartmentName,Name,Employees.Number,B.Card,CONVERT(Nvarchar(10),Brushtime,121) as Brushtime,CONVERT(Nvarchar(10),Brushtime,108) as Brushtime1,property from BrushCardAcs B left join Employees on (B.EmployeeId=Employees.EmployeeId or B.Card=Employees.Card) left join Departments D on Employees.DepartmentID = D.DepartmentID where B.RecordID>0 "&strWhere&" "&"order by "& sidx & " " & sord

set a.dbconnection=conn
Dim arr(11)
strSQL = " RecordID,Controllerid,InputPoint,CONVERT(CHAR(10),OccurTime,121) as OccurTime1,CONVERT(CHAR(10),OccurTime,108) as OccurTime2  "
if sidx = "Location" then 
	strOrderBy = "Controllerid"
	strExportOrderby = "TB.Controllerid"
elseif sidx = "OccurTime1" then 
	strOrderBy = "OccurTime"
	strExportOrderby = "OccurTime1"
elseif sidx = "OccurTime2" then 
	strOrderBy = "OccurTime2"
	strExportOrderby = "OccurTime2"
else
	strOrderBy = sidx
	strExportOrderby = sidx
end if

if sidx = "RecordID" or sidx = "InputPoint" or sidx = "Location" then 
	strOrderType = "int"
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
strShowField = " TB.RecordID,C.location,TB.InputPoint"
strShowField = strShowField & ",TB.OccurTime1,TB.OccurTime2 "
'分页后再与其它表关联
strJoinTable = " left join Controllers C on TB.Controllerid = C.ControllerId  "		
arr(0) = "V_EventRecord" 	'@tblName
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
strExportSQL = "select C.location,TB.InputPoint,CONVERT(CHAR(10),OccurTime,121) as OccurTime1,CONVERT(CHAR(10),OccurTime,108) as OccurTime2 From EventRecord TB LEFT JOIN Controllers C ON TB.ControllerId=C.ControllerId "
strExportSQL=strExportSQL & strExportWhere&" Order by "&strExportOrderby&" "&sord
Session("exportdata")=strExportSQL

response.Write(a.GetJSONByProc("dbo.pPagePROCTables",arr,11))
'end if

'conn.close()
'set conn = nothing
fCloseADO()

%>
