<!--#include file="..\Common\Page.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim strSQL,strJS,strexportType,strTableId,oneRecord,strColumnName,arrColumn
dim arrVal
dim i
strexportType = Cstr(Trim(Request.QueryString("exportType")))
strTableId = Cstr(Trim(Request.QueryString("TableId")))

fConnectADODB()
strJS = ""

if LCase(strexportType) = "employees" or  LCase(strexportType) = "departments" or LCase(strexportType) = "controllers" or LCase(strexportType) = "holiday" or LCase(strexportType) = "schedule" or LCase(strexportType) = "inout" or LCase(strexportType) = "register" or LCase(strexportType) = "registerdetail" or LCase(strexportType) = "users" or LCase(strexportType) = "logevent" or LCase(strexportType) = "attendtotal" or LCase(strexportType) = "acsbuttonreport" or LCase(strexportType) = "askforleave" or LCase(strexportType) = "ontrip" or LCase(strexportType) = "signcard" or LCase(strexportType) = "overtime"then  
	if LCase(strexportType) = "employees" then 
		strSQL = Session("exportdata")
		'strColumnName="部门,姓名,工号,卡号,身份证,性别,职务,职位,电话,Email,出生日期,入职日期,婚否,学历,国籍,籍贯,通信地址,在职状态,含指纹,含照片"
		strColumnName=GetToolLbl("ExportEmployeesTitle")
	elseif LCase(strexportType) = "departments" then 
		strSQL = Session("exportdata")
		'strColumnName="部门ID,部门名称,部门代码"
		strColumnName=GetToolLbl("ExportDepartmentsTitle")
	elseif LCase(strexportType) = "controllers" then 
		strSQL = Session("exportdata")
		'strColumnName="设备ID,设备编号,设备名称,位置,设备IP,工作类型,服务器,同步状态"
		strColumnName=GetToolLbl("ExportControllersTitle")
	elseif LCase(strexportType) = "holiday" then 
		strSQL = Session("exportdata")
		'strColumnName="设备ID,设备编号,设备名称,位置,设备IP,工作类型,服务器,同步状态"
		strColumnName=GetToolLbl("ExportControllersTitle")
	elseif LCase(strexportType) = "schedule" then 
		strSQL = Session("exportdata")
		'strColumnName="设备ID,设备编号,设备名称,位置,设备IP,工作类型,服务器,同步状态"
		strColumnName=GetToolLbl("ExportControllersTitle")
	elseif LCase(strexportType) = "inout" then 
		strSQL = Session("exportdata")
		'strColumnName="设备ID,设备编号,设备名称,位置,设备IP,工作类型,服务器,同步状态"
		strColumnName=GetToolLbl("ExportControllersTitle")
	elseif LCase(strexportType) = "register" then 
		strSQL = Session("exportdata")
		'strColumnName="设备ID,设备编号,设备名称,位置,设备IP,工作类型,服务器,同步状态"
		strColumnName=GetToolLbl("ExportControllersTitle")
	elseif LCase(strexportType) = "registerdetail" then 
		strSQL = Session("exportdata")
		'strColumnName="设备编号,部门,姓名,工号,卡号,验证方式,时间表,进出门,有照片,有指纹,同步状态"
		strColumnName=GetToolLbl("ExportRegisterdetailTitle")
	elseif LCase(strexportType) = "users" then 
		strSQL = Session("exportdata")
		'strColumnName="登录名,姓名,角色"
		strColumnName=GetToolLbl("ExportUsersTitle")
	elseif LCase(strexportType) = "logevent" then 
		strSQL = Session("exportdata")
		'strColumnName="用户名,登录机器,日期,模块,操作方式,对象"
		strColumnName=GetToolLbl("ExportLogeventTitle")
	elseif LCase(strexportType) = "attendtotal" then 
		'考勤汇总
		strSQL = Session("exportdata")
		'strColumnName="部门,姓名,工号,月份,出勤天数,总工时,迟到次数,迟到时间,早退次数,早退时间,异常次数"
		strColumnName=GetToolLbl("ExportAttendtotalTitle")
	elseif LCase(strexportType) = "acsbuttonreport" then 
		'按钮事件
		strSQL = Session("exportdata")
		'strColumnName="设备,输入,日期,时间"
		strColumnName=GetToolLbl("ExportAcsbuttonreportTitle")
	elseif LCase(strexportType) = "shift" then  '班次
		strSQL = Session("exportdata")
		strColumnName=GetToolLbl("ExportShiftTitle")
	elseif LCase(strexportType) = "shiftadjustment" then  '班次调整
		strSQL = Session("exportdata")
		strColumnName=GetToolLbl("ExportShiftAdjustmentTitle")
	elseif LCase(strexportType) = "shiftrules" then  '上班规则
		strSQL = Session("exportdata")
		strColumnName=GetToolLbl("ExportShiftRulesTitle")
	elseif LCase(strexportType) = "legalholiday" then  '法定假期
		strSQL = Session("exportdata")
		strColumnName=GetToolLbl("ExportHolidayTitle")
	elseif LCase(strexportType) = "askforleave" then  '请假
		strSQL = Session("exportdata")
		strColumnName=GetToolLbl("ExportLeaveTitle")
	elseif LCase(strexportType) = "ontrip" then  '出差
		strSQL = Session("exportdata")
		strColumnName=GetToolLbl("ExportTripTitle")
	elseif LCase(strexportType) = "signcard" then  '补卡
		strSQL = Session("exportdata")
		strColumnName=GetToolLbl("ExportSignCardTitle")
	elseif LCase(strexportType) = "overtime" then  '加班
		strSQL = Session("exportdata")
		strColumnName=GetToolLbl("ExportOvertimeTitle")
	end if
	strJS=strJS&strColumnName


	'response.write strSQL + "<br />"
	'response.write strColumnName + "<br />"
	'response.end
	On Error Resume Next
	Rs.open strSQL, Conn, 2, 1
	if err.number <> 0 then
		Rs.close
		set Rs=Nothing
		fCloseADO()
		strJS = strJS & chr(10)&Err.Description&chr(10)
		response.write strJS
		On Error GoTo 0
		response.End()
	end if
	if Rs.eof=false and Rs.Bof=false then
		while NOT Rs.EOF
			oneRecord=chr(13)&chr(10)	'回车及换行符
			for i=0 to Rs.Fields.Count -1
				if NOT ISNULL(Rs.Fields(i).value) then
					oneRecord=oneRecord&Replace(Rs.Fields(i).Value,",","'")&","		'将数值中有,替换为'
				else
					oneRecord=oneRecord&" ,"
				end if
			Next
			oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1)
			strJS=strJS & oneRecord
			Rs.MoveNext
		wend
	end if
	strJS=strJS
	response.write strJS
