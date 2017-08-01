<!--#include file="..\Conn\GetLbl.asp"-->
<%
response.Charset="utf-8"
'strLogAdd = GetCerbLbl("strLogAdd")	'"增加"
'strLogEdit = GetCerbLbl("strLogEdit")	'"修改"
'strLogDel = GetCerbLbl("strLogDel")	'"删除"
'strLogSync = GetCerbLbl("strLogSync")	'"同步"

'const strLogAdd = "增加"
'const strLogEdit = "修改"
'const strLogDel = "删除"
'const strLogSync = "同步"

Function GetSafeJs( str )
	Dim Temp
	Temp = str
	If Temp<> "" Then
		If InStr(Temp, "\") > 0 Then
			Temp = Replace( Temp, "\", "\\")
		End If
		If InStr(Temp, "'") > 0 Then
			Temp = Replace( Temp, "'", "\'")
		End If
	End If
	GetSafeJs = Temp
End Function

'返回JSON格式信息。rStatus：true or false; rMsg为提示信息
Function ReturnMsg(rStatus,rMsg,id )
	Dim Temp
	Temp = "{"&chr(34)&"success"&chr(34)&":"&rStatus&","&chr(34)&"message"&chr(34)&":"&chr(34)&rMsg&chr(34)&","&chr(34)&"id"&chr(34)&":"&chr(34)&id&chr(34)&"}"
	response.Write(Temp)
	'if	returnStatus=false then 
	'	response.End()
	'end if
	'ReturnMsg = Temp
End Function

Function ReturnErrMsg(rMsg)
	Dim Temp
	Temp = "{"&chr(34)&"success"&chr(34)&":false,"&chr(34)&"message"&chr(34)&":"&chr(34)&rMsg&chr(34)&"}"
	response.Write(Temp)
	response.End()
	'if	returnStatus=false then 
	'	response.End()
	'end if
	'ReturnMsg = Temp
End Function


'获取表某字段最大值，若为空则返回0
Function GetMaxID(FieldName,TableName)
	Dim str,MaxID
	str = "select ISNULL(Max("&FieldName&"),0) from "&TableName
	Rs.open str,Conn,1,1
	if Rs.eof=false and Rs.Bof=false then
		MaxID = Rs.Fields(0)
	else
		MaxID = 0
	end if
	Rs.close
	GetMaxID = MaxID
End Function 

Function GetFieldValue(FieldName,TableName)
	Dim str,strValue
	str = "select top (1) "&FieldName&" from "&TableName
	Rs.open str,Conn,1,1
	if Rs.eof=false and Rs.Bof=false then
		strValue = Rs.Fields(0)
	end if
	Rs.close
	GetFieldValue = strValue
End Function 

Function GetFieldValueBySql(StrSql)
	Dim strValue
	Rs.open StrSql,Conn,1,1
	if Rs.eof=false and Rs.Bof=false then
		strValue = Rs.Fields(0)
	end if
	Rs.close
	GetFieldValueBySql = strValue
End Function 

Function GetOneFieldValues( strTable, strField, strCondition )
	
	if strTable = "" or strField = "" then
		exit function
	end if
	GetOneFieldValues = ""
	
	if strCondition <> "" then
		strSQL = "select "+cstr(strField)+" from "+cstr(strTable)+" where " + cstr(strCondition)
	else
		strSQL = "select "+cstr(strField)+" from "+cstr(strTable)
	end If
	ON ERROR RESUME NEXT 
	Rs.open strSQL, Conn, 1, 1

	if Err.Number <> 0 then
		On Error GoTo 0
		Exit Function
	end if
	while NOT Rs.EOF
		if NOT ISNULL(Rs.Fields(0).value) then
			GetOneFieldValues = GetOneFieldValues + "," + trim(Rs.Fields(0).value)
		else
			GetOneFieldValues = ""
		end if
		Rs.movenext
	wend
	Rs.close
	if GetOneFieldValues <> "" then
		GetOneFieldValues = mid(GetOneFieldValues, 2)
	end if
End Function

Function IsExistsValue(StrSql)
	Dim retValue
	Rs.open StrSql,Conn,1,1
	if Rs.eof=false and Rs.Bof=false then
		retValue = true
	else
		retValue = false
	end if
	Rs.close
	IsExistsValue = retValue
End Function 

'登录检查用户是否存在
'返回值：  存在返回1.    否则返回0
Function CheckUserName( strUserName, strUserPswd, strUserId, strEmId, strOperPermissions )
	
	dim strSQL
	if strUserName = "" then
		CheckUserName = 0
	end if
	CheckUserName = 0

	On Error Resume Next
	'strSQL = "select U.employeeid,U.UserId,E.BrushCardStatus from Users U Left join Employees E on U.employeeid=E.employeeid where LoginName='" + cstr(strUserName) + "' and UserPassword='" + cstr(strUserPswd) + "'"
	strSQL = "select U.employeeid,U.UserId,U.OperPermissions from Users U Left join Employees E on U.employeeid=E.employeeid where LoginName='" + cstr(strUserName) + "' and U.UserPassword='" + cstr(strUserPswd) + "'"
	Rs.open strSQL, Conn, 1, 1

	if err.number <> 0 then
		On Error GoTo 0
		exit function
	end if

	if not Rs.EOF then
		strUserId = Rs.fields("UserId").value
		if NOT ISNULL(Rs.fields("EmployeeId").value) then
			strEmId = Rs.fields("EmployeeId").value
			if strEmId = "" then strEmId = 0
		else
			strEmId = 0
		end If
		strOperPermissions = Rs.fields("OperPermissions").value
		'If Rs("BrushCardStatus") = "1" Then 
		'	CheckUserName = 0
		'Else
			CheckUserName = 1
		'End If 
	end if
	Rs.close
End Function

'考勤申请是否走工作流'
Sub CheckWorkflowApproval
	dim strApproverEmpId, strApproverEmpName
	dim strSQL, strOption, arrOptions

	session("WorkflowApproverEmpId") = ""
	session("WorkflowApproverEmpName") = ""
	session("NeedApprovWorkflow") = 0

	On Error Resume Next
	strSQL = "select ISNULL(VariableValue, '') AS VariableValue from Options where VariableName='strWorkflowApproval' and VariableType='str'"
	Rs.open strSQL, Conn, 1, 1

	if err.number <> 0 then
		On Error GoTo 0
		exit sub
	end if

	if not Rs.EOF then
		strOption = Rs.fields("VariableValue").value		
	end if
	Rs.close

	if strOption = "" then
		exit sub
	end if

	'是否启用流程审批,指定员工审批,员工工号,指定管理员审批'
	arrOptions = split(strOption, ",")

	if isarray(arrOptions) = 0 or ubound(arrOptions) < 3 then
		exit sub
	end if

	'启用流程审批'
	if arrOptions(0) = "1" then 
		session("NeedApprovWorkflow") = 1

		'指定员工审批,员工工号'
		if ubound(arrOptions) >= 2 and arrOptions(1) = "1" and arrOptions(2) <> "" then 
			strSQL = "select EmployeeId, Name from Employees where Left(IncumbencyStatus,1) <> '1' and Number='" & arrOptions(2) & "'"
		Else '指定管理员审批'
			strSQL = "select EmployeeId, Name from Employees where Left(IncumbencyStatus,1) <> '1' and EmployeeId=(select top 1 EmployeeId from users where LoginName = 'admin')"
		End If 

		Rs.open strSQL, Conn, 1, 1

		if err.number <> 0 then
			On Error GoTo 0
			exit sub
		end if

		if not Rs.EOF then
			session("WorkflowApproverEmpId") = Rs.fields("EmployeeId").value
			session("WorkflowApproverEmpName") = Rs.fields("Name").value
		end if

		Rs.close
	End if
End Sub

'登录用户是否有审批权限'
Function CheckApprovalPermission()	
	CheckApprovalPermission = 0

	if session("NeedApprovWorkflow") = 1 and session("WorkflowApproverEmpId") <> "" and session("WorkflowApproverEmpId") = session("EmId")  then
		CheckApprovalPermission = 1
	end if
End Function

'检查用户流程操作权限'
Function CheckWorkflowPermission(strOper)	
	CheckWorkflowPermission = false

	if strOper = "add" or strOper = "del" or (CheckApprovalPermission() = 1 and strOper = "edit") then
		CheckWorkflowPermission = true
	end if
End Function

Function AddLogEvent(strModules , strActions , strObjects )
	AddLogEvent=0
	if strModules = "" or strActions = "" then
		AddLogEvent = 0
		exit function
	end if
	dim strSQL
	Dim LoginIP
	LoginIP = Trim(request.ServerVariables("REMOTE_ADDR"))	
	strSQL = "insert into LogEvent(LoginName,LoginIP,OperateTime,Modules,Actions,Objects) values('"+Session("UserName")+"','"+LoginIP+"',getdate(),'"+strModules+"','"+strActions+"','"+strObjects+"')"

	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 Then
		AddLogEvent = 0
		On Error GoTo 0
		exit function
	end If

	AddLogEvent=1
End Function

Function AddLogEvent2(strUserName, strModules , strActions , strObjects )
	AddLogEvent2=0
	if strModules = "" or strActions = "" then
		AddLogEvent2 = 0
		exit function
	end if
	dim strSQL
	Dim LoginIP
	LoginIP = Trim(request.ServerVariables("REMOTE_ADDR"))	
	strSQL = "insert into LogEvent(LoginName,LoginIP,OperateTime,Modules,Actions,Objects) values('"+strUserName+"','"+LoginIP+"',getdate(),'"+strModules+"','"+strActions+"','"+strObjects+"')"

	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 Then
		AddLogEvent2 = 0
		On Error GoTo 0
		exit function
	end If

	AddLogEvent2=1
End Function

'列出子部门及没子部门的部门编号
'入口参数:
'strTable:     表名
'strFields:    字段名
'strCondition  条件
'返回记录条数
Function GetChildDepart()
	
	GetChildDepart = ""
	dim strSQL
	dim strResult
	dim strPrev, strTemp,strPrevId
	dim strUserId
	strUserId = session("UserId")
	if strUserId = "" then strUserId = "0" end if

	strResult = ""
	strPrev = ""
	strTemp = ""
	strSQL = "select DepartmentCode,DepartmentID From Departments "
	'取有访问权限的部门
	if strUserId<>"1" then '1 为admin用户
		strSQL = strSQL & " Where DepartmentID in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if 
	strSQL = strSQL & " order by DepartmentCode "
'	response.write strSQL
	ON ERROR RESUME NEXT
	Rs.open strSQL, Conn, 0, 1
	While NOT Rs.EOF
		if not isnull(Rs.fields("DepartmentCode").value) then
			strTemp = trim(Rs.fields("DepartmentCode").value)
			if len(strTemp) <= len(strPrev) then
				'strResult = strResult + "," + strPrev
				strResult = strResult + "," + strPrevId
			end if
			strPrev = strTemp
			strPrevId = trim(Rs.fields("DepartmentID").value)
		end if
		Rs.movenext
	wend
	Rs.close

	if strPrev <> "" then strResult = strResult + "," + strPrevId
		
	if strResult <> "" then strResult = mid(strResult,2)

	GetChildDepart = strResult
End Function


'获取某个模板可操作权限 
'入口参数:
'strModules:模板名称
'strOper:操作方法 （如add,edit,del等）
'返回值：有权限则返回true，否则返回false
Function GetOperRole(strModules,strOper)
	Dim retValue
	retValue = false
	GetOperRole = retValue
	if session("OperPermissions")="1" and session("UserId") <> "" and session("EmId") <> "" then 
		retValue = true
	else
		retValue = false
	end if
	'一般职员用户可修改自己用户
	if strModules = "Users" and strOper = "edit" then 
		retValue = true 
	end if
	GetOperRole = retValue
End Function

'中文解码。 GET提交中文时 ，JS需要使用encodeURI编码
function URLDecode(enStr)
	dim deStr,strSpecial
	dim c,i,v
	deStr=""
	strSpecial="!""#$%&’()*+,.-_/:;<=>?@[\]^`{|}~%"
	for i=1 to len(enStr)
		c=Mid(enStr,i,1)
		if c="%" then
			v=eval("&h"+Mid(enStr,i+1,2))
			if inStr(strSpecial,chr(v))>0 then
				deStr=deStr&chr(v)
				i=i+2
			else
				v=eval("&h"+ Mid(enStr,i+1,2) + Mid(enStr,i+4,2))
				deStr=deStr & chr(v)
				i=i+5
			end if
		else
			if c="+" then
				deStr=deStr&" "
			else
				deStr=deStr&c
			end if
		end if
	next
	URLDecode=deStr
end function 

'返回SQL where 语句 （不包括 'where' ）
Function GetSearchSQLConidtion(strField,strSearchOper,strFieldData)
	Dim strWhere,isMultiFieldData
	isMultiFieldData = 0
	GetSearchSQLConidtion = ""
	strWhere = "  Left(IncumbencyStatus,1)<>'1' and E.Card>0  "
	'construct where
	IF strField = "DepartmentID" then 
		Select Case strSearchOper
		Case "eq" : 'Equal
			'strWhere = strWhere & " and D.DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID='"&strFieldData&"') "
			'20140512 前台选择某个部门时，将子部门的ID一起返回
			strWhere = strWhere & " and E.DepartmentID in ("&strFieldData&")  "
		Case "ne": 'Not Equal
			'strWhere = strWhere & " and D.DepartmentCode NOT like (select DepartmentCode+'%' from Departments where DepartmentID='"&strFieldData&"') "
			'20140512 前台选择某个部门时，将子部门的ID一起返回
			strWhere = strWhere & " and E.DepartmentID not in ("&strFieldData&")  "
		End Select
		'后面条件判断不再使用
		strSearchOper=""
		strFieldData=""
	ELSEIF strField = "IncumbencyStatus" then 
		strWhere="  E.Card>0 and Left(IncumbencyStatus,1) "
		if Len(strFieldData) >=1 then 
			strFieldData = Left(strFieldData,1)
		end if
	ELSEIF strField = "Card" then 
		strWhere="  Left(IncumbencyStatus,1)<>'1' and E." & strField
	ELSE
		strWhere = strWhere&" and E." & strField
	End if
	
	if strField = "Card" or strField = "Number" or strField = "Name" then
		if InStr(strFieldData,",") > 0 or InStr(strFieldData,"，") > 0 then 
			strFieldData = Replace(strFieldData,"，",",")
			strFieldData = Replace(strFieldData,",","','")
			strFieldData = "'"&strFieldData&"'"
			isMultiFieldData = 1
		end if
	end if
	
	Select Case strSearchOper
		Case "bw" : 'Begin With
			strFieldData = strFieldData & "%"
			strWhere = strWhere & " LIKE '" & strFieldData & "'"
		Case "eq" : 'Equal
			If isMultiFieldData = 1 then 
				strWhere = strWhere & " IN (" & strFieldData & ")"
			Else
				strWhere = strWhere & " = '" & strFieldData & "'"
			End If
		Case "ne": 'Not Equal
			If isMultiFieldData = 1 then 
				strWhere = strWhere & " NOT IN (" & strFieldData & ")"
			Else
				strWhere = strWhere & " <> '"& strFieldData &"'"
			End If
		Case "lt": 'Less Than
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " <" & strFieldData
			Else
				strWhere = strWhere & " <'"& strFieldData &"'"
			End If
		Case "le": 'Less Or Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " <= " & strFieldData
			Else
				strWhere = strWhere & " <= '"& strFieldData &"'"
			End If
		Case "gt": 'Greater Than
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " > " & strFieldData
			Else
				strWhere = strWhere & " > '"& strFieldData &"'"
			End If
		Case "ge": 'Greater Or Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " >= " & strFieldData
			Else
				strWhere = strWhere & " >= '"& strFieldData &"'"
			End If
		Case "ew" : 'End With
			strWhere = strWhere & " LIKE '%" & strFieldData & "'"
		Case "cn" : 'Contains
			strWhere = strWhere & " LIKE '%" & strFieldData & "%'"
		Case "nc" : 'Contains
			strWhere = strWhere & " NOT LIKE '%" & strFieldData & "%'"
	End Select
	
	GetSearchSQLConidtion = strWhere				
End Function


'tempId 模板Id
'isClearOld 清除设备注册历史数据
sub RegCard(tempId, isClearOld)
	On Error Resume Next		
	set recom = server.createobject("adodb.command")
	recom.activeconnection = Conn
	recom.commandtype = 4
	recom.CommandTimeout = 0
	recom.Prepared = true
	recom.Commandtext = "pRegCardTemplateRegister"
	recom.Parameters(1) = tempId
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
end sub

'检测年份正确性
'2006-3-2:Mike
'输入参数：
'strYear: 年份
'iType:   时间数据类型: 0为smalldatetime型, 否则为:datetime型
Function CheckYear( iYear, iType )
	CheckYear = 0
	if not IsNumeric(iYear) then exit function
	if iType = 0 then
		if iYear < 2099 and iYear >= 1900 then
			CheckYear = iYear
		end if
	else
		if iYear < 9999 and iYear > 1111 then
			CheckYear = iYear
		end if
	end if
End Function

'检测月份正确性
'2006-3-2:Mike
'输入参数：
'strYear: 年份
Function CheckMonth( iMonth )
	CheckMonth = 0
	if not IsNumeric(iMonth) then exit function
	if iMonth > 0 and iMonth < 13 then
		CheckMonth = iMonth
	end if
End Function

'检测日期正确性
'2006-3-2:Mike
'输入参数：
'strYear: 日期
Function CheckDay( iDay )
	CheckDay = 0
	if not IsNumeric(iDay) then exit function
	if iDay > 0 and iDay < 32 then
		CheckDay = iDay
	end if
End Function


'检测日期时间正确性 YYYY-MM-DD
'2006-3-2:Mike
'iType:   时间数据类型: 0为smalldatetime型, 否则为:datetime型
'ch   :   时期格式分隔符
Function CheckDate( strDate, iType, ch )
	dim iyear
	dim imonth
	dim iday
	dim arrValues
	CheckDate = 0
	if strDate = "" then
		exit Function
	end if 
	if ch = "" then       '默认格式 YYYY-MM-DD
		ch = "-"
	end if
	arrValues = split(strDate, ch)

	if ubound(arrValues) > 2 then
		exit Function
	end if

	if CheckYear( arrValues(0), iType ) = 0 then
		exit function
	end if

	if CheckMonth( arrValues(1) ) = 0 then
		exit function
	end if

	if CheckDay( arrValues(2) ) = 0 then
		exit function
	end if
	
	CheckDate = 1
End Function
%>