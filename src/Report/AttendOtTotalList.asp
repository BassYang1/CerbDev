<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<!--#include file="..\Report\ReportPage.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim page,rows,sidx,sord,isExport,strExportSql
dim strControllerId,strDepartmentId,strProperty,strshowAllRow,startTime,endTime
dim strYear,strMonth,strAttendMonth,strDate
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strDepartmentId = trim(request.QueryString("DepartmentId"))
strshowAllRow = trim(request.QueryString("showAllRow"))

startTime = request.QueryString("_startTime")
if trim(startTime)="" then 
	startTime = request.QueryString("startTime")
end if

isExport = request.QueryString("isExport")

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "EmployeeId" end if
if sord = "" then sord ="asc" end if
if sidx = "DepartmentID" then sidx = "E.DepartmentID" end if
if sidx = "EmployeeId" then sidx = "E.EmployeeId" end if
Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

strAttendMonth = startTime

fConnectADODB()

strWhere = ""
strSearchOn = request.QueryString("_search")

If (strSearchOn = "true") Then

	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")

	If strField = "Name" OR strField = "Number" Then
		strField = "E."&strField
		strWhere = " where " & strField
		Select Case strSearchOper
			Case "eq" : 'Equal
				strWhere = strWhere & " = '" & strFieldData & "'"
			Case "ne": 'Not Equal
				strWhere = strWhere & " <> '"& strFieldData &"'"
			Case "cn" : 'Contains
				strWhere = strWhere & " LIKE '%" & strFieldData & "%'"
			Case "nc" : 'Contains
				strWhere = strWhere & " NOT LIKE '%" & strFieldData & "%'"
		End Select
	End if

	if strWhere = "" then 
		strWhere = "where "
	else
		strWhere = strWhere & " and "
	end if
	
	'取有访问权限的部门
	if strUserId<>"1" then '1 为admin用户
		strWhere = strWhere & " E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) and "
	end if 
	strWhere = strWhere & " Left(IncumbencyStatus,1)<>'1' "
ELSE

	if strDepartmentId = "0" then	'0 我的记录  	-1 所有部门
		strWhere = " where E.Employeeid in ("&session("EmId")&") "
		strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
	elseif strDepartmentId = "-1" then 
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = " where (E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			strWhere = strWhere & " or  E.Employeeid in ("&session("EmId")&") ) "
			strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
		else
			strWhere = " where Left(IncumbencyStatus,1)<>'1' "
		end if 	
	else
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strWhere = " where D.DepartmentId in ("&strDepartmentId&") "
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " and E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
		end if 
		strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
	end if

End If

'统计月份
if strAttendMonth<>"" then 
	if strWhere = "" then 
		strWhere = "where "
	else
		strWhere = strWhere & " and "
	end if
	strWhere = strWhere & " AttendMonth='"+strAttendMonth+"' "
end if
'server.ScriptTimeout=9000
dim a
set a=new JSONClass
a.Sqlstring="SELECT AttendMonth,D.DepartmentName,E.EmployeeId,E.Name,E.Number,OtTime_0, (SELECT COUNT(1) FROM AttendanceDetail WHERE EmployeeId = E.EmployeeId and AttendMonth = A.AttendMonth and OtTime > 0) AS TotalCount, WorkTime_1,WorkTime_2 from AttendanceTotal A INNER join Employees E ON A.EmployeeId=E.EmployeeId Left Join Departments D ON E.DepartmentId=D.DepartmentId "&strWhere&" "&"order by "& sidx & " " & sord

''导出SQL语句 去掉EmployeeId      else后的'' 改为' '  否则为0的数据导出时会显示0
strExportSql = "SELECT AttendMonth,D.DepartmentName,E.Name,E.Number,OtTime_0, (SELECT COUNT(1) FROM AttendanceDetail WHERE EmployeeId = E.EmployeeId and AttendMonth = A.AttendMonth and OtTime > 0) AS TotalCount, WorkTime_1,WorkTime_2 from AttendanceTotal A INNER join Employees E ON A.EmployeeId=E.EmployeeId Left Join Departments D ON E.DepartmentId=D.DepartmentId "&strWhere&" "&"order by "& sidx & " " & sord


'response.write a.Sqlstring
'response.end

set a.dbconnection=conn

Session("exportdata")=strExportSql

response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
