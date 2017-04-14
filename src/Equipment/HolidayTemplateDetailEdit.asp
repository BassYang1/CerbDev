<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Call CheckLoginStatus("parent.location.href='../login.html'")
Call CheckOperPermissions()

Dim strSQL,strTemplateId,strAddData, strEditData, strDelRowID,iNewRecordID,strTempName,strActions
strTemplateId = Request.Form("TemplateId")
strAddData = Request.Form("strAdd")
strEditData = Request.Form("strEdit")
strDelRowID = Request.Form("strDel")
strTempName = Request.Form("strTempName")

'response.Write(strTemplateId&"<br>"&strAddData&"<br>"&strEditData&"<br>"&strDelRowID)
if	strTemplateId="" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if
if GetOperRole("HolidayTemplate","edit") <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

Call fConnectADODB()

'先执行删除
if	strDelRowID<>"" then 
	strDelRowID = Replace(strDelRowID,"||",",")
	strSQL = "Delete From ControllerTemplateHoliday where TemplateId="&strTemplateId&" and HolidayNumber in ("&strDelRowID&")"
	On Error Resume Next
	Conn.Execute strSQL
	if err.number <> 0 then
		Call fCloseADO()
		Call ReturnMsg("false",Err.Description,0)
		On Error GoTo 0
		response.End()
	end if
end if

'执行插入
Dim AddArray,Row
if	strAddData<>"" then 
	AddArray = split(strAddData,"||")
	If	IsArray(AddArray) then 
		For i = LBound(AddArray) To UBound(AddArray)
			Row = split(AddArray(i),",,")
			strSQL = "INSERT INTO ControllerTemplateHoliday (TemplateId,HolidayNumber,HolidayName,HolidayDate) Values("&strTemplateId&","&Row(0)&",'"&Row(1)&"','"&Row(2)&"')"
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


'执行修改
Dim EditArray
if	strEditData<>"" then 
	EditArray = split(strEditData,"||")
	If	IsArray(EditArray) then 
		For i = 0 To UBound(EditArray)
			Row = split(EditArray(i),",,")
			strSQL = "UPDATE ControllerTemplateHoliday set HolidayName='"&Row(1)&"',HolidayDate = '"&Row(2)&"' where TemplateId="&strTemplateId&" and HolidayNumber="&Row(0)
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
'Call AddLogEvent("设备管理-假期表-模板方式",cstr(strActions),cstr(strActions)&"假期表模板明细,假期表名称["&strTempName&"]")
Call AddLogEvent(GetEquLbl("ConManage")&"-"&GetEquLbl("Holiday")&"-"&GetEquLbl("TempMode"),cstr(strActions),cstr(strActions)&GetEquLbl("HolidayTempDetail")&","&GetEquLbl("HolidayName2")&"["&strTempName&"]")
			
Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	'"执行成功"

%>