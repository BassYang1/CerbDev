<!--#include file="..\Conn\conn.asp" -->
<!--#include file="SearchExec.asp" -->

<%
dim strJS
dim tempId         '部门编号
dim iDepLeavel     '部门级别
dim iflag			'0待注册 1为按部门 2为按模板 3为按条件搜索   '6为根据员工ID获取人员信息
dim strEmployeeId ,strControllerId
Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere,strExportSql

tempId = trim(Request.QueryString("TempId"))         '部门编号
iflag = Cstr(trim(Request.QueryString("iflag")) )
strEmployeeId = trim(Request.QueryString("EmployeeId")) 
strControllerId = trim(Request.QueryString("ControllerId")) 

strSearchOn = request.QueryString("search")
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

fConnectADODB()
strJS = ""

If iflag = "0" Then
	strSQL = "select EmployeeId, Number,Name from Employees where Card>0 and EmployeeId not in (select EmployeeId from ControllerEmployee where Deleteflag != 1 and ControllerId=(select top 1 ControllerId from (select distinct ControllerId from Controllers) as A order by (select count(*) from ControllerEmployee where ControllerId=A.ControllerId))) and Left(IncumbencyStatus,1) <> '1' "
	'取有访问权限的部门
	if strUserId<>"1" then '1 为admin用户
		strSQL = strSQL & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if 
	strSQL = strSQL & " order by Number "
	strJS = ""
	Rs.open strSQL, Conn, 1, 1
	if err.number <> 0 then
		Call fCloseADO()
		response.write Err.Description
		On Error GoTo 0
		response.End()
	end if
	if Rs.eof=false and Rs.Bof=false then
		while NOT Rs.EOF
			strJS = strJS + "','" + trim(Rs.fields("EmployeeId").value) + "," + trim(Rs.fields("Number").value) + "-" + trim(Rs.fields("Name").value)
			Rs.movenext
		wend
	End if
	Rs.close
ElseIf iflag = "1" Then    '部门
	strJS = ""
	If tempId = "0" Then  '0为全部所有部门
		strSQL = "select EmployeeId, Number,Name from Employees where Left(IncumbencyStatus,1) <> '1' and Card>0 "
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strSQL = strSQL & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
		end if 
		strSQL = strSQL & " order by Number "
		Rs.open strSQL, Conn, 1, 1
		if err.number <> 0 then
			Call fCloseADO()
			response.write Err.Description
			On Error GoTo 0
			response.End()
		end if
		while NOT Rs.EOF
			strJS = strJS + "','" + trim(Rs.fields("EmployeeId").value) + "," + trim(Rs.fields("Number").value) + "-" + trim(Rs.fields("Name").value)
			Rs.movenext
		wend
		Rs.close
	ElseIf tempId <> "" then                            '注意部门级别
		'strSQL = "select EmployeeId, Number,Name from Employees E Left Join Departments D ON E.departmentID=D.DepartmentID where D.DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID='"&tempId&"') and  Left(IncumbencyStatus,1) <> '1' and Card>0  order by Number "
		'20140512 前台选择某个部门时，将子部门的ID一起返回
		strSQL = "select EmployeeId, Number,Name from Employees E  where DepartmentID in ("&tempId&") and  Left(IncumbencyStatus,1) <> '1' and Card>0 "
		'取有访问权限的部门
		if strUserId<>"1" then '1 为admin用户
			strSQL = strSQL & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
		end if 
		strSQL = strSQL & " order by Number "
		Rs.open strSQL, Conn, 1, 1
		if err.number <> 0 then
			Call fCloseADO()
			response.write Err.Description
			On Error GoTo 0
			response.End()
		end if
		while NOT Rs.EOF
			strJS = strJS + "','" + trim(Rs.fields("EmployeeId").value) + "," + trim(Rs.fields("Number").value) + "-" + trim(Rs.fields("Name").value)
			Rs.movenext
		wend
		Rs.close
	end if
	
