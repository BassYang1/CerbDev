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


<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" id="gbox_DataGrid_14_t" dir="ltr" style="width: 450px;"><div id="lui_DataGrid_14_t" class="ui-widget-overlay jqgrid-overlay"></div><div id="load_DataGrid_14_t" class="loading ui-state-default ui-state-active" style="display: none;">正在获取，请稍后...</div><div class="ui-jqgrid-view" id="gview_DataGrid_14_t" style="width: 450px;"><div class="ui-jqgrid-titlebar ui-jqgrid-caption ui-widget-header ui-corner-top ui-helper-clearfix" style="display: none;"><span class="ui-jqgrid-title"></span></div><div id="DataGrid_14_t_toppager" class="ui-state-default ui-jqgrid-toppager" style="width: 450px;" dir="ltr"><div role="group" class="ui-pager-control" id="pg_DataGrid_14_t_toppager">
	<table cellspacing="0" cellpadding="0" border="0" role="row" style="width:100%;table-layout:fixed;height:100%;" class="ui-pg-table">
		<tbody>
			<tr>
				<td align="left" id="DataGrid_14_t_toppager_left">
				<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;" class="ui-pg-table navtable">
				  <tbody>
				   <tr>
				       <td class="ui-pg-button ui-corner-all" id="DataGrid_14_t_btnEdit" title="修改单元格，颜色改变的单元格为可编辑，点击可进入编辑状态"><div class="ui-pg-div"><span class="ui-icon ui-icon-pencil"></span>修改</div></td>
				       <td class="ui-pg-button ui-corner-all ui-state-disabled" id="DataGrid_14_t_btnSubmit" title="保存数据，且自动同步到设备"><div class="ui-pg-div"><span class="ui-icon ui-icon-disk"></span>提交</div></td>
				       <td class="ui-pg-button ui-corner-all ui-state-disabled" id="DataGrid_14_t_btnCancel" title="取消保存"><div class="ui-pg-div"><span class="ui-icon ui-icon-cancel"></span>取消</div></td>
					 </tr>
					</tbody>
				 </table></td>
				    <td align="right" id="DataGrid_14_t_toppager_right"></td></tr></tbody></table></div></div>
					<div style="width: 450px;" class="ui-state-default ui-jqgrid-hdiv"><div class="ui-jqgrid-hbox"><table cellspacing="0" cellpadding="0" border="0" aria-labelledby="gbox_DataGrid_14_t" role="grid" style="width:450px" class="ui-jqgrid-htable"><thead><tr role="rowheader" class="ui-jqgrid-labels"><th class="ui-state-default ui-th-column ui-th-ltr" role="columnheader" id="DataGrid_14_t_HolidayNumber" style="width: 93px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_DataGrid_14_t_HolidayNumber" class="ui-jqgrid-sortable">序号<span style="display:none" class="s-ico"><span class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr" sort="asc"></span><span class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr" sort="desc"></span></span></div></th><th class="ui-state-default ui-th-column ui-th-ltr" role="columnheader" id="DataGrid_14_t_TemplateId" style="width: 60px; display: none;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_DataGrid_14_t_TemplateId" class="ui-jqgrid-sortable">TemplateId<span style="display:none" class="s-ico"><span class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr" sort="asc"></span><span class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr" sort="desc"></span></span></div></th><th class="ui-state-default ui-th-column ui-th-ltr" role="columnheader" id="DataGrid_14_t_TemplateName" style="width: 347px;"><div id="jqgh_DataGrid_14_t_TemplateName" class="ui-jqgrid-sortable">假期名称<span style="display:none" class="s-ico"><span class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr" sort="asc"></span><span class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr" sort="desc"></span></span></div></th><th class="ui-state-default ui-th-column ui-th-ltr" role="columnheader" id="DataGrid_14_t_OperType" style="width: 150px; display: none;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_DataGrid_14_t_OperType" class="ui-jqgrid-sortable">OperType<span style="display:none" class="s-ico"><span class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr" sort="asc"></span><span class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr" sort="desc"></span></span></div></th></tr></thead></table></div></div><div class="ui-jqgrid-bdiv" style="height: auto; width: 450px;"><div style="position:relative;"><div></div><table cellspacing="0" cellpadding="0" border="0" class="ui-jqgrid-btable" id="DataGrid_14_t" tabindex="0" role="grid" aria-multiselectable="false" aria-labelledby="gbox_DataGrid_14_t" style="width: 450px;"><tbody><tr style="height:auto" role="row" class="jqgfirstrow">
				       <td style="height:0px;width:93px;" role="gridcell"></td>
				       <td style="height:0px;width:60px;display:none;" role="gridcell"></td>
				       <td style="height:0px;width:347px;" role="gridcell"></td>
				       <td style="height:0px;width:150px;display:none;" role="gridcell"></td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="1" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="1" style="" role="gridcell">1</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="2" style="display:none;" role="gridcell">2</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="1 - 大陆假期表" style="" role="gridcell">1 - 大陆假期表</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="2" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="2" style="" role="gridcell">2</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="26" style="display:none;" role="gridcell">26</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="test1" style="" role="gridcell">test1</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="3" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="3" style="" role="gridcell">3</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="" style="display:none;" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="" style="" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="4" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="4" style="" role="gridcell">4</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="" style="display:none;" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="" style="" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="5" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="5" style="" role="gridcell">5</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="" style="display:none;" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="" style="" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="6" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="6" style="" role="gridcell">6</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="" style="display:none;" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="" style="" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="7" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="7" style="" role="gridcell">7</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="" style="display:none;" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="" style="" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="8" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="8" style="" role="gridcell">8</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="" style="display:none;" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="" style="" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="9" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="9" style="" role="gridcell">9</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="" style="display:none;" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="" style="" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr><tr class="ui-widget-content jqgrow ui-row-ltr" tabindex="-1" id="10" role="row">
				       <td aria-describedby="DataGrid_14_t_HolidayNumber" title="10" style="" role="gridcell">10</td>
				       <td aria-describedby="DataGrid_14_t_TemplateId" title="" style="display:none;" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_TemplateName" title="" style="" role="gridcell">&nbsp;</td>
				       <td aria-describedby="DataGrid_14_t_OperType" title="" style="display:none;" role="gridcell">&nbsp;</td></tr></tbody></table></div></div></div><div id="rs_mDataGrid_14_t" class="ui-jqgrid-resize-mark">&nbsp;</div><div class="scroll ui-state-default ui-jqgrid-pager ui-corner-bottom" id="p_DataGrid_14_t" style="width: 450px;" dir="ltr"><div role="group" class="ui-pager-control" id="pg_p_DataGrid_14_t"><table cellspacing="0" cellpadding="0" border="0" role="row" style="width:100%;table-layout:fixed;height:100%;" class="ui-pg-table"><tbody>
			
			<tr>
				       <td align="left" id="p_DataGrid_14_t_left"></td>
				       <td align="right" id="p_DataGrid_14_t_right"><div class="ui-paging-info" style="text-align:right" dir="ltr">1 - 10&#12288;共 10 条</div></td></tr></tbody></table></div></div></div>