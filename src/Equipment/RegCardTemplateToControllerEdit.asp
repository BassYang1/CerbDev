<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Common\Controller.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
CheckLoginStatus("parent.location.href='../login.html'")
CheckOperPermissions()

dim strTemplateId,arrTemplateId
dim i

response.Charset="utf-8"
strTemplateId = Replace(request.Form("TemplateId"),"'","''")

arrTemplateId = Split(strTemplateId, ",")
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

if GetOperRole("RegCardTemplate","edit") <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

fConnectADODB()

'先注册时间表
For i = 0 To UBound(arrTemplateId)
	Dim strReturnMsg
	Dim ctrlObj
	set ctrlObj = new Controller
	ctrlObj.DBConnection = Conn
	ctrlObj.UserId = strUserId

	strReturnMsg = ctrlObj.RegTemplateCard(arrTemplateId(i), "")

	if strReturnMsg <> "" then
		Call ReturnMsg("false",GetEquLbl("Template")+"["+CStr(strTemplateName)+"]"+GetEquLbl("RegConFail")+strReturnMsg,0)
		response.end
	end if 
	
Next


Call fCloseADO()
Call ReturnMsg("true",GetEquLbl("AlreadyTempRegCon"),0)	'已将所选模板注册到了相应的设备
	
%>