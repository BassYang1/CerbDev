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
if strWhere = "" then 
	strWhere = " where Left(isnull(ControllerType,'1'),1) <> '2' "
	strExportSql = " where Left(isnull(C.ControllerType,'1'),1) <> '2' "
else
	strWhere = strWhere & " and Left(isnull(ControllerType,'1'),1) <> '2' "
	strExportSql = strExportSql & " and Left(isnull(C.ControllerType,'1'),1) <> '2' "
end if
	
a.Sqlstring="select ControllerId,ControllerNumber,ControllerName,Location,IP,WorkType,ServerIP from Controllers"&strWhere&" "&"order by "& sidx & " " & sord
set a.dbconnection=conn

strExportSql="select C.ControllerId,ControllerNumber,ControllerName,Location,IP,WorkType,ServerIP,(Case when ISNULL(CDS.SyncStatus,0)=1 then '"&GetEquLbl("SyncEd")&"' else '"&GetEquLbl("UnSync")&"' end) as SyncStatus from Controllers C left join  ControllerDataSync CDS on (C.ControllerId=CDS.ControllerId and CDS.SyncType='holiday')"&strExportSql&" "&"order by "& Replace(sidx,"ControllerId","C.ControllerId") & " " & sord
Session("exportdata")=strExportSql

response.Write(a.GetJSon())
'conn.close()
'set conn = nothing
fCloseADO()
%>
