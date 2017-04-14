<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strTemplateId, strEditData, strHolidayCode,strTempName,strActions
strTemplateId = Request.Form("TemplateId")
strScheduleID = Request.Form("strScheduleID")
strEditData = Replace(Request.Form("strEdit"),"'","''")

'response.Write(strID&"<br>"&strAddData&"<br>"&strEditData&"<br>"&strDelRowID)
if	strTemplateId="" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if
if GetOperRole("InOutTemplate","edit") <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
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
			strSQL = "UPDATE ControllerTemplateInout set InoutDesc='"&Row(2)&"',OUT1 = '"&Row(3)&"',OUT2='"&Row(4)&"',OUT3 = '"&Row(5)&"',OUT4='"&Row(6)&"',OUT5 = '"&Row(7)&"' where RecordID="&Row(0)
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

'时间表选择
if	strScheduleID<>"" then 
	EditArray = split(strScheduleID,"||")
	If	IsArray(EditArray) then 
		For i = 0 To UBound(EditArray)
			Row = split(EditArray(i),",,")
			if Row(3)<>"undefined" then
				strSQL = "UPDATE ControllerTemplateInout set ScheduleID='"&Row(2)&"',ScheduleName = '"&Row(3)&"' where RecordID="&Row(0)
				On Error Resume Next
				Conn.Execute strSQL
				if err.number <> 0 then
					Call fCloseADO()
					Call ReturnMsg("false",Err.Description,0)
					On Error GoTo 0
					response.End()
				end if
			end if
		Next 
	End if
end if


strActions = GetCerbLbl("strLogEdit")
'Call AddLogEvent("设备管理-输入输出表-模板方式",cstr(strActions),cstr(strActions)&"输入输出模板明细,模板ID["&strTemplateId&"]")
Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Inout")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("InoutTempDetail")&","&GetEquLbl("Template")&"ID["&strTemplateId&"]")
	
Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"

%>