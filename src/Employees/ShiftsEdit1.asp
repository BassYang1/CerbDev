<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Employees</title>
<link rel="stylesheet" type="text/css" media="screen" href="../css/jquery-ui-1.10.2.redmond.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="../css/ui.multiselect.css"/>
<!--[if IE]><link type="text/css" rel="stylesheet" href="ie.css"/><![endif]-->

<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/i18n/grid.locale-cn.js"></script>
<script type="text/javascript">
	$.jgrid.no_legacy_api = true;
	$.jgrid.useJSON = true;
</script>
<script type="text/javascript" src="../js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="../js/custom/jqGridSet.js"></script>
<script type="text/javascript" src="../js/custom/system.js"></script>
<script language="javascript" type="text/javascript" src="../js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="../js/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="../js/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../js/ui/jquery.ui.progressbar.js"></script>

<script src="../js/ui/jquery.ui.mouse.js"></script>
<script src="../js/ui/jquery.ui.button.js"></script>
<script src="../js/ui/jquery.ui.draggable.js"></script>
<script src="../js/ui/jquery.ui.position.js"></script>
<script src="../js/ui/jquery.ui.dialog.js"></script>
<link rel="stylesheet" href="../css/demos.css">
<style>
.ui-border {
	border-top:1px solid #a6c9e2;
	border-left:1px solid #a6c9e2;
	padding: 6px;
}
.ui-NoneRightBorder {
	

}
</style>	
</head>
<%
dim strConId,strEmpId,iDoor,iSearch

strConId = Cstr(Trim(Request.QueryString("ControllerID")))
strEmpId = Cstr(Trim(Request.QueryString("EmployeeID")))

%>


