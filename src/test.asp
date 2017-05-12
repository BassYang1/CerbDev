<!--#include file="common\Page.asp" -->
<!--#include file="Conn\conn.asp" -->
<!--#include file="Conn\json.asp" -->
<link rel="stylesheet" type="text/css" media="screen" href="css/jquery-ui-1.10.2.redmond.css" />
<link rel="stylesheet" type="text/css" media="screen" href="css/ui.jqgrid.css"/>
<link rel="stylesheet" type="text/css" href="css/ui.multiselect.css"/>
<link rel="stylesheet" type="text/css" href="css/ui.custom.css"/>
<!--[if IE]><link type="text/css" rel="stylesheet" href="ie.css"/><![endif]-->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/lang/lang.js"></script>

<script type="text/javascript" src="js/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="js/grid.subgrid.js"></script>
<script type="text/javascript" src="js/custom/jqGridSet.js"></script>
<script type="text/javascript" src="js/custom/system.js"></script>

<script src="js/ui/jquery.ui.core.js"></script>
<script src="js/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="js/ui/jquery.ui.progressbar.js"></script>
<script src="js/ui/jquery.ui.mouse.js"></script>
<script src="js/ui/jquery.ui.button.js"></script>
<script src="js/ui/jquery.ui.draggable.js"></script>
<script src="js/ui/jquery.ui.position.js"></script>
<script src="js/ui/jquery.ui.dialog.js"></script>
<link rel="stylesheet" href="css/demos.css">

<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='btnSearchEmployee' onclick='fSearchEmployee()'>查找<span class='ui-icon ui-icon-search'></span></a><TABLE width='100%' border='0' cellPadding=0 cellSpacing=0><TBODY><TR><TD width='30%' valign='top'><div onDblClick='fInsertEmp()' style='padding-left:1em;' class='ui-jqdialog-content ui-widget-content'><select id='selEmpSrc' name='selEmpSrc' class='FormElement ui-widget-content ui-corner-all' size=8 multiple style='WIDTH: 270px'></select></div></TD><TD width='18%'align=middle valign='middle'><div align='center'><a class='fm-button ui-state-default ui-corner-all fm-button-icon-left ' id='empadd' onclick='fInsertEmp()'><span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -13px;top: 8px;'></span><span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -8px;top: 0px;'></span></a><p><a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='empdel' onclick='fDelEmp()'><span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -13px;top: 8px;'></span><span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -8px;top: 0px;'></span></a></div></TD><TD width='52%' valign='top'><div onDblClick='fDelEmp()' class='ui-jqdialog-content ui-widget-content'><select id='selEmpDesc' name='selEmpDesc' class='FormElement ui-widget-content ui-corner-all' style='WIDTH: 270px' multiple size=8 ></select></div></TD></TR></TBODY></TABLE>
<script>
	//document.write("<script type='text/javascript' src='AdjustShifts.js?rnd=" + Math.random() + "'><\/script>");


function fSearchEmployee(){
	//alert(123);
	$("#divSearch").load("Equipment/search.asp?submitfun=fSearchEmployeeSubmit()");
	$("#divSearch").show();
}

function fSearchEmployeeSubmit(){
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();
	
	condition = strsearchField + "|," + strsearchOper + "|," + encodeURI(strsearchString);
	
	var arrEmps = getEmpJSON(condition);

	//所选职员列表
	var $srcObj = $("#selEmpSrc");
	$srcObj.empty();

	for(var i in arrEmps){
		$srcObj.append("<option value='" + arrEmps[i].id + "'>" + arrEmps[i].number + "-" + arrEmps[i].name + "</option>");
	}
}
</script>