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

Call fConnectADODB()

strDate = GetStartEndDate( strYear, strMonth)
strWhere = ""
' 不要加 where 
if strEmployeeId <> "" then 	
	strWhere = " ( Employeeid in ("&strEmployeeId&") ) "
end if

'server.ScriptTimeout=9000

dim a
set a=new JSONClass
'a.Sqlstring="select B.RecordID,D.DepartmentName,Name,Employees.Number,B.Card,CONVERT(Nvarchar(10),Brushtime,121) as Brushtime,CONVERT(Nvarchar(10),Brushtime,108) as Brushtime1,property from BrushCardAcs B left join Employees on (B.EmployeeId=Employees.EmployeeId or B.Card=Employees.Card) left join Departments D on Employees.DepartmentID = D.DepartmentID where B.RecordID>0 "&strWhere&" "&"order by "& sidx & " " & sord
a.Sqlstring="select DATEPART(dd ,OnDutyDate) as OnDutyDate1,(case Nobrushcard when 1 then (case Substring(OnDutyType, 1, 1) when '0' then '("+GetReportLbl("FreeCard")+")' else '' end)  else '' end) as Nobrushcard,ShiftName,convert(nvarchar(20),OnDuty1,120) as OnDuty1,convert(nvarchar(20),OffDuty1,120) as OffDuty1,convert(nvarchar(20),OnDuty2,120) as OnDuty2,convert(nvarchar(20),OffDuty2,120) as OffDuty2,convert(nvarchar(20),OnDuty3,120) as OnDuty3,convert(nvarchar(20),OffDuty3,120) as OffDuty3,(CASE WHEN ISNULL(SignInFlag, '000000') = '000000' THEN Result1 WHEN Result1 <> N'正常' THEN Result1 ELSE N'" + GetToolLbl("SignCard") + "' END) AS Remark,Result1,Result2,Result3,Result4,Result5,Result6,isnull(worktime,0) as worktime,LateTime1,LateTime2,LateTime3,(isnull(LateTime1,0)+isnull(LateTime2,0)+isnull(LateTime3,0)) as LateTime,LeaveEarlyTime1,LeaveEarlyTime2,LeaveEarlyTime3,(isnull(LeaveEarlyTime1,0)+isnull(LeaveEarlyTime2,0)+isnull(LeaveEarlyTime3,0)) as LeaveEarlyTime,Absent,SignInFlag,isnull(OTtime,0) as OTtime from AttendanceDetail where convert(varchar(10),OnDutyDate, 121) between "+Trim(strDate)+"  and Employeeid="+Trim(strEmployeeId)+"  order by OnDutyDate "


'response.write a.Sqlstring
'response.end

set a.dbconnection=conn

response.Write(a.GetJSon())
'end if

'conn.close()
'set conn = nothing
fCloseADO()
 
%>
