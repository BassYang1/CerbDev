<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<!--#include file="..\Report\ReportPage.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim page,rows,sidx,sord,isExport,strExportSql
dim strControllerId,strDepartmentId,strProperty,strshowAllRow,startTime,endTime
dim strSQL, strField1, strField2, strField3, strField4, strField5, strField6, strField7
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
if sidx = "" then sidx = "DepartmentID" end if
if sord = "" then sord ="asc" end if
Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere, strUserDepts
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

strAttendMonth = startTime

fConnectADODB()

strWhere = ""
strUserDepts = "select DepartmentId from Departments where 1 > 0 "
if strUserId<>"1" then '1 为admin用户
	strUserDepts = " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1) "
end if 	

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
	strWhere = strWhere & " and DepartmentId in (" + strUserDepts + ") "
ELSE
	if strDepartmentId = "-1" then
		strWhere = strWhere & " where DepartmentId in ("&strUserDepts&") "
	else
		strWhere = strWhere & " where DepartmentId in ("&strDepartmentId&") "
		strWhere = strWhere & " and DepartmentId in (" + strUserDepts + ") "
	end if

End If

dim a
set a=new JSONClass
strField1 = ",(select count(1) from Employees where DepartmentId in (" + strUserDepts + " and DepartmentCode like Dept.DepartmentCode+'%') and IncumbencyStatus <> '1') as 'EmpCount'"
strField2 = ",(select count(1) from (select EmployeeId,OnDutyDate from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=1) and (OnDuty1<>''or OffDuty1<>'') union all select EmployeeId,OnDutyDate from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=2) and (OnDuty1<>'' or OffDuty1<>'' or OnDuty2<>'' or OffDuty2<>'')  union all select EmployeeId,OnDutyDate from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=3) and  (OnDuty1<>'' or OffDuty1<>'' or OnDuty2<>'' or OffDuty2<>'' or OnDuty3<>'' or OffDuty3<>'')) as A where A.OnDutyDate='"+Trim(strAttendMonth)+"' and A.EmployeeId in (select EmployeeId from Employees where DepartmentId in (" + strUserDepts + " and DepartmentCode like Dept.DepartmentCode+'%') and IncumbencyStatus <> '1')) as 'EmpTodayCount'"
strField3 = ",(select count(1) from (select EmployeeId,OnDutyDate from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=1) and LateTime1>0 union all select EmployeeId,OnDutyDate from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=2) and (LateTime1>0 or LateTime2>0)  union all select EmployeeId,OnDutyDate from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=3) and  (LateTime1>0 or LateTime2>0 or LateTime3>0)) as A where A.OnDutyDate='"+Trim(strAttendMonth)+"' and A.EmployeeId in (select EmployeeId from Employees where DepartmentId in (" + strUserDepts + " and DepartmentCode like Dept.DepartmentCode+'%') and IncumbencyStatus <> '1')) as 'LateCount'"
strField4 = ",(select count(1) from AttendanceDetail where PersonalLeave>0 and EmployeeId in (select EmployeeId from Employees where DepartmentId in (" + strUserDepts + " and DepartmentCode like Dept.DepartmentCode+'%') and IncumbencyStatus <> '1') and OnDutyDate='"+Trim(strAttendMonth)+"') as 'PrivateCount'"
strField5 = ",(select count(1) from AttendanceDetail where SickLeave>0 and EmployeeId in (select EmployeeId from Employees where DepartmentId in (" + strUserDepts + " and DepartmentCode like Dept.DepartmentCode+'%') and IncumbencyStatus <> '1') and OnDutyDate='"+Trim(strAttendMonth)+"') as 'SickCount'"
strField6 = ",( select count(1) from AttendanceDetail where OnTrip>0 and EmployeeId in (select EmployeeId from Employees where DepartmentId in (" + strUserDepts + " and DepartmentCode like Dept.DepartmentCode+'%') and IncumbencyStatus <> '1') and OnDutyDate='"+Trim(strAttendMonth)+"') as 'TripCount'"
strField7 = ",( select count(1) from AttendanceDetail where (AnnualVacation > 0 or InjuryLeave > 0 or WeddingLeave > 0 or MaternityLeave > 0 or FuneralLeave > 0 or CompensatoryLeave > 0 or PublicHoliday > 0 or OtherLeave > 0 or VisitLeave > 0 or LactationLeave > 0) and EmployeeId in (select EmployeeId from Employees where DepartmentId in (" + strUserDepts + " and DepartmentCode like Dept.DepartmentCode+'%') and IncumbencyStatus <> '1') and OnDutyDate='"+Trim(strAttendMonth)+"') as 'OtherCount'"
strField8 = ",(select count(1) from AttendanceDetail where Absent>0 and nobrushcard !=1 and  EmployeeId in (select EmployeeId from Employees where DepartmentId in (" + strUserDepts + " and DepartmentCode like Dept.DepartmentCode+'%') and IncumbencyStatus <> '1') and OnDutyDate='"+Trim(strAttendMonth)+"') as 'AbsCount'"

strSQL = "select Dept.DepartmentId,Dept.DepartmentName " + cstr(strField1)+cstr(strField2)+cstr(strField3)+cstr(strField4)+cstr(strField5)+cstr(strField6)+cstr(strField7)+CStr(strField8)+" from (select DepartmentId,DepartmentCode,DepartmentName from Departments " + strWhere + ") as Dept order by "+ sidx + " " + sord

'response.write strSQL
'response.end

a.Sqlstring=strSQL

''导出SQL语句 去掉EmployeeId      else后的'' 改为' '  否则为0的数据导出时会显示0
strExportSql = strSQL


set a.dbconnection=conn

Session("exportdata")="select Dept.DepartmentName " + cstr(strField1)+cstr(strField2)+cstr(strField3)+cstr(strField4)+cstr(strField5)+cstr(strField6)+cstr(strField7)+CStr(strField8)+" from (select DepartmentId,DepartmentCode,DepartmentName from Departments where DepartmentId in (" + strUserDepts + ")) as Dept order by "+ sidx + " " + sord

response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>

