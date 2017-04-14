<!--#include file="Conn\GetLbl.asp"-->
<%
'检查登录状态
Function CheckLoginStatus(strUrl)
	if session("UserName") = "" or session("UserId") = "" or session("EmId") = "" then 
		session("UserName") = ""
		session("UserId") = ""
		session("EmId") = ""
		session("OperPermissions") = ""
		
		Response.Cookies("Cerb_UserName") = ""
		Response.Cookies("Cerb_UserId") = ""
		Response.Cookies("Cerb_EmId") = ""
		Response.Cookies("Cerb_OperPermissions") = ""
		'登录超时
		Response.Write("<script language='javascript'>alert('"+GetCerbLbl("LoginTimeOut")+"'); "+cstr(strUrl)+";</script>")
		response.End()
	end if
End Function

'检查是否有管理员权限
Function CheckOperPermissions()
	if session("OperPermissions") <> "1" then 
		'您无权操作
		Call ReturnMsg("false",GetCerbLbl("NoRight"),0)
		response.End()
	end if
End Function

%>



