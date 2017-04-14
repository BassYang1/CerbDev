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
		strAcalculateLate     = Rs.fields("AcalculateLate").value
		strAcalculateEarly     = Rs.fields("AcalculateEarly").value
		strArestTime     = Rs.fields("ArestTime").value
		if strAcalculateLate = 0 then strAcalculateLate = ""
		if strAcalculateEarly = 0 then strAcalculateEarly = ""
		if strArestTime = 0 then strArestTime = ""

		if clng(strDegree) > 1 Then          '时段二
			strBonDuty       = GetDBValues(Rs.fields("BonDuty").value, 0)
			strBonDutyStart  = GetDBValues(Rs.fields("BonDutyStart").value, 0)
			strBonDutyEnd    = GetDBValues(Rs.fields("BonDutyEnd").value, 0)
			strBoffDuty      = GetDBValues(Rs.fields("BoffDuty").value, 0)
			strBoffDutyStart = GetDBValues(Rs.fields("BoffDutyStart").value, 0)
			strBoffDutyEnd   = GetDBValues(Rs.fields("BoffDutyEnd").value, 0)
			strBcalculateLate     = Rs.fields("BcalculateLate").value
			strBcalculateEarly     = Rs.fields("BcalculateEarly").value
			strBrestTime     = Rs.fields("BrestTime").value
			if strBcalculateLate = 0 then strBcalculateLate = ""
			if strBcalculateEarly = 0 then strBcalculateEarly = ""
			if strBrestTime = 0 then strBrestTime = ""
		End if

		if 	clng(strDegree) > 2 then     '时段三
			strConDuty       = GetDBValues(Rs.fields("ConDuty").value, 0)
			strConDutyStart  = GetDBValues(Rs.fields("ConDutyStart").value, 0)
			strConDutyEnd    = GetDBValues(Rs.fields("ConDutyEnd").value, 0)
			strCoffDuty      = GetDBValues(Rs.fields("CoffDuty").value, 0)
			strCoffDutyStart = GetDBValues(Rs.fields("CoffDutyStart").value, 0)
			strCoffDutyEnd   = GetDBValues(Rs.fields("CoffDutyEnd").value, 0)
			strCcalculateLate     = Rs.fields("CcalculateLate").value
			strCcalculateEarly     = Rs.fields("CcalculateEarly").value
			strCrestTime     = Rs.fields("CrestTime").value
			if strCcalculateLate = 0 then strCcalculateLate = ""
			if strCcalculateEarly = 0 then strCcalculateEarly = ""
			if strCrestTime = 0 then strCrestTime = ""
		end if
	end if
	Rs.close
	
	Call fCloseADO()
%>



