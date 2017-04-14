<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<%
CheckLoginStatus("parent.location.href='../login.html'")
CheckOperPermissions()

dim strSQL,strActions
dim strTemplateId,isClearOld,arrTemplateId
dim arrConValue,strEmController,strEmCode,strTemplateName,strEmployeeScheID,strEmployeeDoor,strValidateMode,strConId,strWhere
dim i,j,n

response.Charset="utf-8"
strTemplateId = Replace(request.Form("TemplateId"),"'","''")
isClearOld = Replace(request.Form("isClearOld"),"'","''")

arrTemplateId = Split(strTemplateId, ",")
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

if GetOperRole("RegCardTemplate","edit") <> true then 
	Call ReturnMsg("false","您无权操作！",0)
	response.End()
end if

fConnectADODB()

'先注册时间表
For i = 0 To UBound(arrTemplateId)
	iSQL = "select * from ControllerTemplates where TemplateId="+cstr(arrTemplateId(i))
	Rs.Open iSQL, Conn, 1, 1
	If Not Rs.eof Then
		strEmController = Trim(Rs.fields("EmployeeController").value)
		If Not IsNull(Rs.fields("EmployeeCode").value) and Rs.fields("EmployeeCode").value <> "" then
			strEmCode = Trim(Rs.fields("EmployeeCode").value)
		Else
			strEmCode = "select * from Employees where Left(IncumbencyStatus,1) != '1'"
		End if
		strTemplateName = Trim(Rs.fields("TemplateName").value)
		strEmployeeScheID = Trim(Rs.fields("EmployeeScheID").value)
		strEmployeeDoor = Trim(Rs.fields("EmployeeDoor").value)
		strValidateMode = Trim(Rs("ValidateMode"))
	End If
	Rs.close
	
	'取有访问权限的设备
	strWhere = ""
	if strUserId<>"1" then '1 为admin用户
		strWhere = " ControllerID in (select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 ) "
	end if 

	If Left(strEmController,1) = "0" Then   '所有设备
		strConId = GetOneFieldValues("Controllers", "ControllerId", strWhere)
	Else
		strConId = GetOneFieldValues("Controllers", "ControllerId", "ControllerId in ("+CStr(strEmController)+") and "&strWhere)
	End If
	
	arrConValue = Split(strConId,",")

	'先注册时间表
	For j=0 To UBound(arrConValue)
		'判断当前时间表ID是否已经注册到设备上
		strSQL = " select 1 from ControllerSchedule where ControllerId="&CStr(arrConValue(j))&" and TemplateId="&strEmployeeScheID
		if IsExistsValue(strSQL) = false then 
			'没注册的，则找一个未使用最小的ScheduleCode来注册该时间表
			strSQL = " update ControllerSchedule set TemplateId="&strEmployeeScheID&",TemplateName=(select top 1 TemplateName from ControllerTemplates where TemplateId="&strEmployeeScheID&" ),Status=0 where  ControllerId="&CStr(arrConValue(j))&" and ScheduleCode=(select Min(ScheduleCode) from ControllerSchedule where ControllerId="&CStr(arrConValue(j))&" and  ISNULL(TemplateId,0)=0 ) ;  "
		strSQL = strSQL + " update ControllerDataSync set SyncStatus=0,SyncTime=GETDATE() where ControllerId="&CStr(arrConValue(j))&" and SyncType='schedule' "
			On Error Resume Next
			Conn.Execute strSQL
			if err.number <> 0 then
				Call fCloseADO()
				Call ReturnMsg("false","注册时间表到设备:[ControllerId="+CStr(arrConValue(j))+"]时出错！"+Err.Description,0)
				On Error GoTo 0
				response.End()
			end if
		end if
	Next

	strSQL = ""
	n=0
	For j=0 To UBound(arrConValue)
		If isClearOld="0" Then   '追加
			'strSQL = strSQL + "delete from ControllerEmployee where ControllerId in("+CStr(arrConValue(j))+") and Employeeid in(select Employeeid from ("+CStr(strEmCode)+") A );"
			'追加注册，只注册未注册的数据，已注册的不修改
			strSQL = strSQL + "insert into ControllerEmployee(ControllerId,Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag,Status, ValidateMode) select "+cstr(arrConValue(j))+", E.Employeeid, U.Userpassword,'"+cstr(strEmployeeScheID)+"','"+CStr(strEmployeeDoor)+"','0','0', '"+cstr(strValidateMode)+"'  from Employees E left join Users U on  E.Employeeid=U.Employeeid where  E.EmployeeId in (select EmployeeId from ("+CStr(strEmCode)+") A ) and Left(E.IncumbencyStatus,1)!='1' and E.Card>0 and E.EmployeeId not in (select Employeeid from ControllerEmployee where ControllerId in ("+cstr(arrConValue(j))+") ) "
			'取有访问权限的部门
			if strUserId<>"1" then '1 为admin用户
				strSQL = strSQL & " and E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			end if 
			strSQL = strSQL & "; "
		Else               '覆盖
			'清空原注册卡号SQL语句
			strSQL = strSQL + "delete from ControllerEmployee where ControllerId in("+CStr(arrConValue(j))+") "
			'取有访问权限的部门
			if strUserId<>"1" then '1 为admin用户
				strSQL = strSQL & " and Employeeid in (select Employeeid from Employees E where E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) ) "
			end if 
			strSQL = strSQL & "; "
			strSQL = strSQL + "insert into ControllerEmployee(ControllerId,Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag,Status, ValidateMode) select "+cstr(arrConValue(j))+", E.Employeeid, U.Userpassword,'"+cstr(strEmployeeScheID)+"','"+CStr(strEmployeeDoor)+"','0','0', '"+cstr(strValidateMode)+"'  from Employees E left join Users U on  E.Employeeid=U.Employeeid where  E.EmployeeId in(select EmployeeId from ("+CStr(strEmCode)+") A ) and Left(E.IncumbencyStatus,1)!='1' and E.Card>0 "
			'取有访问权限的部门
			if strUserId<>"1" then '1 为admin用户
				strSQL = strSQL & " AND E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			end if 
			strSQL = strSQL & "; "
		End If
		n = n + 1
		'避免设备太多时，SQL语句过长。 每10台设备的SQL语句就执行一次
		if n >= 10 then
			On Error Resume Next
			Conn.Execute strSQL
			if err.number <> 0 then
				Call fCloseADO()
				Call ReturnMsg("false","模板:["+CStr(strTemplateName)+"]时注册到设备时失败！"+Err.Description,0)
				On Error GoTo 0
				response.End()
			end if 
			n = 0
			strSQL = ""
		end if
	next
		
	If Left(strEmController,1) = "0" Then   '所有设备
		strSQL = strSQL + "delete from ControllerDataSync where ControllerId in(select ControllerId from Controllers) and SyncType='register';insert into  ControllerDataSync(ControllerId, SyncType, SyncStatus, SyncTime) select ControllerId, 'register', 0, getdate() from Controllers where ControllerId in(select ControllerId from Controllers);"
	Else
		strSQL = strSQL + "delete from ControllerDataSync where ControllerId in("+CStr(strEmController)+") and SyncType='register';insert into  ControllerDataSync(ControllerId, SyncType, SyncStatus, SyncTime) select ControllerId, 'register', 0, getdate() from Controllers where ControllerId in("+CStr(strEmController)+");"
	End If 
	
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false","模板:["+CStr(strTemplateName)+"]时注册到设备时失败！"+Err.Description,0)
		On Error GoTo 0
		response.End()
	end if

	strActions = GetCerbLbl("strLogAdd")
	Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号,模板注册到设备,模板名称:["&CStr(strTemplateName)&"]")
	
Next


Call fCloseADO()
Call ReturnMsg("true","已将所选模板注册到了相应的设备",0)
	
%>