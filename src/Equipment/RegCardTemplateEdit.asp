<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Common\Controller.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="SearchExec.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strTemplateName,strEmployeeDesc,strEmployeeCode,strDepartmentCode,strOtherCode,strEmployeeController,strEmployeeScheID,strEmployeeDoor,strValidateMode,strActions, strOnlyByCondition
Dim strDepartmentName, strEmployeeName
Dim isEditEmpCode,arr
Dim strConditionSql
strOper = Request.Form("oper")
strRecordID = Replace(Request.Form("id"),"'","''")
strTemplateName = Replace(Request.Form("TemplateName"),"'","''")
strEmployeeCode = Replace(Request.Form("EmployeeCode"),"'","''")
strDepartmentCode = Replace(Request.Form("DepartmentCode"),"'","''")
strOtherCode = Replace(Request.Form("OtherCode"),"'","''")
strEmployeeController = Replace(Request.Form("EmployeeController"),"'","''")
strEmployeeScheID = Replace(Request.Form("EmployeeScheID"),"'","''")
strEmployeeDoor = Replace(Request.Form("EmployeeDoor"),"'","''")
strValidateMode = Replace(Request.Form("ValidateMode"),"'","''")
strOnlyByCondition = Replace(Request.Form("OnlyByCondition"),"'","''")
strEmployeeDesc = ""
strDepartmentName = Replace(Request.Form("DepartmentName"),"'","''")
strEmployeeName = Replace(Request.Form("EmployeeName"),"'","''")

dim strUserId
strUserId = session("UserId")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if

if GetOperRole("RegCardTemplate",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if strDepartmentName <> "" then
	strEmployeeDesc = strEmployeeDesc & "," & strDepartmentName
end if

if strEmployeeName <> "" then
	strEmployeeDesc = strEmployeeDesc & "," & strEmployeeName
end if

if strOper<>"del" and strEmployeeCode = "" and strDepartmentCode = "" and strEmployeeDesc = "" then	
	Call ReturnMsg("false",GetEquLbl("RegEmpCondition"),0)'未设置注册员工条件
	response.End()
end if

if strEmployeeDesc <> "" then
	strEmployeeDesc = right(strEmployeeDesc, len(strEmployeeDesc) - 1)  '注册员工描述
end if

if strEmployeeController = "0" then 
	strEmployeeController = GetEquLbl("AllCon0")	'"0 - 所有设备"
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

Dim ctrlObj
set ctrlObj = new Controller
ctrlObj.DBConnection = Conn
ctrlObj.UserId = strUserId

Select Case strOper
	Case "add": 'Add Record
		strSQL = "INSERT INTO ControllerTemplates (TemplateType,TemplateName,EmployeeDesc,EmployeeCode,DepartmentCode,OtherCode,EmployeeController,EmployeeScheID,EmployeeDoor,ValidateMode, OnlyByCondition) values('4'"&",'"&strTemplateName&"','"&strEmployeeDesc&"','"&strEmployeeCode&"','"&strDepartmentCode&"','"&strOtherCode&"','"&strEmployeeController&"','"&strEmployeeScheID&"','"&strEmployeeDoor&"','"&strValidateMode&"',"&strOnlyByCondition&")"
	Case "edit": 'Edit Record
		strSQL = "Update ControllerTemplates Set TemplateName ='"&strTemplateName&"' "
		strSQL = strSQL & " ,EmployeeDesc='"&strEmployeeDesc&"' "
		strSQL = strSQL & " ,EmployeeCode='"&strEmployeeCode&"' "
		strSQL = strSQL & " ,DepartmentCode='"&strDepartmentCode&"' "
		strSQL = strSQL & " ,OtherCode='"&strOtherCode&"' "
		strSQL = strSQL & " ,EmployeeController='"&strEmployeeController&"',EmployeeScheID='"&strEmployeeScheID&"',EmployeeDoor='"&strEmployeeDoor&"',ValidateMode='"&strValidateMode&"' "
		strSQL = strSQL & " ,OnlyByCondition="&strOnlyByCondition&" "
		strSQL = strSQL & " Where TemplateId = "&strRecordID
	Case "del": 'Delete Record
		strSQL = " Delete From ControllerTemplates where TemplateId in ("&strRecordID&") "
End Select

if	strSQL<>"" then 
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",Err.Description,0)
		On Error GoTo 0
		response.End()
	end if
	
	Select Case strOper
		Case "add": 'Add Record
			On Error Resume Next
			strSQL = "SELECT TemplateId AS Id FROM ControllerTemplates WHERE TemplateType='4' AND TemplateName='" & strTemplateName & "'"
			Rs.Open strSQL, Conn, 1, 1
			If Not Rs.eof Then
				strRecordID = cstr(Rs.fields("Id").value)
			End If
			Rs.close

			if err.number <> 0 then
				Call fCloseADO()
				Call ReturnMsg("false",Err.Description,0)
				On Error GoTo 0
				response.End()
			end if

			if strRecordID <> "" then
				ctrlObj.RegTemplateCard strRecordID, "0" //注册卡号
			end if

			strActions = GetCerbLbl("strLogAdd")
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,模板名称["&strTemplateName&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("RegCardTemp")&","&GetEquLbl("TempName")&"["&strTemplateName&"]")
		Case "edit": 'Edit Record
			if strRecordID <> "" then
				ctrlObj.RegTemplateCard strRecordID, "0" //注册卡号
			end if

			strActions = GetCerbLbl("strLogEdit")
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,ID["&strRecordID&"],修改后模板名称["&strTemplateName&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("RegCardTemp")&",ID["&strRecordID&"],"&GetEquLbl("EditRegTempName")&"["&strTemplateName&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,ID["&strRecordID&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("RegCardTemp")&",ID["&strRecordID&"]")
	End Select
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
end if
%>