<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all " id="editmodDataGrid" dir="ltr" style="width: 970px; height: auto; " >
	<div class="ui-jqgrid-view" id="gview_DataGrid"  style="width: 970px;">
	<div class="ui-jqgrid-titlebar ui-jqgrid-caption ui-widget-header ui-corner-top ui-helper-clearfix" ><span class="ui-jqgrid-title"><%=GetEmpLbl("Shifts")%></span></div>
	<div id="DataGrid_toppager" class="ui-state-default ui-jqgrid-toppager" dir="ltr"><div role="group" class="ui-pager-control" id="pg_DataGrid_toppager"><table cellspacing="0" cellpadding="0" border="0" role="row" style="width:100%;table-layout:fixed;height:100%;" class="ui-pg-table"><tbody><tr><td align="left" id="DataGrid_toppager_left" style="width: 99%;"><table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;" class="ui-pg-table navtable">
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
        <td style="width: 13%;" align="center" class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("ShiftName")%></td><td class="ui-border ui-NoneRightBorder" style="width: 37%;">&nbsp;<input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ShiftName" id="ShiftName" type="text"><font color="#FF0000">*</font></td><td style="width: 13%;"  align="center"  class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("ShiftTime")%></td><td class="ui-border ui-NoneRightBorder ui-border-R">&nbsp;<input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ShiftTime" id="ShiftTime" type="text"><%=GetEmpLbl("Hour")%><font color="#FF0000">*</font></td></tr>
      <tr id="trNight" class="FormData " rowpos="3" ><td align="center"  class="ui-border ui-NoneRightBorder" ><%=GetEmpLbl("Night")%></td><td class="ui-border ui-NoneRightBorder " >&nbsp;<input class="FormElement " role="checkbox" name="Night" id="Night" value="1" type="checkbox"></td><td style="display: table-cell;" align="center"  class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("FirstOnDuty")%></td><td style="display: table-cell;" class="ui-border ui-NoneRightBorder ui-border-R">&nbsp;
      <select class="FormElement ui-widget-content ui-corner-all" name="FirstOnDuty" id="FirstOnDuty" role="select" style="width:120px;">
         <option value="0" role="option">0 - <%=GetEmpLbl("CurrentDay")%></option>
       </select></td></tr>
      <tr style="display: table-row;" id="trDegree" class="FormData" rowpos="4"><td  align="center"  class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("Degree")%></td><td class="ui-border ui-NoneRightBorder">&nbsp;
      <select class="FormElement ui-widget-content ui-corner-all" name="Degree" id="Degree" role="select" style="width:120px;" onchange="SelDegree(this)">
         <option value="1" role="option">1</option>
         <option value="2" role="option">2</option>
         <option value="3" role="option">3</option>
       </select>
      </td><td  align="center"  class="ui-border ui-NoneRightBorder"><%=GetEmpLbl("StretchShift")%></td><td class="ui-border ui-NoneRightBorder ui-border-R">&nbsp;&nbsp;<input class="FormElement" role="checkbox" name="StretchShift" id="StretchShift" offval="0" value="1" type="checkbox"></td></tr>
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
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AonDuty" id="AonDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AonDutyStart" id="AonDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AonDutyEnd" id="AonDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AoffDuty" id="AoffDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AoffDutyStart" id="AoffDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AoffDutyEnd" id="AoffDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AcalculateLate" id="AcalculateLate" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="AcalculateEarly" id="AcalculateEarly" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB ui-border-R"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ArestTime" id="ArestTime" type="text" style="width:50px;"></TD>
            </TR>
            <TR id="trBOnDuty">
           	 <TD colspan=2 align="center" class="ui-border-LB">2</TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BonDuty" id="BonDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BonDutyStart" id="BonDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BonDutyEnd" id="BonDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BoffDuty" id="BoffDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BoffDutyStart" id="BoffDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BoffDutyEnd" id="BoffDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BcalculateLate" id="BcalculateLate" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BcalculateEarly" id="BcalculateEarly" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB ui-border-R"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="BrestTime" id="BrestTime" type="text" style="width:50px;"></TD>
            </TR>
            <TR id="trCOnDuty">
           	 <TD colspan=2 align="center" class="ui-border-LB">3</TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ConDuty" id="ConDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ConDutyStart" id="ConDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="ConDutyEnd" id="ConDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CoffDuty" id="CoffDuty" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CoffDutyStart" id="CoffDutyStart" type="text" style="width:50px;"></TD>
             <TD colspan=1 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CoffDutyEnd" id="CoffDutyEnd" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CcalculateLate" id="CcalculateLate" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CcalculateEarly" id="CcalculateEarly" type="text" style="width:50px;"></TD>
             <TD colspan=2 align="center" class="ui-border-LB ui-border-R"><input class="FormElement ui-widget-content ui-corner-all" role="textbox" name="CrestTime" id="CrestTime" type="text" style="width:50px;"></TD>
            </TR>
		  </TBODY>
		</TABLE>
       </td>
      </tr>
      <tr style="display:none" class="FormData"><td class="ui-border-LB"></td><td class="ui-border-LB" colspan="3"><input type="text" value="_empty" name="DataGrid_id" id="id_g" class="FormElement"></td></tr></tbody></table></form></div>
     
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
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnSubmit' title='<%=GetEmpLbl("Submit")%>'><div class='ui-pg-div'><span class='ui-icon ui-icon-disk'></span><a><%=GetEmpLbl("Submit")%></a></div></td>");
}
if(iedit){
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnCancel' title='<%=GetEmpLbl("Cancel")%>'><div class='ui-pg-div'><span class='ui-icon ui-icon-cancel'></span><a><%=GetEmpLbl("Cancel")%></a></div></td>");
}
if(irefresh){
	$("#trOper").append("<td class='ui-pg-button ui-corner-all' id='DataGrid_btnRefresh' title='<%=GetEmpLbl("Refresh")%>'><div class='ui-pg-div'><span class='ui-icon ui-icon-refresh'></span><a><%=GetEmpLbl("Refresh")%></a></div></td>");
}

