<%Session.CodePage=65001%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Shifts Edit</title>
<link rel="stylesheet" type="text/css" media="screen" href="../css/jquery-ui-1.10.2.redmond.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="../css/ui.multiselect.css"/>
<link href="../css/ui.custom.css" media="screen" type="text/css" rel="stylesheet">
<!--[if IE]><link type="text/css" rel="stylesheet" href="ie.css"/><![endif]-->

<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/lang/lang.js"></script>
<script type="text/javascript">
	document.write("<scr"+"ipt type='text/javascript' src='../js/lang/"+getLan()+"'><\/script>");
	document.write("<scr"+"ipt type='text/javascript' src='../js/i18n/"+getJgLan()+"'><\/script>");
	document.write("<scr"+"ipt type='text/javascript' src='../js/My97DatePicker/"+getDpLan()+"'><\/script>");
</script>
<script type="text/javascript">
	$.jgrid.no_legacy_api = true;
	$.jgrid.useJSON = true;
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
<style>
.ui-border {
	border-top:1px solid #a6c9e2;
	border-left:1px solid #a6c9e2;
	padding: 6px;
}
.ui-border-LB {
	border-bottom:1px solid #a6c9e2;
	border-left:1px solid #a6c9e2;
	padding: 6px;
}
.ui-border-R {
	border-right:1px solid #a6c9e2;
	padding: 6px;
}
.ui-NoneRightBorder {
}
</style>	
</head>
<!--#include file="..\Conn\conn.asp"-->
<!--#include file="..\Common\Page.asp"-->
<!--#include file="..\Conn\GetLbl.asp"-->
<%
dim strConId,strEmpId,iDoor,iSearch
dim strId
dim strFields
dim strSQL
dim strShiftName, strStretchShift, strDegree, strNight, strFirstOnDuty, strShiftTime
dim strAonDuty,strAonDutyStart, strAonDutyEnd, strAoffDuty, strAoffDutyStart, strAoffDutyEnd,strAcalculateLate,strAcalculateEarly, strArestTime
dim strBonDuty, strBonDutyStart,strBonDutyEnd, strBoffDuty, strBoffDutyStart, strBoffDutyEnd,strBcalculateLate,strBcalculateEarly, strBrestTime
dim strConDuty, strConDutyStart, strConDutyEnd,strCoffDuty, strCoffDutyStart, strCoffDutyEnd,strCcalculateLate,strCcalculateEarly,strCrestTime

strConId = Cstr(Trim(Request.QueryString("ControllerID")))
strEmpId = Cstr(Trim(Request.QueryString("EmployeeID")))

call fConnectADODB()

