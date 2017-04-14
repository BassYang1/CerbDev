<%Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID, strEmployeeid,strDepartmentID,strName,strNumber,strCard,strIdentityCard,strSex,strHeadship,strPosition,strTelephone
dim strEmail,strBirthDate,strJoinDate,strMarry,strKnowledge,strCountry,strNativePlace,strAddress,strIncumbencyStatus,strDimissionDate,strDimissionReason,strDimission,strDate
Dim DeleteFlag,strConWhere,strActions
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

response.Charset="utf-8"
strOper = request.Form("oper")
strRecordID = Replace(request.Form("id"),"'","''")
strEmployeeid = Replace(request.Form("EmployeeID"),"'","''")
strDepartmentID = Replace(request.Form("DepartmentID"),"'","''")
strName = Replace(request.Form("Name"),"'","''")
strNumber = Replace(request.Form("Number"),"'","''")
strCard = Replace(request.Form("Card"),"'","''")
strIdentityCard = Replace(request.Form("IdentityCard"),"'","''")
strSex = Replace(request.Form("Sex"),"'","''")
strHeadship = Replace(request.Form("Headship"),"'","''")
strPosition = Replace(request.Form("Position"),"'","''")
strTelephone = Replace(request.Form("Telephone"),"'","''")

strEmail = Replace(request.Form("Email"),"'","''")
strBirthDate = Replace(request.Form("BirthDate"),"'","''")
strJoinDate = Replace(request.Form("JoinDate"),"'","''")
strMarry = Replace(request.Form("Marry"),"'","''")
strKnowledge = Replace(request.Form("Knowledge"),"'","''")
strCountry = Replace(request.Form("Country"),"'","''")
strNativePlace = Replace(request.Form("NativePlace"),"'","''")
strAddress = Replace(request.Form("Address"),"'","''")
strIncumbencyStatus = Replace(request.Form("IncumbencyStatus"),"'","''")
strDimissionDate = Replace(request.Form("DimissionDate"),"'","''")
strDimissionReason = Replace(request.Form("DimissionReason"),"'","''")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 

if GetOperRole("Employees",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

Call fConnectADODB()

'判断卡号是否存在 
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from employees where card='"&strCard&"' and Left(IncumbencyStatus,1) <> '1' "
	Case "edit": 'Edit Record
	strSQL = "Select 1 from employees where card='"&strCard&"' and  Left(IncumbencyStatus,1) <> '1' and Employeeid <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetEmpLbl("CardUsed"),0)'"卡号已使用"
		response.End()
	end if
end if

'判断工号是否存在 
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from employees where Number='"&strNumber&"' and Left(IncumbencyStatus,1) <> '1' "
	Case "edit": 'Edit Record
	strSQL = "Select 1 from employees where Number='"&strNumber&"' and  Left(IncumbencyStatus,1) <> '1' and Employeeid <> "&strRecordID
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetEmpLbl("NumberUsed"),0)'"工号已使用"
		response.End()
	end if
end if

'记录离职日期。 若离职日期为空，则使用当前系统日期
strDimission=""
if strIncumbencyStatus <> "" and len(strIncumbencyStatus) > 0 and left(strIncumbencyStatus,1) <> "1" then 
	strDimission = ",DimissionDate=NULL,DimissionReason=NULL"
else
	if strDimissionDate = "" then 
		strDate=now()
		strDimissionDate=CStr(Year(strDate))&"-"
		if Len(CStr(Month(strDate)))=1 then 
			strDimissionDate = strDimissionDate&"0"&CStr(Month(strDate))&"-"
		else
			strDimissionDate = strDimissionDate&CStr(Month(strDate))&"-"
		end if
    	if Len(CStr(Day(strDate)))=1 then 
			strDimissionDate = strDimissionDate&"0"&CStr(Day(strDate))
		else
			strDimissionDate = strDimissionDate&CStr(Day(strDate))
		end if
	end if
	strDimission = ",DimissionDate='"&strDimissionDate&"',DimissionReason='"&strDimissionReason&"'"
