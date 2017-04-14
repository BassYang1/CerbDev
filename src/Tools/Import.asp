<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Import</title>
<link rel="stylesheet" type="text/css" media="screen" href="../css/jquery-ui-1.10.2.redmond.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="../css/ui.multiselect.css"/>
<!--[if IE]><link type="text/css" rel="stylesheet" href="ie.css"/><![endif]-->
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/lang/lang.js"></script>
<script>
	document.write("<scr"+"ipt type='text/javascript' src='../js/i18n/"+getJgLan()+"'><\/script>");
	document.write("<scr"+"ipt type='text/javascript' src='../js/My97DatePicker/"+getDpLan()+"'><\/script>");
</script>
<script type="text/javascript" src="../js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="../js/custom/jqGridSet.js"></script>
<script type="text/javascript" src="../js/custom/system.js"></script>
<script type="text/javascript" src="../js/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="../js/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../js/ui/jquery.ui.progressbar.js"></script>

<script src="../js/ui/jquery.ui.mouse.js"></script>
<script src="../js/ui/jquery.ui.button.js"></script>
<script src="../js/ui/jquery.ui.draggable.js"></script>
<script src="../js/ui/jquery.ui.position.js"></script>
<script src="../js/ui/jquery.ui.dialog.js"></script>
<link rel="stylesheet" href="../css/demos.css">
<!--#include file="..\Conn\GetLbl.asp"-->
</head>
<script language="javascript">
var empArr = new Array();
var tableArr = new Array();
function changeExcel()
{
	var i;
	var j;
	var path = form1.file1.value;
	try
	{ 
		var xlApp = new ActiveXObject("Excel.Application");//创建Excel对象
	} 
	catch(e)
	{ 
		//alert("请启用ActiveX控件设置！\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
		alert("<%=GetToolLbl("ImportAlertMsg")%>");
		return;
	} 
	var oWB = xlApp.Workbooks.open(path); 
	var exWbook = xlApp.ActiveWorkBook;
	document.form1.selTable.length = 0;
	//document.form1.selTable.options[0] = new Option('====请选择====','0');
	document.form1.selTable.options[0] = new Option("<%=GetToolLbl("PleaseSelect")%>","0");
	var k = 0;
	for (i=1;i<=exWbook.Sheets.Count ;i++ )
	{
		document.form1.selTable.options[document.form1.selTable.length] = new Option(exWbook.Sheets(i).Name, i);
		//alert(exWbook.Sheets(i).UsedRange.columns.Count);
		//alert(exWbook.Sheets(i).UsedRange.rows.Count);
		tableArr[i-1]=new Array(i,exWbook.Sheets(i).Name);
		for (j=1;j<= exWbook.Sheets(i).UsedRange.columns.Count;j++ )
		{
			var temp = typeof(exWbook.Sheets(i).cells(1,j).value);
			if (temp != "undefined")
			{
				empArr[k]=new Array(i,j,exWbook.Sheets(i).cells(1,j).value);
				k = k + 1;
			}
		}
	}
	xlApp.Quit();
	xlApp = null;
}
function init()
{
	document.form1.selTable.options[0] = new Option("<%=GetToolLbl("PleaseSelect")%>","0");
	for (i=0;i<document.form1.elements.length;i++)
	{
		//alert(document.form1.elements[i].name);
		if (document.form1.elements[i].name == 'chkEmp')
		{
	　　		document.form1.elements[i].length = 0;
			document.form1.elements[i].options[0] = new Option('','0');
		}
	}
}
	