strFields = "ShiftId, ShiftName, convert(Nvarchar(2),StretchShift) as StretchShift, Degree, convert(Nvarchar(2),Night) as Night, FirstOnDuty, ShiftTime, substring(convert(varchar(19), AonDuty, 121),12, 5) as AonDuty, substring(convert(varchar(19), AonDutyStart, 121),12, 5) as AonDutyStart, substring(convert(varchar(19), AonDutyEnd, 121),12, 5) as AonDutyEnd, substring(convert(varchar(19), AoffDuty, 121),12, 5) as AoffDuty, substring(convert(varchar(19), AoffDutyStart, 121),12, 5) as AoffDutyStart, substring(convert(varchar(19), AoffDutyEnd, 121),12, 5) as AoffDutyEnd,AcalculateLate,AcalculateEarly, ArestTime, substring(convert(varchar(19), BonDuty, 121),12, 5) as BonDuty, substring(convert(varchar(19), BonDutyStart, 121),12, 5) as BonDutyStart, substring(convert(varchar(19), BonDutyEnd, 121),12, 5) as BonDutyEnd, substring(convert(varchar(19), BoffDuty, 121),12, 5) as BoffDuty, substring(convert(varchar(19), BoffDutyStart, 121),12, 5) as BoffDutyStart, substring(convert(varchar(19), BoffDutyEnd, 121),12, 5) as BoffDutyEnd,BcalculateLate,BcalculateEarly, BrestTime, substring(convert(varchar(19), ConDuty, 121),12, 5) as ConDuty, substring(convert(varchar(19), ConDutyStart, 121),12, 5) as ConDutyStart, substring(convert(varchar(19), ConDutyEnd, 121),12, 5) as ConDutyEnd, substring(convert(varchar(19), CoffDuty, 121),12, 5) as CoffDuty, substring(convert(varchar(19), CoffDutyStart, 121),12, 5) as CoffDutyStart, substring(convert(varchar(19), CoffDutyEnd, 121),12, 5) as CoffDutyEnd,CcalculateLate,CcalculateEarly, CrestTime"
	strSQL = "select top 1 "+cstr(strFields)+" from AttendanceShifts order by ShiftId desc "
	On Error Resume Next
	Rs.open strSQL, Conn, 1, 1
	if NOT Rs.EOF then
		strId			 = trim(Rs.fields("ShiftId").value)
		strShiftName     = trim(Rs.fields("ShiftName").value)
		strStretchShift  = Rs.fields("StretchShift").value
		strDegree        = trim(Rs.fields("Degree").value)
		strNight         = Rs.fields("Night").value
		strFirstOnDuty   = trim(Rs.fields("FirstOnDuty").value)
		strShiftTime     = trim(Rs.fields("ShiftTime").value)
		if strShiftTime = "" then strShiftTime = "0"

		strAonDuty       = GetDBValues(Rs.fields("AonDuty").value, 0)
		strAonDutyStart  = GetDBValues(Rs.fields("AonDutyStart").value, 0)
		strAonDutyEnd    = GetDBValues(Rs.fields("AonDutyEnd").value, 0)
		strAoffDuty      = GetDBValues(Rs.fields("AoffDuty").value, 0)
		strAoffDutyStart = GetDBValues(Rs.fields("AoffDutyStart").value, 0)
		strAoffDutyEnd   = GetDBValues(Rs.fields("AoffDutyEnd").value, 0)
		strAcalculateLate     = GetDBValues(Rs.fields("AcalculateLate").value, 1)
		strAcalculateEarly     = GetDBValues(Rs.fields("AcalculateEarly").value, 1)
		strArestTime     = GetDBValues(Rs.fields("ArestTime").value, 1)
		if strAcalculateLate = 0 then strAcalculateLate = " "
		if strAcalculateEarly = 0 then strAcalculateEarly = " "
		if strArestTime = 0 then strArestTime = " "

		if clng(strDegree) > 1 Then          '时段二
			strBonDuty       = GetDBValues(Rs.fields("BonDuty").value, 0)
			strBonDutyStart  = GetDBValues(Rs.fields("BonDutyStart").value, 0)
			strBonDutyEnd    = GetDBValues(Rs.fields("BonDutyEnd").value, 0)
			strBoffDuty      = GetDBValues(Rs.fields("BoffDuty").value, 0)
			strBoffDutyStart = GetDBValues(Rs.fields("BoffDutyStart").value, 0)
			strBoffDutyEnd   = GetDBValues(Rs.fields("BoffDutyEnd").value, 0)
			strBcalculateLate     = GetDBValues(Rs.fields("BcalculateLate").value, 1)
			strBcalculateEarly     = GetDBValues(Rs.fields("BcalculateEarly").value, 1)
			strBrestTime     = GetDBValues(Rs.fields("BrestTime").value, 1)
			if strBcalculateLate = 0 then strBcalculateLate = " "
			if strBcalculateEarly = 0 then strBcalculateEarly = " "
			if strBrestTime = 0 then strBrestTime = " "
		End if

		if 	clng(strDegree) > 2 then     '时段三
			strConDuty       = GetDBValues(Rs.fields("ConDuty").value, 0)
			strConDutyStart  = GetDBValues(Rs.fields("ConDutyStart").value, 0)
			strConDutyEnd    = GetDBValues(Rs.fields("ConDutyEnd").value, 0)
			strCoffDuty      = GetDBValues(Rs.fields("CoffDuty").value, 0)
			strCoffDutyStart = GetDBValues(Rs.fields("CoffDutyStart").value, 0)
			strCoffDutyEnd   = GetDBValues(Rs.fields("CoffDutyEnd").value, 0)
			strCcalculateLate     = GetDBValues(Rs.fields("CcalculateLate").value, 1)
			strCcalculateEarly     = GetDBValues(Rs.fields("CcalculateEarly").value, 1)
			strCrestTime     = GetDBValues(Rs.fields("CrestTime").value, 1)
			if strCcalculateLate = 0 then strCcalculateLate = " "
			if strCcalculateEarly = 0 then strCcalculateEarly = " "
			if strCrestTime = 0 then strCrestTime = " "
		end if
	end if
	Rs.close
	
	Call fCloseADO()
