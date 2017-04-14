<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
fConnectADODB()
dim strSQL,strJS,strDepartmentId,strEmployeeId
strDepartmentId = request.QueryString("strDepartmentId")
strEmployeeId = request.QueryString("strEmployeeId")
if strDepartmentId = "" then 
	response.Write("")
	response.End()
end if
if strEmployeeId = "" then strEmployeeId = "0" end if

strSQL = "select EmployeeId, Number,Name from Employees where DepartmentID in ("&strDepartmentId&") and EmployeeId not in (select EmployeeId from Users where Employeeid <> "&strEmployeeId&") "
strJS = ""
Rs.open strSQL, Conn, 1, 1
while NOT Rs.EOF
	if instr(trim(Rs.fields("Number").value), "'") or instr(trim(Rs.fields("Name").value), "'") > 0 then
		strJS = strJS&trim(Rs.fields("Employeeid").value)&",," & GetSafeJs(trim(Rs.fields("Number").value)) + "-" + GetSafeJs(trim(Rs.fields("Name").value)) & "||"
	else
		strJS = strJS&trim(Rs.fields("Employeeid").value)&",," & trim(Rs.fields("Number").value) + "-" + trim(Rs.fields("Name").value) & "||"
	end if
	Rs.movenext
	i = i + 1
wend
Rs.close

if strJS <> "" and len(strJS) >= 2 then 
	strJS=left(strJS,len(strJS)-2)
end if
response.write strJS
	
fCloseADO()
%>