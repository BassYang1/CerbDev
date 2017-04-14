<!--#include file="..\Conn\conn.asp" -->
<%
fConnectADODB()
dim strSQL,strJS,strEmpId,strCondition

strEmpId = trim(Request.QueryString("id"))         '
strCondition = trim(Request.QueryString("condition"))	
strJS = "0"

if strEmpId <> "" then                            '
		strSQL = "select Name from Users U inner join Employees E on U.employeeid=E.employeeid where U.Employeeid in ("+Trim(strEmpId)+") and '0' = isNumeric(UserPassword) UNION select Name From employees where Employeeid in ("+Trim(strEmpId)+") and Employeeid not in (select employeeid from Users where employeeid in ("+Trim(strEmpId)+")) "
		On Error Resume next
		Rs.open strSQL, Conn, 1, 1
		If Not Rs.eof Then
			strJS = ""
			While Not Rs.eof
				strJS = strJS + "," + Rs("name")
				Rs.movenext
			Wend
		End If
		Rs.close
end if

if strCondition <> "" Then
	strSQL = "select Name from Users where "+strCondition+"  '0' = isNumeric(UserPassword)"
	On Error Resume next
	Rs.open strSQL, Conn, 1, 1
	If Not Rs.eof Then
		strJS = "1"
	End If
	Rs.close
End if

response.write strJS

fCloseADO()
%>