function InitValue(){
	strId = "<%=strId%>";
	var strNight = "<%=strNight%>";
	var strStretchShift = "<%=strStretchShift%>";
	var strDegree = "<%=strDegree%>";
	$("#ShiftName").val("<%=strShiftName%>");
	$("#ShiftTime").val("<%=strShiftTime%>");
	if(strNight != "" && strNight == "1"){
		$("#Night").val("1");
		$("#Night").get(0).checked = true;
	}
	else{
		$("#Night").val("0");
		$("#Night").get(0).checked = false;
	}
	NightChange();
	
	if(strStretchShift != "" && strStretchShift == "1"){
		$("#StretchShift").val("1");
		$("#StretchShift").get(0).checked = true;
	}
	else{
		$("#StretchShift").val("0");
		$("#StretchShift").get(0).checked = false;
	}
	StretchShiftChange();

	$("#FirstOnDuty").val("<%=strFirstOnDuty%>");
	$("#Degree").val(strDegree);
	$("#AonDuty").val("<%=strAonDuty%>");
	$("#AonDutyStart").val("<%=strAonDutyStart%>");
	$("#AonDutyEnd").val("<%=strAonDutyEnd%>");
	$("#AoffDuty").val("<%=strAoffDuty%>");
	$("#AoffDutyStart").val("<%=strAoffDutyStart%>");
	$("#AoffDutyEnd").val("<%=strAoffDutyEnd%>");
	$("#AcalculateLate").val("<%=strAcalculateLate%>");
	$("#AcalculateEarly").val("<%=strAcalculateEarly%>");
	$("#ArestTime").val("<%=strArestTime%>");
	if(strDegree == "2" || strDegree > "2"){
		$("#BonDuty").val("<%=strBonDuty%>");
		$("#BonDutyStart").val("<%=strBonDutyStart%>");
		$("#BonDutyEnd").val("<%=strBonDutyEnd%>");
		$("#BoffDuty").val("<%=strBoffDuty%>");
		$("#BoffDutyStart").val("<%=strBoffDutyStart%>");
		$("#BoffDutyEnd").val("<%=strBoffDutyEnd%>");
		$("#BcalculateLate").val("<%=strBcalculateLate%>");
		$("#BcalculateEarly").val("<%=strBcalculateEarly%>");
		$("#BrestTime").val("<%=strBrestTime%>");
	}
	if(strDegree == "3" || strDegree > "3"){
		$("#ConDuty").val("<%=strConDuty%>");
		$("#ConDutyStart").val("<%=strConDutyStart%>");
		$("#ConDutyEnd").val("<%=strConDutyEnd%>");
		$("#CoffDuty").val("<%=strCoffDuty%>");
		$("#CoffDutyStart").val("<%=strCoffDutyStart%>");
		$("#CoffDutyEnd").val("<%=strCoffDutyEnd%>");
		$("#CcalculateLate").val("<%=strCcalculateLate%>");
		$("#CcalculateEarly").val("<%=strCcalculateEarly%>");
		$("#CrestTime").val("<%=strCrestTime%>");
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
		NightChange();
	});
	
	$("#StretchShift").click(function(){
		StretchShiftChange();
	});
	
	$("#Degree").change();
	NightChange();
	StretchShiftChange();
	
}
Init();
InitValue();

});


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

function NightChange(){
	if($("#Night").get(0).checked == true){
			$("#Night").val("1");
			$("#FirstOnDuty").empty();
			$("#FirstOnDuty").append("<option value='0'>0 - <%=GetEmpLbl("CurrentDay")%></option>"); //当日
			$("#FirstOnDuty").append("<option value='1'>1 - <%=GetEmpLbl("LastDay")%></option>");  //上日
		}else{
			$("#Night").val("0");
			$("#FirstOnDuty").empty();
			$("#FirstOnDuty").append("<option value='0'>0 - <%=GetEmpLbl("CurrentDay")%></option>"); //当日
		}
}

