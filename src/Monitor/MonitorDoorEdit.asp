<%Session.CodePage=65001%>
<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\CheckLoginStatus.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
Dim strSQL,strOper, strRecordID, strdatatype,strControllerID,strcheck
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if

response.Charset="utf-8"
strOper = request.Form("oper")
strRecordID = Replace(request.Form("id"),"'","''")
strdatatype = Replace(request.Form("datatype"),"'","''")
strControllerID = Replace(request.Form("ControllerID"),"'","''")
strcheck = Replace(request.Form("check"),"'","''")

if strOper<>"add" and strOper<>"edit" and strOper<>"del" then 
	Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
	response.End()
end if 

if GetOperRole("MonitorDoor",strOper) <> true then 
	Call ReturnMsg("false",GetEmpLbl("NoRight"),0)'您无权操作！
	response.End()
end if

if strcheck = "1" then 
	Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)
	response.End()
end if

Call fConnectADODB()


if strdatatype = "opendoor" then 
	Call AddLogEvent(GetMonitorLbl("strMonitor")&"-"&GetMonitorLbl("DoorStatus"),GetMonitorLbl("OpenDoor"),GetMonitorLbl("Controller")&"ID["&strControllerID&"]")	'"实时监控-门状态","远程开门","设备
elseif strdatatype = "syncdata" then
	Call AddLogEvent(GetMonitorLbl("strMonitor")&"-"&GetMonitorLbl("DoorStatus"),GetMonitorLbl("SyncData"),GetMonitorLbl("Controller")&"ID["&strControllerID&"]") 
	'Call AddLogEvent("实时监控-门状态","立即同步","设备ID["&strControllerID&"]")
elseif strdatatype = "synctime" then 
	Call AddLogEvent(GetMonitorLbl("strMonitor")&"-"&GetMonitorLbl("DoorStatus"),GetMonitorLbl("SyncTime"),GetMonitorLbl("Controller")&"ID["&strControllerID&"]") 
	'Call AddLogEvent("实时监控-门状态","立即校时","设备ID["&strControllerID&"]")
end if

Call fCloseADO()
Call ReturnMsg("true",GetEmpLbl("ExecSuccess"),0)	



%>