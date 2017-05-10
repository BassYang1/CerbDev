<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
dim strUserId, strOper, templateId
dim strSQL,strJS,strid,strPid,strName,strCheck
strOper = Cstr(Trim(Request.Form("oper")))
strUserId = Cstr(Trim(Request.QueryString("userId")))
templateId = Cstr(Trim(Request.QueryString("templateId")))
if strUserId = "" then strUserId = "0" end if

fConnectADODB()

strJS = ""
'取部门(有访问)

if strOper = "regcard" then
	strSQL = "select(select '{"&chr(34)&"id"&chr(34)&":"&chr(34)&"' + CAST(C.ControllerId AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"pId"&chr(34)&":"&chr(34)&"0"&chr(34)&","&chr(34)&"name"&chr(34)&":"&chr(34)&"' + C.ControllerNumber + '-' + CAST(C.ControllerId AS NVARCHAR(10)) + '-' + C.Location + '"&chr(34)&"' + (CASE WHEN ISNULL(T.ControllerCode,'') != '' THEN ',"&chr(34)&"open"&chr(34)&":"&chr(34)&"true"&chr(34)&","&chr(34)&"checked"&chr(34)&":"&chr(34)&"true"&chr(34)&"' ELSE '' END) + '},' from Controllers C"


	strSQL = strSQL & " LEFT JOIN (select TOP 1 CAST(EmployeeController AS NVARCHAR(MAX)) AS ControllerCode from ControllerTemplates where TemplateType = 4 and TemplateId = " & templateId & ") T"
	strSQL = strSQL & " ON LEFT(LTRIM(ISNULL(T.ControllerCode, '')),3) = '0 -' OR CHARINDEX(',' + CAST(C.ControllerId AS NVARCHAR(10)) + ',', ',' + T.ControllerCode + ',') > 0"

	strSQL = strSQL & " where 1 > 0"

	if strUserId <> "1" then
		strSQL = strSQL & " and exists(select 1 from RoleController where ControllerId=C.ControllerId and UserId = '"&strUserId&"')"
	end if

	strSQL = strSQL & " order by ControllerNumber for xml path('')) JsonData"
else 
	strSQL = "select(select '{"&chr(34)&"id"&chr(34)&":"&chr(34)&"' + CAST(C.ControllerId AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"pId"&chr(34)&":"&chr(34)&"0"&chr(34)&","&chr(34)&"name"&chr(34)&":"&chr(34)&"' + C.ControllerNumber + '-' + CAST(C.ControllerId AS NVARCHAR(10)) + '-' + C.Location + '"&chr(34)&"' + (CASE ISNULL(R.Permission,0) WHEN 1 THEN ',"&chr(34)&"open"&chr(34)&":"&chr(34)&"true"&chr(34)&","&chr(34)&"checked"&chr(34)&":"&chr(34)&"true"&chr(34)&"' ELSE '' END) + '},' from Controllers C left join RoleController R on (C.ControllerId=R.ControllerId and R.UserId = '"&strUserId&"') order by ControllerNumber for xml path('')) JsonData "
end if

strPid = "0"
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