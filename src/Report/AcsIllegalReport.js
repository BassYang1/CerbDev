
$(document).ready(function(){  
	$("#progressbar").hide();
	CheckLoginStatus();
	InitForm();
	//获取操作权限
	var role = GetOperRole("AcsIllegalReport");
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
		url:'AcsIllegalReportList.asp',
		datatype: "json",
		//colNames:['RecordID','部门','姓名','工号','卡号','设备','日期','时间','状态'],
		colNames:['RecordID',getlbl("hr.Dept"),getlbl("hr.Name"),getlbl("hr.Num"),getlbl("hr.Card"),getlbl("con.Controller"),getlbl("rep.BCDate"),getlbl("rep.BCTime"),getlbl("rep.Status")],
		colModel :[
			{name:'RecordID',index:'RecordID',width:10,hidden:true,editrules:{edithidden:false},search:false},
			{name:'DepartmentName',index:'DepartmentName',align:'center',width:160,editable:false,search:false,},  
			{name:'Name',index:'Name',align:'center',width:120,editable:false,search:false,},  
			{name:'Number',index:'Number',align:'center',width:120,editable:false,search:false,}, 
			{name:'Card',index:'Card',editable:false,align:'center',width:120,search:false,}, 
			{name:'Location',index:'Location',editable:false,align:'center',width:160,search:false,}, 
			{name:'Brushtime1',index:'Brushtime1',align:'center',width:100,editable:false,search:false,}, 
			{name:'Brushtime2',index:'Brushtime2',align:'center',width:100,editable:false,search:false,}, 
			{name:'Property',index:'Property',align:'center',width:120,editable:false,
				formatter:getBrushCardProDesc,
			},
			], 
		caption:getlbl("rep.AcsIllegalReport"),//"非法进出报表",
		imgpath:'/images',
		multiselect: false,
		rowNum:irowNum,
		rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		postData:{startTime: function() { return $("#startTime").val(); },
				  endTime: function() { return $("#endTime").val(); },
				  ControllerId: function() { return $("#selCon").val(); },
				  DepartmentId: function() { return GetDeptSelChildIds("selDept") /*$("#selDept").val()*/; },
				  Property: function() { return $("#selProperty").val(); },
				  
		},
		//jsonReader: { repeatitems: false },
		pager: '#pager',
		//sortname: 'RecordID',
		multiselect: false,
        multiboxonly: false,
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
if(isearch){
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:getlbl("hr.Search"),//"查找",
		buttonicon:"ui-icon-search",
		title:getlbl("hr.Search"),//"查找",
		id:"DataGrid_btnSearch",
		onClickButton: Search,
		position:"first"
	});
}
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
	 GetDepartments();
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
					$("#selCon").append($("<option></option>").attr("value", "0").text(getlbl("rep.AllCon0")));	//0 - 所有设备
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
	$("#DataGrid").jqGrid('setGridParam',{url:"AcsIllegalReportList.asp",page:1,}).trigger("reloadGrid");
}

}); 
function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=acsillegal");
	$("#divExport").show();
}
function Search(){
	$("#divSearch").load("../Equipment/search.asp?submitfun=SearchSubmit()");
	$("#divSearch").show();
}

function SearchSubmit(){
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();
	$("#DataGrid").jqGrid('setGridParam',{url:"AcsIllegalReportList.asp?search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString),page:1,}).trigger("reloadGrid");
	//$("#DataGrid").jqGrid('setGridParam',{url : 'RegCardDetailList.asp?ControllerId='+strControllerId+"&search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+strsearchString}).trigger("reloadGrid");
	//alert(strsearchString);
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