%>



<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all " id="editmodDataGrid" dir="ltr" style="width: 970px; height: auto; " >
	<div class="ui-jqgrid-view" id="gview_DataGrid"  style="width: 970px;">
	<div class="ui-jqgrid-titlebar ui-jqgrid-caption ui-widget-header ui-corner-top ui-helper-clearfix" ><span class="ui-jqgrid-title"><%=GetEmpLbl("Shifts")%></span></div>
	<div id="DataGrid_toppager" class="ui-state-default ui-jqgrid-toppager" dir="ltr">
     <div role="group" class="ui-pager-control" id="pg_DataGrid_toppager">
      <table cellspacing="0" cellpadding="0" border="0" role="row" style="width:100%;table-layout:fixed;height:100%;" class="ui-pg-table">		        <tbody>
          <tr>
           <td align="left" id="DataGrid_toppager_left" style="width: 99%;">
            <table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;" class="ui-pg-table navtable">
             <tbody>
              <tr id="trOper">
             </tr>
           </tbody>
    </table></td><td align="right" id="DataGrid_toppager_right" style="width: 1%;"></td></tr></tbody></table></div></div>
	<div id="editcntDataGrid" class="ui-jqdialog-content ui-widget-content">
	<form name="FrmGrid_DataGrid" id="FrmGrid_DataGrid" >
    <table id="TblGrid_DataGrid" class="EditTable" border="0" cellpadding="0" cellspacing="0">
     <tbody>
      <tr style="display: none;" id="FormError"><td colspan="4" class="ui-state-error"></td><td colspan="2" class="i-state-error"></td></tr>
      <tr class="tinfo" style="display:none"><td colspan="4" class="topinfo"></td></tr>
      <tr rowpos="2" class="FormData" id="trShiftName">
        <td style="width: 13%;" align="center" class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("ShiftName")%></td><td class="ui-border ui-NoneRightBorder" id="tdShiftName"  style="width: 37%;">&nbsp;</td><td style="width: 13%;"  align="center"  class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("ShiftTime")%></td><td class="ui-border ui-NoneRightBorder ui-border-R" id="tdShiftTime">&nbsp;</td></tr>
      <tr id="trNight" class="FormData " rowpos="3" ><td align="center"  class="ui-border ui-NoneRightBorder" ><%=GetEmpLbl("Night")%></td><td class="ui-border ui-NoneRightBorder " id="tdNight" >&nbsp;</td><td style="display: table-cell;" align="center"  class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("FirstOnDuty")%></td><td style="display: table-cell;" class="ui-border ui-NoneRightBorder ui-border-R" id="tdFirstOnDuty">&nbsp;
      </td></tr>
      <tr style="display: table-row;" id="trDegree" class="FormData" rowpos="4"><td  align="center"  class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("Degree")%></td><td class="ui-border ui-NoneRightBorder" id="tdDegree">&nbsp;
      </td><td  align="center"  class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("StretchShift")%></td><td class="ui-border ui-NoneRightBorder ui-border-R" id="tdStretchShift">&nbsp;&nbsp;</td></tr>
      <tr style="display: table-row;" id="tr_DNS" class="FormData" rowpos="5">
       <td colspan="4">
        <TABLE width="100%" border="0" cellPadding=0 cellSpacing=0>
		  <TBODY>
          	<TR  class="FormData" >
             <TD colspan=2 rowspan="2" align="center" class="ui-border ui-NoneRightBorder ui-border-LB"  style="width: 13%;"><%=GetEmpLbl("Times")%></TD>
             <TD colspan=3 align="center" class="ui-border ui-NoneRightBorder"  style="width: 25%;"><%=GetEmpLbl("OnDuty")%></TD>
             <TD colspan=3 align="center" class="ui-border ui-NoneRightBorder"  style="width: 25%;"><%=GetEmpLbl("OffDuty")%></TD>
             <TD colspan=6 align="center" class="ui-border ui-NoneRightBorder ui-border-R"><%=GetEmpLbl("Other")%></TD>
            </TR>
			<TR>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder ui-border-LB"><%=GetEmpLbl("Duty")%></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder ui-border-LB"><%=GetEmpLbl("Start")%></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder ui-border-LB"><%=GetEmpLbl("End")%></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder ui-border-LB"><%=GetEmpLbl("Duty")%></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder ui-border-LB"><%=GetEmpLbl("Start")%></TD>
             <TD colspan=1 align="center" class="ui-border ui-NoneRightBorder ui-border-LB"><%=GetEmpLbl("End")%></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder ui-border-LB"><%=GetEmpLbl("AcalculateLate")%></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder ui-border-LB"><%=GetEmpLbl("AcalculateEarly")%></TD>
             <TD colspan=2 align="center" class="ui-border ui-NoneRightBorder ui-border-LB ui-border-R"><%=GetEmpLbl("ArestTime")%></TD>
            </TR>
            <TR id="trAOnDuty">
           	 <TD colspan=2 align="center" class="ui-border-LB">1</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdAonDuty">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdAonDutyStart">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdAonDutyEnd">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdAoffDuty">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdAoffDutyStart">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdAoffDutyEnd">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB" id="tdAcalculateLate">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB" id="tdAcalculateEarly">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB ui-border-R" id="tdArestTime">&nbsp;</TD>
            </TR>
            <TR id="trBOnDuty">
           	 <TD colspan=2 align="center" class="ui-border-LB">2</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdBonDuty">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdBonDutyStart">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdBonDutyEnd">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdBoffDuty">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdBoffDutyStart">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdBoffDutyEnd">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB" id="tdBcalculateLate">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB" id="tdBcalculateEarly">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB ui-border-R" id="tdBrestTime">&nbsp;</TD>
            </TR>
            <TR id="trCOnDuty">
           	 <TD colspan=2 align="center" class="ui-border-LB">3</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdConDuty">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdConDutyStart">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdConDutyEnd">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdCoffDuty">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdCoffDutyStart">&nbsp;</TD>
             <TD colspan=1 align="center" class="ui-border-LB" id="tdCoffDutyEnd">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB" id="tdCcalculateLate">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB" id="tdCcalculateEarly">&nbsp;</TD>
             <TD colspan=2 align="center" class="ui-border-LB ui-border-R" id="tdCrestTime">&nbsp;</TD>
            </TR>
		  </TBODY>
		</TABLE>
       </td>
      </tr>
      <tr style="display:none" class="FormData"><td class="ui-border-LB"></td><td class="ui-border-LB" colspan="3"></td></tr></tbody></table></form></div>
     
	 </div>
	  <div style="text-align: center; width: 970px;" class="scroll ui-state-default ui-jqgrid-pager ui-corner-bottom" id="pager" dir="ltr"><div role="group" class="ui-pager-control" id="pg_pager"><table cellspacing="0" cellpadding="0" border="0" role="row" style="width:100%;table-layout:fixed;height:100%;" class="ui-pg-table"><tbody><tr><td align="left" id="pager_left"></td>
	            <td align="center" style="white-space: pre; width: 240px;" id="pager_center">&nbsp;</td>
	            <td align="right" id="pager_right">&nbsp;</td>
	  </tr></tbody></table></div></div>
	  
     </div>
    
    
