<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
CheckLoginStatus("parent.location.href='../login.html'")
CheckOperPermissions()

dim strSQL,strActions
dim strTemplateId,isClearOld,arrTemplateId
dim strEmpWhere,strConWhere,strTemplateName
dim i,j,n

response.Charset="utf-8"
strTemplateId = Replace(request.Form("TemplateId"),"'","''")
isClearOld = Replace(request.Form("isClearOld"),"'","''")

arrTemplateId = Split(strTemplateId, ",")
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if
if isClearOld = "" then isClearOld = "0" end if

if GetOperRole("RegCardTemplate","edit") <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

fConnectADODB()

'先注册时间表
For i = 0 To UBound(arrTemplateId)
	iSQL = "select * from ControllerTemplates where TemplateId="+cstr(arrTemplateId(i))
	Rs.Open iSQL, Conn, 1, 1
	If Not Rs.eof Then
		strTemplateName = Trim(Rs.fields("TemplateName").value)
	End If
	Rs.close
	
	'取有访问权限的设备
	strConWhere = ""
	if strUserId<>"1" then '1 为admin用户
		strConWhere = " select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 "
	end if 

	'取有访问权限的部门
	strEmpWhere = ""
	if strUserId<>"1" then '1 为admin用户
		strEmpWhere = " Select Employeeid from Employees where DepartmentID in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1) and Left(IncumbencyStatus,1)<>'1' "
	end if 
	
	On Error Resume Next		
	set recom = server.createobject("adodb.command")
	recom.activeconnection = Conn
	recom.commandtype = 4
	recom.CommandTimeout = 0
	recom.Prepared = true
	recom.Commandtext = "pRegCardTemplateRegister"
	recom.Parameters(1) = cstr(arrTemplateId(i))
	recom.Parameters(2) = isClearOld
	recom.Parameters(3) = strEmpWhere
	recom.Parameters(4) = strConWhere
	
	On Error Resume Next	
	recom.execute()
	if err.number <> 0 then
		Call fCloseADO()
		'Call ReturnMsg("false","模板:["+CStr(strTemplateName)+"]注册到设备时失败！"+Err.Description,0)
		Call ReturnMsg("false",GetEquLbl("Template")+"["+CStr(strTemplateName)+"]"+GetEquLbl("RegConFail")+Err.Description,0)
		On Error GoTo 0
		response.End()
	end if

	strActions = GetCerbLbl("strLogAdd")
	'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号,模板注册到设备,模板名称:["&CStr(strTemplateName)&"]")
	Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("RegCard2")&","&GetEquLbl("TempRegCon")&","&GetEquLbl("TempName")&"["&CStr(strTemplateName)&"]")
	
Next


Call fCloseADO()
Call ReturnMsg("true",GetEquLbl("AlreadyTempRegCon"),0)	'已将所选模板注册到了相应的设备
	
%>