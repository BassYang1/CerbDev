<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
'使用后面的判断,这里注销
'Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strEmployeeid, strLoginName, strOperPermDesc,strOperPermissions,strUserPassword,strRoleDeptId,strRoleConId
Dim iNewUserid,strActions

strOper = request.Form("oper")
strRecordID = Replace(request.Form("id"),"'","''")
strEmployeeid = Replace(request.Form("Employeeid"),"'","''")
strLoginName = Replace(request.Form("LoginName"),"'","''")
strOperPermDesc = Replace(request.Form("OperPermDesc"),"'","''")
strOperPermissions = Replace(request.Form("OperPermissions"),"'","''")
strUserPassword = Replace(request.Form("UserPassword"),"'","''")
strRoleDeptId = Replace(request.Form("RoleDeptId"),"'","''")
strRoleConId = Replace(request.Form("RoleConId"),"'","''")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 

if GetOperRole("Users",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

'判断一般职员用户是否修改他人用户
IF session("OperPermissions") <> "1" and cstr(session("UserId")) <> Cstr(strRecordID) then 
	Call ReturnMsg("false",GetToolLbl("EditSelfInfo"),0)	'您仅能修改自己信息！
	response.End()
END IF

Call fConnectADODB()

'判断卡号是否存在 
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from Users where LoginName='"&strLoginName&"'"
	Case "edit": 'Edit Record
	strSQL = "Select 1 from Users where LoginName='"&strLoginName&"' and UserId <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetToolLbl("LoginUsed"),0)	'登录名已使用
		response.End()
	end if
end if

'判断工号是否存在 
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from Users where Employeeid='"&strEmployeeid&"'"
	Case "edit": 'Edit Record
	strSQL = "Select 1 from Users where Employeeid='"&strEmployeeid&"' and UserId <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetToolLbl("EmpUsed"),0)	'"该职员已对应另一个用户"
		response.End()
	end if
end if

strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "insert into Users(LoginName,UserPassword,EmployeeId,OperPermissions,OperPermDesc,VisitTimeSignIn) Values("&"'"&strLoginName&"','"&strUserPassword&"',"&strEmployeeid&","&strOperPermissions&",'"&strOperPermDesc&"','') "
	
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetToolLbl("AddUserError"),0)	'"增加用户出错"
		On Error GoTo 0
		response.End()
	end if
	iNewId = GetMaxID("UserID","Users")
	strSQL = "Delete RoleDepartment where UserId = '"&iNewId&"'; "
	if strRoleDeptId <> "" then 
		strSQL = strSQL & " insert into RoleDepartment(UserID,DepartmentID,Permission) select '"&iNewId&"',DepartmentID,1 from Departments where DepartmentID in ("&strRoleDeptId&"); "
	end if
	strSQL = strSQL & " Delete RoleController where UserId = '"&iNewId&"'; "
	if strRoleConId <> "" then 
		strSQL = strSQL & " insert into RoleController(UserID,ControllerID,Permission) select '"&iNewId&"',ControllerId,1 from Controllers where ControllerId in ("&strRoleConId&"); "
	end if
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetToolLbl("AddUserRoleError"),0)	'增加用户权限出错
		On Error GoTo 0
		response.End()
	end if
	
	Case "edit": 'Edit Record
	IF session("OperPermissions") <> "1" then 
		'一般职员修改自己用户
		strSQL = "Update Users Set LoginName ='"&strLoginName&"',UserPassword = '"&strUserPassword&"' Where UserID = "&strRecordID
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetToolLbl("EditUserError"),0)	'修改用户出错
			On Error GoTo 0
			response.End()
		end if

		session("UserName") = strLoginName
		Response.Cookies("Cerb_UserName") = strLoginName

	ELSE
		'管理员修改 
		strSQL = "Update Users Set LoginName ='"&strLoginName&"',UserPassword = '"&strUserPassword&"', EmployeeId = '"&strEmployeeid&"', OperPermissions = '"&strOperPermissions&"', OperPermDesc = '"&strOperPermDesc&"' Where UserID = "&strRecordID
		
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetToolLbl("EditUserError"),0)	'修改用户出错
			On Error GoTo 0
			response.End()
		end if
		strSQL = "Delete RoleDepartment where UserId = '"&strRecordID&"'; "
		if strRoleDeptId <> "" then 
			strSQL = strSQL & " insert into RoleDepartment(UserID,DepartmentID,Permission) select '"&strRecordID&"',DepartmentID,1 from Departments where DepartmentID in ("&strRoleDeptId&"); "
		end if
		strSQL = strSQL & " Delete RoleController where UserId = '"&strRecordID&"'; "
		if strRoleConId <> "" then 
			strSQL = strSQL & " insert into RoleController(UserID,ControllerID,Permission) select '"&strRecordID&"',ControllerId,1 from Controllers where ControllerId in ("&strRoleConId&"); "
		end if
		On Error Resume Next
		Conn.Execute strSQL
		if err.number <> 0 then
			Call fCloseADO()
			Call ReturnMsg("false",GetToolLbl("EditUserRoleError"),0)	'修改用户权限出错
			On Error GoTo 0
			response.End()
		end if
		
		'修改自己用户，重新给session赋值
		if cstr(session("UserId")) = Cstr(strRecordID) then 
			session("EmId") = strEmployeeid
			session("UserName") = strLoginName
			session("OperPermissions") = strOperPermissions
			Response.Cookies("Cerb_UserName") = strLoginName
			Response.Cookies("Cerb_EmId") = strEmployeeid
			Response.Cookies("Cerb_OperPermissions") = strOperPermissions
		end if
	END IF
	
	Case "del": 'Delete Record
	strSQL = "Delete RoleDepartment where UserId in ("&strRecordID&"); "
	strSQL = strSQL & " Delete RoleController where UserId in ("&strRecordID&"); "
	strSQL = strSQL & " Delete From Users Where UserID in ("&strRecordID&")"
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",GetToolLbl("DelUserError"),0)	'删除用户出错
		On Error GoTo 0
		response.End()
	end if
	
End Select

if	strOper="add" or strOper = "edit" or strOper="del" then 
	Select Case strOper
		Case "add": 'Add Record
			strActions = GetCerbLbl("strLogAdd")
			'Call AddLogEvent("工具-用户设置",cstr(strActions),cstr(strActions)&"用户,用户名["&strLoginName&"]")
			Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("UserSet"),cstr(strActions),cstr(strActions)&GetToolLbl("User2")&","&GetToolLbl("UserName2")&"["&strLoginName&"]")
		Case "edit": 'Edit Record
			strActions = GetCerbLbl("strLogEdit")
			'Call AddLogEvent("工具-用户设置",cstr(strActions),cstr(strActions)&"用户,用户ID["&strRecordID&"],修改后用户名["&strLoginName&"]")
			Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("UserSet"),cstr(strActions),cstr(strActions)&GetToolLbl("User2")&","&GetToolLbl("UserID")&"["&strRecordID&"],"&GetToolLbl("EditLastUser")&"["&strLoginName&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			'Call AddLogEvent("工具-用户设置",cstr(strActions),cstr(strActions)&"用户,用户ID["&strRecordID&"]")
			Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("UserSet"),cstr(strActions),cstr(strActions)&GetToolLbl("User2")&","&GetToolLbl("UserID")&"["&strRecordID&"]")
	End Select
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)'执行成功
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
end if

%>