end if
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Insert Into Employees (DepartmentID,Name,Number,Card,IdentityCard,Sex,Headship,Position,Telephone,Email,BirthDate,JoinDate,Marry,Knowledge,Country,NativePlace,Address,IncumbencyStatus)   Values("&strDepartmentID&", '"&strName&"', '"&strNumber&"','"&strCard&"','"&strIdentityCard&"','"&strSex&"','"&strHeadship&"','"&strPosition&"','"&strTelephone&"','"&strEmail&"','"&strBirthDate&"','"&strJoinDate&"','"&strMarry&"','"&strKnowledge&"','"&strCountry&"','"&strNativePlace&"','"&strAddress&"','"&strIncumbencyStatus&"') "
	Case "edit": 'Edit Record
	strSQL = "Update employees Set DepartmentID ="&strDepartmentID&",Name = '"&strName&"',Number = '"&strNumber&"', Card = '"&strCard&"', IdentityCard = '"&strIdentityCard&"', Sex = '"&strSex&"', Headship = '"&strHeadship&"', Position = '"&strPosition&"', Telephone = '"&strTelephone&"', Email = '"&strEmail&"', BirthDate = '"&strBirthDate&"', JoinDate = '"&strJoinDate&"', Marry = '"&strMarry&"', Knowledge = '"&strKnowledge&"', Country = '"&strCountry&"', NativePlace = '"&strNativePlace&"', Address = '"&strAddress&"', IncumbencyStatus = '"&strIncumbencyStatus&"'"&strDimission&" Where Employeeid = "&strRecordID
	'人事资料有修改时，重新同步注册卡号
	if len(trim(strIncumbencyStatus)) > 1 then 
		DeleteFlag = Left(trim(strIncumbencyStatus),1)
		if DeleteFlag <> "1" then DeleteFlag = "0" end if
	else
		DeleteFlag = "0"
	end if
	strSQL = strSQL + " ; Update ControllerEmployee set Status='0',DeleteFlag='"&DeleteFlag&"' where employeeid="+CStr(strRecordID)
	strSQL = strSQL +  "; Update ControllerDataSync Set SyncStatus='0' where SyncType='register' "
	Case "del": 'Delete Record
	strSQL = " Update ControllerEmployee set Status='0',DeleteFlag='1' where Employeeid in( "&strRecordID&")"
	strSQL = strSQL +  "; Update ControllerDataSync Set SyncStatus='0' where SyncType='register' "
	strSQL = strSQL +  "; Delete From employees Where Employeeid in( "&strRecordID&")"
End Select
'response.Write strSQL
'response.Write("{"&chr(34)&"success"&chr(34)&":true,"&chr(34)&"message"&chr(34)&":"&chr(34)&"保存失败"&chr(34)&"}")


'Set rs = Conn.Execute(strSQL)
if	strSQL<>"" then 

	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",Err.Description,0)
		On Error GoTo 0
		response.End()
	end if
	if strOper = "add" then 
		strRecordID = GetMaxID("employeeid","employees")
	end if
	
	Select Case strOper
		Case "add": 'Add Record
			strActions = GetCerbLbl("strLogAdd")
			'Call AddLogEvent("人事资料-人事-人事列表",cstr(strActions),cstr(strActions)&"人事,工号["&strNumber&"]")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("EmpData")&"-"&GetEmpLbl("EmpList"),cstr(strActions),cstr(strActions)&GetEmpLbl("EmpData")&","&GetEmpLbl("Num")&"["&strNumber&"]")
		Case "edit": 'Edit Record
			strActions = GetCerbLbl("strLogEdit")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("EmpData")&"-"&GetEmpLbl("EmpList"),cstr(strActions),cstr(strActions)&GetEmpLbl("EmpData")&","&GetEmpLbl("EmpID")&"["&strRecordID&"],"&GetEmpLbl("EditNum")&"["&strNumber&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("EmpData")&"-"&GetEmpLbl("EmpList"),cstr(strActions),cstr(strActions)&GetEmpLbl("EmpData")&","&GetEmpLbl("EmpID")&"["&strRecordID&"]")
	End Select

	if strOper = "add" then 	
		'新增加的人事，按模板自动注册到设备
		
		'取有访问权限的设备
		strConWhere = ""
		if strUserId<>"1" then '1 为admin用户
			strConWhere = " select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 "
		end if 
		On Error Resume Next		
		set recom = server.createobject("adodb.command")
		recom.activeconnection = Conn
		recom.commandtype = 4
		recom.CommandTimeout = 0
		recom.Prepared = true
		recom.Commandtext = "pRegCardTemplateRegisterAll"
		recom.Parameters(1) = "0"	'0为追加注册。（已注册的不做修改。当有多个模板时，ID最大的优先注册）
		recom.Parameters(2) = strRecordID	'员工ID
		recom.Parameters(3) = strConWhere	'有权限的设备 
		
		On Error Resume Next	
		recom.execute()
		if err.number <> 0 then
			'Call AddLogEvent("人事资料-人事-自动注册",cstr(strActions),cstr(strActions)&"注册卡号,模板自动注册到设备失败,员工工号:["&CStr(strNumber)&"]")
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("EmpData")&"-"&GetEmpLbl("AutoReg"),cstr(strActions),cstr(strActions)&GetEmpLbl("AutoRegMsgFail")&"["&CStr(strNumber)&"]")
		Else
			Call AddLogEvent(GetEmpLbl("Emp")&"-"&GetEmpLbl("EmpData")&"-"&GetEmpLbl("AutoReg"),cstr(strActions),cstr(strActions)&GetEmpLbl("AutoRegMsg")&"["&CStr(strNumber)&"]")
		End if
	End if		
	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),strRecordID)	'将EmployeeId返回，以便更新照片时使用
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'参数错误
end if

%>