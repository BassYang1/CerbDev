<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<%
	dim strModule,iedit,iadd,idel,iview,irefresh,isearch,iexport,iprint,isync,iapply,iapprove
	Dim Temp
	strModule = Request.QueryString("module")
	
	if session("OperPermissions")="1" then 
		iedit="true"
		iadd="true"
		idel="true"
		isync="true"
		iapply = "true"
		iapprove = "false"

		if CheckApprovalPermission() = 1  then
			iapprove = "true"
		end if
	else
		iedit="false"
		iadd="false"
		idel="false"
		isync="false"
		iapply = "false"
		iapprove = "false"
	end if
	'一般职员用户可修改自己用户
	if strModule = "users" then iedit = "true" end if
	
	iview="true"
	irefresh="true"
	isearch="true"
	iexport="true"
	iprint="true"
	
	Temp = "{"&chr(34)&"edit"&chr(34)&":"&iedit&","&chr(34)&"add"&chr(34)&":"&iadd&","&chr(34)&"del"&chr(34)&":"&idel&","&chr(34)&"view"&chr(34)&":"&iview&","&chr(34)&"refresh"&chr(34)&":"&irefresh&","&chr(34)&"search"&chr(34)&":"&isearch&","&chr(34)&"exportdata"&chr(34)&":"&iexport&","&chr(34)&"print"&chr(34)&":"&iprint&","&chr(34)&"sync"&chr(34)&":"&isync&","&chr(34)&"apply"&chr(34)&":"&iapply&","&chr(34)&"approve"&chr(34)&":"&iapprove&"}"
	response.Write(Temp)
%>