<div class="ui-widget ui-widget-content ui-corner-all ui-jqdialog jqmID1" id="editmodDataGrid" dir="ltr" style="width: 900px; height: auto; z-index: 950; top: 12px; left: 12px; display: block;" tabindex="-1" role="dialog" aria-labelledby="edithdDataGrid" aria-hidden="false">
	<div class="ui-jqdialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" id="edithdDataGrid" style="cursor: move;"><span style="float: left;" class="ui-jqdialog-title">添加记录</span><a class="ui-jqdialog-titlebar-close ui-corner-all" style="right: 0.3em;"><span class="ui-icon ui-icon-closethick"></span></a></div>
	<div id="editcntDataGrid" class="ui-jqdialog-content ui-widget-content">
	<form name="FormPost" id="FrmGrid_DataGrid" >
    <table id="TblGrid_DataGrid" class="EditTable" border="0" cellpadding="0" cellspacing="0">
     <tbody>
      
      <tr style="display: none;" id="FormError"><td colspan="4" class="ui-state-error"></td><td colspan="2" class="i-state-error"></td></tr>
      <tr class="tinfo" style="display:none"><td colspan="4" class="topinfo"></td></tr>
      <tr rowpos="2" class="FormData" id="trShiftName">
        <td style="width: 13%;" align="center" class="ui-border ui-NoneRightBorder">班次名称</td><td class="ui-border ui-NoneRightBorder">&nbsp;<input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ShiftName" id="ShiftName" type="text"><font color="#FF0000">*</font></td><td style="width: 13%;"  align="center"  class="ui-border ui-NoneRightBorder">标准工时</td><td class="ui-border ui-NoneRightBorder">&nbsp;<input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ShiftTime" id="ShiftTime" type="text">小时<font color="#FF0000">*</font></td></tr>
      <tr id="trNight" class="FormData " rowpos="3" ><td align="center"  class="ui-border ui-NoneRightBorder" >过夜</td><td class="ui-border ui-NoneRightBorder " >&nbsp;<input class="FormElement" role="checkbox" name="Night" id="Night" offval="0" value="1" type="checkbox"></td><td style="display: table-cell;" align="center"  class="ui-border ui-NoneRightBorder">第一次上班刷卡</td><td style="display: table-cell;" class="ui-border ui-NoneRightBorder">&nbsp;
      <select class="FormElement ui-widget-content ui-corner-all" name="FirstOnDuty" id="FirstOnDuty" role="select" style="width:120px;">
         <option value="0" role="option">0 - 当日</option>
       </select></td></tr>
      <tr style="display: table-row;" id="trDegree" class="FormData" rowpos="4"><td  align="center"  class="ui-border ui-NoneRightBorder">时段数</td><td class="ui-border ui-NoneRightBorder">&nbsp;
      <select class="FormElement ui-widget-content ui-corner-all" name="Degree" id="Degree" role="select" style="width:120px;" onchange="SelDegree(this)">
         <option value="1" role="option">1</option>
         <option value="2" role="option">2</option>
         <option value="3" role="option">3</option>
       </select>
      </td><td  align="center"  class="ui-border ui-NoneRightBorder">弹性班次</td><td class="ui-border ui-NoneRightBorder">&nbsp;&nbsp;<input class="FormElement" role="checkbox" name="StretchShift" id="StretchShift" offval="0" value="1" type="checkbox"></td></tr>
      <tr style="display: table-row;" id="tr_DNS" class="FormData" rowpos="5">
       <td colspan="4">
        <TABLE width="100%" border="0" cellPadding=0 cellSpacing=0>
		  <TBODY>
          	<TR  class="FormData" >
             <TD colspan=2 rowspan="2" align="center" class="ui-border ui-NoneRightBorder"  style="width: 13%;">时段</TD>
             <TD colspan=3 align="center" class="ui-border ui-NoneRightBorder"  style="width: 25%;">上班</TD>
             <TD colspan=3 align="center" class="ui-border ui-NoneRightBorder"  style="width: 25%;">下班</TD>
             <TD colspan=6 align="center" class="ui-border ui-NoneRightBorder">其它</TD>
            </TR>
			<TR>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder">标准</TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder">开始</TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder">截止</TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder">标准</TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder">开始</TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder">截止</TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder">允许迟到时间(分)</TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder">允许早退时间(分)</TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder">中间休息(分)</TD>
            </TR>
            <TR id="trAOnDuty">
           	 <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder">1</TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AonDuty" id="AonDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AonDutyStart" id="AonDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AonDutyEnd" id="AonDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AoffDuty" id="AoffDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AoffDutyStart" id="AoffDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AoffDutyEnd" id="AoffDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AcalculateLate" id="AcalculateLate" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AcalculateEarly" id="AcalculateEarly" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ArestTime" id="ArestTime" type="text" style="width:50px;"></TD>
            </TR>
            <TR id="trBOnDuty">
           	 <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder">2</TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BonDuty" id="BonDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BonDutyStart" id="BonDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BonDutyEnd" id="BonDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BoffDuty" id="BoffDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BoffDutyStart" id="BoffDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BoffDutyEnd" id="BoffDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BcalculateLate" id="BcalculateLate" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BcalculateEarly" id="BcalculateEarly" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BrestTime" id="BrestTime" type="text" style="width:50px;"></TD>
            </TR>
            <TR id="trCOnDuty">
           	 <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder">3</TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ConDuty" id="ConDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ConDutyStart" id="ConDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ConDutyEnd" id="ConDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CoffDuty" id="CoffDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CoffDutyStart" id="CoffDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CoffDutyEnd" id="CoffDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CcalculateLate" id="CcalculateLate" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CcalculateEarly" id="CcalculateEarly" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CrestTime" id="CrestTime" type="text" style="width:50px;"></TD>
            </TR>
		  </TBODY>
		</TABLE>
       </td>
      </tr>
      <tr style="display:none" class="FormData"><td class="ui-border ui-NoneRightBorder"></td><td class="ui-border ui-NoneRightBorder" colspan="3"><input type="text" value="_empty" name="DataGrid_id" id="id_g" class="FormElement"></td></tr></tbody></table></form>
      
      <table class="EditTable" id="TblGrid_DataGrid_2" border="0" cellpadding="0" cellspacing="0"><tbody><tr><td colspan="2"><hr class="ui-widget-content" style="margin:1px"></td></tr>
      <tr id="Act_Buttons"><td class="navButton"><a style="display: none;" id="pData" class="fm-button ui-state-default ui-corner-left"><span class="ui-icon ui-icon-triangle-1-w"></span></a><a style="display: none;" id="nData" class="fm-button ui-state-default ui-corner-right"><span class="ui-icon ui-icon-triangle-1-e"></span></a></td><td class="EditButton"><a id="sData" class="fm-button ui-state-default ui-corner-all fm-button-icon-left">提交<span class="ui-icon ui-icon-disk"></span></a><a id="cData" class="fm-button ui-state-default ui-corner-all fm-button-icon-left">取消<span class="ui-icon ui-icon-close"></span></a></td></tr>
      <tr style="display:none" class="binfo"><td class="bottominfo" colspan="2"></td></tr></tbody></table></div>
      
	<div class="jqResize ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"></div></div>
    
    
