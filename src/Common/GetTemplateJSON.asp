<!--#include file="Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<%
dim strUserId, strTemplateType
dim strSQL,strJS

strUserId = Cstr(Trim(Request.QueryString("userId")))
if strUserId = "" then strUserId = "0" end if

strTemplateType = Cstr(Trim(Request.Form("templateType")))
if strTemplateType = "" then 
	response.write "[]"
	response.end
end if

fConnectADODB()

strSQL = "select(select '{"&chr(34)&"id"&chr(34)&":"&chr(34)&"'+ CAST(TemplateId AS NVARCHAR(10)) + '"&chr(34)&","&chr(34)&"name"&chr(34)&":"&chr(34)&"' + TemplateName + '"&chr(34)&"},' from ControllerTemplates where TemplateType=" & strTemplateType & " order by TemplateId for xml path('')) JsonData"

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