Elseif iflag = "2" Then    '模板选择
	strSQL = "select EmployeeCode from ControllerTemplates where TemplateId="+Trim(tempId)
	On Error Resume next
	Rs.open strSQL, Conn, 1, 1
	If Not Rs.eof Then
		If Not IsNull(Rs.fields("EmployeeCode").value) and trim(Rs.fields("EmployeeCode").value)<>"" Then
			'strSQL = Trim(Rs.fields("EmployeeCode").value)
			strSQL = "select EmployeeId, Number,Name from Employees where Employeeid in (" + Trim(Rs.fields("EmployeeCode").value) + ") and Left(IncumbencyStatus,1) <> '1' and card>0  " 
			'取有访问权限的部门
			if strUserId<>"1" then '1 为admin用户
				strSQL = strSQL & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			end if 
			strSQL = strSQL & " order by Number "
		Else
			strSQL = "select EmployeeId, Number,Name from Employees where Left(IncumbencyStatus,1) <> '1' and card>0  "
			'取有访问权限的部门
			if strUserId<>"1" then '1 为admin用户
				strSQL = strSQL & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
			end if 
			strSQL = strSQL & " order by Number "
		End If
	End If
	Rs.close
	Rs.open strSQL, Conn, 1, 1
	if err.number <> 0 then
		Call fCloseADO()
		response.write Err.Description
		On Error GoTo 0
		response.End()
	end if
	While Not Rs.eof
		strJS = strJS + "','" + trim(Rs.fields("EmployeeId").value) + "," + trim(Rs.fields("Number").value) + "-" + trim(Rs.fields("Name").value)
		Rs.movenext
	Wend
	Rs.close
	
Elseif iflag = "3" Then    '搜索

	strWhere = ""
	If (strSearchOn = "true") Then
		strField = request.QueryString("searchField")
		strFieldData = request.QueryString("searchString")
		strSearchOper = request.QueryString("searchOper")
		if strWhere = "" then 
			strWhere = " where "
		else
			strWhere = strWhere & " and "
		end if
		strWhere = strWhere & GetSearchSQLWhere(strField,strSearchOper,strFieldData)		'construct where
		
	End If
	strSQL = "select EmployeeId, Number,Name from  Employees E Left Join Departments D ON E.departmentID=D.DepartmentID "&strWhere
	'取有访问权限的部门
	if strUserId<>"1" then '1 为admin用户
		strSQL = strSQL & " and E.DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if 
	strSQL = strSQL & " order by Number "
	Rs.open strSQL, Conn, 1, 1
	if err.number <> 0 then
		Call fCloseADO()
		response.write Err.Description
		On Error GoTo 0
		response.End()
	end if
	While Not Rs.eof
		strJS = strJS + "','" + trim(Rs.fields("EmployeeId").value) + "," + trim(Rs.fields("Number").value) + "-" + trim(Rs.fields("Name").value)
		Rs.movenext
	Wend
	Rs.close
				
ElseIf iflag = "6" Then '根据员工ID获取员工信息

	strSQL = "select EmployeeId, Number,Name from Employees where EmployeeId in ("&strEmployeeId&") and Card>0 and Left(IncumbencyStatus,1) <> '1' "
	'取有访问权限的部门
	if strUserId<>"1" then '1 为admin用户
		strSQL = strSQL & " and DepartmentId in (select DepartmentID from RoleDepartment where UserId in ("&strUserId&") and Permission=1 ) "
	end if 
	strSQL = strSQL & " order by Number "
	strJS = ""
	Rs.open strSQL, Conn, 1, 1
	if err.number <> 0 then
		Call fCloseADO()
		response.write Err.Description
		On Error GoTo 0
		response.End()
	end if
	if Rs.eof=false and Rs.Bof=false then
		while NOT Rs.EOF
			strJS = strJS + "','" + trim(Rs.fields("EmployeeId").value) + "," + trim(Rs.fields("Number").value) + "-" + trim(Rs.fields("Name").value)
			Rs.movenext
		wend
	End if
	Rs.close
		
ElseIf iflag = "7" Then '根据员工ID获取已注册的验证方式、时间表、进出门及楼层

	strSQL = "select top 1 ISNULL(ScheduleCode,'') as ScheduleCode,ISNULL(EmployeeDoor,'') as EmployeeDoor,ISNULL(ValidateMode,'') as ValidateMode,ISNULL(Floor,'') as Floor,ISNULL(CombinationID,'') as CombinationID from ControllerEmployee where EmployeeId in ("&strEmployeeId&") and ControllerId in ("&strControllerId&") order by EmployeeId,ControllerId "
	strJS = ""
	Rs.open strSQL, Conn, 1, 1
	if err.number <> 0 then
		Call fCloseADO()
		response.write Err.Description
		On Error GoTo 0
		response.End()
	end if
	if Rs.eof=false and Rs.Bof=false then
		strJS = trim(Rs.fields("ScheduleCode").value) + "','" + trim(Rs.fields("EmployeeDoor").value) + "','" + trim(Rs.fields("ValidateMode").value) + "','" + trim(Rs.fields("Floor").value) + "','" + trim(Rs.fields("CombinationID").value)
	End if
	Rs.close

end if

response.write strJS

fCloseADO()
%>