<!--#include file="..\Conn\conn.asp" -->
<!--#include file="..\Conn\json.asp" -->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim strExportType,strExportSql,strArray,strFileNameArray,strDownloadFileName,num
strExportType = request.Form("strExportType")
strExportSql=Request.Cookies("ExportData")&"          "

strArray = Split(strExportSql,"||")
if	strArray(0) = "acs" then 
	if	strExportType = "acs" then 
		Set Obj=CreateObject("httpAspCOM.Tools") 
		
		if Obj.ExportData(cstr(strArray(1)),cstr(strExportSql)) = 1 then 
			strFileNameArray = Split(strArray(1),"\")	'strArray(1)==>\ResidentFlash\www\wwwpub\download\acs.csv
			num = ubound(strFileNameArray)
			if num > 3 then   
				strDownloadFileName = "../"&strFileNameArray(num-1)&"/"&strFileNameArray(num)
			end if
			Call ReturnMsg("true",cstr(strDownloadFileName),0)
			response.End()
		else
			Call ReturnMsg("false",GetReportLbl("ExportFail"),0)	'"导出失败"
			response.End()
		end if
	else
		Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
		response.End()
	end if
elseif	strArray(0) = "attend" then 
	if	strExportType = "attend" then 
		Set Obj=CreateObject("httpAspCOM.Tools") 
		
		if Obj.ExportData(cstr(strArray(1)),cstr(strExportSql)) = 1 then 
			strFileNameArray = Split(strArray(1),"\")	'strArray(1)==>\ResidentFlash\www\wwwpub\download\attend.csv
			num = ubound(strFileNameArray)
			if num > 3 then   
				strDownloadFileName = "../"&strFileNameArray(num-1)&"/"&strFileNameArray(num)
			end if
			Call ReturnMsg("true",cstr(strDownloadFileName),0)
			response.End()
		else
			Call ReturnMsg("false",GetReportLbl("ExportFail"),0)	'"导出失败"
			response.End()
		end if
	else
		Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
		response.End()
	end if
elseif	strArray(0) = "originalattend" then 
	if	strExportType = "originalattend" then 
		Set Obj=CreateObject("httpAspCOM.Tools") 
		
		if Obj.ExportData(cstr(strArray(1)),cstr(strExportSql)) = 1 then 
			strFileNameArray = Split(strArray(1),"\")	'strArray(1)==>\ResidentFlash\www\wwwpub\download\originalattend.csv
			num = ubound(strFileNameArray)
			if num > 3 then   
				strDownloadFileName = "../"&strFileNameArray(num-1)&"/"&strFileNameArray(num)
			end if
			Call ReturnMsg("true",cstr(strDownloadFileName),0)
			response.End()
		else
			Call ReturnMsg("false",GetReportLbl("ExportFail"),0)	'"导出失败"
			response.End()
		end if
	else
		Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
		response.End()
	end if
elseif	strArray(0) = "employees" then 
	if	strExportType = "employees" then 
		Set Obj=CreateObject("httpAspCOM.Tools") 
		
		if Obj.ExportData(cstr(strArray(1)),cstr(strExportSql)) = 1 then 
			strFileNameArray = Split(strArray(1),"\")	'strArray(1)==>\ResidentFlash\www\wwwpub\download\originalattend.csv
			num = ubound(strFileNameArray)
			if num > 3 then   
				strDownloadFileName = "../"&strFileNameArray(num-1)&"/"&strFileNameArray(num)
			end if
			Call ReturnMsg("true",cstr(strDownloadFileName),0)
			response.End()
		else
			Call ReturnMsg("false",GetReportLbl("ExportFail"),0)	'"导出失败"
			response.End()
		end if
	else
		Call ReturnMsg("false",GetEmpLbl("PartError"),0)'"参数错误"
		response.End()
	end if
end if 


%>
