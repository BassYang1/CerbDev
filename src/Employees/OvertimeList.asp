<%'Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp" -->
<%
response.Charset="utf-8"
dim page,rows,sidx,sord
dim departmentId,strSQL,strExportSql
dim strYear,strMonth,strDate,strHead,strStatus,strDept
strYear = trim(request.QueryString("selYear"))
strMonth = trim(request.QueryString("selMonth"))

if strYear <> "" then strDate = strYear end if
if strDate <> "" and strMonth <> "" then strDate = strDate + "-" + strMonth end if

strHead = trim(request.QueryString("selHead"))
strStatus = trim(request.QueryString("selStatus"))
strDept = trim(request.QueryString("selDept"))

page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "L.OTId" end if
if sord = "" then sord ="asc" end if

dim strUserId, strEmpId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

strEmpId = session("EmId")
if strEmpId = "" then strEmpId = "0" end if

Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
strSearchOn = request.QueryString("_search")
'response.Write("strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper")

'construct where
strWhere = ""

if strHead = "0" then  '我的资料
	if strStatus = "A" then
		strWhere = strWhere + " and L.EmployeeId="+cstr(strEmpId)
	Else
		strWhere = strWhere + " and substring(L.Status,1,1)='"+strStatus+"' and L.EmployeeId="+cstr(strEmpId)
	End If
ElseIf strHead = "2" then  '已办资料
	strWhere = "L.TransactorId="+CStr(strEmpId) + " "
	strWhere = strWhere + "and substring(L.Status,1,1) in ('0') " '0 - 申请'
Else       '待办资料
	strWhere = "L.TransactorId="+CStr(strEmpId) + " "
	strWhere = strWhere + "and substring(L.Status,1,1) in ('2', '3') " '2 - 已批, 3 - 拒绝'
	
end If

If strHead <> "0" and strDept <> "" Then
	strWhere = strWhere + "and L.EmployeeId in (select EmployeeId from Employees where DeparmentId in (select DeparmentId from Departments where DepartmentCode LIKE '" + strDept + "%')) "
End If

if strDate <> "" then
	strWhere = strWhere + " and convert(varchar(10),L.StartTime,121) like '"+cstr(strDate)+"%' "
end If

If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	strFieldData = request.QueryString("searchString")
	strSearchOper = request.QueryString("searchOper")
End If

'server.ScriptTimeout=9000
fConnectADODB()
'fConnectADOCE()
dim a
set a=new JSONClass
strSQL = "SELECT L.OTId, D.DepartmentName, E.Name,'' AS DepartmentCode, '' AS EmployeeCode, '' AS OtherCode, AllDay, Note, convert(varchar(19),StartTime,121) as StartTime, convert(varchar(19),EndTime,121) as EndTime, Status "
strSQL = strSQL & "FROM AttendanceOT L "
strSQL = strSQL & "INNER JOIN Employees E ON E.EmployeeId = L.EmployeeId "
strSQL = strSQL & "INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID "
strSQL = strSQL & strWhere & " order by "& sidx & " " & sord

'response.write strSQL
'response.end
a.Sqlstring=strSQL

'导出
strExportSql = "SELECT L.OTId, D.DepartmentName, E.Name, Note, convert(varchar(19),StartTime,121) as StartTime, convert(varchar(19),EndTime,121) as EndTime, Status "
strExportSql = strExportSql & "FROM AttendanceOT L "
strExportSql = strExportSql & "INNER JOIN Employees E ON E.EmployeeId = L.EmployeeId "
strExportSql = strExportSql & "INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID "
strExportSql = strExportSql & strWhere & " order by "& sidx & " " & sord

'response.write strExportSql
'response.end
set a.dbconnection=conn

'strExportSql = "employees||\ResidentFlash\www\wwwpub\download\employees.csv||" & strExportSql
'Response.Cookies("ExportData")=strExportSql
Session("exportdata")=strExportSql
 
'response.Write(Session("exportdata"))
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>

