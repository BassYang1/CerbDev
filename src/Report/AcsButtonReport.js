
$(document).ready(function(){  
	$("#progressbar").hide();
	CheckLoginStatus();
	InitForm();
	//获取操作权限
	var role = GetOperRole("AcsButtonReport");
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
		
	$("#startTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd HH:mm:ss'})});
	$("#endTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd HH:mm:ss'})});
	var d,strMonth,strDay,time1;
	d = new Date();
	d.setDate(d.getDate()-1);
	
	strMonth = d.getMonth() + 1;
	strDay = d.getDate();
	if (strMonth <= 9)  strMonth = "0" + strMonth;
	if (strDay <= 9)    strDay = "0" + strDay;
	startTime.value = d.getFullYear() + "-" + strMonth + "-" + strDay + " 00:00:00";
	
	d = new Date();
	strMonth = d.getMonth() + 1;
	strDay = d.getDate();
	if (strMonth <= 9)  strMonth = "0" + strMonth;
	if (strDay <= 9)    strDay = "0" + strDay;
	endTime.value = d.getFullYear() + "-" + strMonth + "-" + strDay + " 23:59:59";

jQuery("#DataGrid").jqGrid({
		url:'AcsButtonReportList.asp',
		datatype: "json",
		//colNames:['RecordID','设备','输入','日期','时间'],
		colNames:['RecordID',getlbl("con.Controller"),getlbl("rep.Input"),getlbl("rep.BCDate"),getlbl("rep.BCTime")],
		colModel :[
			{name:'RecordID',index:'RecordID',width:10,hidden:true,editrules:{edithidden:false},search:false},
			{name:'Location',index:'Location',editable:false,align:'center',width:160,search:false,}, 
			{name:'InputPoint',index:'InputPoint',editable:false,align:'center',width:160,search:false,}, 
			{name:'OccurTime1',index:'OccurTime1',align:'center',width:160,editable:false,search:false,}, 
			{name:'OccurTime2',index:'OccurTime2',align:'center',width:160,editable:false,search:false,}, 
			], 
		caption:getlbl("rep.ButtonReport"),//"按钮事件报表",
		imgpath:'/images',
		multiselect: false,
		rowNum:irowNum,
		rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		postData:{startTime: function() { return $("#startTime").val(); },
				  endTime: function() { return $("#endTime").val(); },
				  ControllerId: function() { return $("#selCon").val(); },
				  
		},
		//jsonReader: { repeatitems: false },
		pager: '#pager',
		//sortname: 'RecordID',
		multiselect: false,
        multiboxonly: false,
		viewrecords: true,
		sortorder: "desc",
		height: 'auto',
		width:'auto',
		forceFit:true, //调整列宽度不会改变表格的宽度
		hidegrid:false,//禁用控制表格显示、隐藏的按钮
		loadtext:strloadtext,
		toppager:true,
		loadComplete:function(data){ //完成服务器请求后，回调函数 
        if(data == null || data.records==0){ 
			jQuery("#DataGrid").jqGrid('clearGridData');
        }},
});

jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:false,add:false,del:false,view:false,refresh:irefresh,search:false,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
	},  //  default settings for edit
	{
	},  //  default settings for add
	{
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,caption:strsearchcaption,top:60} ,// search options
	{top:0,}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css('width','75%');
$("#DataGrid_toppager_left").css("width","25%");
if(iexport){
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:getlbl("hr.Export"),//"导出",
		buttonicon:"ui-icon-bookmark",
		title:getlbl("hr.ExportToLocal"),//"导出至本地",
		id:"DataGrid_btnExportdata",
		onClickButton: ExportData,
		//position:"first"
	});
}
	
$('#table_DataGrid_top_right').appendTo('#DataGrid_toppager_right');
$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_right").jqGrid('navButtonAdd',"#DataGrid_toppager_right",{
	caption:getlbl("rep.ConfirmStr"),//"确定",
	buttonicon:"ui-icon-check",
	title:getlbl("rep.ConfirmSearch"),//"确定查找",
	id:"btnQuery_DataGrid_top",
	onClickButton: gridReload,
	position:"last"
});

function InitForm(){
	 GetController();
}
function GetController()
{
	var seloptions;
	var DataArray;
	$.ajax({
		type: 'Post',
		url: 'GetControllerForReport.asp?nd='+getRandom(),
		data:{"":""},
		async:false,
		success: function(data) {
			try {
				if(data != "")
				{
					eval(data);
					$("#selCon").find('option').remove();
					$("#selCon").append($("<option></option>").attr("value", "0").text(getlbl("rep.AllCon0")));//0 - 所有设备
					for(i=0; i<ConArray[1].length; i++)
					{
						$("#selCon").append($("<option></option>").attr("value", ConArray[0][i]).text(ConArray[1][i]));
					}
					$("#selCon").val(0);//选择value为0的项
				}
			}
			catch(exception) {
				alert(exception);
			}
		}
	});
}


function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"AcsButtonReportList.asp",page:1,}).trigger("reloadGrid");
}

}); 
function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=acsbuttonreport");
	$("#divExport").show();
}

$(function(){
	var iWidth = $(window).width()-40;
	if (iWidth <= 970)
		iWidth = 970;
	$("#DataGrid").setGridWidth(iWidth);　 
	$(window).resize(function(){　　
		$("#DataGrid").setGridWidth(iWidth);
	});　　
});

