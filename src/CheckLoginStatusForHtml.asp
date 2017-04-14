<!--#include file="Common\Page.asp"-->
<!--#include file="Conn\GetLbl.asp"-->
<%
if session("UserName") = "" or session("UserId") = "" or session("EmId") = "" then 
	session("UserName") = ""
	session("UserId") = ""
	session("EmId") = ""
	session("OperPermissions") = ""
		
	Response.Cookies("Cerb_UserName") = ""
	Response.Cookies("Cerb_UserId") = ""
	Response.Cookies("Cerb_EmId") = ""
	Response.Cookies("Cerb_OperPermissions") = ""
	Call ReturnMsg("false",GetCerbLbl("LoginTimeOut"),0)
Else
	Call ReturnMsg("true","",0)
end if

%>



