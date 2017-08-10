<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<!--#include file="..\Report\ReportPage.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim page,rows,sidx,sord,isExport,strExportSql
dim strDate, strDeptId
dim strSQL, strDeptsSQL, strTemp, strLeave

page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")

strDate = trim( Request.QueryString("startTime") )       '时间
strDeptId = trim( Request.QueryString("deptId") )       '部门编号
strLink = trim( Request.QueryString("detailLink") )       '数据类型

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "EmployeeId" end if
if sord = "" then sord ="asc" end if

if strLink = "" or strDeptId = "" Or strDate = "" then
	response.write ""
	response.end
end If

dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

fConnectADODB()

strDeptsSQL = "select D1.DepartmentId from Departments D1, Departments D2 where D1.DepartmentCode LIKE D2.DepartmentCode + '%' and D2.DepartmentId=" & strDeptId 
if strUserId<>"1" then '1 为admin用户
	strDeptsSQL = strDeptsSQL + " and D2.DepartmentId in (select DepartmentId from RoleDepartment where UserId in (" & strUserId &") and Permission=1)"
end if 	

dim strTypeDesc, arrDesc
'年假,事假,病假,工伤,婚假,产假,出差,丧假,补假,法定假,其它假,哺乳假,探亲假'
strTypeDesc = GetReportLbl("AttTodayDetail_Leave_Type")
arrDesc=Split(strTypeDesc,",")

if strLink = "1" then '// 获取实际上班人员	
	strSQL = "select e.EmployeeId, Name, Sex, Number, e.Card, Headship, (Select top 1 BrushTime From BrushCardAttend Where Employeeid=E.employeeid and Convert(varchar(10),BrushTime,121)='"+Trim(strDate)+"') as BrushTime from Employees E where EmployeeId in(select EmployeeId from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=1) and OnDutyDate='"+Trim(strDate)+"' and (OnDuty1<>'' or OffDuty1<>'') union all select EmployeeId from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=2) and OnDutyDate='"+Trim(strDate)+"' and (OnDuty1<>'' or OffDuty1<>'' or OnDuty2<>'' or OffDuty2<>'')  union all select EmployeeId from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=3) and OnDutyDate='"+Trim(strDate)+"' and  (OnDuty1<>'' or OffDuty1<>'' or OnDuty2<>'' or OffDuty2<>'' or OnDuty3<>'' or OffDuty3<>'')) and DepartmentId in ("+strDeptsSQL+") and IncumbencyStatus <> '1' "
elseif strLink = "2" then '// 获取请假人员报表	
	strSQL="select Employees.EmployeeId, Employees.Name, Employees.Sex, Employees.Number, Employees.Card, Employees.Headship, Employees.JoinDate,(case when isnull(A.AnnualVacation, 0) > 0 then '" + arrDesc(0) + "' when isnull(A.PersonalLeave, 0) > 0 then '" + arrDesc(1) + "' when isnull(A.SickLeave, 0) > 0 then '" + arrDesc(2) + "' when isnull(A.InjuryLeave, 0) > 0 then '" + arrDesc(3) + "' when isnull(A.WeddingLeave, 0) > 0 then '" + arrDesc(4) + " 'when isnull(A.MaternityLeave, 0) > 0 then '" + arrDesc(5) + "' when isnull(A.OnTrip, 0) > 0 then '" + arrDesc(6) + "' when isnull(A.OnTrip, 0) > 0 then '" + arrDesc(6) + "' when isnull(A.FuneralLeave, 0) > 0 then '" + arrDesc(7) + "' when isnull(A.CompensatoryLeave, 0) > 0 then '" + arrDesc(8) + "' when isnull(A.PublicHoliday, 0) > 0 then '" + arrDesc(9) + "' when isnull(A.OtherLeave, 0) > 0 then '" + arrDesc(10) + "' when isnull(A.LactationLeave, 0) > 0 then '" + arrDesc(11) + "' when isnull(A.VisitLeave, 0) > 0 then '" + arrDesc(12) + "' ELSE '' END) AS LeaveType from Employees,AttendanceDetail A where Employees.EmployeeId=A.EmployeeId and A.OnDutyDate='"+Trim(strDate)+"' and Employees.DepartmentId in ("+strDeptsSQL+") and Employees.IncumbencyStatus <> '1' and LeaveType <> '' order by Employees.EmployeeId"
elseif strLink = "3" then '// 获取未上班人员报表	
	strSQL="select EmployeeId, Name, Sex, Card, Number, Headship, JoinDate from Employees where EmployeeId in (select EmployeeId from AttendanceDetail where Absent>0 and OnDutyDate='"+Trim(strDate)+"' ) and DepartmentId in ("+strDeptsSQL+") and IncumbencyStatus <> '1'"
elseif strLink = "4" then '// 获取迟到人员报表	
	strSQL = "select E.EmployeeId, Name, Sex, E.Card, Number, Headship, JoinDate,(Select top 1 BrushTime From BrushCardAttend Where Employeeid=E.employeeid and Convert(varchar(10),BrushTime,121)='"+Trim(strDate)+"') as BrushTime from Employees E  where E.EmployeeId in (select EmployeeId from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=1) and OnDutyDate='"+Trim(strDate)+"' and LateTime1>0 union all select EmployeeId from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=2) and OnDutyDate='"+Trim(strDate)+"' and (LateTime1>0 or LateTime2>0)  union all select EmployeeId from AttendanceDetail where ShiftName in (select ShiftName from AttendanceShifts where Degree=3) and OnDutyDate='"+Trim(strDate)+"' and  (LateTime1>0 or LateTime2>0 or LateTime3>0)) and DepartmentId in ("+strDeptsSQL+") and IncumbencyStatus <> '1'"

end if

'response.write strSQL
'response.end

if strSQL <> "" then		
	dim a
	set a=new JSONClass
	a.Sqlstring = strSQL
	set a.dbconnection=conn
	response.Write(a.GetJSon())
end if

fCloseADO()
%>
