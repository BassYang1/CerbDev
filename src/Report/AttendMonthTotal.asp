<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<!--#include file="..\Report\ReportPage.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim page,rows,sidx,sord,isExport,strExportSql
dim strControllerId,strDepartmentId,strProperty,strshowAllRow,startTime
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

strAttendMonth = startTime
isExport = request.QueryString("isExport")

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "Rpt.EmployeeId" end if
if sord = "" then sord ="asc" end if
sidx = "Rpt.EmployeeId"


dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

fConnectADODB()

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
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

'server.ScriptTimeout=9000

dim days, cols
cols = ""
for i = 1 to 31              '  31
	cols = cols + "day" + CStr(i) + ","
next

cols = left(cols, len(cols) - 1)

'OnDutyType: 0-平常,1-休息,2-假日'
dim a
set a=new JSONClass
a.Sqlstring="SELECT Rpt.*, WorkDay_0, (SELECT COUNT(EmployeeId) FROM AttendanceDetail WHERE CONVERT(NVARCHAR(10), OnDutyDate, 121) LIKE '" + strAttendMonth + "%' AND EmployeeId = T.EmployeeId AND LEFT(ISNULL(OnDutyType, ''), 1) = '0') AS WorkDay_1 FROM (SELECT E.EmployeeId, E.Name, 'Day' + CAST(DAY(ISNULL(OnDutyDate, NULL)) AS NVARCHAR(2)) AS DateDay, ISNULL(CONVERT(NVARCHAR(5), D.OnDuty1, 108) + ',' + CONVERT(NVARCHAR(5), D.OffDuty1, 108), NULL) AS OndudyTime FROM Employees E, AttendanceDetail D " + strWhere + " AND E.EmployeeId = D.EmployeeId AND CONVERT(NVARCHAR(10), D.OnDutyDate, 121) LIKE '" + strAttendMonth + "%') Dt PIVOT(MAX(OndudyTime) FOR DateDay IN (Io," + cols + ")) Rpt, AttendanceTotal T WHERE Rpt.EmployeeId = T.EmployeeId AND T.AttendMonth = '" + strAttendMonth + "' order by " + sidx+  " " + sord

'response.write a.Sqlstring
'response.end

''导出SQL语句 去掉EmployeeId      else后的'' 改为' '  否则为0的数据导出时会显示0
days = request.QueryString("days")
strExportSql = "SELECT Rpt.EmployeeId,Name, '" + GetReportLbl("R_P_Io") + "' AS Io, " + cols + ", WorkDay_0, (SELECT COUNT(EmployeeId) FROM AttendanceDetail WHERE CONVERT(NVARCHAR(10), OnDutyDate, 121) LIKE '" + strAttendMonth + "%' AND EmployeeId = T.EmployeeId AND LEFT(ISNULL(OnDutyType, ''), 1) = '0') AS WorkDay_1 FROM (SELECT E.EmployeeId, E.Name, 'Day' + CAST(DAY(ISNULL(OnDutyDate, NULL)) AS NVARCHAR(2)) AS DateDay, ISNULL(CONVERT(NVARCHAR(5), D.OnDuty1, 108) + ',' + CONVERT(NVARCHAR(5), D.OffDuty1, 108), NULL) AS OndudyTime FROM Employees E, AttendanceDetail D " + strWhere + " AND E.EmployeeId = D.EmployeeId AND CONVERT(NVARCHAR(10), D.OnDutyDate, 121) LIKE '" + strAttendMonth + "%') Dt PIVOT(MAX(OndudyTime) FOR DateDay IN (Io," + cols + ")) Rpt, AttendanceTotal T WHERE Rpt.EmployeeId = T.EmployeeId AND T.AttendMonth = '" + strAttendMonth + "' order by " + sidx+  " " + sord


'response.write strExportSql
'response.end

set a.dbconnection=conn

Session("exportdata")=strExportSql

response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
