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
strSearchOn = request.QueryString("search")

If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")
	'If (strField = "ControllerId" Or strField = "ControllerNumber" Or strField = "ControllerName" Or strField = "Location" Or strField = "ServerIP" ) Then
	if strWhere = "" then 
		strWhere = "where "
	else
		strWhere = strWhere & " and "
	end if
	strWhere = strWhere & GetSearchSQLWhere(strField,strSearchOper,strFieldData)
	'取有访问权限的部门
	if strUserId<>"1" then '1 为admin用户
		strWhere = strWhere & " and E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if 
	strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
ELSE

	if strDepartmentId = "0" then	'0 我的记录  	-1 所有部门
		strWhere = strWhere & " where E.Employeeid in ("&session("EmId")&") "
		strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
	elseif strDepartmentId = "-1" then 
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strWhere = strWhere & " where (E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			strWhere = strWhere & " or  E.Employeeid in ("&session("EmId")&") ) "
			strWhere = strWhere & " and Left(IncumbencyStatus,1)<>'1' "
		else
			strWhere = strWhere & " where Left(IncumbencyStatus,1)<>'1' "
		end if 	
	else
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strWhere = strWhere & " where D.DepartmentId in ("&strDepartmentId&") "
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
a.Sqlstring="select A.EmployeeId,D.DepartmentName,E.Name,E.Number,AttendMonth,(CASE WHEN IsNull(WorkDay_0, 0)>0 then (CASE WHEN CAST(ISNULL(WorkDay_0,0) AS INT)=WorkDay_0 Then ltrim(str(IsNull(WorkDay_0, 0)))  ElSE ltrim(str(IsNull(WorkDay_0, 0),10,2)) END)  else '' end) as WorkDay_01,(Case when Cast(IsNull(WorkTime_0, 0) as int) / 60>0  then ltrim(str(Cast(IsNull(WorkTime_0, 0) as int) / 60))+'"&GetReportLbl("Hour")&"' else '' end +Case when Cast(IsNull(WorkTime_0, 0) as int) % 60>0  then ltrim(str(Cast(IsNull(WorkTime_0, 0) as int) % 60))+'"&GetReportLbl("Minute")&"' else '' end) as WorkTime_01 ,(Case when Cast(IsNull(LateCount_0, 0) as int)>0  then ltrim(str(Cast(IsNull(LateCount_0, 0) as int))) else '' end ) as LateCount_01,(Case when Cast(IsNull(LateTime_0, 0) as int) / 60>0  then ltrim(str(Cast(IsNull(LateTime_0, 0) as int) / 60))+'"&GetReportLbl("Hour")&"' else '' end +Case when Cast(IsNull(LateTime_0, 0) as int) % 60>0  then ltrim(str(Cast(IsNull(LateTime_0, 0) as int) % 60))+'"&GetReportLbl("Minute")&"' else '' end) as LateTime_01 ,(Case when Cast(IsNull(LeaveEarlyCount_0, 0) as int)>0  then ltrim(str(Cast(IsNull(LeaveEarlyCount_0, 0) as int))) else '' end ) as LeaveEarlyCount_01,(Case when Cast(IsNull(LeaveEarlyTime_0, 0) as int) / 60>0  then ltrim(str(Cast(IsNull(LeaveEarlyTime_0, 0) as int) / 60))+'"&GetReportLbl("Hour")&"' else '' end +Case when Cast(IsNull(LeaveEarlyTime_0, 0) as int) % 60>0  then ltrim(str(Cast(IsNull(LeaveEarlyTime_0, 0) as int) % 60))+'"&GetReportLbl("Minute")&"' else '' end) as LeaveEarlyTime_01 ,(Case when Cast(IsNull(AbnormityCount_0, 0) as int)>0  then ltrim(str(Cast(IsNull(AbnormityCount_0, 0) as int))) else '' end ) as AbnormityCount_01  from AttendanceTotal A INNER join Employees E ON A.EmployeeId=E.EmployeeId Left Join Departments D ON E.DepartmentId=D.DepartmentId "&strWhere&" "&"order by "& sidx & " " & sord

''导出SQL语句 去掉EmployeeId      else后的'' 改为' '  否则为0的数据导出时会显示0
strExportSql = "select D.DepartmentName,E.Name,E.Number,AttendMonth,(CASE WHEN IsNull(WorkDay_0, 0)>0 then (CASE WHEN CAST(ISNULL(WorkDay_0,0) AS INT)=WorkDay_0 Then ltrim(str(IsNull(WorkDay_0, 0)))  ElSE ltrim(str(IsNull(WorkDay_0, 0),10,2)) END)  else ' ' end) as WorkDay_01,(Case when Cast(IsNull(WorkTime_0, 0) as int) / 60>0  then ltrim(str(Cast(IsNull(WorkTime_0, 0) as int) / 60))+'"&GetReportLbl("Hour")&"' else ' ' end +Case when Cast(IsNull(WorkTime_0, 0) as int) % 60>0  then ltrim(str(Cast(IsNull(WorkTime_0, 0) as int) % 60))+'"&GetReportLbl("Minute")&"' else ' ' end) as WorkTime_01 ,(Case when Cast(IsNull(LateCount_0, 0) as int)>0  then ltrim(str(Cast(IsNull(LateCount_0, 0) as int))) else ' ' end ) as LateCount_01,(Case when Cast(IsNull(LateTime_0, 0) as int) / 60>0  then ltrim(str(Cast(IsNull(LateTime_0, 0) as int) / 60))+'"&GetReportLbl("Hour")&"' else ' ' end +Case when Cast(IsNull(LateTime_0, 0) as int) % 60>0  then ltrim(str(Cast(IsNull(LateTime_0, 0) as int) % 60))+'"&GetReportLbl("Minute")&"' else ' ' end) as LateTime_01 ,(Case when Cast(IsNull(LeaveEarlyCount_0, 0) as int)>0  then ltrim(str(Cast(IsNull(LeaveEarlyCount_0, 0) as int))) else ' ' end ) as LeaveEarlyCount_01,(Case when Cast(IsNull(LeaveEarlyTime_0, 0) as int) / 60>0  then ltrim(str(Cast(IsNull(LeaveEarlyTime_0, 0) as int) / 60))+'"&GetReportLbl("Hour")&"' else ' ' end +Case when Cast(IsNull(LeaveEarlyTime_0, 0) as int) % 60>0  then ltrim(str(Cast(IsNull(LeaveEarlyTime_0, 0) as int) % 60))+'"&GetReportLbl("Minute")&"' else ' ' end) as LeaveEarlyTime_01 ,(Case when Cast(IsNull(AbnormityCount_0, 0) as int)>0  then ltrim(str(Cast(IsNull(AbnormityCount_0, 0) as int))) else ' ' end ) as AbnormityCount_01  from AttendanceTotal A INNER join Employees E ON A.EmployeeId=E.EmployeeId Left Join Departments D ON E.DepartmentId=D.DepartmentId "&strWhere&" "&"order by "& sidx & " " & sord


set a.dbconnection=conn

Session("exportdata")=strExportSql

response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
