<!--#include file="..\Conn\conn.asp" -->
<%
fConnectADODB()
dim strSQL,strJS,strType,strControllerId
dim i

strType = trim(Request.QueryString("Type"))
strControllerId = trim(Request.Form("ControllerId"))

if strType="controller" or strType="schedule" or strType="holiday" or strType="inout" or strType="register" then 
	strSQL = "select ControllerId,ISNULL(SyncStatus,0) as SyncStatus from ControllerDataSync where SyncType='"&strType&"' "
	if strControllerId <> "" then 
		strSQL = strSQL+" and ControllerId in ("&strControllerId&") "
	end if

	i =0
	'strJS = "<script language='javascript'>var Arr = new Array(new Array(),new Array());"
	strJS = "var Arr = new Array(new Array(),new Array());"
	Rs.open strSQL, Conn, 1, 1
	if Rs.eof=false and Rs.Bof=false then
		while not Rs.eof 
			strJS = strJS + "Arr[0][" + cstr(i) + "] = " + trim(Rs.fields("ControllerId").value) + ";"
			strJS = strJS + "Arr[1][" + cstr(i) + "] = " + trim(Rs.fields("SyncStatus").value) + ";"
			'if Rs.fields("SyncStatus").value=0 or Rs.fields("SyncStatus").value=false then 
			'	strJS = strJS + "Arr[1][" + cstr(i) + "] = 0 ;"
			'else
			'	strJS = strJS + "Arr[1][" + cstr(i) + "] = 1 ;"
			'end if
			i = i + 1	
			Rs.MoveNext
		Wend
	end if
	Rs.close
elseif strType="RegCardCount" then 
	strSQL = "SELECT ControllerId,CAST(Sum(Case Status WHen '1' THEN 1 Else 0 End) AS NVARCHAR(10))+'/'+CAST(Sum(Case Status WHen '1' THEN 0 Else 1 End) AS  NVARCHAR(10)) AS CountSync  FROM controllerEmployee  "
	if strControllerId <> "" then 
		strSQL = strSQL+" where ControllerId in ("&strControllerId&") "
	end if
	strSQL = strSQL+" GROUP BY ControllerId "
	
	i =0
	strJS = "var ArrCount = new Array(new Array(),new Array());"
	Rs.open strSQL, Conn, 1, 1
	if Rs.eof=false and Rs.Bof=false then
		while not Rs.eof 
			strJS = strJS + "ArrCount[0][" + cstr(i) + "] = " + trim(Rs.fields("ControllerId").value) + ";"
			strJS = strJS + "ArrCount[1][" + cstr(i) + "] = '" + trim(Rs.fields("CountSync").value) + "';"
			i = i + 1	
			Rs.MoveNext
		Wend
	end if
	Rs.close
end if

response.write strJS

fCloseADO()
%>