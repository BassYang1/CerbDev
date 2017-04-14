<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strOper, strRecordID,strActions
strOper = request.Form("oper")
strRecordID = Replace(request.Form("id"),"'","''")

Call fConnectADODB()

strSQL=""
Select Case strOper
	Case "del": 'Delete Record
	strSQL = "Delete From LogEvent Where EventID in ("&strRecordID&")"
End Select

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
	
	strActions = GetCerbLbl("strLogDel")
	'Call AddLogEvent("工具-日志",cstr(strActions),cstr(strActions)&"日志,ID["&strRecordID&"]")	
	Call AddLogEvent(GetToolLbl("Tool")&"-"&GetToolLbl("logevent"),cstr(strActions),cstr(strActions)&GetToolLbl("logevent")&",ID["&strRecordID&"]")	
	Call fCloseADO()
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"
else
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
end if

%>