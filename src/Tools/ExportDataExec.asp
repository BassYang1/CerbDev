<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="../js/export/Base64.js"></script>
<script type="text/javascript" src="../js/export/e2e-0.8.js"></script>
</head>
<body>

<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim strexportType,strexportFlag,strisIE,strIEFileName
strexportType=trim(Request.QueryString("exportType"))
strexportFlag=trim(Request.QueryString("exportFlag"))
strisIE=trim(Request.QueryString("isIE"))
strIEFileName=trim(Request.QueryString("IEFileName"))
strIEFileName = replace(strIEFileName,"\","\\")
%>
<div id="div_tableId" style="display:none"></div>
<script language="javascript">
var strexportType,strSheetName,strexportFlag,strisIE,strIEFileName;
strexportType = "<%=strexportType%>";
strexportFlag = "<%=strexportFlag%>";
strisIE = "<%=strisIE%>";
strIEFileName = "<%=strIEFileName%>";
strexportType = strexportType.toLowerCase();
strexportFlag = strexportFlag.toLowerCase();
if(strexportType == "employees"){
	strSheetName = "<%=GetEmpLbl("EmpList")%>";//人事列表
}
else if(strexportType == "departments"){
	strSheetName = "<%=GetEmpLbl("DeptList")%>";//部门列表
}
else if(strexportType == "controllers"){
	strSheetName = "<%=GetToolLbl("ConBasicData")%>";//设备基本资料
}
else if(strexportType == "holiday"){
	strSheetName = "<%=GetEquLbl("ConHoliday")%>";//设备假期表
}
else if(strexportType == "schedule"){
	strSheetName = "<%=GetEquLbl("ConSchedule")%>";//设备时间表
}
else if(strexportType == "inout"){
	strSheetName = "<%=GetToolLbl("ConInout")%>";//设备输入输出表
}
else if(strexportType == "register"){
	strSheetName = "<%=GetToolLbl("ConRegCard")%>";//设备注册卡号表
}
else if(strexportType == "registerdetail"){
	strSheetName = "<%=GetToolLbl("ConRegCardDetail")%>";//设备注册卡号明细
}
else if(strexportType == "attend"){
	strSheetName = "<%=GetToolLbl("attend")%>";//考勤原始刷卡
}
else if(strexportType == "attenddetail"){
	strSheetName = "<%=GetToolLbl("attenddetail")%>";//考勤明细
}
else if(strexportType == "attendcard"){
	strSheetName = "<%=GetToolLbl("attendcard")%>";//考勤卡
}
else if(strexportType == "attendtotal"){
	strSheetName = "<%=GetToolLbl("attendtotal")%>";//考勤汇总
}
else if(strexportType == "acsdetail"){
	strSheetName = "<%=GetToolLbl("acsdetail")%>";//进出明细
}
else if(strexportType == "acsillegal"){
	strSheetName = "<%=GetToolLbl("acsillegal")%>";//非法进出
}
else if(strexportType == "acsbuttonreport"){
	strSheetName = "<%=GetToolLbl("acsbuttonreport")%>";//按钮事件明细
}
else if(strexportType == "users"){
	strSheetName = "<%=GetToolLbl("users")%>";//用户列表
}
else if(strexportType == "logevent"){
	strSheetName = "<%=GetToolLbl("logevent")%>";//日志
}
else if(strexportType == "shift"){
	strSheetName = "<%=GetToolLbl("shift")%>";//班次
}
else
{
	strSheetName = "Sheet1";
}

if(strexportFlag == "excel"){
	//导出excel格式
	if(strisIE=="1"){
		//IE导出.  GetExportdataIE返回的是JSON数据，包含表头
		var htmlObj = $.ajax({url:'../Tools/GetExportdataIE.asp?nd='+getRandom()+'&exportType='+strexportType+'&TableId=tableid1',async:false});
		var responseMsg = $.parseJSON(htmlObj.responseText);
		if(strexportType == "attendcard"){
			IE_ExportToXLS_AttendCard(responseMsg); //导出考勤卡
		}else{
			IE_ExportToXLS(responseMsg);
		}
	}
	else{
		//GetExportdataTable.asp返回的是Table
		var htmlObj = $.ajax({url:'../Tools/GetExportdataTable.asp?nd='+getRandom()+'&exportType='+strexportType+'&TableId=tableid1',async:false});
		$("#div_tableId").html(htmlObj.responseText);
		$('#tableid1').e2e({sheetName:strSheetName});
	}
}
else{
	//导出csv格式
	if(strisIE=="1"){
		//IE导出. GetExportdataIE返回的是JSON数据，包含表头
		var htmlObj = $.ajax({url:'../Tools/GetExportdataIE.asp?nd='+getRandom()+'&exportType='+strexportType+'&TableId=tableid1',async:false});
		var responseMsg = $.parseJSON(htmlObj.responseText);
		if(strexportType == "attendcard"){
			IE_ExportToCSV_AttendCard(responseMsg);
		}
		else{
			IE_ExportToCSV(responseMsg);
		}
	}
	else{
		//GetExportdataCSV.asp返回的是以逗号分隔的数据 
		var htmlObj = $.ajax({url:'../Tools/GetExportdataCSV.asp?nd='+getRandom()+'&exportType='+strexportType+'&TableId=tableid1',async:false});
		var str = htmlObj.responseText;
		
		str =  encodeURIComponent(str);
		var uri = 'data:text/csv;charset=utf-8,\ufeff' + str;
		var downloadLink = document.createElement("a");
		downloadLink.href = uri;
		downloadLink.download = strexportType+".csv"; //"export.csv"
		
		document.body.appendChild(downloadLink);
		downloadLink.click();
		document.body.removeChild(downloadLink);
	}
}


function IE_ExportToXLS(respData)
{
	var i,j,m,t;
	var arrFields;	
	var tfile;
	tfile=strIEFileName;
	try
	{
		i=1;
		var xlWorksheet ;
		var xlApplication;
		
		xlApplication = new ActiveXObject("Excel.Application");
		xlApplication.SheetsInNewWorkbook=1; 
		xlApplication.Workbooks.Add();
		
		xlWorksheet = xlApplication.Worksheets(1);	
		xlWorksheet.name = strSheetName;
		for(m = 0; m < respData.rows.length; m++)
		{
			arrFields = respData.rows[m];
			for (j=0;j<arrFields.cell.length ;j++ )
			{
				xlWorksheet.Cells(i,j+1).Value = arrFields.cell[j];
			}
			i++;
		}
		
		xlWorksheet.SaveAs(tfile);
		xlWorksheet = null;
		xlApplication.Workbooks.close();
		xlApplication.Quit();
		xlApplication=null;
		alert("<%=GetToolLbl("ExportComplete")%>");	//导出完成！
	}
	catch(e)
	{
		try
		{
			if (e.name != "SyntaxError")
			{
				//alert("导出失败("+e.message+")\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
				alert("<%=GetToolLbl("ExportFail")%>"+"("+e.message+")"+"<%=GetToolLbl("ExportFailMsg")%>");
			}
			else{
				//alert(e.message+"\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
				alert(e.message+"<%=GetToolLbl("ExportFailMsg")%>");
			}
			xlWorksheet = null;
			xlApplication.ActiveWorkBook.Saved = true;
			xlApplication.Workbooks.close();
			xlApplication.Quit();
			xlApplication=null;
		}
		catch(ex)
		{}
	}
}

function IE_ExportToXLS_AttendCard(respData)
{
	var i,j,m,t;
	var arrFields;	
	var tfile;
	tfile=strIEFileName;
	try
	{
		i=1;
		var xlWorksheet ;
		var xlApplication;
		
		xlApplication = new ActiveXObject("Excel.Application");
		xlApplication.SheetsInNewWorkbook=1; 
		xlApplication.Workbooks.Add();
		
		xlWorksheet = xlApplication.Worksheets(1);	
		xlWorksheet.name = strSheetName;
		for(m = 0; m < respData.rows.length; m++)
		{
			arrFields = respData.rows[m];
			for (j=1;j<arrFields.cell.length ;j++ )
			{
				//考勤卡，第一列为1的数据，表示这一行存储 部门，工号，姓名 
				if(arrFields.cell[0] == "1"){
					//xlWorksheet.get_Range("A1", "E1"); 
					xlWorksheet.Range("A"+i,"B"+i).MergeCells = true; //合并单元格
					xlWorksheet.Range("A"+i).font.Size=14;//字体大小
					xlWorksheet.Range("A"+i).font.bold=true;//粗体
					xlWorksheet.Range("A"+i).Font.ColorIndex=5; //字体颜色 5 为蓝色
					xlWorksheet.Range("C"+i,"D"+i).MergeCells = true; //合并单元格
					xlWorksheet.Range("C"+i).font.Size=14;//字体大小
					xlWorksheet.Range("C"+i).font.bold=true;//粗体
					xlWorksheet.Range("C"+i).Font.ColorIndex=5; //字体颜色 5 为蓝色
					xlWorksheet.Range("E"+i,"F"+i).MergeCells = true; //合并单元格
					xlWorksheet.Range("E"+i).font.Size=14;//字体大小
					xlWorksheet.Range("E"+i).font.bold=true;//粗体
					xlWorksheet.Range("E"+i).Font.ColorIndex=5; //字体颜色 5 为蓝色
					xlWorksheet.Cells(i,1).Value = arrFields.cell[1];
					xlWorksheet.Cells(i,3).Value = arrFields.cell[2];
					xlWorksheet.Cells(i,5).Value = arrFields.cell[3];
					break;
				}
				else{
					xlWorksheet.Cells(i,j).Value = arrFields.cell[j];
				}
			}
			i++;
		}
		
		xlWorksheet.SaveAs(tfile);
		xlWorksheet = null;
		xlApplication.Workbooks.close();
		xlApplication.Quit();
		xlApplication=null;
		alert("<%=GetToolLbl("ExportComplete")%>");	//导出完成！
	}
	catch(e)
	{
		try{
			if (e.name != "SyntaxError")
			{
				//alert("导出失败("+e.message+")\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
				alert("<%=GetToolLbl("ExportFail")%>"+"("+e.message+")"+"<%=GetToolLbl("ExportFailMsg")%>");
			}
			else{
				//alert(e.message+"\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
				alert(e.message+"<%=GetToolLbl("ExportFailMsg")%>");
			}
			xlWorksheet = null;
			xlApplication.ActiveWorkBook.Saved = true;
			xlApplication.Workbooks.close();
			xlApplication.Quit();
			xlApplication=null;
		}
		catch(ex)
		{}
	}
}

function IE_ExportToCSV(respData)
{
	var i,j,m,t;
	var arrFields,strResult;	
	var tfile;
	tfile=strIEFileName;
	try
	{
		var fso, f, s ;
		fso = new ActiveXObject("Scripting.FileSystemObject");   
		f = fso.OpenTextFile(tfile,8,true);
		strResult= "";
			
		for(m = 0; m < respData.rows.length; m++)
		{
			arrFields = respData.rows[m];
			strLines = "";
			for (j=0;j<arrFields.cell.length ;j++ )
			{
				strLines = strLines+arrFields.cell[j].replace(/[,]/g,"'")+",";
			}
			if(strLines.length >= 1){
				strLines = strLines.substring(0,strLines.length-1); //去掉最后一个逗号
			}
			strLines = strLines+"\r\n";
			//strLines = strLines.replace(/[,]/g,"'");
			strResult = strResult + strLines;
		}
		if(strResult.length >= 1){
			strResult = strResult.substring(0,strResult.length-2); //去掉最后一个回车及换行
		}
		f.WriteLine(strResult); 
		
		f.Close();
		alert("<%=GetToolLbl("ExportComplete")%>");	//导出完成！
	}
	catch(e)
	{
		try{
			if (e.name != "SyntaxError")
			{
				//alert("导出失败("+e.message+")\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
				alert("<%=GetToolLbl("ExportFail")%>"+"("+e.message+")"+"<%=GetToolLbl("ExportFailMsg")%>");
			}
			else{
				//alert(e.message+"\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
				alert(e.message+"<%=GetToolLbl("ExportFailMsg")%>");
			}
			f.Close();
		}
		catch(ex)
		{}
	}
}

function IE_ExportToCSV_AttendCard(respData)
{
	var i,j,m,t;
	var arrFields,strResult;	
	var tfile;
	tfile=strIEFileName;
	try
	{
		var fso, f, s ;
		fso = new ActiveXObject("Scripting.FileSystemObject");   
		f = fso.OpenTextFile(tfile,8,true);
		strResult= "";
			
		for(m = 0; m < respData.rows.length; m++)
		{
			arrFields = respData.rows[m];
			strLines = "";
			for (j=1;j<arrFields.cell.length ;j++ )
			{
				//考勤卡，第一列为1的数据，表示这一行存储 部门，工号，姓名 
				if(arrFields.cell[0] == "1"){
					strLines = strLines+arrFields.cell[1].replace(/[,]/g,"'")+",";
					strLines = strLines+arrFields.cell[2].replace(/[,]/g,"'")+",";
					strLines = strLines+arrFields.cell[3].replace(/[,]/g,"'")+",";
					break;
				}
				else{
					strLines = strLines+arrFields.cell[j].replace(/[,]/g,"'")+",";
				}
			}
			if(strLines.length >= 1){
				strLines = strLines.substring(0,strLines.length-1); //去掉最后一个逗号
			}
			strLines = strLines+"\r\n";
			//strLines = strLines.replace(/[,]/g,"'");
			strResult = strResult + strLines;
		}
		if(strResult.length >= 1){
			strResult = strResult.substring(0,strResult.length-2); //去掉最后一个回车及换行
		}
		f.WriteLine(strResult); 
		
		f.Close();
		alert("<%=GetToolLbl("ExportComplete")%>");	//导出完成！
	}
	catch(e)
	{
		try{
			if (e.name != "SyntaxError")
			{
				//alert("导出失败("+e.message+")\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
				alert("<%=GetToolLbl("ExportFail")%>"+"("+e.message+")"+"<%=GetToolLbl("ExportFailMsg")%>");
			}
			else{
				//alert(e.message+"\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
				alert(e.message+"<%=GetToolLbl("ExportFailMsg")%>");
			}
			f.Close();
		}
		catch(ex)
		{}
	}
}

</script>
</body>
</html>
