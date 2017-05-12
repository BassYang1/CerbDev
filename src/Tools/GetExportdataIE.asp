<!--#include file="..\Common\Page.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim strSQL,strJS,strexportType,strTableId,oneRecord,strColumnName,arrColumn
dim i,page,rows,a
dim arrVal,arrParam(10),arrParamLen,strProcName
strexportType = Cstr(Trim(Request.QueryString("exportType")))
strTableId = Cstr(Trim(Request.QueryString("TableId")))
 page = 1
rows = 10 

fConnectADODB()
if LCase(strexportType) = "employees" or  LCase(strexportType) = "departments" or LCase(strexportType) = "controllers" or LCase(strexportType) = "holiday" or LCase(strexportType) = "schedule" or LCase(strexportType) = "inout" or LCase(strexportType) = "register" or LCase(strexportType) = "registerdetail" or LCase(strexportType) = "users" or LCase(strexportType) = "logevent" or LCase(strexportType) = "attendtotal" or LCase(strexportType) = "acsbuttonreport" or LCase(strexportType) = "shift" or LCase(strexportType) = "shiftadjustment" then  
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
	end if
	
	set a=new JSONClass
	a.Sqlstring=strSQL
	set a.dbconnection=conn
	response.Write(a.GetJSONForExport(strColumnName))
elseif LCase(strexportType) = "attend" or LCase(strexportType) = "attenddetail" or LCase(strexportType) = "acsdetail"  or LCase(strexportType) = "acsillegal" then  
	if LCase(strexportType) = "attend" then 
		'strColumnName="部门,姓名,工号,卡号,刷卡日期,刷卡时间"
		strColumnName=GetToolLbl("ExportattendTitle")
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="attend|4|"&startTime&"|"&endTime&"|"&strshowAllRow&"|"&strExportSql
		arrVal = Split(Session("exportdata"),"|")
		arrParamLen = 0
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="attend" then 
				strProcName = "pExportBrushCardRowToCol"
				arrParamLen = arrVal(1)
				'Redim arrParam(arrParamLen) '存放存储过程参数数组
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					arrParam(i) = arrVal(i+2)
				Next
			end if
		End if
	elseif LCase(strexportType) = "attenddetail" then 
		'strColumnName="部门,姓名,工号,卡号,设备编号,位置,刷卡日期,刷卡时间,状态(0:合法;1:非法)"
		strColumnName=GetToolLbl("ExportAttenddetailTitle")
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="attenddetail|6|"&startTime&"|"&endtime&"|"&strExportControllerid&"|"&strExportPeroperty&"|"&strExportWhere&"|"&"BrushCardAttend"
		arrVal = Split(Session("exportdata"),"|")
		arrParamLen = 0
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="attenddetail" then 
				strProcName = "pExprotBrushcardData"
				arrParamLen = arrVal(1)
				'Redim arrParam(arrParamLen) '存放存储过程参数数组
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					arrParam(i) = arrVal(i+2)
				Next
			end if
		End if
	elseif LCase(strexportType) = "acsdetail" then '进出明细
		'strColumnName="部门,姓名,工号,卡号,设备编号,位置,刷卡日期,刷卡时间,状态(0:合法)"
		strColumnName=GetToolLbl("ExportAcsdetailTitle")
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="acsdetail|6|"&startTime&"|"&endtime&"|"&strExportControllerid&"|"&strExportPeroperty&"|"&strExportWhere&"|"&"BrushCardACS"
		arrVal = Split(Session("exportdata"),"|")
		arrParamLen = 0
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="acsdetail" then 
				strProcName = "pExprotBrushcardData"
				arrParamLen = arrVal(1)
				'Redim arrParam(arrParamLen) '存放存储过程参数数组
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					arrParam(i) = arrVal(i+2)
				Next
			end if
		End if
	elseif LCase(strexportType) = "acsillegal" then '非法进出
		'strColumnName="部门,姓名,工号,卡号,设备编号,位置,刷卡日期,刷卡时间,状态(0:合法)"
		strColumnName=GetToolLbl("ExportAcsdetailTitle")
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="acsdetail|6|"&startTime&"|"&endtime&"|"&strExportControllerid&"|"&strExportPeroperty&"|"&strExportWhere&"|"&"BrushCardACS"
		arrVal = Split(Session("exportdata"),"|")
		arrParamLen = 0
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="acsillegal" then 
				strProcName = "pExprotBrushcardData"
				arrParamLen = arrVal(1)
				'Redim arrParam(arrParamLen) '存放存储过程参数数组
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					arrParam(i) = arrVal(i+2)
				Next
			end if
		End if
	end if
	
	set a=new JSONClass
	a.Sqlstring=strSQL
	set a.dbconnection=conn
	response.Write(a.GetJSONForExportByProc(strColumnName,strProcName,arrParam,arrParamLen))
	
elseif LCase(strexportType) = "attendcard" then 
		'strColumnName="日期,上班（一）,下班（一）,上班（二）,下班（二）,上班（三）,下班（三）,工时（M）,迟到（M）,早退（M）"
		strColumnName=GetToolLbl("ExportAttendcardTitle")
		'参数说明 ：报表类型|参数个数|参数.....
		'Session("exportdata")="attend|4|"&startTime&"|"&endTime&"|"&strshowAllRow&"|"&strExportSql
		arrVal = Split(Session("exportdata"),"|")
		arrParamLen = 0
		If IsArray(arrVal) then 
			if UBound(arrVal) > 2 and arrVal(0)="attendcard" then 
				strProcName = "pExportAttendCard"
				arrParamLen = arrVal(1)
				'Redim arrParam(arrParamLen) '存放存储过程参数数组
				For i = 0 To Cint(arrVal(1))-1 'arrVal(1) 为参数长度
					arrParam(i) = arrVal(i+2)
				Next
			end if
		End if
			
		set a=new JSONClass
		a.Sqlstring=strSQL
		set a.dbconnection=conn
		response.Write(a.GetJSONForExportAttendCardByProc(strColumnName,strProcName,arrParam,arrParamLen))
end if
	
fCloseADO()

%>