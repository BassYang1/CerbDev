<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
dim selectId,strDeptId,selID
dim i,j
selID = Cstr(Trim(Request.QueryString("selID")))
selectId = Cstr(Trim(Request.QueryString("selectId")))
strDeptId = Cstr(Trim(Request.QueryString("DeptId")))

fConnectADODB()

dim strSQL,strJS,strNULL,DepartmentCode,strSQLWhere
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if
strSQLWhere = ""
strSQL = "select DepartmentID,DepartmentCode,DepartmentName from Departments "

'取有访问权限的部门
if strUserId<>"1" then '1 为admin用户
	strSQLWhere = " where DepartmentID in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
end if 
if strDeptId <> "" then 
	if strSQLWhere = "" then
		strSQLWhere = " where "
	else
		strSQLWhere = strSQLWhere&" and "
	end if
	strSQLWhere = strSQLWhere & " DepartmentID in ("&strDeptId&")"
end if
strSQL = strSQL & strSQLWhere&" order by DepartmentCode "

if selID <>  "" then 
	strJS = "<select  id='"+selID+"'  class='FormElement ui-widget-content ui-corner-all' >"
else
	strJS = "<select class='FormElement ui-widget-content ui-corner-all' >"
end if
	Rs.open strSQL, Conn, 1, 1
	while NOT Rs.EOF
		strNULL = ""
		DepartmentCode = trim(Rs.fields("DepartmentCode").value)
		j = 1
		strNULL = ""
		While LEN(DepartmentCode)/5 > j
			if j = 1 then 
				strNULL = strNULL & "&nbsp;&nbsp;"
			else
				strNULL = strNULL & "|&nbsp;"
			end if
			j = j + 1
		Wend
		if strNULL <> "" then 
			strNULL = strNULL & "|-"
		end if
		
		if Cstr(Rs.fields("DepartmentID").value) = selectId then 
			if instr(trim(Rs.fields("DepartmentName").value), "'") > 0 then
				strJS = strJS + "<Option value ='"+trim(Rs.fields("DepartmentID").value)+"' selected='selected' >"+strNULL+GetSafeJs(trim(Rs.fields("DepartmentName").value))+"</option>"
			else
				strJS = strJS + "<Option value ='"+trim(Rs.fields("DepartmentID").value)+"' selected='selected' >"+strNULL+trim(Rs.fields("DepartmentName").value)+"</option>"
			end if
		else 
			if instr(trim(Rs.fields("DepartmentName").value), "'") > 0 then
				strJS = strJS + "<option value ='"+trim(Rs.fields("DepartmentID").value)+"'>"+strNULL+GetSafeJs(trim(Rs.fields("DepartmentName").value))+"</option>"
			else
				strJS = strJS + "<option value ='"+trim(Rs.fields("DepartmentID").value)+"'>"+strNULL+trim(Rs.fields("DepartmentName").value)+"</option>"
			end if		
		end if
		Rs.movenext
		i = i + 1
	wend
	Rs.close

	strJS = strJS + "</select>"
	response.write strJS
	
fCloseADO()
%>