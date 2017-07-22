<!--#include file="..\Conn\GetLbl.asp"-->
<%
response.Charset="utf-8"
'---------------------------------------
' Controller类
' 设备管理
'------------------------------------------

Class Controller 
	Dim DBConnection
	Dim UserId

	'strTempId 模板Id
	'isClearOld 清除设备注册历史数据
	Public Function RegTemplateCard(strTempId, isClearOld)
		Dim strConWhere, strEmpWhere, strSQL
		Dim strTemplateName, strActions
		'20170601 mike 注销下面一句代码
		'isClearOld = 0 '页面同步默认都传0，因为存储过程会通过接口(Job)执行，数据会不停删除并重新同步

		strSQL = "select TemplateName, ISNULL(OnlyByCondition, 0) AS OnlyByCondition from ControllerTemplates where TemplateId="+strTempId
		Rs.Open strSQL, Conn, 1, 1
		If Not Rs.eof Then
			strTemplateName = Trim(Rs.fields("TemplateName").value)

			'If isClearOld = "" then
				'isClearOld = "0"

				'if Rs.fields("OnlyByCondition").value = true then
					'isClearOld = "1"
				'end if
			'end if	
		End If
		Rs.close
		
		'取有访问权限的设备
		strConWhere = ""
		if UserId<>"1" then '1 为admin用户
			strConWhere = " select ControllerID from RoleController where UserId in ("&UserId&") and Permission=1 "
		end if 

		'取有访问权限的部门
		strEmpWhere = ""
		if UserId<>"1" then '1 为admin用户
			strEmpWhere = " Select Employeeid from Employees where DepartmentID in (select DepartmentID from RoleDepartment where UserId in ("&UserId&") and Permission=1) and Left(IncumbencyStatus,1)<>'1' "
		end if 
		
		On Error Resume Next		
		set recom = server.createobject("adodb.command")
		recom.activeconnection = Conn
		recom.commandtype = 4
		recom.CommandTimeout = 0
		recom.Prepared = true
		recom.Commandtext = "pRegCardTemplateRegister"
		recom.Parameters(1) = strTempId
		recom.Parameters(2) = isClearOld
		recom.Parameters(3) = strEmpWhere
		recom.Parameters(4) = strConWhere
		
		On Error Resume Next	
		recom.execute()
		if err.number <> 0 then
			Call fCloseADO()
			RegTemplateCard = Err.Description
			On Error GoTo 0
			exit Function
		end if

		strActions = GetCerbLbl("strLogAdd")
		'Call AddLogEvent("设备管理-注册卡号表-模板方式",cstr(strActions),cstr(strActions)&"注册卡号,模板注册到设备,模板名称:["&CStr(strTemplateName)&"]")
		Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("RegCard")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("RegCard2")&","&GetEquLbl("TempRegCon")&","&GetEquLbl("TempName")&"["&CStr(strTemplateName)&"]")

		RegTemplateCard = ""
	end Function
End Class
%>