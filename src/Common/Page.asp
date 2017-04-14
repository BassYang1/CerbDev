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
%>