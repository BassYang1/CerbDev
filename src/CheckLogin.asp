<!--#include file="Conn\ReadFile.asp"-->
<!--#include file="Conn\conn.asp" -->
<!--#include file="Conn\ReadLbl.asp" -->
<!--#include file="Conn\json.asp" -->
<!--#include file="Common\Page.asp"-->
<!--#include file="Conn\GetLbl.asp"-->
<%
'20150704 mike 增加如下三行代码。解决当asp脚本发生异常时，导致整个项目乱码，需要重启浏览器才能解决。
Response.CodePage=65001
Response.Charset="utf-8" 
Session.CodePage=65001 

Response.Buffer=true 

'if Request.Cookies("UserName") = "" or Request.Cookies("UserId") = "" or Request.Cookies("EmId") = ""  or Request.Cookies("OperPermissions") = "" then 
if session("UserName") = "" or session("UserId") = "" or session("EmId") = ""  or session("OperPermissions") = "" then 
	dim strUserName,strPwd,strEmId,iflag
	'iflag = request("flag")
	strUserName = Request.Form("strUserName")
	strPwd = Request.Form("strPwd")
	if strUserName = "" then
		Call ReturnMsg("false",GetCerbLbl("EnterUserName"),0)
		response.End()
	end if
	strUserName = SetStringSafe(strUserName)
	strPwd = SetStringSafe(strPwd)
	Call fConnectADODB()
	if CheckUserName(strUserName, strPwd, strUserId, strEmId, strOperPermissions) = 1 then 
	
		session("UserName") = strUserName
		session("UserId") = strUserId
		session("EmId") = strEmId
		session("OperPermissions") = strOperPermissions
		
		Response.Cookies("Cerb_UserName") = strUserName
		Response.Cookies("Cerb_UserId") = strUserId
		Response.Cookies("Cerb_EmId") = strEmId
		Response.Cookies("Cerb_OperPermissions") = strOperPermissions
		
		'考勤申请是否走工作流
		Call CheckWorkflowApproval()

		'Call AddLogEvent2(cstr(strUserName),"登录系统","登录","用户名:"&cstr(strUserName))
		Call AddLogEvent2(cstr(strUserName),GetCerbLbl("LoginSystem"),GetCerbLbl("Login"),GetCerbLbl("UserName")&cstr(strUserName))
		Call fCloseADO()
		Call ReturnMsg("true",GetCerbLbl("LoginSuccess"),0)
		'Call ReturnMsg("true","test",0)
		response.End()
	End if
	Call fCloseADO()
	Call ReturnMsg("false",GetCerbLbl("UserOrPwdError"),0)
	response.End()
else 
	Call fConnectADODB()
	'call AddLogEvent("重新登录系统","登录","用户名:"&session("UserName"))
	call AddLogEvent(GetCerbLbl("ReLoginSystem"),GetCerbLbl("Login"),GetCerbLbl("UserName")&session("UserName"))
	Call fCloseADO()
		
	Call ReturnMsg("true","Login",0)
	response.End()
end if
%>