<script type="text/javascript">
function GetTime(){
	WdatePicker({isShowClear:true,dateFmt:'HH:mm',isShowToday:false,qsEnabled:false});
};

function CompareTime(Duty,DutyStart,DutyEnd)
{
	if(Duty == "")
		return 1;
	if(DutyStart == "")
		return 2;
	if(DutyEnd == "")
		return 3;
	
	var arrDuty = Duty.split(":");
	var arrDutyStart = DutyStart.split(":");
	var arrDutyEnd = DutyEnd.split(":");
	if(arrDuty.length !=2)
		return 11;
	if(arrDutyStart.length !=2)
		return 22;
	if(arrDutyEnd.length !=2)
		return 33;
		
	if((arrDutyStart[0] > arrDuty[0]) || (arrDutyStart[0] == arrDuty[0] && arrDutyStart[1] > arrDuty[1])){
		return 111;
	}	
	if((arrDuty[0] > arrDutyEnd[0]) || (arrDuty[0] == arrDutyEnd[0] && arrDuty[1] > arrDutyEnd[1])){
		return 222;
	}
	return 0;
}

function CompareTime2(DutyStart,DutyEnd)
{
	if(DutyStart == "")
		return 1;
	if(DutyEnd == "")
		return 2;
	
	var arrDutyStart = DutyStart.split(":");
	var arrDutyEnd = DutyEnd.split(":");
	if(arrDutyStart.length !=2)
		return 11;
	if(arrDutyEnd.length !=2)
		return 22;
		
	if((arrDutyStart[0] > arrDutyEnd[0]) || (arrDutyStart[0] == arrDutyEnd[0] && arrDutyStart[1] > arrDutyEnd[1])){
		return 111;
	}
	return 0;
}


function SelDegree(){
	var val = $("#Degree").val();
	if(val == "1"){
		$("#trAOnDuty").show();
		$("#trBOnDuty").hide();
		$("#trCOnDuty").hide();
	}
	else if(val == "2"){
		$("#trAOnDuty").show();
		$("#trBOnDuty").show();
		$("#trCOnDuty").hide();
	}
	else if(val == "3"){
		$("#trAOnDuty").show();
		$("#trBOnDuty").show();
		$("#trCOnDuty").show();
	}
	else{
		$("#trAOnDuty").show();
		$("#trBOnDuty").hide();
		$("#trCOnDuty").hide();
	}
}

function Init(){
	$("#AonDuty").bind('focus',GetTime);
	$("#AonDutyStart").bind('focus',GetTime);
	$("#AonDutyEnd").bind('focus',GetTime);
	$("#AoffDuty").bind('focus',GetTime);
	$("#AoffDutyStart").bind('focus',GetTime);
	$("#AoffDutyEnd").bind('focus',GetTime);
	
	$("#BonDuty").bind('focus',GetTime);
	$("#BonDutyStart").bind('focus',GetTime);
	$("#BonDutyEnd").bind('focus',GetTime);
	$("#BoffDuty").bind('focus',GetTime);
	$("#BoffDutyStart").bind('focus',GetTime);
	$("#BoffDutyEnd").bind('focus',GetTime);
	
	$("#ConDuty").bind('focus',GetTime);
	$("#ConDutyStart").bind('focus',GetTime);
	$("#ConDutyEnd").bind('focus',GetTime);
	$("#CoffDuty").bind('focus',GetTime);
	$("#CoffDutyStart").bind('focus',GetTime);
	$("#CoffDutyEnd").bind('focus',GetTime);
	
	$("#Night").click(function(){
		if($("#Night").get(0).checked == true){
			$("#FirstOnDuty").empty();
			$("#FirstOnDuty").append("<option value='0'>0 - 当日</option>"); 
			$("#FirstOnDuty").append("<option value='1'>1 - 上日</option>"); 
		}else{
			$("#FirstOnDuty").empty();
			$("#FirstOnDuty").append("<option value='0'>0 - 当日</option>"); 
		}
	});
	
	$("#StretchShift").click(function(){
		if($("#StretchShift").get(0).checked == true){
			 $("#Degree").val("1");
			 $("#Degree").change();
			 $("#AonDutyEnd").val("");
			 $("#AoffDutyStart").val("");
			 $("#AonDutyEnd").attr("disabled","disabled"); 
			 $("#AoffDutyStart").attr("disabled","disabled");   
			 $("#Degree").attr("disabled","disabled");  
		}else{
			$("#AonDutyEnd").removeAttr("disabled");  
			$("#AoffDutyStart").removeAttr("disabled");  
			$("#Degree").removeAttr("disabled");  
		}
	});
	
	$("#Degree").change();
	
	$("#sData").click(function(){
		checkData();
	});
}
Init();