<script type="text/javascript">
var strId;
$(document).ready(function(){
CheckLoginStatus();  
//获取操作权限
var role = GetOperRole("Shifts");
var iedit=false,iadd=false,idel=false,iview=false,irefresh=false,isearch=false,iexport=false,isync=false;
try{
	iedit=role.edit;
	iadd=role.add;
	idel=role.del;
	iview=role.view;
	irefresh=role.refresh;
	isearch=role.search;
	iexport=role.exportdata;
	isync=role.sync;
}
catch(exception) {
	alert(exception);
}

if(iedit){
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnEdit' title='<%=GetEmpLbl("Edit")%>'><div class='ui-pg-div'><span class='ui-icon ui-icon-pencil'></span><a><%=GetEmpLbl("Edit")%></a></div></td>");
}
if(iedit){
	$("#trOper").append("<td class='ui-pg-button ui-corner-all ui-state-disabled' id='DataGrid_btnSubmit' title='<%=GetEmpLbl("Submit")%>'><div class='ui-pg-div'><span class='ui-icon ui-icon-disk'></span><a><%=GetEmpLbl("Submit")%></a></div></td>");
}
if(iedit){
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnCancel' title='<%=GetEmpLbl("Cancel")%>'><div class='ui-pg-div'><span class='ui-icon ui-icon-cancel'></span><a><%=GetEmpLbl("Cancel")%></a></div></td>");
}
if(irefresh){
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnRefresh' title='<%=GetEmpLbl("Refresh")%>'><div class='ui-pg-div'><span class='ui-icon ui-icon-refresh'></span><a><%=GetEmpLbl("Refresh")%></a></div></td>");
}

function InitValue(){
	strId = "<%=strId%>";
	var strDegree = "<%=strDegree%>";
	var strNight = "<%=strNight%>";
	var strStretchShift = "<%=strStretchShift%>";
	var strFirstOnDuty = "<%=strFirstOnDuty%>";
	if(strNight == "1")
		$("#tdNight").html("<%=GetEmpLbl("Yes")%>"); //是
	else
		$("#tdNight").html("<%=GetEmpLbl("No")%>"); //否
	if(strStretchShift == "1")
		$("#tdStretchShift").html("<%=GetEmpLbl("Yes")%>"); // 是
	else
		$("#tdStretchShift").html("<%=GetEmpLbl("No")%>"); //否
		
	if(strFirstOnDuty == "1")
		$("#tdFirstOnDuty").html("<%=GetEmpLbl("LastDay")%>"); //上日
	else
		$("#tdFirstOnDuty").html("<%=GetEmpLbl("CurrentDay")%>"); //当日
	$("#tdDegree").html("<%=strDegree%>");
	$("#tdShiftName").html("<%=strShiftName%>");
	$("#tdShiftTime").html("<%=strShiftTime%>"+" <%=GetEmpLbl("Hour")%>"); //小时

	$("#tdDegree").html(strDegree);
	$("#tdAonDuty").html("<%=strAonDuty%>");
	$("#tdAonDutyStart").html("<%=strAonDutyStart%>");
	$("#tdAonDutyEnd").html("<%=strAonDutyEnd%>");
	$("#tdAoffDuty").html("<%=strAoffDuty%>");
	$("#tdAoffDutyStart").html("<%=strAoffDutyStart%>");
	$("#tdAoffDutyEnd").html("<%=strAoffDutyEnd%>");
	$("#tdAcalculateLate").html("<%=strAcalculateLate%>");
	$("#tdAcalculateEarly").html("<%=strAcalculateEarly%>");
	$("#tdArestTime").html("<%=strArestTime%>");
	if(strDegree == "2" || strDegree > "2"){
		$("#tdBonDuty").html("<%=strBonDuty%>");
		$("#tdBonDutyStart").html("<%=strBonDutyStart%>");
		$("#tdBonDutyEnd").html("<%=strBonDutyEnd%>");
		$("#tdBoffDuty").html("<%=strBoffDuty%>");
		$("#tdBoffDutyStart").html("<%=strBoffDutyStart%>");
		$("#tdBoffDutyEnd").html("<%=strBoffDutyEnd%>");
		$("#tdBcalculateLate").html("<%=strBcalculateLate%>");
		$("#tdBcalculateEarly").html("<%=strBcalculateEarly%>");
		$("#tdBrestTime").html("<%=strBrestTime%>");
	}
	if(strDegree == "3" || strDegree > "3"){
		$("#tdConDuty").html("<%=strConDuty%>");
		$("#tdConDutyStart").html("<%=strConDutyStart%>");
		$("#tdConDutyEnd").html("<%=strConDutyEnd%>");
		$("#tdCoffDuty").html("<%=strCoffDuty%>");
		$("#tdCoffDutyStart").html("<%=strCoffDutyStart%>");
		$("#tdCoffDutyEnd").html("<%=strCoffDutyEnd%>");
		$("#tdCcalculateLate").html("<%=strCcalculateLate%>");
		$("#tdCcalculateEarly").html("<%=strCcalculateEarly%>");
		$("#tdCrestTime").html("<%=strCrestTime%>");
	}
	SelDegree();
	
}

function SelDegree(){
	var val = "<%=strDegree%>";
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
	$("#DataGrid_btnEdit").click(function(){
		 if (!$(this).hasClass('ui-state-disabled')) {
			btnEditClick(); 
		}
		return false;
	}).hover(
		function () {
			if (!$(this).hasClass('ui-state-disabled')) {
				$(this).addClass("ui-state-hover");
			}
		},
		function() {$(this).removeClass("ui-state-hover");}
	);
	$("#DataGrid_btnSubmit").click(function(){
		 if (!$(this).hasClass('ui-state-disabled')) {
			btnbtnSubmit();      
		}
		return false;
	}).hover(
		function () {
			if (!$(this).hasClass('ui-state-disabled')) {
				$(this).addClass("ui-state-hover");
			}
		},
		function() {$(this).removeClass("ui-state-hover");}
	);
	$("#DataGrid_btnCancel").click(function(){
		 if (!$(this).hasClass('ui-state-disabled')) {
			btnCancel();      
		}
		return false;
	}).hover(
		function () {
			if (!$(this).hasClass('ui-state-disabled')) {
				$(this).addClass("ui-state-hover");
			}
		},
		function() {$(this).removeClass("ui-state-hover");}
	);
	$("#DataGrid_btnRefresh").click(function(){
		 if (!$(this).hasClass('ui-state-disabled')) {
			btnRefresh();      
		}
		return false;
	}).hover(
		function () {
			if (!$(this).hasClass('ui-state-disabled')) {
				$(this).addClass("ui-state-hover");
			}
		},
		function() {$(this).removeClass("ui-state-hover");}
	);
	
	$("#DataGrid_btnCancel").addClass("ui-state-disabled");
}
InitValue();
Init();
         
});





