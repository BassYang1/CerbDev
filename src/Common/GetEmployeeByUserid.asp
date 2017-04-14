<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
fConnectADODB()
dim strSQL,strJS,strUserId
strUserId = request.QueryString("strUserId")
if strUserId = "" then 
	response.Write("")
	response.End()
end if
strSQL = "select D.DepartmentID,D.DepartmentName,E.employeeid,E.Name from Users U left join Employees E on U.Employeeid=E.employeeid left join Departments D on E.DepartmentId=D.DepartmentId where UserId="&strUserId
strJS = ""
Rs.open strSQL, Conn, 1, 1
If Rs.eof=false and Rs.Bof=false then
	strJS = strJS & trim(Rs.fields("DepartmentID").value) & ",,"
	if instr(trim(Rs.fields("DepartmentName").value), "'") > 0 then
		strJS = strJS & GetSafeJs(trim(Rs.fields("DepartmentName").value)) & ",,"
	else
		strJS = strJS & trim(Rs.fields("DepartmentName").value) & ",,"
	end if
	
	strJS = strJS & trim(Rs.fields("employeeid").value) & ",,"
	if instr(trim(Rs.fields("Name").value), "'") > 0 then
		strJS = strJS & GetSafeJs(trim(Rs.fields("Name").value)) & ",,"
	else
		strJS = strJS & trim(Rs.fields("Name").value) & ",,"
	end if
	Rs.movenext
	i = i + 1
End if
Rs.close

if strJS <> "" and len(strJS) >= 2 then 
	strJS=left(strJS,len(strJS)-2)
end if
response.write strJS
	
fCloseADO()
%>