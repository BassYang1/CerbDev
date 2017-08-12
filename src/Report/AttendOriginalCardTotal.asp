<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<!--#include file="..\Report\ReportPage.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim page,rows,sidx,sord,isExport,strExportSql
dim strControllerId,strDepartmentId,strProperty,startTime,endTime,strEmployeeId
dim strYear,strMonth,strAttendMonth,strDate
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strEmployeeId = trim(request.QueryString("EmployeeId"))
strDepartmentId = trim(request.QueryString("DepartmentId"))
strshowAllRow = trim(request.QueryString("showAllRow"))

startTime = request.QueryString("startTime")
isExport = request.QueryString("isExport")

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "EmployeeId" end if
if sord = "" then sord ="asc" end if
if strEmployeeId="" then strEmployeeId = 0 end if

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

If startTime="" then 
	strYear=Year(Date)
	strMonth=Month(Date) 
else
	startTime = startTime & "-01"
	strYear=Year(startTime)
	strMonth=Month(startTime) 
end if
strAttendMonth = CStr(strYear) + "-" + CStr(strMonth)
If Len(strMonth) = 1 Then strAttendMonth = CStr(strYear) + "-0" + CStr(strMonth)
If Len(strMonth) = 1  Then strMonth = "0"+CStr(Trim(strMonth))

strWhere = ""
' 不要加 where 
if strEmployeeId <> "" then 	
	strWhere = " ( Employeeid in ("&strEmployeeId&") ) "
end if

fConnectADODB()

strSQL = "select Employees.Name,PersonalLeave,SickLeave,WorkDay_0,cast((WorkTime_0/60.0) as decimal(18,2)) as WorkTime_0 ,Absent,LateCount_0,LeaveEarlyCount_0,LateTime_0,LeaveEarlyTime_0,OtTime_0 from Employees,AttendanceTotal where  Employees.EmployeeId=AttendanceTotal.EmployeeId and AttendanceTotal.AttendMonth='"+Trim(strAttendMonth)+"' and Employees.EmployeeId="+Trim(strEmployeeId) 

'response.write strSQL

WorkDay_0=0
WorkTime_0=0
LateTime_0=0
LeaveEarlyTime_0=0
	
Rs.open strSQL, Conn, 1, 1
if NOT Rs.EOF then 

	If Not IsNull(Rs("WorkDay_0")) Then WorkDay_0=WorkDay_0+CDbl(Rs("WorkDay_0")) end If
	If Not IsNull(Rs("WorkTime_0")) Then WorkTime_0=WorkTime_0+CDbl(Rs("WorkTime_0")) end If
	If Not IsNull(Rs("LateTime_0")) Then LateTime_0=LateTime_0+CDbl(Rs("LateTime_0")) end If
	If Not IsNull(Rs("LeaveEarlyTime_0")) Then LeaveEarlyTime_0=LeaveEarlyTime_0+CDbl(Rs("LeaveEarlyTime_0")) end If
end if
Rs.close


fCloseADO()

%>
<div style='width: 100%;' class='ui-state-default ui-jqgrid-hdiv'>
  <div class='ui-jqgrid-hbox'>
    <table cellspacing='0' cellpadding='0' border='0' aria-labelledby='gbox_DataGrid_250_t' role='grid' style='width:100%' class='ui-jqgrid-htable'>
     <thead>
      <tr role='row' aria-hidden='true' class='jqg-first-row-header' style='height: auto;'>
       <th role='gridcell' style='height: 0px; width: 62px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 124px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 124px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 124px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 124px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 124px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 124px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 52px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 52px;' class='ui-first-th-ltr'></th>
       <th role='gridcell' style='height: 0px; width: 51px;' class='ui-first-th-ltr'></th></tr>
      <tr role='rowheader' class='ui-jqgrid-labels jqg-second-row-header'>
       <th role='columnheader' class='ui-state-default ui-th-column-header ui-th-ltr' style='border-top: 0px none;'></th>
       <th role='columnheader' class='ui-state-default ui-th-column-header ui-th-ltr' style='height: 22px; border-top: 0px none;' colspan='4'><%=GetReportLbl("WorkDay0")%><!--出勤天数: --><%=WorkDay_0%></th>
       <th role='columnheader' class='ui-state-default ui-th-column-header ui-th-ltr' style='height: 22px; border-top: 0px none;' colspan='6'><%=GetReportLbl("WorkTime0")%><!--总工时(H): --><%=WorkTime_0%></th>
       </tr>
       <tr role='rowheader' class='ui-jqgrid-labels jqg-second-row-header'>
       <th role='columnheader' class='ui-state-default ui-th-column-header ui-th-ltr' style='border-top: 0px none;'></th>
       <th role='columnheader' class='ui-state-default ui-th-column-header ui-th-ltr' style='height: 22px; border-top: 0px none;' colspan='4'><%=GetReportLbl("LateTime0")%><!--退到时间(M): --><%=LateTime_0%></th>
       <th role='columnheader' class='ui-state-default ui-th-column-header ui-th-ltr' style='height: 22px; border-top: 0px none;' colspan='6'><%=GetReportLbl("LeaveEarlyTime0")%><!--早退时间(M): --><%=LeaveEarlyTime_0%></th>
       </tr>
       <tr role='rowheader' class='ui-jqgrid-labels jqg-third-row-header jqg-second-row-header'></tr>
     </thead>
   </table>
 </div>
</div>