function btnEditClick(){
	$("#DataGrid_btnSubmit").removeClass("ui-state-disabled");
	window.location.href="ShiftsEdit.asp?nd="+getRandom();
}
function btnbtnSubmit(){
	if(checkData() == false){
		return;
	}
	 $.ajax({
			type: "POST",
			dataType: "html",
			url: 'ShiftsEditSubmit.asp?iflag=1&strId='+strId,
			data: $('#FrmGrid_DataGrid').serialize(),
			 success: function(data) {
			  try  {
					var responseMsg = $.parseJSON(data);
					if(responseMsg.success == false){
						//alert(responseMsg.message);
						showMsg(responseMsg.message);
					}else if(responseMsg.success == true){
						//成功
						showMsg(responseMsg.message);
						//$("#DataGrid").trigger("reloadGrid");
					}else{
						alert("保存异常");
					}
				}
				catch(exception) {
					alert(exception+"," + data);
				}
			},
			error:function(XmlHttpRequest,textStatus, errorThrown){
				alert(textStatus+":ShiftsEditSubmit.asp,"+XmlHttpRequest.responseText);
			}

		});
}
function btnCancel(){
	//$("#DataGrid_btnSubmit").addClass("ui-state-disabled");
	//alert("Cancel");
}
function btnRefresh(){
	window.location.href="ShiftsView.asp?nd="+getRandom();
}
function showMsg(strMsg){
	$("#FormError").show();
	$("#FormError").children("td:eq(0)").html(strMsg);
}



</script>