function changeTable(tableid)
{
	var i;
	for (i=0;i<document.form1.elements.length;i++)
　　	{
		//alert(document.form1.elements[i].name);
　　		if (document.form1.elements[i].name == 'chkEmp')
			{
　　			document.form1.elements[i].length = 0;
				document.form1.elements[i].options[0] = new Option('','0');
			}
　　	}
	
	for (i=0; i<empArr.length; i++) //legth=20 
	{ 
		if (empArr[i][0] == tableid) //[0] [1] 第一列 第二列 
		{
			for (var j=0;j<document.form1.elements.length;j++)
		　　{
		　　	if (document.form1.elements[j].name == "chkEmp")
				{
					document.form1.elements[j].options[document.form1.elements[j].length] = new  Option(empArr[i][2], empArr[i][1]);
				}
		　　}
		}  
	} 
}
function fSubmit()
{
	strUrl = "";
	var act = (document.form1.act1.checked ? 0 : 1); //０：新增数据; １：修改数据
	
	if (document.form1.file1.value == "")
	{
		//alert("请选择要上传的Excel文件！");
		alert("<%=GetToolLbl("PleaseSelectExcelFile")%>");
		return false;
	}
	if (document.form1.elements['table'].options[document.form1.elements['table'].options.selectedIndex].value == "0")
	{
		//alert("请选择要导入的Excel表！");
		alert("<%=GetToolLbl("PleaseSelectExcelTable")%>");
		return false;
	}
	
	if(act == 0){ //新增加人事
		//document.form1.action = "ImportEdit.asp";
		strUrl = "ImportEdit.asp";
		if (document.form1.elements['DepartmentId'].options[document.form1.elements['DepartmentId'].options.selectedIndex].value == "0")
		{
			alert("<%=GetToolLbl("DeptNull")%>");	//部门不能为空！
			return false;
		}
		if (document.form1.elements['Name'].options[document.form1.elements['Name'].options.selectedIndex].value == "0")
		{
			alert("<%=GetToolLbl("NameNull")%>");	//姓名不能为空！
			return false;
		}
		if (document.form1.elements['Number'].options[document.form1.elements['Number'].options.selectedIndex].value == "0")
		{
			alert("<%=GetToolLbl("NumberNull")%>");	//工号不能为空！
			return false;
		}
		if (document.form1.elements['Headship'].options[document.form1.elements['Headship'].options.selectedIndex].value == "0")
		{
			alert("<%=GetToolLbl("HeadshipNull")%>");	//职务不能为空！
			return false;
		}
		if (document.form1.elements['JoinDate'].options[document.form1.elements['JoinDate'].options.selectedIndex].value == "0")
		{
			alert("<%=GetToolLbl("JoinDateNull")%>");	//请选择入职日期！
			return false;
		}
	}
	else if(act == 1){ //修改人事
		//document.form1.action = "changeEmOper.asp";
		strUrl="ImportChangeEdit.asp";
		var objs = document.getElementsByTagName("SELECT"); //读取页面中TagName为SELECT的控件对象
		var hasItem = false;
		if(objs[3].options[objs[3].options.selectedIndex].value == "0"){
			//alert("请选择员工工号，修改人事以员工工号为索引关联人事资料！");
			alert("<%=GetToolLbl("EditByNumber")%>");
			return false;
		}
		
		for(var i = 1; i < objs.length; i ++){
			if(objs[i].id != "Number" && objs[i].options[objs[i].options.selectedIndex].value != "0"){ //以Number为索引，批量修改人事资料
				hasItem = true;
				break;
			}
		}
		
		if(!hasItem){
			//alert("请选择要修改的项！");
			alert("<%=GetToolLbl("SelectOptions")%>");
			return false;
		}
	}
	else return false;
	
	var i,j,k;
	var path = document.form1.file1.value;
	try
	{ 
		var xlApp = new ActiveXObject("Excel.Application");//创建Excel对象
	} 
	catch(e)
	{ 
		//alert("请启用ActiveX控件设置！\n请尝试：工具 -> Internet 选项 -> 安全 -> \n自定义安全级别 -> ActiveX 控件与插件 ->\n对未标记为可安全执行脚本的ActiveX 控件初始化并执行\n设置为[启用]");
		alert("<%=GetToolLbl("ImportAlertMsg")%>");
		return;
	} 
	var oWB = xlApp.Workbooks.open(path); 
	var exWbook = xlApp.ActiveWorkBook 
	var k=parseInt(document.form1.elements['table'].options[document.form1.elements['table'].options.selectedIndex].value);
	var strValues = "";
	var selobject;
	for (i=1;i<= exWbook.Sheets(k).UsedRange.rows.count ;i++ )  //循环获取Excel表中的数据
	{
		selobject = document.form1.elements['DepartmentId'].options;
		if(selobject[selobject.selectedIndex].value != "0")
		{
			if(i != 1)
			{
				if(typeof(exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value)== "undefined")
				{			
					continue;
				}
				else
					strValues = strValues + exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value + ",";
			}
			else
				strValues = strValues + "DepartmentId,";
		}
		selobject = document.form1.elements['Name'].options;
		if(selobject[selobject.selectedIndex].value != "0")
		{
			if(i != 1)
			{
				if(typeof(exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value)== "undefined")
				{			
					continue;
				}
				else
					strValues = strValues + exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value + ",";
			}
			else
				strValues = strValues + "Name,";
		}
		//alert(document.form1.elements[6].id);
		//alert(document.form1.elements[10].id);
		//alert(document.form1.elements[24].id);
		//return false;
		for(j=10;j<=24;j++)
		{
			selobject = document.form1.elements[document.form1.elements[j].id].options;
			if(selobject[selobject.selectedIndex].value != "0")
			{
				if(i != 1)
				{
					if(typeof(exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value)== "undefined")
					{	
						if(document.form1.elements[j].id == "Card")
						{
							strValues = strValues + "0,"
						}
						else		
							strValues = strValues + ","
					}
					else
					{
						if(document.form1.elements[j].id == "JoinDate" || document.form1.elements[j].id == "BirthDate")
						{
							//传换时间格式
							try{
								var strDateVal = exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value;
								//js转日期格式，只能为2015/4/28 ，不能为2015-04-28
								//Excel如果是日期格式，如2015-1-1， 读取出来的值将直接是UTC格式，使用下面正则表达式将报错。
								var d;
								try{
									var regEx = new RegExp("\\-","gi");
									strDateVal=strDateVal.replace(regEx,"/"); 
									d = new Date(strDateVal);
								}
								catch(ex){
									d = new Date(strDateVal);
								}
								var s = "";
								s += d.getFullYear() + "-";
								s += (d.getMonth() + 1) + "-";
								s += d.getDate();
								strValues = strValues + s + ",";
							}
							catch(e){
								strValues = strValues + ",";
							}
						}
						else if(document.form1.elements[j].id == "AnnualVacation"){
							strValues = strValues + exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value + "," + exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value + ",";
						}
						else
							strValues = strValues + exWbook.Sheets(k).cells(i,parseInt(selobject[selobject.selectedIndex].value)).value + ",";
					}
				}
				else{
					if(document.form1.elements[j].id == "AnnualVacation") strValues = strValues + "AnnualVacationCust, " + document.form1.elements[j].id + ",";
					else strValues = strValues + document.form1.elements[j].id + ",";
				}
			}
			else
			{
				if(document.form1.elements[j].id == "JoinDate")
				{
					if(act == 0){ //如为新增人事，则添加入职时间字段
						if(i == 1)
						{
							strValues = strValues + "JoinDate,";
						}
						else strValues = strValues + ",";
					}
				}
			}
		}
		
		if(i == 1)
		{
			strValues = strValues + "IncumbencyStatus|";
		}
		else strValues = strValues + "0|";
		
	}
	xlApp.Quit();
	xlApp = null;
	document.form1.ListValues.value = strValues;
	//alert(strValues);
	$.ajax({
		type: 'Post',
		url: strUrl,
		data:{"ListValues":strValues},
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					alert(responseMsg.message);
				}else if(responseMsg.success == true){
					//保存成功后，清空参数，按钮置为禁用
					alert(responseMsg.message);
				}else{
					//alert("保存数据异常");
					alert("<%=GetToolLbl("SaveDataEx")%>");
				}
			}
			catch(exception) {
				alert(exception);
			}
		}
	});	
	//return false;
	return true;
}

