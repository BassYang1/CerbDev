<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="SearchExec.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strTemplateName,strEmployeeDesc,strEmployeeCode,strEmployeeController,strEmployeeScheID,strEmployeeDoor,strValidateMode,strActions
Dim isEditEmpCode,arr
strOper = Request.Form("oper")
strRecordID = Replace(Request.Form("id"),"'","''")
strTemplateName = Replace(Request.Form("TemplateName"),"'","''")
strEmployeeDesc = Replace(Request.Form("EmployeeDesc"),"'","''")
strEmployeeCode = Replace(Request.Form("EmployeeCode"),"'","''")
strEmployeeController = Replace(Request.Form("EmployeeController"),"'","''")
strEmployeeScheID = Replace(Request.Form("EmployeeScheID"),"'","''")
strEmployeeDoor = Replace(Request.Form("EmployeeDoor"),"'","''")
strValidateMode = Replace(Request.Form("ValidateMode"),"'","''")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 
if GetOperRole("RegCardTemplate",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

isEditEmpCode = "0"
if strEmployeeCode <> "" then 
	arr = split(strEmployeeCode,"|,")
	if IsArray(arr) and UBound(arr) >= 3 and arr(0) = "edit" then 
		isEditEmpCode = "1"
		strEmployeeCode = GetSearchSQLWhere(arr(1),arr(2),arr(3))
		'strEmployeeCode = "select Employeeid from Employees E Left join Departments D on E.DepartmentID=D.DepartmentID where " & strEmployeeCode
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strEmployeeCode = "select Employeeid from Employees E where " & strEmployeeCode
		strEmployeeCode = Replace(strEmployeeCode,"'","''")
	end if
end if
if strEmployeeDesc <> "" and left(strEmployeeDesc,1) = "0" then
	isEditEmpCode = "1"
	strEmployeeCode = ""
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

Select Case strOper
	Case "add": 'Add Record
		strSQL = "INSERT INTO ControllerTemplates (TemplateType,TemplateName,EmployeeDesc,EmployeeCode,EmployeeController,EmployeeScheID,EmployeeDoor,ValidateMode) values('4'"&",'"&strTemplateName&"','"&strEmployeeDesc&"','"&strEmployeeCode&"','"&strEmployeeController&"','"&strEmployeeScheID&"','"&strEmployeeDoor&"','"&strValidateMode&"') "
	Case "edit": 'Edit Record
		strSQL = "Update ControllerTemplates Set TemplateName ='"&strTemplateName&"' "
		strSQL = strSQL & " ,EmployeeDesc='"&strEmployeeDesc&"' "
		if isEditEmpCode = "1" then 
			strSQL = strSQL & " ,EmployeeCode='"&strEmployeeCode&"' "
		end if
		strSQL = strSQL & " ,EmployeeController='"&strEmployeeController&"',EmployeeScheID='"&strEmployeeScheID&"',EmployeeDoor='"&strEmployeeDoor&"',ValidateMode='"&strValidateMode&"' "
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
			strActions = GetCerbLbl("strLogAdd")
			'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号模板,模板名称["&strTemplateName&"]")
			Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("RegCardTemp")&","&GetEquLbl("TempName")&"["&strTemplateName&"]")
		Case "edit": 'Edit Record
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