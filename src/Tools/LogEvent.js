
$(document).ready(function(){  
	CheckLoginStatus();
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
	InitForm();
	
jQuery("#DataGrid").jqGrid({
		url:'LogEventList.asp',
		editurl:"LogEventEdit.asp",
		datatype: "json",
		//colNames:['EventID','用户名','登录机器','日期','模块','操作方式','对象'],
		colNames:['EventID',getlbl("tool.LoginName"),getlbl("tool.LoginIP"),getlbl("tool.OperateTime"),getlbl("tool.Modules"),getlbl("tool.Actions"),getlbl("tool.Objects")],
		colModel :[
			{name:'EventID',index:'EventID',width:10,hidden:true,editrules:{edithidden:false},search:false},
			{name:'LoginName',index:'LoginName',width:100,editable:false,
				stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']}},  
			{name:'LoginIP',index:'LoginIP',width:100,editable:false,
				searchoptions:{sopt:["eq","ne",'cn','nc']},},
			{name:'OperateTime',index:'OperateTime',editable:false,search:false,
				searchoptions:{sopt:["eq","ne",'cn','nc']}},
			{name:'Modules',index:'Modules',width:200,editable:false,align:'left',
				searchoptions:{sopt:["eq","ne",'cn','nc']}}, 
			{name:'Actions',index:'Actions',width:80,editable:false,
				searchoptions:{sopt:["eq","ne",'cn','nc']}}, 
			{name:'Objects',index:'Objects',width:360,editable:false,
				searchoptions:{sopt:["eq","ne",'cn','nc']}}, 
			], 
		caption:getlbl("tool.LogEvent"),//"日志浏览",
		imgpath:'/images',
		multiselect: false,
		rowNum:irowNum,
		rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		postData:{startTime: function() { return $("#startTime").val(); },
				 endTime: function() { return $("#endTime").val(); },
				 DepartmentId: function() { return GetDeptSelChildIds("selDept") /*$("#selDept").val()*/; },
		},
		//jsonReader: { repeatitems: false },
		pager: '#pager',
		//sortname: 'RecordID',
		multiselect: true,
        multiboxonly: true,
		viewrecords: true,
		sortorder: "desc",
		height: 'auto',
		width:970,
		forceFit:true, //调整列宽度不会改变表格的宽度
		hidegrid:false,//禁用控制表格显示、隐藏的按钮
		loadtext:strloadtext,
		toppager:true,
		loadComplete:function(data){ //完成服务器请求后，回调函数 
        if(data == null || data.records==0){ 
			jQuery("#DataGrid").jqGrid('clearGridData');
        }},
});

//获取操作权限
var role = GetOperRole("LogEvent");
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
jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:false,add:false,del:idel,view:false,refresh:true,search:true,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
	},  //  default settings for edit
	{
	},  //  default settings for add
	{
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,closeAfterSearch: true,caption:strsearchcaption,top:60} ,// search options
	{top:0,}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css('width','60%');
$("#DataGrid_toppager_left").css("width","40%");

$('#table_DataGrid_top_right').appendTo('#DataGrid_toppager_right');
$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_right").jqGrid('navButtonAdd',"#DataGrid_toppager_right",{
	caption:getlbl("rep.ConfirmStr"),//"确定",
	buttonicon:"ui-icon-check",
	title:getlbl("rep.ConfirmSearch"),//"确定查找",
	id:"btnQuery_DataGrid_top",
	onClickButton: gridReload,
	position:"last"
});

if(iexport){
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:getlbl("hr.Export"),//"导出",
		buttonicon:"ui-icon-bookmark",
		title:getlbl("hr.ExportToLocal"),//"导出至本地",
		id:"DataGrid_btnSubmit",
		onClickButton: ExportData,
		//position:"first"
	});
}

function InitForm(){
	 GetDepartments();
}
function GetDepartments(){
	var htmlObj = $.ajax({url:'../Common/GetDepartment.asp?nd='+getRandom()+'&selID=selDept&DeptId=',async:false});
		$("#tdDept").html(htmlObj.responseText);
		$("#selDept").css('width','140');
		$("#selDept").css('font-size','12px');
		$("#selDept").prepend("<option value='-1'>"+getlbl("rep.AllDept1")+"</option>"); 	//1 - 所有部门
		$("#selDept").prepend("<option value='0'>"+getlbl("rep.MyRecord0")+"</option>"); 	//0 - 我的记录
		$("#selDept").val(0);	//选择value为0的项
}

function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"LogEventList.asp",page:1}).trigger("reloadGrid");
}
function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=logevent");
	$("#divExport").show();
}
}); 

$(function(){
	var iWidth = $(window).width()-40;
	if (iWidth <= 970)
		iWidth = 970;
	$("#DataGrid").setGridWidth(iWidth);　 
	$(window).resize(function(){　　
		$("#DataGrid").setGridWidth(iWidth);
	});　　
});