function fReset()
{
	//document.form1.selTable.clear();
	form1.reset();
	return false;
}

//选择添加人事
function fSelAddEm(){
	document.all.spDept.innerText = "＊";
	document.all.spName.innerText = "＊";
	document.all.spHeadship.innerText = "＊";
	document.all.spJoinDate.innerText = "＊";
}

//选择修改人事
function fSelChangeEm(){
	document.all.spDept.innerHTML = "";
	document.all.spName.innerText = "";
	document.all.spHeadship.innerText = "";
	document.all.spJoinDate.innerText = "";
}

</script>
<style type="text/css">
body{ font-size:11.5px;}
.file-box{ position:relative;width:220px; top:2px; height:20px }
.btn{ position:absolute; background-color:#FFF; border:1px solid #CDCDCD;top:2px; left:140px;height:18px; width:50px;}
.file{ position:absolute; top:0; left:-3px; height:22px; filter:alpha(opacity:0);opacity: 0;width:195px;z-index:1 }
.inputstyle { position:absolute; top:1px; left:1px;border:1px solid #BEBEBE; width:130px; float:left;
 height:16px; line-height:16px; background:#FFF;z-index:99 } 
</style>
<body onLoad="init()">
<form id="form1" name="form1" method="post" action="" target="lead">
  <input name="leadIn" type="hidden" id="leadIn" value="leadIn" >
  <input type="hidden" name="ListValues" value="">
  <div id="dialog-modal-Msg" title="<%=GetToolLbl("prompt")%>" style="display: none;">
  	<span class="ui-icon ui-icon-alert" style="float:left; margin:20px;margin-left:30px;"></span><br />
  	<p><%=GetToolLbl("OnlyIEUsed")%><!--该功能请在IE下使用--></p>
  </div>
  <table width="900px"  border="0" cellspacing="0" cellpadding="0" class="ui-jqgrid ui-widget ui-widget-content ui-corner-all">
    <tr>
      <td valign="top">
	     <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><div class="ui-jqgrid-titlebar ui-jqgrid-caption ui-widget-header ui-corner-top ui-helper-clearfix">
					<span class="ui-jqgrid-title"><%=GetToolLbl("EmpImport")%><!--人事导入--></span>
			</div></td>
          </tr>
        </table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <td><div id="DataGrid_toppager" class="ui-state-default ui-jqgrid-toppager" style="" dir="ltr"><div role="group" class="ui-pager-control" id="pg_DataGrid_toppager"><table border="0" cellspacing="0" cellpadding="0" role="row" style="width:100%;table-layout:fixed;height:100%;" class="ui-pg-table"><tbody><tr><td align="left" id="DataGrid_toppager_left" style="width: 269px;"><table border="0" cellspacing="0" cellpadding="0" style="float:left;table-layout:auto;" class="ui-pg-table navtable"><tbody><tr><td class="ui-pg-button ui-corner-all" id="DataGrid_btnSubmit" title="<%=GetEmpLbl("Submit")%>"><div class="ui-pg-div"><span class="ui-icon ui-icon-disk"></span><%=GetEmpLbl("Submit")%><!--提交--></div></td><td class="ui-pg-button ui-corner-all" id="DataGrid_btnCancel" title="<%=GetEmpLbl("Cancel")%>"><div class="ui-pg-div"><span class="ui-icon ui-icon-cancel"></span><%=GetEmpLbl("Cancel")%></div></td></tr></tbody></table></td><td align="right" id="DataGrid_toppager_right" style="width: 1%;"></td></tr></tbody></table></div></div></td>
          </tr>
         </table>
		 <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr class="ui-widget-content jqgrow ui-row-ltr">
              <td width="80" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("FileName")%><!--文件名：--></div></td>
              <td height="16"><div id="divBrowseFile" class="file-box" style="position:relative; float:left; display:inline">
			  <input name="" type="text" id="viewfile" class="inputstyle FormElement ui-widget-content ui-corner-all" />
			  <input type='button' id="button1" class='btn FormElement ui-widget-content ui-corner-all' value="<%=GetToolLbl("Browse")%>" />
			  <input type="file" name="file1" dir="file1" class="file" onChange="document.getElementById('viewfile').value=this.value;changeExcel();">
			  </div><div id="divImportType" style="height:18px; line-height:18px;top:5px;position:relative; float:left; display:inline"><input type="radio" id="act1" name="act" checked value="0" onClick="fSelAddEm()"><label for="act1"><%=GetToolLbl("AddEmp")%><!--新增人事--></label><input type="radio" id="act2" name="act" value="1" onClick="fSelChangeEm()"><label for="act2"><%=GetToolLbl("EditEmp")%><!--修改人事--></label></div>
			  </td>
            </tr>
		  </table>
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr class="ui-widget-content jqgrow ui-row-ltr">
              <td width="80" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("TableName")%><!--表名：--></div></td>
              <td><select id="table" name="selTable" onChange="changeTable(this.value)" class="FormElement ui-widget-content ui-corner-all">
			  </select>＊</td>
            </tr>
          </table>
		  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr class="ui-widget-content jqgrow ui-row-ltr">
              <td height="24" class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;<%=GetToolLbl("FiledName")%><!--字段对应：--></td>
            </tr>
            <tr>
              <td><table width="100%"  border="0" cellpadding="0" cellspacing="0" class="">
                  <tr class="ui-widget-content jqgrow ui-row-ltr">
                    <td width="15%" height="24" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Dept")%><!--部门：--></div></td>
                    <td width="30%"><select id="DepartmentId" name="chkEmp" class="FormElement ui-widget-content ui-corner-all">
                    </select><span id="spDept">＊</span></td>
                    <td width="15%"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Name1")%><!--姓名：--></div></td>
                    <td width="40%"><select id="Name" name="chkEmp" class="FormElement ui-widget-content ui-corner-all">
                    </select><span id="spName">＊</span></td>
                  </tr>
                  <tr class="ui-widget-content jqgrow ui-row-ltr">
                    <td height="24" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Number")%><!--工号：--></div></td>
                    <td><select name="chkEmp" id="Number" class="FormElement ui-widget-content ui-corner-all">
                    </select>＊</td>
					<td ><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Card")%><!--卡号：--></div></td>
                    <td><select name="chkEmp" id="Card" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                  </tr>
                  <tr class="ui-widget-content jqgrow ui-row-ltr">
				  	<td height="24" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Ident")%><!--身份证号：--></div></td>
                    <td><select name="chkEmp" id="IdentityCard" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                    <td height="0" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Sex")%><!--性别：--></div></td>
                    <td><select name="chkEmp" id="Sex" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                  </tr>
                  <tr class="ui-widget-content jqgrow ui-row-ltr">
                    <td height="5" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Headship")%><!--职务：--></div></td>
                    <td><select name="chkEmp" id="Headship" class="FormElement ui-widget-content ui-corner-all">
                    </select><span id="spHeadship">＊</span></td>
                    <td height="0" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Position")%><!--职位：--></div></td>
                    <td><select name="chkEmp" id="Position" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                  </tr>
				  <tr class="ui-widget-content jqgrow ui-row-ltr">
                    <td height="6" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Tel")%><!--电话：--></div></td>
                    <td><select name="chkEmp" id="Telephone" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                    <td height="6" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Email")%><!--Email：--></div></td>
                    <td><select name="chkEmp" id="Email" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                  </tr>
                  <tr class="ui-widget-content jqgrow ui-row-ltr">
				  	<td height="2" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("BirthDate")%><!--出生日期：--></div></td>
                    <td><select name="chkEmp" id="BirthDate" class="FormElement ui-widget-content ui-corner-all">
                    </select>(YYYY-MM-DD)</td>
                    <td height="1" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("JoinDate")%><!--入职日期：--></div></td>
                    <td><select name="chkEmp" id="JoinDate" class="FormElement ui-widget-content ui-corner-all">
                    </select><span id="spJoinDate">＊</span>(YYYY-MM-DD)</td>
                  </tr>
                  <tr class="ui-widget-content jqgrow ui-row-ltr">
                    <td height="24" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Marry")%><!--婚否：--></div></td>
                    <td><select name="chkEmp" id="Marry" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                    <td height="24" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Knowledge")%><!--学历：--></div></td>
                    <td><select name="chkEmp" id="Knowledge" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                  </tr>
                  <tr class="ui-widget-content jqgrow ui-row-ltr">
                    <td width="119" height="24" align="right"><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Country")%><!--国籍：--></div></td>
                    <td width="235"><select name="chkEmp" id="Country" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                    <td><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("NativePlace")%><!--籍贯：--></div></td>
                    <td><select name="chkEmp" id="NativePlace" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                  </tr>
                  <tr class="ui-widget-content jqgrow ui-row-ltr">
					<td><div align="left"><span class="toptd">&nbsp;&nbsp;&nbsp;&nbsp;</span><%=GetToolLbl("Address")%><!--通信地址：--></div></td>
                    <td><select name="chkEmp" id="Address" class="FormElement ui-widget-content ui-corner-all">
                    </select></td>
                    <td height="0" align="right"></td>
                    <td></td>
                  </tr>
              </table></td>
            </tr>
          </table>
          <table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr><td><div style="text-align: center; width: 100%px;" class="scroll ui-state-default ui-jqgrid-pager ui-corner-bottom" id="pager" dir="ltr"><div role="group" class="ui-pager-control" id="pg_pager"><table border="0" cellspacing="0" cellpadding="0" role="row" style="width:100%;table-layout:fixed;height:100%;" class="ui-pg-table"><tbody><tr><td align="left" id="pager_left"></td><td align="center" style="white-space: pre; width: 237px;" id="pager_center"></td></tr></tbody></table></div></div></td></tr>
          </table>
       </td>
    </tr>
  </table>
</form>
<iframe src="" name="lead" width="0" height="0" scrolling="auto" frameborder="0" id="lead"></iframe>
<script language="javascript">
//获取操作权限
var role = GetOperRole("import");
var iedit=false,iadd=false,idel=false,iview=false,irefresh=false,isearch=false,iexport=false;
try{
	iedit=role.edit;
	iadd=role.add;
	idel=role.del;
	iview=role.view;
	irefresh=role.refresh;
	isearch=role.search;
	iexport=role.exportdata;
}
catch(exception) {
	alert(exception);
}

$("#DataGrid_btnSubmit").hover( function () { $(this).addClass("ui-state-hover"); }, function () { $(this).removeClass("ui-state-hover"); }); 
$("#DataGrid_btnCancel").hover( function () { $(this).addClass("ui-state-hover"); }, function () { $(this).removeClass("ui-state-hover"); }); 
var isSubmit = false; //按钮无法禁用。用于避免重复提交 
$("#DataGrid_btnSubmit").click(function(){
	$("#DataGrid_btnSubmit").addClass('ui-state-disabled'); 
	if(isSubmit) return;
	isSubmit = true;
	fSubmit();
	isSubmit = false;
	$("#DataGrid_btnSubmit").removeClass('ui-state-disabled'); 
});
$("#DataGrid_btnCancel").click(function(){
	fReset(); 
});
function ShowIEMsg(){
	$( "#dialog-modal-Msg" ).dialog({
		height: 140,
		modal: true,
		open: function(event, ui) {
			$(this).closest('.ui-dialog').find('.ui-dialog-titlebar-close').hide();
		},
		position:[ 130,60 ] ,
	});
}
if(!isIE()){
	ShowIEMsg();
}

if(!iadd){
	$("#DataGrid_btnSubmit").attr("disabled","disabled"); 
	$("#DataGrid_btnSubmit").addClass('ui-state-disabled'); 
	$("#DataGrid_btnCancel").attr("disabled","disabled"); 
	$("#DataGrid_btnCancel").addClass('ui-state-disabled'); 
	$("#DataGrid_btnSubmit").hide();
	$("#DataGrid_btnCancel").hide();
	$("#divBrowseFile").attr("disabled","disabled"); 
	$("#divBrowseFile").addClass('ui-state-disabled'); 
	$("#divImportType").attr("disabled","disabled"); 
	$("#divImportType").addClass('ui-state-disabled'); 
}
</script>
</body>
</html>

