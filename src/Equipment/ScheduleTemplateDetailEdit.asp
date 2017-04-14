<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strTemplateId, strEditData, strHolidayTemplateId,strTempName,strActions
strTemplateId = Request.Form("TemplateId")
strHolidayTemplateId = Request.Form("HolidayTemplateId")
strEditData = Request.Form("strEdit")
strTempName = Request.Form("strTempName") 

'response.Write(strTemplateId&"<br>"&strAddData&"<br>"&strEditData&"<br>"&strDelRowID)
if	strTemplateId="" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if
if GetOperRole("ScheduleTemplate","edit") <> true then 
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
			strSQL = "UPDATE ControllerTemplateSchedule set StartTime1='"&Row(1)&"',EndTime1 = '"&Row(2)&"',StartTime2='"&Row(3)&"',EndTime2 = '"&Row(4)&"',StartTime3='"&Row(5)&"',EndTime3 = '"&Row(6)&"',StartTime4='"&Row(7)&"',EndTime4 = '"&Row(8)&"',StartTime5='"&Row(9)&"',EndTime5 = '"&Row(10)&"' where RecordID="&Row(0)
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

'执行修改假期表ID
if strHolidayTemplateId<> "undefined" then 
	strSQL = "UPDATE ControllerTemplateSchedule set HolidayTemplateId='"&strHolidayTemplateId&"' where WeekDay = 'holiday' and TemplateId="&strTemplateId
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",Err.Description,0)
		On Error GoTo 0
		response.End()
	end if
end if		

strActions = GetCerbLbl("strLogEdit")
'Call AddLogEvent("设备管理-时间表-模板方式",cstr(strActions),cstr(strActions)&"时间表模板明细,模板名称["&strTempName&"]")
Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Schedule")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("ScheduleDetail")&","&GetEquLbl("TempName")&"["&strTempName&"]")
	
Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"

%>