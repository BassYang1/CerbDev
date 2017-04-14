<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID,strFieldId,strContent,strActions
response.Charset="utf-8"

strFieldId = Trim(Request.Form("FieldId"))
strOper = request.Form(("oper"))
strRecordID = Replace(request.Form("id"),"'","''")
strContent = Replace(request.Form("Content"),"'","''")


if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 

if GetOperRole("SetCode",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

Call fConnectADODB()

'判断部门名称是否存在
strSQL=""
Select Case strOper
	Case "add": 'Add Record
	strSQL = "Select 1 from TableFieldCode where Content='"&strContent&"' and FieldId="&strFieldId
	Case "edit": 'Edit Record
	strSQL = "Select 1 from TableFieldCode where Content='"&strContent&"' and RecordID <> "&strRecordID&" and FieldId="&strFieldId
End Select
if	strSQL<>"" then 
	if IsExistsValue(strSQL) = true then 
		Call fCloseADO()
		Call ReturnMsg("false",GetToolLbl("NameUsed"),0)	'"名称已使用"
		response.End()
	end if
end if

strSQL = ""
Select Case strOper
	Case "add": 'Add Record	
		if strFieldId = "" or strContent = "" then 
			Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
			response.End()
		end if
		strSQL = "Insert Into TableFieldCode (FieldId,Content) select '"&strFieldId&"','"&strContent&"' "
	Case "edit": 'Edit Record
		strSQL = "Update TableFieldCode Set Content ='"&strContent&"' Where RecordID = "&strRecordID
	Case "del": 'Delete Record
		strSQL = "Delete From TableFieldCode Where RecordID in ("&strRecordID&")"
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
			Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("SetCode"),cstr(strActions),cstr(strActions)&GetToolLbl("Code")&","&GetToolLbl("Name")&"["&strContent&"]")
		Case "edit": 'Edit Record
			strActions = GetCerbLbl("strLogEdit")
			Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("SetCode"),cstr(strActions),cstr(strActions)&GetToolLbl("Code")&",ID["&strRecordID&"],"&GetToolLbl("EditLastName")&"["&strContent&"]")
		Case "del": 'Delete Record
			strActions = GetCerbLbl("strLogDel")
			Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("SetCode"),cstr(strActions),cstr(strActions)&GetToolLbl("Code")&",ID["&strRecordID&"]")
	End Select

	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)'执行成功
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
end if

%>