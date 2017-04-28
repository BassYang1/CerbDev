<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
dim strUserId, strDeptIds, strOper
dim strSQL,strJS,strid,strPid,strDepartmentCode,strName,strCheck

strDeptIds = Cstr(Trim(Request.Form("deptIds")))
strOper = Cstr(Trim(Request.Form("oper")))
strUserId = Cstr(Trim(Request.QueryString("userId")))
if strUserId = "" then strUserId = "0" end if


fConnectADODB()

strJS = ""
'取部门(有访问)
'strSQL = " select DepartmentId from RoleDepartment where UserId=" + cstr(id) + " and Permission=1  and len(DepartmentCode)%5 = 0"
'strSQL = "select DepartmentId,DepartmentCode,DepartmentName,'0' as checked from Departments where isNumeric(DepartmentCode)=1 order by DepartmentCode "

if strOper = "filter" then 'filter
	strSQL = "select D.DepartmentID,D.DepartmentName, D.DepartmentCode, ISNULL(P.DepartmentID,0) as PDepartmentID from Departments D Left join Departments P on left(D.DepartmentCode,len(D.DepartmentCode)-5)=P.DepartmentCode where isNumeric(D.DepartmentCode)=1"

	if strUserId <> "1" then
		strSQL = strSQL & " and exists(select 1 from RoleDepartment where DepartmentId=D.DepartmentId and UserId = '"&strUserId&"')"
	end if
else 'all
	strSQL = "select D.DepartmentID,D.DepartmentName, D.DepartmentCode, ISNULL(P.DepartmentID,0) as PDepartmentID,ISNULL(R.Permission,0) as checked from Departments D Left join Departments P on left(D.DepartmentCode,len(D.DepartmentCode)-5)=P.DepartmentCode  left join RoleDepartment R on (D.DepartmentId=R.DepartmentId and R.UserId = '"&strUserId&"') where isNumeric(D.DepartmentCode)=1"
end if

if strDeptIds <> "" then
	strSQL = strSQL & " and D.DepartmentId IN (" & strDeptIds & ")"
end if

strSQL = strSQL & " order by D.DepartmentCode"

Rs.open strSQL, Conn, 2, 1
strJS = "["
if strOper = "filter" then
	while NOT Rs.EOF
		if NOT ISNULL(Rs.fields("DepartmentId").value) then
			strid = trim(Rs.fields("DepartmentId").value)
			strDepartmentCode = trim(Rs.fields("DepartmentCode").value)
			strName = trim(Rs.fields("DepartmentName").value)
			strPid = trim(Rs.fields("PDepartmentID").value)
			
			strJS = strJS + "{"&chr(34)&"id"&chr(34)&":" &chr(34)&strid&chr(34)&","&chr(34)&"pId"&chr(34)&":" &chr(34)&strPid&chr(34)&","&chr(34)&"name"&chr(34)&":" &chr(34)&strName&chr(34)&","&chr(34)&"code"&chr(34)&":" &chr(34)&strDepartmentCode&chr(34)&"},"
		end if
		Rs.movenext
	wend
else
	while NOT Rs.EOF
		if NOT ISNULL(Rs.fields("DepartmentId").value) then
			strid = trim(Rs.fields("DepartmentId").value)
			strDepartmentCode = trim(Rs.fields("DepartmentCode").value)
			strName = trim(Rs.fields("DepartmentName").value)
			strPid = trim(Rs.fields("PDepartmentID").value)
			if NOT ISNULL(Rs.fields("checked").value) then
				'strCheck = Cstr(trim(Rs.fields("checked").value))
				if trim(Rs.fields("checked").value) = "True" then 
					strCheck = "1"
				else
					strCheck = "0"
				end if
			else
				strCheck = "0"
			end if
			
			'strJS = strJS + "DateArray[" + cstr(i) + "] = '" +Cstr(id)+",,"+Cstr(pid)+",,"+strName+",,"+strCheck + "';" 
			if strCheck = "1" then 
				strJS = strJS + "{"&chr(34)&"id"&chr(34)&":" &chr(34)&strid&chr(34)&","&chr(34)&"pId"&chr(34)&":" &chr(34)&strPid&chr(34)&","&chr(34)&"name"&chr(34)&":" &chr(34)&strName&chr(34)&","&chr(34)&"open"&chr(34)&":" &chr(34)&"true"&chr(34)&","&chr(34)&"checked"&chr(34)&":" &chr(34)&"true"&chr(34)&"},"
			else
				strJS = strJS + "{"&chr(34)&"id"&chr(34)&":" &chr(34)&strid&chr(34)&","&chr(34)&"pId"&chr(34)&":" &chr(34)&strPid&chr(34)&","&chr(34)&"name"&chr(34)&":" &chr(34)&strName&chr(34)&","&chr(34)&"code"&chr(34)&":" &chr(34)&strDepartmentCode&chr(34)&"},"
			end if
		end if
		Rs.movenext
	wend
end if

Rs.close
if len(strJS) >= 2 then 
	strJS=left(strJS,InStrRev(strJS,",")-1)
end if
strJS=strJS & "]"
response.write strJS
	
fCloseADO()
%>