<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim page,rows,sidx,sord,strExportSql
page = request.QueryString("page") 'page
rows = request.QueryString("rows") 'pagesize
sidx = request.QueryString("sidx") 'order by ??
sord = request.QueryString("sord")
if page="" then page = 1 end if
if rows = "" then rows = 10 end if
if sidx = "" then sidx = "ControllerId" end if
if sord = "" then sord ="asc" end if
Dim strSearchOn, strField, strFieldData, strSearchOper, strWhere
strSearchOn = request.QueryString("_search")
dim strUserId
strUserId = session("UserId")
if strUserId = "" then strUserId = "0" end if
'response.Write("strSearchOn:"&strSearchOn&",strField:"&request.QueryString("searchField")&",strFieldData:"&request.QueryString("searchString")&",strSearchOper:"&request.QueryString("searchOper")
strWhere=""
If (strSearchOn = "true") Then
	strField = request.QueryString("searchField")
	If (strField = "ControllerId" Or strField = "ControllerNumber" Or strField = "ControllerName" Or strField = "Location" Or strField = "ServerIP" ) Then
		strFieldData = request.QueryString("searchString")
		strSearchOper = request.QueryString("searchOper")
		'construct where
		strWhere = " Where " & strField
		Select Case strSearchOper
			Case "bw" : 'Begin With
			strFieldData = strFieldData & "%"
			strWhere = strWhere & " LIKE '" & strFieldData & "'"
			Case "eq" : 'Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " = " & strFieldData
			Else
				strWhere = strWhere & " = '" & strFieldData & "'"
			End If
			Case "ne": 'Not Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " <> " & strFieldData
			Else
				strWhere = strWhere & " <> '"& strFieldData &"'"
			End If
			Case "lt": 'Less Than
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " <" & strFieldData
			Else
				strWhere = strWhere & " <'"& strFieldData &"'"
			End If
			Case "le": 'Less Or Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " <= " & strFieldData
			Else
				strWhere = strWhere & " <= '"& strFieldData &"'"
			End If
			Case "gt": 'Greater Than
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " > " & strFieldData
			Else
				strWhere = strWhere & " > '"& strFieldData &"'"
			End If
			Case "ge": 'Greater Or Equal
			If(IsNumeric(strFieldData)) Then
				strWhere = strWhere & " >= " & strFieldData
			Else
				strWhere = strWhere & " >= '"& strFieldData &"'"
			End If
			Case "ew" : 'End With
			strWhere = strWhere & " LIKE '%" & strFieldData & "'"
			Case "cn" : 'Contains
			strWhere = strWhere & " LIKE '%" & strFieldData & "%'"
			Case "nc" : 'not Contains
			strWhere = strWhere & " NOT LIKE '%" & strFieldData & "%'"
		End Select
	End if
End If
'server.ScriptTimeout=9000
fConnectADODB()
dim a
set a=new JSONClass

strExportSql=strWhere
strExportSql=Replace(strExportSql,"ControllerId","C.ControllerId")
'取有访问权限的设备
if strUserId<>"1" then '1 为admin用户
	if strWhere = "" then 
		strWhere = " where "
		strExportSql = " where "
	else
		strWhere = strWhere & " and "
		strExportSql = strExportSql & " and "
	end if
	strWhere = strWhere & " ControllerId in (select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 ) "
	strExportSql=strExportSql & " C.ControllerId in (select ControllerID from RoleController where UserId in ("&strUserId&") and Permission=1 ) "
end if 
		
a.Sqlstring="select ControllerId,ControllerType,ControllerSerail,ControllerNumber,ControllerName,Location,IP,MASK,GateWay,DNS,DNS2,convert(Nvarchar(2),EnableDHCP) as EnableDHCP,convert(Nvarchar(2),AntiPassBackType) as AntiPassBackType,WorkType,ServerIP,StorageMode,convert(Nvarchar(2),IsFingerprint) as IsFingerprint,DoorType,CardReader1,CardReader2,SystemPassword,DataUpdateTime,WaitTime,CloseLightTime,convert(Nvarchar(2),DownPhoto) as DownPhoto,convert(Nvarchar(2),DownFingerprint) as DownFingerprint,Sound,BoardType,'' as ScreenFile11,'' as ScreenFile21 from Controllers"&strWhere&" "&"order by "& sidx & " " & sord

strExportSql="select C.ControllerId,ControllerNumber,ControllerName,Location,IP,WorkType,ServerIP,(Case when ISNULL(CDS.SyncStatus,0)=1 then '"&GetEquLbl("SyncEd")&"' else '"&GetEquLbl("UnSync")&"' end) as SyncStatus from Controllers C left join  ControllerDataSync CDS on (C.ControllerId=CDS.ControllerId and CDS.SyncType='controller')"&strExportSql&" "&"order by "& Replace(sidx,"ControllerId","C.ControllerId") & " " & sord
Session("exportdata")=strExportSql

set a.dbconnection=conn
response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
