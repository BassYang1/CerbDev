<!--#include file="..\Common\Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
dim strUserId
dim strSQL,strJS,strid,strPid,strName,strCheck
strUserId = Cstr(Trim(Request.QueryString("userId")))
if strUserId = "" then 
	strUserId = "0"
end if

fConnectADODB()

strJS = ""
'取设备(有访问)
'strSQL = " select DepartmentId from RoleDepartment where UserId=" + cstr(id) + " and Permission=1  and len(DepartmentCode)%5 = 0"
strSQL = "select C.ControllerId,C.ControllerNumber,C.Location from Controllers C left join RoleController R on (C.ControllerId=R.ControllerId and R.UserId = '"&strUserId&"') order by ControllerId  "
strPid = "0"
Rs.open strSQL, Conn, 2, 1
'strJS = "["
strJS = "{ "&chr(34)&"success"&chr(34)&":"&chr(34)&"true"&chr(34)&", "&chr(34)&"rows"&chr(34)&":["
while NOT Rs.EOF
	if NOT ISNULL(Rs.fields("ControllerId").value) then
		strid = trim(Rs.fields("ControllerId").value)
		strName = trim(Rs.fields("ControllerNumber").value) + "-"+trim(Rs.fields("Location").value)
		
		strJS = strJS + "{"&chr(34)&"id"&chr(34)&":" &chr(34)&strid&chr(34)&","&chr(34)&"name"&chr(34)&":" &chr(34)&strName&chr(34)&"},"
		
		'strJS = strJS + "{"&chr(34)&"id"&chr(34)&":" &chr(34)&strid&chr(34)&","&chr(34)&"name"&chr(34)&":" &chr(34)&strName&chr(34)&"},"
		
		'strJS = strJS + "{"&chr(34)&"id"&chr(34)&":" &chr(34)&strid&chr(34)&","&chr(34)&"name"&chr(34)&":" &chr(34)&strName&chr(34)&"},"
		
	end if
	Rs.movenext
	i = i + 1
wend
Rs.close
if len(strJS) >= 2 then 
	strJS=left(strJS,InStrRev(strJS,",")-1)
end if
strJS=strJS & "]}"
response.write strJS
	
fCloseADO()
%>