elseif LCase(strexportType) = "attend" or LCase(strexportType) = "attenddetail" or LCase(strexportType) = "acsdetail"  or LCase(strexportType) = "acsillegal" then 

	set recom = server.createobject("adodb.command")
	recom.activeconnection = Conn
	recom.commandtype = 4
	recom.CommandTimeout = 0
	recom.Prepared = true
	
	if LCase(strexportType) = "attend" then 
		'strColumnName="部门,姓名,工号,卡号,刷卡日期,刷卡时间"
		strColumnName=GetToolLbl("ExportattendTitle")
		strJS=strJS&strColumnName
		
		On Error Resume Next
		recom.Commandtext = "pExportBrushCardRowToCol" 
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="attend|4|"&startTime&"|"&endTime&"|"&strshowAllRow&"|"&strExportSql
		arrVal = Split(Session("exportdata"),"|")
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="attend" then 
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					recom.Parameters(i+1) = arrVal(i+2)
				Next
			end if
		End if
	elseif LCase(strexportType) = "attenddetail" then 
		'strColumnName="部门,姓名,工号,卡号,设备编号,位置,刷卡日期,刷卡时间,状态(0:合法;1:非法)"
		strColumnName=GetToolLbl("ExportAttenddetailTitle")
		strJS=strJS&strColumnName
		
		On Error Resume Next
		recom.Commandtext = "pExprotBrushcardData" 
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="attenddetail|6|"&startTime&"|"&endtime&"|"&strExportControllerid&"|"&strExportPeroperty&"|"&strExportWhere&"|"&"BrushCardAttend"
		arrVal = Split(Session("exportdata"),"|")
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="attenddetail" then 
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					recom.Parameters(i+1) = arrVal(i+2)
				Next
			end if
		End if
	elseif LCase(strexportType) = "acsdetail" then '进出明细
		'strColumnName="部门,姓名,工号,卡号,设备编号,位置,刷卡日期,刷卡时间,状态(0:合法)"
		strColumnName=GetToolLbl("ExportAcsdetailTitle")
		strJS=strJS&strColumnName
		
		On Error Resume Next
		recom.Commandtext = "pExprotBrushcardData" 
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="acsdetail|6|"&startTime&"|"&endtime&"|"&strExportControllerid&"|"&strExportPeroperty&"|"&strExportWhere&"|"&"BrushCardACS"
		arrVal = Split(Session("exportdata"),"|")
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="acsdetail" then 
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					recom.Parameters(i+1) = arrVal(i+2)
				Next
			end if
		End if
	elseif LCase(strexportType) = "acsillegal" then '非法进出
		'strColumnName="部门,姓名,工号,卡号,设备编号,位置,刷卡日期,刷卡时间,状态(0:合法)"
		strColumnName=GetToolLbl("ExportAcsdetailTitle")
		strJS=strJS&strColumnName
		
		On Error Resume Next
		recom.Commandtext = "pExprotBrushcardData" 
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="acsdetail|6|"&startTime&"|"&endtime&"|"&strExportControllerid&"|"&strExportPeroperty&"|"&strExportWhere&"|"&"BrushCardACS"
		arrVal = Split(Session("exportdata"),"|")
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="acsillegal" then 
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					recom.Parameters(i+1) = arrVal(i+2)
				Next
			end if
		End if
	end if
	
	On Error Resume Next
	set Rs = recom.execute()
	if err.number <> 0 then
		Rs.close
		set Rs=Nothing
		fCloseADO()
		strJS = strJS & chr(10)&Err.Description&chr(10)
		response.write strJS
		On Error GoTo 0
		response.End()
	end if
	if Rs.eof=false and Rs.Bof=false then
		while NOT Rs.EOF
			oneRecord=chr(13)&chr(10)	'回车及换行符
			for i=0 to Rs.Fields.Count-1
				'if Rs.Fields(i).value <> "" then '这里判断，是由于数据集中一字段定义为nvarchar(max)，若使用NOT ISNULL下一句读不出值。不知何原因？？？
					oneRecord=oneRecord&Replace(Rs.Fields(i).Value,",","'")&","		'将数值中有,替换为'
				'else
				'	oneRecord=oneRecord&","
				'end if
			Next
			oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1)
			strJS=strJS & oneRecord
			Rs.MoveNext
		wend
	end if
	strJS=strJS
	response.write strJS
	
