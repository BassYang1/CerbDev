<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Equipment\SearchExec.asp" -->
<%
dim page,rows,sidx,sord,isExport,strExportSql
dim strControllerId,strDepartmentId,strProperty,startTime,endTime,strEmployeeId
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
strEmployeeId = trim(request.QueryString("EmployeeId"))
strDepartmentId = trim(request.QueryString("DepartmentId"))
strshowAllRow = trim(request.QueryString("showAllRow"))

startTime = request.QueryString("startTime")
endTime = request.QueryString("endTime")
isExport = request.QueryString("isExport")

if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "EmployeeId" end if
if sord = "" then sord ="asc" end if
Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

strWhere = ""
' 不要加 where 
if strEmployeeId <> "" then 	
	strWhere = " ( Employeeid in ("&strEmployeeId&") or (Card in (select Card from Employees where Employeeid in ("&strEmployeeId&")) and property <> '0' ) ) "
end if

endTime = endTime & " 23:59:59"

'server.ScriptTimeout=9000
fConnectADODB()
dim a
set a=new JSONClass
'a.Sqlstring="select B.RecordID,D.DepartmentName,Name,Employees.Number,B.Card,CONVERT(Nvarchar(10),Brushtime,121) as Brushtime,CONVERT(Nvarchar(10),Brushtime,108) as Brushtime1,property from BrushCardAcs B left join Employees on (B.EmployeeId=Employees.EmployeeId or B.Card=Employees.Card) left join Departments D on Employees.DepartmentID = D.DepartmentID where B.RecordID>0 "&strWhere&" "&"order by "& sidx & " " & sord

set a.dbconnection=conn
Dim arr(4)
arr(0) = startTime	 		'@startTime
arr(1) = endTime			'@endTime
arr(2) = strshowAllRow				'@showAllRow
arr(3) = strWhere			'@strWhere

'Response.Cookies("ExportData")=strExportSql

response.Write(a.GetJSONByProc("dbo.pGetBrushCardRowToCol",arr,4))
'end if

'conn.close()
'set conn = nothing
fCloseADO()

%>