function StretchShiftChange(){
	if($("#StretchShift").get(0).checked == true){
			 $("#StretchShift").val("1");
			 $("#Degree").val("1");
			 $("#Degree").change();
			 $("#AonDutyEnd").val("");
			 $("#AoffDutyStart").val("");
			 $("#AonDutyEnd").attr("disabled","disabled"); 
			 $("#AoffDutyStart").attr("disabled","disabled");   
			 $("#Degree").attr("disabled","disabled");  
		}else{
			$("#StretchShift").val("0");
			$("#AonDutyEnd").removeAttr("disabled");  
			$("#AoffDutyStart").removeAttr("disabled");  
			$("#Degree").removeAttr("disabled");  
		}
}

function btnEditClick(){
	$("#DataGrid_btnSubmit").removeClass("ui-state-disabled");
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
						btnCancel();
						//$("#DataGrid").trigger("reloadGrid");
					}else{
						alert("Save Exception");
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
	$("#DataGrid_btnSubmit").addClass("ui-state-disabled");
	window.location.href="ShiftsView.asp?nd="+getRandom();
}
function btnRefresh(){
	window.location.href="ShiftsEdit.asp?nd="+getRandom();
}
function showMsg(strMsg){
	$("#FormError").show();
	$("#FormError").children("td:eq(0)").html(strMsg);
}

