<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strEditData,strActions
strEditData = Request.Form("strEdit")

if	strEditData="" then 
	Call ReturnMsg("false","参数错误",0)
	response.End()
end if
if GetOperRole("Bell","edit") <> true then 
	Call ReturnMsg("false","您无权操作！",0)
	response.End()
end if

Call fConnectADODB()

'执行时间
Dim EditArray
if	strEditData<>"" then 
	EditArray = split(strEditData,"||")
	If	IsArray(EditArray) then 
		For i = 0 To UBound(EditArray)
			Row = split(EditArray(i),",,")
			strSQL = "UPDATE Bell set EnableBell='"&Row(1)&"',Voice = '"&Row(2)&"',Out='"&Row(3)&"',Time1 = '"&Row(4)&"',Time2='"&Row(5)&"',Time3 = '"&Row(6)&"',Time4='"&Row(7)&"',Time5 = '"&Row(8)&"',Time6='"&Row(9)&"',Time7 = '"&Row(10)&"',Time8 = '"&Row(11)&"',Time9 = '"&Row(12)&"',Time10 = '"&Row(13)&"' where RecordID="&Row(0)
			On Error Resume Next
			Conn.Execute strSQL
			if err.number <> 0 then
				Call fCloseADO()
				Call ReturnMsg("false",Err.Description,0)
				On Error GoTo 0
				response.End()
			end if
		Next 
	End if
end if

strActions = GetCerbLbl("strLogEdit")
Call AddLogEvent("系统设置",cstr(strActions),cstr(strActions)&"铃响")

Call fCloseADO()
Call ReturnMsg("true","执行成功",0)

%>