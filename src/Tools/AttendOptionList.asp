<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Common\Controller.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL, strJS

dim strUserId
strUserId = session("UserId")

if GetOperRole("Options",strOper) <> true then 
	Call ReturnMsg("false", GetEmpLbl("NoRight"), 0)'您无权操作！
	response.End()
end if

Call fConnectADODB()

On Error Resume NEXT

strSQL = "select(select '{"&chr(34)&"name"&chr(34)&":"&chr(34)&"'+ VariableName + '"&chr(34)&","&chr(34)&"value"&chr(34)&":"&chr(34)&"' + VariableValue + '"&chr(34)&"},' from Options where VariableName in ('strLate', 'strLeaveEarly', 'strAbnormity', 'strOnduty', 'strOTType', 'strTotalCycle', 'strAnalyseOffDuty', 'blnAnalyseWorkDay', 'strWorkflowApproval', 'blnautoTotal', 'datAutotime')" & " order by VariableId for xml path('')) JsonData"

'response.write strSQL
'response.end

Rs.open strSQL, Conn, 2, 1
strJS = "["

If Not Rs.eof Then
	strJS = strJS & Trim(Rs.fields(0).value)
End If

Rs.close
if len(strJS) >= 2 then 
	strJS=left(strJS,InStrRev(strJS,",")-1)
end if
strJS=strJS & "]"
response.write strJS
	
fCloseADO()
%>