function checkData(){
	if($("#ShiftName").val() == ""){
		$("#ShiftName").focus();
		showMsg("<%=GetEmpLbl("ShiftNameNull")%>");//[班次名称]不能为空
		return false;
	}else if($("#ShiftTime").val() == ""){
		$("#ShiftTime").focus();
		showMsg("<%=GetEmpLbl("ShiftTimeNull")%>"); //[标准工时]不能为空
		return false;
	}
	if(isNaN($("#ShiftTime").val())){
		$("#ShiftTime").focus();
		$("#ShiftTime").select();
		showMsg("<%=GetEmpLbl("ShiftTimeDigital")%>"); //[标准工时]必须为数字
		return false;
	}
	else if($("#AcalculateLate").val() != "" && isNaN($("#AcalculateLate").val()) ){
		$("#AcalculateLate").focus();
		$("#AcalculateLate").select();
		showMsg("<%=GetEmpLbl("AcalculateLateDigital")%>"); //[允许迟到]必须为数字
		return false;
	}
	else if($("#AcalculateEarly").val() != "" && isNaN($("#AcalculateEarly").val()) ){
		$("#AcalculateEarly").focus();
		$("#AcalculateEarly").select();
		showMsg("<%=GetEmpLbl("AcalculateEarlyDigital")%>"); //[允许早退]必须为数字
		return false;
	}
	else if($("#ArestTime").val() != "" && isNaN($("#ArestTime").val()) ){
		$("#ArestTime").focus();
		$("#ArestTime").select();
		showMsg("<%=GetEmpLbl("ArestTimeDigital")%>"); //[中间休]息必须为数字
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
			case 1:showMsg("<%=GetEmpLbl("onDutyNull")%>");$("#AonDuty").focus(); return false; //[上班标准时间]不能为空！
			case 2:showMsg("<%=GetEmpLbl("onDutyStartNull")%>");$("#AonDutyStart").focus(); return false; //[上班开始时间]不能为空！
			case 3:showMsg("<%=GetEmpLbl("onDutyEndNull")%>");$("#AonDutyEnd").focus(); return false; //[上班截止时间]不能为空！
			case 11:showMsg("<%=GetEmpLbl("onDutyIllegal")%>");$("#AonDuty").focus(); return false; //[上班标准时间]非法！
			case 22:showMsg("<%=GetEmpLbl("onDutyStartIllegal")%>");$("#AonDutyStart").focus(); return false; //[上班开始时间]非法！
			case 33:showMsg("<%=GetEmpLbl("onDutyEndIllegal")%>");$("#AonDutyEnd").focus(); return false; //[上班截止时间]非法！
			case 111:showMsg("<%=GetEmpLbl("OnDutyLtonDutyStart")%>");$("#AonDuty").focus(); return false; //[上班标准时间]不能小于[上班开始时间]！
			case 222:showMsg("<%=GetEmpLbl("OnDutyEndLtOnDuty")%>");$("#AonDutyEnd").focus(); return false; //[上班截止时间]不能小于[上班标准时间]！
		}
		RetVal = CompareTime($("#AoffDuty").val(),$("#AoffDutyStart").val(),$("#AoffDutyEnd").val());
		switch(RetVal){
			case 1:showMsg("<%=GetEmpLbl("offDutyNull")%>");$("#AoffDuty").focus(); return false; //[下班标准时间]不能为空！
			case 2:showMsg("<%=GetEmpLbl("offDutyStartNull")%>");$("#AoffDutyStart").focus(); return false; //[下班开始时间]不能为空！
			case 3:showMsg("<%=GetEmpLbl("offDutyEndNull")%>");$("#AoffDutyEnd").focus(); return false; //[下班截止时间]不能为空！
			case 11:showMsg("<%=GetEmpLbl("offDutyIllegal")%>");$("#AoffDuty").focus(); return false; //[下班标准时间]非法！
			case 22:showMsg("<%=GetEmpLbl("offDutyStartIllegal")%>");$("#AoffDutyStart").focus(); return false; //[下班开始时间]非法！
			case 33:showMsg("<%=GetEmpLbl("offDutyEndIllegal")%>");$("#AoffDutyEnd").focus(); return false; //[下班截止时间]非法！
			case 111:showMsg("<%=GetEmpLbl("offDutyLtoffDutyStart")%>");$("#AoffDuty").focus(); return false; //[下班标准时间]不能小于[下班开始时间]！
			case 222:showMsg("<%=GetEmpLbl("offDutyEndLtoffDuty")%>");$("#AoffDutyEnd").focus(); return false; //[下班截止时间]不能小于[下班标准时间]！
		}
		
		RetVal = CompareTime2($("#AonDutyEnd").val(),$("#AoffDutyStart").val());
		switch(RetVal){
			case 111:showMsg("<%=GetEmpLbl("FirstOffDutyLtOnDutyEnd")%>");$("#AoffDutyStart").focus(); return false; //第一次[下班开始时间]不能小于[上班截止时间]！
		}
	}
	//alert(iDegree);
	//两个时段或三个时段的，验证时段2的合法性
	if(iDegree == "2" || iDegree == "3" ){
		if($("#BcalculateLate").val() != "" && isNaN($("#BcalculateLate").val()) ){
			$("#BcalculateLate").focus();
			$("#BcalculateLate").select();
			showMsg("<%=GetEmpLbl("AcalculateLateDigital")%>");//允许迟到必须为数字
			return false;
		}
		else if($("#BcalculateEarly").val() != "" && isNaN($("#BcalculateEarly").val()) ){
			$("#BcalculateEarly").focus();
			$("#BcalculateEarly").select();
			showMsg("<%=GetEmpLbl("AcalculateEarlyDigital")%>"); //允许早退必须为数字
			return false;
		}
		else if($("#BrestTime").val() != "" && isNaN($("#BrestTime").val()) ){
			$("#BrestTime").focus();
			$("#BrestTime").select();
			showMsg("<%=GetEmpLbl("ArestTimeDigital")%>");//中间休息必须为数字
			return false;
		}
		if(!iStretchShift && !iNight){
			RetVal = CompareTime($("#BonDuty").val(),$("#BonDutyStart").val(),$("#BonDutyEnd").val());
			switch(RetVal){
				case 1:showMsg("<%=GetEmpLbl("onDutyNull")%>");$("#BonDuty").focus(); return false; //[上班标准时间]不能为空！
				case 2:showMsg("<%=GetEmpLbl("onDutyStartNull")%>");$("#BonDutyStart").focus(); return false; //[上班开始时间]不能为空！
				case 3:showMsg("<%=GetEmpLbl("onDutyEndNull")%>");$("#BonDutyEnd").focus(); return false; //[上班截止时间]不能为空！
				case 11:showMsg("<%=GetEmpLbl("onDutyIllegal")%>");$("#BonDuty").focus(); return false; //[上班标准时间]非法！
				case 22:showMsg("<%=GetEmpLbl("onDutyStartIllegal")%>");$("#BonDutyStart").focus(); return false; //[上班开始时间]非法！
				case 33:showMsg("<%=GetEmpLbl("onDutyEndIllegal")%>");$("#BonDutyEnd").focus(); return false; //[上班截止时间]非法！
				case 111:showMsg("<%=GetEmpLbl("OnDutyLtonDutyStart")%>");$("#BonDuty").focus(); return false; //[上班标准时间]不能小于[上班开始时间]！
				case 222:showMsg("<%=GetEmpLbl("OnDutyEndLtOnDuty")%>");$("#BonDutyEnd").focus(); return false; //[上班截止时间]不能小于[上班标准时间]！
			}
			RetVal = CompareTime($("#BoffDuty").val(),$("#BoffDutyStart").val(),$("#BoffDutyEnd").val());
			switch(RetVal){
				case 1:showMsg("<%=GetEmpLbl("offDutyNull")%>");$("#BoffDuty").focus(); return false; //[下班标准时间]不能为空！
				case 2:showMsg("<%=GetEmpLbl("offDutyStartNull")%>");$("#BoffDutyStart").focus(); return false; //[下班开始时间]不能为空！
				case 3:showMsg("<%=GetEmpLbl("offDutyEndNull")%>");$("#BoffDutyEnd").focus(); return false; //[下班截止时间]不能为空！
				case 11:showMsg("<%=GetEmpLbl("offDutyIllegal")%>");$("#BoffDuty").focus(); return false; //[下班标准时间]非法！
				case 22:showMsg("<%=GetEmpLbl("offDutyStartIllegal")%>");$("#BoffDutyStart").focus(); return false; //[下班开始时间]非法！
				case 33:showMsg("<%=GetEmpLbl("offDutyEndIllegal")%>");$("#BoffDutyEnd").focus(); return false; //[下班截止时间]非法！
				case 111:showMsg("<%=GetEmpLbl("offDutyLtoffDutyStart")%>");$("#BoffDuty").focus(); return false; //[下班标准时间]不能小于[下班开始时间]！
				case 222:showMsg("<%=GetEmpLbl("offDutyEndLtoffDuty")%>");$("#BoffDutyEnd").focus(); return false; //[下班截止时间]不能小于[下班标准时间]！
			}
			RetVal = CompareTime2($("#BonDutyEnd").val(),$("#BoffDutyStart").val());
			switch(RetVal){
				case 111:showMsg("<%=GetEmpLbl("SecondOffDutyLtOnDutyEnd")%>");$("#BoffDutyStart").focus(); return false; //第二次[下班开始时间]不能小于[上班截止时间]！
			}
		}
	}
	//三个时段的，验证第三个时段的合法性
	if(iDegree == "3" ){
		if($("#CcalculateLate").val() != "" && isNaN($("#CcalculateLate").val()) ){
			$("#CcalculateLate").focus();
			$("#CcalculateLate").select();
			showMsg("<%=GetEmpLbl("AcalculateLateDigital")%>");//允许迟到必须为数字
			return false;
		}
		else if($("#CcalculateEarly").val() != "" && isNaN($("#CcalculateEarly").val()) ){
			$("#CcalculateEarly").focus();
			$("#CcalculateEarly").select();
			showMsg("<%=GetEmpLbl("AcalculateEarlyDigital")%>"); //允许早退必须为数字
			return false;
		}
		else if($("#CrestTime").val() != "" && isNaN($("#CrestTime").val()) ){
			$("#CrestTime").focus();
			$("#CrestTime").select();
			showMsg("<%=GetEmpLbl("ArestTimeDigital")%>"); //中间休息必须为数字
			return false;
		}
		if(!iStretchShift && !iNight){
			RetVal = CompareTime($("#ConDuty").val(),$("#ConDutyStart").val(),$("#ConDutyEnd").val());
			switch(RetVal){
				case 1:showMsg("<%=GetEmpLbl("onDutyNull")%>");$("#ConDuty").focus(); return false; //[上班标准时间]不能为空！
				case 2:showMsg("<%=GetEmpLbl("onDutyStartNull")%>");$("#ConDutyStart").focus(); return false; //[上班开始时间]不能为空！
				case 3:showMsg("<%=GetEmpLbl("onDutyEndNull")%>");$("#ConDutyEnd").focus(); return false; //[上班截止时间]不能为空！
				case 11:showMsg("<%=GetEmpLbl("onDutyIllegal")%>");$("#ConDuty").focus(); return false; //[上班标准时间]非法！
				case 22:showMsg("<%=GetEmpLbl("onDutyStartIllegal")%>");$("#ConDutyStart").focus(); return false; //[上班开始时间]非法！
				case 33:showMsg("<%=GetEmpLbl("onDutyEndIllegal")%>");$("#ConDutyEnd").focus(); return false; //[上班截止时间]非法！
				case 111:showMsg("<%=GetEmpLbl("OnDutyLtonDutyStart")%>");$("#ConDuty").focus(); return false; //[上班标准时间]不能小于[上班开始时间]！
				case 222:showMsg("<%=GetEmpLbl("OnDutyEndLtOnDuty")%>");$("#ConDutyEnd").focus(); return false; //[上班截止时间]不能小于[上班标准时间]！
			}
			RetVal = CompareTime($("#CoffDuty").val(),$("#CoffDutyStart").val(),$("#CoffDutyEnd").val());
			switch(RetVal){
				case 1:showMsg("<%=GetEmpLbl("offDutyNull")%>");$("#CoffDuty").focus(); return false; //[下班标准时间]不能为空！
				case 2:showMsg("<%=GetEmpLbl("offDutyStartNull")%>");$("#CoffDutyStart").focus(); return false; //[下班开始时间]不能为空！
				case 3:showMsg("<%=GetEmpLbl("offDutyEndNull")%>");$("#CoffDutyEnd").focus(); return false; //[下班截止时间]不能为空！
				case 11:showMsg("<%=GetEmpLbl("offDutyIllegal")%>");$("#CoffDuty").focus(); return false; //[下班标准时间]非法！
				case 22:showMsg("<%=GetEmpLbl("offDutyStartIllegal")%>");$("#CoffDutyStart").focus(); return false; //[下班开始时间]非法！
				case 33:showMsg("<%=GetEmpLbl("offDutyEndIllegal")%>");$("#CoffDutyEnd").focus(); return false; //[下班截止时间]非法！
				case 111:showMsg("<%=GetEmpLbl("offDutyLtoffDutyStart")%>");$("#CoffDuty").focus(); return false; //[下班标准时间]不能小于[下班开始时间]！
				case 222:showMsg("<%=GetEmpLbl("offDutyEndLtoffDuty")%>");$("#CoffDutyEnd").focus(); return false; //[下班截止时间]不能小于[下班标准时间]！
			}
			RetVal = CompareTime2($("#ConDutyEnd").val(),$("#CoffDutyStart").val());
			switch(RetVal){
				case 111:showMsg("<%=GetEmpLbl("ThirdOffDutyLtOnDutyEnd")%>");$("#CoffDutyStart").focus(); return false; //第三次[下班开始时间]不能小于[上班截止时间]！
			}
		}
	}
	
	//弹性班次，只有一个时段
	if(iStretchShift){
		RetVal = CompareTime2($("#AonDutyStart").val(),$("#AonDuty").val());
		switch(RetVal){
			case 1:showMsg("<%=GetEmpLbl("onDutyNull")%>");$("#AonDuty").focus(); return false; //[上班标准时间]不能为空！
			case 2:showMsg("<%=GetEmpLbl("onDutyStartNull")%>");$("#AonDutyStart").focus(); return false; //[上班开始时间]不能为空！
			case 11:showMsg("<%=GetEmpLbl("onDutyIllegal")%>");$("#AonDuty").focus(); return false; //[上班标准时间]非法！
			case 22:showMsg("<%=GetEmpLbl("onDutyStartIllegal")%>");$("#AonDutyStart").focus(); return false; //[上班开始时间]非法！
			case 111:showMsg("<%=GetEmpLbl("OnDutyLtonDutyStart")%>");$("#AonDuty").focus(); return false; //[上班标准时间]不能小于[上班开始时间]！
		}
		RetVal = CompareTime2($("#AoffDuty").val(),$("#AoffDutyEnd").val());
		switch(RetVal){
			case 1:showMsg("<%=GetEmpLbl("offDutyNull")%>");$("#AoffDuty").focus(); return false; //[下班标准时间]不能为空！
			case 2:showMsg("<%=GetEmpLbl("offDutyStartNull")%>");$("#AoffDutyStart").focus(); return false; //[下班开始时间]不能为空！
			case 11:showMsg("<%=GetEmpLbl("offDutyIllegal")%>");$("#AoffDuty").focus(); return false; //[下班标准时间]非法！
			case 22:showMsg("<%=GetEmpLbl("offDutyStartIllegal")%>");$("#AoffDutyStart").focus(); return false; //[下班开始时间]非法！
			case 111:showMsg("<%=GetEmpLbl("offDutyLtoffDutyStart")%>");$("#AoffDuty").focus(); return false; //[下班标准时间]不能小于[下班开始时间]！
		}
	}
	$("#FormError").hide();
}

</script>