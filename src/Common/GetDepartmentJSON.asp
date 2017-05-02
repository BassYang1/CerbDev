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
	strSQL = "SELECT (SELECT '{"&chr(34)&"id"&chr(34)&":"&chr(34)&"' + CAST(D.DepartmentID AS NVARCHAR(10)) + '"&chr(34)&",','"&chr(34)&"name"&chr(34)&":"&chr(34)&"' + D.DepartmentName + '"&chr(34)&",', '"&chr(34)&"code"&chr(34)&":"&chr(34)&"' + D.DepartmentCode + '"&chr(34)&",', '"&chr(34)&"pid"&chr(34)&":"&chr(34)&"' + CAST(D.ParentDepartmentID AS NVARCHAR(10)) + '"&chr(34)&"},' from Departments D where isNumeric(D.DepartmentCode)=1"

	if strUserId <> "1" then
		strSQL = strSQL & " and exists(select 1 from RoleDepartment where DepartmentId=D.DepartmentId and UserId = '"&strUserId&"')"
	end if

	if strDeptIds <> "" then
		strSQL = strSQL & " and D.DepartmentId IN (" & strDeptIds & ")"
	end if

	strSQL = strSQL & " order by D.DepartmentCode for xml path('')) as JsonData"
else 'all
	strSQL = "select(select '{"&chr(34)&"id"&chr(34)&":"&chr(34)&"' + CAST(D.DepartmentID AS NVARCHAR(10)) + '"&chr(34)&",', '"&chr(34)&"name"&chr(34)&":"&chr(34)&"' + D.DepartmentName + '"&chr(34)&",', '"&chr(34)&"code"&chr(34)&":"&chr(34)&"' + D.DepartmentCode + '"&chr(34)&",', '"&chr(34)&"pId"&chr(34)&":"&chr(34)&"' + CAST(ISNULL(P.DepartmentID,0) AS NVARCHAR(10)) + '"&chr(34)&"',(case ISNULL(R.Permission,0) when 1 then ',"&chr(34)&"checked"&chr(34)&":"&chr(34)&"true"&chr(34)&"' else '' end), '},' from Departments D Left join Departments P on left(D.DepartmentCode,len(D.DepartmentCode)-5)=P.DepartmentCode left join RoleDepartment R on (D.DepartmentId=R.DepartmentId and R.UserId = '"&strUserId&"') where isNumeric(D.DepartmentCode)=1 order by D.DepartmentCode for xml path('')) as JsonData"
end if

Rs.open strSQL, Conn, 2, 1
strJS = "["

If Not Rs.eof Then
	strJS = strJS & Trim(Rs.fields(0).value)
End If

Rs.close
if len(strJS) >= 2 then 
	strJS=left(strJS,InStrRev(strJS,",")-1)
end if
strJS=strJS & "]"
response.write strJS
	
fCloseADO()
%>