elseif LCase(strexportType) = "attendcard" then 

	set recom = server.createobject("adodb.command")
	recom.activeconnection = Conn
	recom.commandtype = 4
	recom.CommandTimeout = 0
	recom.Prepared = true
	
		'strColumnName="日期,上班（一）,下班（一）,上班（二）,下班（二）,上班（三）,下班（三）,工时（M）,迟到（M）,早退（M）"
		strColumnName=GetToolLbl("ExportAttendcardTitle")
		strJS=strJS&strColumnName
		
		On Error Resume Next
		recom.Commandtext = "pExportAttendCard" 
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="acsdetail|6|"&startTime&"|"&endtime&"|"&strExportControllerid&"|"&strExportPeroperty&"|"&strExportWhere&"|"&"BrushCardACS"
		arrVal = Split(Session("exportdata"),"|")
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="attendcard" then 
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					recom.Parameters(i+1) = arrVal(i+2)
				Next
			end if
		End if	
		
	On Error Resume Next
	set Rs = recom.execute()
	if err.number <> 0 then
		Rs.close
		set Rs=Nothing
		fCloseADO()
		strJS = strJS & chr(10)&Err.Description&chr(10)
		response.write strJS
		On Error GoTo 0
		response.End()
	end if
	if Rs.eof=false and Rs.Bof=false then
		while NOT Rs.EOF
			oneRecord=chr(13)&chr(10)	'回车及换行符
			If Not IsNull(Rs("DataType")) And Rs("DataType") Then
				'表示头，这一行存储 部门，工号，姓名 
				oneRecord=oneRecord&GetToolLbl("ExportDept")&Replace(Rs("DepartmentName"),",","'")&","		'将数值中有,替换为'	'部门：
				oneRecord=oneRecord&GetToolLbl("ExportNumber")&Replace(Rs("Number"),",","'")&","		'将数值中有,替换为'		'工号：
				oneRecord=oneRecord&GetToolLbl("ExportName")&Replace(Rs("Name"),",","'")&","		'将数值中有,替换为'			'姓名：
			else
				'这里为NULL的数据，若直接使用Replace函数时，整列让不显示，分号也没有。   所以这里每个必须判断是否为NULL
				If Not IsNull(Rs("OnDutyDate")) Then 
					oneRecord=oneRecord&Replace(Rs("OnDutyDate"),",","'")&","		'将数值中有,替换为'
				else
					oneRecord=oneRecord&","
				end if
				If Not IsNull(Rs("OnDuty1")) Then 
					oneRecord=oneRecord&Replace(Rs("OnDuty1"),",","'")&","		'将数值中有,替换为'
				else
					oneRecord=oneRecord&","
				end if
				If Not IsNull(Rs("OffDuty1")) Then 
					oneRecord=oneRecord&Replace(Rs("OffDuty1"),",","'")&","		'将数值中有,替换为'
				else
					oneRecord=oneRecord&","
				end if
				If Not IsNull(Rs("OnDuty2")) Then 
					oneRecord=oneRecord&Replace(Rs("OnDuty2"),",","'")&","		'将数值中有,替换为'
				else
					oneRecord=oneRecord&","
				end if
				If Not IsNull(Rs("OffDuty2")) Then 
					oneRecord=oneRecord&Replace(Rs("OffDuty2"),",","'")&","		'将数值中有,替换为'
				else
					oneRecord=oneRecord&","
				end if
				If Not IsNull(Rs("OnDuty3")) Then 
					oneRecord=oneRecord&Replace(Rs("OnDuty3"),",","'")&","		'将数值中有,替换为'
				else
					oneRecord=oneRecord&","
				end if
				If Not IsNull(Rs("OffDuty3")) Then 
					oneRecord=oneRecord&Replace(Rs("OffDuty3"),",","'")&","		'将数值中有,替换为'
				else
					oneRecord=oneRecord&","
				end if
				
				If Not IsNull(Rs("WorkTime")) And Rs("WorkTime") <> "0" Then
					oneRecord=oneRecord&Replace(Rs("WorkTime"),",","'")&","		
				else
					oneRecord=oneRecord&" "&","
				end if
				If Not IsNull(Rs("LateTime")) And Rs("LateTime") <> "0" Then
					oneRecord=oneRecord&Replace(Rs("LateTime"),",","'")&","		
				else
					oneRecord=oneRecord&" "&","
				end if
				If Not IsNull(Rs("LeaveEarlyTime")) And Rs("LeaveEarlyTime") <> "0" Then
					oneRecord=oneRecord&Replace(Rs("LeaveEarlyTime"),",","'")&","		
				else
					oneRecord=oneRecord&" "&","
				end if
			end if
				
			oneRecord=left(oneRecord,InStrRev(oneRecord,",")-1)
			strJS=strJS & oneRecord
			Rs.MoveNext
		wend
	end if
	strJS=strJS
	response.write strJS

end if

	
fCloseADO()
%>