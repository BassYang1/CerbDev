<!--#include file="Conn\conn.asp" -->
<!--#include file="Conn\json.asp" -->
<!--#include file="Common\Page.asp"-->
<%
Response.Buffer=true 
session("UserName") = ""
session("UserId") = ""
session("EmId") = ""
session("OperPermissions") = ""
	
Response.Cookies("Cerb_UserName") = ""
Response.Cookies("Cerb_UserId") = ""
Response.Cookies("Cerb_EmId") = ""
Response.Cookies("Cerb_OperPermissions") = ""
response.write "<script language='javascript'>parent.location.href='login.html';window.close();</script>"
response.End()
%>