function showMsg(strMsg){
	$("#FormError").show();
	$("#FormError").children("td:eq(0)").html(strMsg);
}

function checkData(){
	if($("#ShiftName").val() == ""){
		$("#ShiftName").focus();
		showMsg("[班次名称]不能为空");
		return false;
	}else if($("#ShiftTime").val() == ""){
		$("#ShiftTime").focus();
		showMsg("[标准工时]不能为空");
		return false;
	}
	if(isNaN($("#ShiftTime").val())){
		$("#ShiftTime").focus();
		$("#ShiftTime").select();
		showMsg("[标准工时]必须为数字");
		return false;
	}
	else if($("#AcalculateLate").val() != "" && isNaN($("#AcalculateLate").val()) ){
		$("#AcalculateLate").focus();
		$("#AcalculateLate").select();
		showMsg("[允许迟到]必须为数字");
		return false;
	}
	else if($("#AcalculateEarly").val() != "" && isNaN($("#AcalculateEarly").val()) ){
		$("#AcalculateEarly").focus();
		$("#AcalculateEarly").select();
		showMsg("[允许早退]必须为数字");
		return false;
	}
	else if($("#ArestTime").val() != "" && isNaN($("#ArestTime").val()) ){
		$("#ArestTime").focus();
		$("#ArestTime").select();
		showMsg("[中间休]息必须为数字");
		return false;
	}
	var iDegree = $("#Degree").val();
	var iStretchShift = $("#StretchShift").get(0).checked; //是否弹性班次
	var iNight =  $("#Night").get(0).checked;//是否过夜
	var iFirstOnDuty = $("#FirstOnDuty").val();
	var RetVal;
	if(!iStretchShift && !iNight){
		RetVal = CompareTime($("#AonDuty").val(),$("#AonDutyStart").val(),$("#AonDutyEnd").val());
		switch(RetVal){
			case 1:showMsg("[上班标准时间]不能为空！");$("#AonDuty").focus(); return false;
			case 2:showMsg("[上班开始时间]不能为空！");$("#AonDutyStart").focus(); return false;
			case 3:showMsg("[上班截止时间]不能为空！");$("#AonDutyEnd").focus(); return false;
			case 11:showMsg("[上班标准时间]非法！");$("#AonDuty").focus(); return false;
			case 22:showMsg("[上班开始时间]非法！");$("#AonDutyStart").focus(); return false;
			case 33:showMsg("[上班截止时间]非法！");$("#AonDutyEnd").focus(); return false;
			case 111:showMsg("[上班标准时间]不能小于[上班开始时间]！");$("#AonDuty").focus(); return false;
			case 222:showMsg("[上班截止时间]不能小于[上班标准时间]！");$("#AonDutyEnd").focus(); return false;
		}
		RetVal = CompareTime($("#AoffDuty").val(),$("#AoffDutyStart").val(),$("#AoffDutyEnd").val());
		switch(RetVal){
			case 1:showMsg("[下班标准时间]不能为空！");$("#AoffDuty").focus(); return false;
			case 2:showMsg("[下班开始时间]不能为空！");$("#AoffDutyStart").focus(); return false;
			case 3:showMsg("[下班截止时间]不能为空！");$("#AoffDutyEnd").focus(); return false;
			case 11:showMsg("[下班标准时间]非法！");$("#AoffDuty").focus(); return false;
			case 22:showMsg("[下班开始时间]非法！");$("#AoffDutyStart").focus(); return false;
			case 33:showMsg("[下班截止时间]非法！");$("#AoffDutyEnd").focus(); return false;
			case 111:showMsg("[下班标准时间]不能小于[下班开始时间]！");$("#AoffDuty").focus(); return false;
			case 222:showMsg("[下班截止时间]不能小于[下班标准时间]！");$("#AoffDutyEnd").focus(); return false;
		}
		
		RetVal = CompareTime2($("#AonDutyEnd").val(),$("#AoffDutyStart").val());
		switch(RetVal){
			case 111:showMsg("第一次[下班开始时间]不能小于[上班截止时间]！");$("#AoffDutyStart").focus(); return false;
		}
	}
	//alert(iDegree);
	//两个时段或三个时段的，验证时段2的合法性
	if(iDegree == "2" || iDegree == "3" ){
		if($("#BcalculateLate").val() != "" && isNaN($("#BcalculateLate").val()) ){
			$("#BcalculateLate").focus();
			$("#BcalculateLate").select();
			showMsg("允许迟到必须为数字");
			return false;
		}
		else if($("#BcalculateEarly").val() != "" && isNaN($("#BcalculateEarly").val()) ){
			$("#BcalculateEarly").focus();
			$("#BcalculateEarly").select();
			showMsg("允许早退必须为数字");
			return false;
		}
		else if($("#BrestTime").val() != "" && isNaN($("#BrestTime").val()) ){
			$("#BrestTime").focus();
			$("#BrestTime").select();
			showMsg("中间休息必须为数字");
			return false;
		}
		if(!iStretchShift && !iNight){
			RetVal = CompareTime($("#BonDuty").val(),$("#BonDutyStart").val(),$("#BonDutyEnd").val());
			switch(RetVal){
				case 1:showMsg("[上班标准时间]不能为空！");$("#BonDuty").focus(); return false;
				case 2:showMsg("[上班开始时间]不能为空！");$("#BonDutyStart").focus(); return false;
				case 3:showMsg("[上班截止时间]不能为空！");$("#BonDutyEnd").focus(); return false;
				case 11:showMsg("[上班标准时间]非法！");$("#BonDuty").focus(); return false;
				case 22:showMsg("[上班开始时间]非法！");$("#BonDutyStart").focus(); return false;
				case 33:showMsg("[上班截止时间]非法！");$("#BonDutyEnd").focus(); return false;
				case 111:showMsg("[上班标准时间]不能小于[上班开始时间]！");$("#BonDuty").focus(); return false;
				case 222:showMsg("[上班截止时间]不能小于[上班标准时间]！");$("#BonDutyEnd").focus(); return false;
			}
			RetVal = CompareTime($("#BoffDuty").val(),$("#BoffDutyStart").val(),$("#BoffDutyEnd").val());
			switch(RetVal){
				case 1:showMsg("[下班标准时间]不能为空！");$("#BoffDuty").focus(); return false;
				case 2:showMsg("[下班开始时间]不能为空！");$("#BoffDutyStart").focus(); return false;
				case 3:showMsg("[下班截止时间]不能为空！");$("#BoffDutyEnd").focus(); return false;
				case 11:showMsg("[下班标准时间]非法！");$("#BoffDuty").focus(); return false;
				case 22:showMsg("[下班开始时间]非法！");$("#BoffDutyStart").focus(); return false;
				case 33:showMsg("[下班截止时间]非法！");$("#BoffDutyEnd").focus(); return false;
				case 111:showMsg("[下班标准时间]不能小于[下班开始时间]！");$("#BoffDuty").focus(); return false;
				case 222:showMsg("[下班截止时间]不能小于[下班标准时间]！");$("#BoffDutyEnd").focus(); return false;
			}
			RetVal = CompareTime2($("#BonDutyEnd").val(),$("#BoffDutyStart").val());
			switch(RetVal){
				case 111:showMsg("第二次[下班开始时间]不能小于[上班截止时间]！");$("#BoffDutyStart").focus(); return false;
			}
		}
	}
	//三个时段的，验证第三个时段的合法性
	if(iDegree == "3" ){
		if($("#CcalculateLate").val() != "" && isNaN($("#CcalculateLate").val()) ){
			$("#CcalculateLate").focus();
			$("#CcalculateLate").select();
			showMsg("允许迟到必须为数字");
			return false;
		}
		else if($("#CcalculateEarly").val() != "" && isNaN($("#CcalculateEarly").val()) ){
			$("#CcalculateEarly").focus();
			$("#CcalculateEarly").select();
			showMsg("允许早退必须为数字");
			return false;
		}
		else if($("#CrestTime").val() != "" && isNaN($("#CrestTime").val()) ){
			$("#CrestTime").focus();
			$("#CrestTime").select();
			showMsg("中间休息必须为数字");
			return false;
		}
		if(!iStretchShift && !iNight){
			RetVal = CompareTime($("#ConDuty").val(),$("#ConDutyStart").val(),$("#ConDutyEnd").val());
			switch(RetVal){
				case 1:showMsg("[上班标准时间]不能为空！");$("#ConDuty").focus(); return false;
				case 2:showMsg("[上班开始时间]不能为空！");$("#ConDutyStart").focus(); return false;
				case 3:showMsg("[上班截止时间]不能为空！");$("#ConDutyEnd").focus(); return false;
				case 11:showMsg("[上班标准时间]非法！");$("#ConDuty").focus(); return false;
				case 22:showMsg("[上班开始时间]非法！");$("#ConDutyStart").focus(); return false;
				case 33:showMsg("[上班截止时间]非法！");$("#ConDutyEnd").focus(); return false;
				case 111:showMsg("[上班标准时间]不能小于[上班开始时间]！");$("#ConDuty").focus(); return false;
				case 222:showMsg("[上班截止时间]不能小于[上班标准时间]！");$("#ConDutyEnd").focus(); return false;
			}
			RetVal = CompareTime($("#CoffDuty").val(),$("#CoffDutyStart").val(),$("#CoffDutyEnd").val());
			switch(RetVal){
				case 1:showMsg("[下班标准时间]不能为空！");$("#CoffDuty").focus(); return false;
				case 2:showMsg("[下班开始时间]不能为空！");$("#CoffDutyStart").focus(); return false;
				case 3:showMsg("[下班截止时间]不能为空！");$("#CoffDutyEnd").focus(); return false;
				case 11:showMsg("[下班标准时间]非法！");$("#CoffDuty").focus(); return false;
				case 22:showMsg("[下班开始时间]非法！");$("#CoffDutyStart").focus(); return false;
				case 33:showMsg("[下班截止时间]非法！");$("#CoffDutyEnd").focus(); return false;
				case 111:showMsg("[下班标准时间]不能小于[下班开始时间]！");$("#CoffDuty").focus(); return false;
				case 222:showMsg("[下班截止时间]不能小于[下班标准时间]！");$("#CoffDutyEnd").focus(); return false;
			}
			RetVal = CompareTime2($("#ConDutyEnd").val(),$("#CoffDutyStart").val());
			switch(RetVal){
				case 111:showMsg("第三次[下班开始时间]不能小于[上班截止时间]！");$("#CoffDutyStart").focus(); return false;
			}
		}
	}
	
	//弹性班次，只有一个时段
	if(iStretchShift){
		RetVal = CompareTime2($("#AonDutyStart").val(),$("#AonDuty").val());
		switch(RetVal){
			case 1:showMsg("[上班标准时间]不能为空！");$("#AonDuty").focus(); return false;
			case 2:showMsg("[上班开始时间]不能为空！");$("#AonDutyStart").focus(); return false;
			case 11:showMsg("[上班标准时间]非法！");$("#AonDuty").focus(); return false;
			case 22:showMsg("[上班开始时间]非法！");$("#AonDutyStart").focus(); return false;
			case 111:showMsg("[上班标准时间]不能小于[上班开始时间]！");$("#AonDuty").focus(); return false;
		}
		RetVal = CompareTime2($("#AoffDuty").val(),$("#AoffDutyEnd").val());
		switch(RetVal){
			case 1:showMsg("[下班标准时间]不能为空！");$("#AoffDuty").focus(); return false;
			case 2:showMsg("[下班截止时间]不能为空！");$("#AoffDutyEnd").focus(); return false;
			case 11:showMsg("[下班标准时间]非法！");$("#AoffDuty").focus(); return false;
			case 22:showMsg("[下班截止时间]非法！");$("#AoffDutyEnd").focus(); return false;
			case 111:showMsg("[下班截止时间]不能小于[下班标准时间]！");$("#AoffDutyEnd").focus(); return false;
		}
	}
	$("#FormError").hide();
}

</script>