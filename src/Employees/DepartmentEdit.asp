<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strDepartmentCode, strDepartmentName,strNewDepartmentCode,strNewDepartmentCodeLen,strActions
dim departmentId,strParentDepartmentCode,strParentDepartmentID
response.Charset="utf-8"

departmentId = Trim(Request.QueryString("departmentId"))
strOper = request.Form(("oper"))
strRecordID = Replace(request.Form("id"),"'","''")
strDepartmentCode = Replace(request.Form("DepartmentCode"),"'","''")
strDepartmentName = Replace(request.Form("DepartmentName"),"'","''")
strParentDepartmentID = Replace(request.Form("ParentDepartmentID"),"'","''")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 

if GetOperRole("Department",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if strParentDepartmentID = "" then 
	strParentDepartmentID = "0"
end if

Call fConnectADODB()

'判断部门名称是否存在
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from Departments where DepartmentName='"&strDepartmentName&"'"
	Case "edit": 'Edit Record
	strSQL = "Select 1 from Departments where DepartmentName='"&strDepartmentName&"' and DepartmentID <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetEmpLbl("DeptNameUsed"),0)'部门名称已使用
		response.End()
	end if
end if

strSQL = ""
Select Case strOper
	Case "add": 'Add Record
		if strParentDepartmentID <> "0" then 
			strParentDepartmentCode = Cstr(GetFieldValue("DepartmentCode","Departments where DepartmentID='"&strParentDepartmentID&"'"))
		else
			strParentDepartmentCode = ""
		end if
		if	Len(strParentDepartmentCode) >= 50 then 
			Call fCloseADO()
			Call ReturnMsg("false",GetEmpLbl("DeptMaxTenLevel"),0)	'部门最大支持10级
			response.End()
		end if
		
		strNewDepartmentCodeLen = len(strParentDepartmentCode) + 5
		strNewDepartmentCode = GetMaxID("DepartmentCode","Departments where Len(DepartmentCode)="&strNewDepartmentCodeLen&" and DepartmentCode like '"&strParentDepartmentCode+"%' ")
		if strNewDepartmentCode = 0 then 
			strNewDepartmentCode = CSTR(strParentDepartmentCode&"00001")
		else 
			rightCode = right(strNewDepartmentCode,5)
			if rightCode <> "" then 
				rightCode = CSTR(Cint(rightCode) + 1)
			end  if
			While len(rightCode) < 5 
				rightCode = "0"+Cstr(rightCode)
			Wend
			strNewDepartmentCode = CSTR(left(strNewDepartmentCode,Len(strNewDepartmentCode)-5))&rightCode
		end if
		
		strSQL = "Insert Into Departments (DepartmentCode,DepartmentName,ParentDepartmentID) select '"&strNewDepartmentCode&"','"&strDepartmentName&"','"&strParentDepartmentID&"' "
	Case "edit": 'Edit Record
		strSQL = "Update Departments Set DepartmentName ='"&strDepartmentName&"' Where DepartmentID = "&strRecordID
	Case "del": 'Delete Record
		strSQL = "select top 1 1 from Employees E inner join Departments D on E.DepartmentID=D.DepartmentID where D.DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID = '"&strRecordID&"') "
		if IsExistsValue(strSQL) = true then 
			Call fCloseADO()
			Call ReturnMsg("false",GetEmpLbl("DeptNotDel"),0)	'该部门或子部门下有人事资料，不能删除
			response.End()
		end if
		strSQL = "Delete From RoleDepartment where DepartmentID in (select DepartmentID From Departments Where DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID = '"&strRecordID&"')); "
		strSQL = strSQL&"Delete From Departments Where DepartmentCode like (select DepartmentCode+'%' from Departments where DepartmentID = '"&strRecordID&"') "
End Select
'response.Write strSQL
'response.Write("{"&chr(34)&"success"&chr(34)&":true,"&chr(34)&"message"&chr(34)&":"&chr(34)&"保存失败"&chr(34)&"}")

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
			'Call AddLogEvent("人事资料-人事-部门列表",cstr(strActions),cstr(strActions)&"部门,部门名称["&strDepartmentName&"]")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("EmpData")&"-"&GetEmpLbl("DeptList"),cstr(strActions),cstr(strActions)&GetEmpLbl("Dept")&","&GetEmpLbl("DeptName")&"["&strDepartmentName&"]")
		Case "edit": 'Edit Record
			strActions = GetCerbLbl("strLogEdit")
			'Call AddLogEvent("人事资料-人事-部门列表",cstr(strActions),cstr(strActions)&"部门,部门ID["&strRecordID&"],修改后名称["&strDepartmentName&"]")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("EmpData")&"-"&GetEmpLbl("DeptList"),cstr(strActions),cstr(strActions)&GetEmpLbl("Dept")&","&GetEmpLbl("Dept")&"ID["&strRecordID&"],"&GetEmpLbl("EditName")&"["&strDepartmentName&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("EmpData")&"-"&GetEmpLbl("DeptList"),cstr(strActions),cstr(strActions)&GetEmpLbl("Dept")&","&GetEmpLbl("Dept")&"ID["&strRecordID&"]")
	End Select

	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)'执行成功
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'参数错误
end if

%>