<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strTemplateName,iNewID,iNewHolidayCode,iControllerID,strActions
strOper = Request.Form("oper")
strRecordID = Replace(Request.Form("id"),"'","''")
strTemplateName = Replace(Request.Form("TemplateName"),"'","''")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 
if GetOperRole("InOutTemplate",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

Call fConnectADODB()

'判断模板名称是否存在
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from ControllerTemplates where TemplateName='"&strTemplateName&"'"
	Case "edit": 'Edit Record
	strSQL = "Select 1 from ControllerTemplates where TemplateName='"&strTemplateName&"' and TemplateId <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetEquLbl("TempNameUsed"),0)	'"名称已使用"
		response.End()
	end if
end if

Select Case strOper
	Case "add": 'Add Record
		strSQL = "INSERT INTO ControllerTemplates (TemplateType,TemplateName) values('3'"&",'"&strTemplateName&"') "
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("AddInoutTempError"),0)	'增加输入输出模板出错
			On Error GoTo 0
			response.End()
		end if
		iNewId = GetMaxID("TemplateId","ControllerTemplates where TemplateType='3'")
		
		strSQL = ""
		strSQL = strSQL +"INSERT ControllerTemplateInout (TemplateId,InoutPoint,InoutDesc,ScheduleID,ScheduleName,Out1,Out2)  "
		strSQL = strSQL +" 	          select "+CStr(iNewId)+",'1','Button1',0,'"+GetEquLbl("Schedule024")+"',3000,0"		'0 - 24H进出
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'2',NULL,NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'3',NULL,NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'4',NULL,NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'5',NULL,NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'6','"+GetEquLbl("RD1Valid")+"',NULL,NULL,3000,0"		'读卡器1-有效卡
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'7','"+GetEquLbl("RD1Illegal")+"',NULL,NULL,0,3000"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'8','"+GetEquLbl("RD1IllegalTime")+"',NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'9','"+GetEquLbl("RD1AntiPassBack")+"',NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'10','"+GetEquLbl("RD2Valid")+"',NULL,NULL,3000,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'11','"+GetEquLbl("RD2Illegal")+"',NULL,NULL,0,3000"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'12','"+GetEquLbl("RD2IllegalTime")+"',NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'13','"+GetEquLbl("RD2AntiPassBack")+"',NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'14','"+GetEquLbl("DoorNO")+"',NULL,NULL,0,0"
		strSQL = strSQL +" 	UNION ALL select "+CStr(iNewId)+",'15','"+GetEquLbl("DoorNC")+"',NULL,NULL,0,0"
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("AddInoutTempDetailError"),0)		'增加输入输出模板明细出错
			On Error GoTo 0
			response.End()
		end if
		
	Case "edit": 'Edit Record
		strSQL = "Update ControllerTemplates Set TemplateName ='"&strTemplateName&"' Where TemplateId = "&strRecordID
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("EditInoutTempError"),0)	'修改输入输出模板出错
			On Error GoTo 0
			response.End()
		end if
	Case "del": 'Delete Record
		strSQL = "Delete From ControllerTemplateInout where TemplateId in ("&strRecordID&")"
		strSQL = strSQL & "; Delete From ControllerTemplates where TemplateId in ("&strRecordID&") "
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetEquLbl("DelInoutTempError"),0)	'删除输入输出模板出错
			On Error GoTo 0
			response.End()
		end if
End Select


	
Select Case strOper
	Case "add": 'Add Record
		strActions = GetCerbLbl("strLogAdd")
		'Call AddLogEvent("设备管理-输入输出表-模板方式",cstr(strActions),cstr(strActions)&"输入输出模板,输入输出模板名称["&strTemplateName&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Inout")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("InoutTemp")&","&GetEquLbl("InoutTempName")&"["&strTemplateName&"]")
	Case "edit": 'Edit Record
		strActions = GetCerbLbl("strLogEdit")
		'Call AddLogEvent("设备管理-输入输出表-模板方式",cstr(strActions),cstr(strActions)&"输入输出模板,ID["&strRecordID&"],修改后输入输出模板名称["&strTemplateName&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Inout")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("InoutTemp")&",ID["&strRecordID&"],"&GetEquLbl("EditInoutTempName")&"["&strTemplateName&"]")
	Case "del": 'Delete Record
		strActions = GetCerbLbl("strLogDel")
		'Call AddLogEvent("设备管理-输入输出表-模板方式",cstr(strActions),cstr(strActions)&"输入输出模板,ID["&strRecordID&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Inout")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("InoutTemp")&",ID["&strRecordID&"]")
End Select

Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"


%>