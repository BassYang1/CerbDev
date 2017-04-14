
$(document).ready(function(){  
	CheckLoginStatus();
	InitForm();
	//获取操作权限
	var role = GetOperRole("AttendOriginalReport");
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
	
	$("#startTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})});
	$("#endTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})});
	var d,strMonth,strDay,time1;
	d = new Date();
	d.setDate(d.getDate()-1);
	
	strMonth = d.getMonth() + 1;
	strDay = d.getDate();
	if (strMonth <= 9)  strMonth = "0" + strMonth;
	if (strDay <= 9)    strDay = "0" + strDay;
	startTime.value = d.getFullYear() + "-" + strMonth + "-" + strDay;
	
	d = new Date();
	strMonth = d.getMonth() + 1;
	strDay = d.getDate();
	if (strMonth <= 9)  strMonth = "0" + strMonth;
	if (strDay <= 9)    strDay = "0" + strDay;
	endTime.value = d.getFullYear() + "-" + strMonth + "-" + strDay;
	var strexpandSubGridIds = ","; //记录已展开的行ID

jQuery("#DataGrid").jqGrid({
		url:'AttendOriginalReportList.asp',
		datatype: "json",
		//colNames:['Employeeid','部门','姓名','工号','卡号','性别','职务','入职日期'],
		colNames:['Employeeid',getlbl("hr.Dept"),getlbl("hr.Name"),getlbl("hr.Num"),getlbl("hr.Card"),getlbl("hr.Sex"),getlbl("hr.Position"),getlbl("hr.JoinDate")],
		colModel :[
			{name:'Employeeid',index:'Employeeid',width:10,hidden:true,viewable:false,editrules:{edithidden:false},search:false},
			{name:'DepartmentID',index:'DepartmentID',width:160,align:'center',},  
			{name:'Name',index:'Name',editable:true,width:160,align:'center',}, 
			{name:'Number',index:'Number',editable:true,width:160,align:'center',}, 
			{name:'Card',index:'Card',editable:true,width:120,align:'center',}, 
			{name:'Sex',index:'Sex',editable:true,editrules:{required:false,edithidden:true},width:100,align:'center',}, 
			{name:'Headship',index:'Headship',editable:true,editrules:{required:false},width:160,align:'center',}, 
			{name:'JoinDate',index:'JoinDate',editable:true,editrules:{required:false,date:false,edithidden:true},search:false,width:120,
				formatter:'date',sorttype:'date',
				formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', align:'center',}, 
			], 
		caption:getlbl("rep.AttendOriginalReport"),//"考勤原始刷卡报表",
		imgpath:'/images',
		multiselect: false,
		rowNum:irowNum,
		rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		postData:{
				  DepartmentId: function() { return GetDeptSelChildIds("selDept") /*$("#selDept").val()*/; },
				  startTime: function() { return $("#startTime").val(); },
				  endTime: function() { return $("#endTime").val(); },
				  showAllRow:function() { return $("#selshowAllRow").val(); },
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
			}else{
				var ids = $("#DataGrid").jqGrid('getDataIDs');
				if(ids.length == 1){
					//判断如果只有一行，则自动展开子表格
					$('#DataGrid').expandSubGridRow(ids[0]);
				}else{
					//若非一行，则将上次展开的子表格自动展开
					if(strexpandSubGridIds != ""){
						var ids = strexpandSubGridIds.split(",");
						for(var i=0; i< ids.length; i++){
							if(ids[i] != undefined && ids[i] != ""){
								$('#DataGrid').expandSubGridRow(ids[i]);
							}
						}
					}
				}
			}
		},
		subGrid: true,
		subGridRowColapsed: function(subgrid_id, row_id) {
			//点"-"收起子表格
			strexpandSubGridIds = strexpandSubGridIds.replace(","+row_id+",",",");
		},
		subGridRowExpanded: function(subgrid_id, row_id) {
			if(strexpandSubGridIds.indexOf(","+row_id+",") < 0){
				strexpandSubGridIds = strexpandSubGridIds + row_id+","; //记录已展开的ID行　
			}
			var subgrid_table_id, pager_id;
			subgrid_table_id = subgrid_id+"_t";
			pager_id = "p_"+subgrid_table_id;
			$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
			$("#"+subgrid_table_id).jqGrid({
				url:"AttendOriginalDetailReportList.asp?EmployeeId="+row_id,
				datatype: "json",
				//colNames:['日期','刷卡时间'],
				colNames:[getlbl("rep.BCDate"),getlbl("rep.BCTime2")],
				colModel :[
					{name:'BrushTime1',index:'BrushTime1',sortable:false,width:120,align:'center',},  
					{name:'BrushTime2',index:'BrushTime2',sortable:false,width:720,
					formatter:FormatBrushCardAttendRowToCol,
					},  
					], 
				imgpath:'/images',
				rowNum:1000,
				//rowList:[16,20,30],
				prmNames: {search: "_search"},  
				postData:{
					startTime: function() { return $("#startTime").val(); },
				  	endTime: function() { return $("#endTime").val(); },
					showAllRow:function() { return $("#selshowAllRow").val(); },
				},
				pager: pager_id,
				viewrecords: true,
				height: 'auto',
				width: 'auto',
				autowidth: true,
       			shrinkToFit: true,
       			scrollrows: true,
				forceFit:false, //调整列宽度不会改变表格的宽度
				hidegrid:false,//禁用控制表格显示、隐藏的按钮
				loadtext:strloadtext,
				toppager:false,
				cellsubmit: "clientArray",
				loadComplete:function(data){ //完成服务器请求后，回调函数 
					if(data == null || data.records==0){ 
						$("#"+subgrid_table_id).jqGrid('clearGridData');
					}
				},
			});
			$("#"+pager_id+"_center").remove();//去掉底部翻页按钮
			$("#"+pager_id+"_left").html(getlbl("rep.RedColor"));	//" 注：<font color=#FF0000>(红色)</font>表示非法卡"
		},
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
	 GetDepartments();
	 $("#selshowAllRow").change(function(){
			gridReload();
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
		$("#selDept").change(function(){
			strexpandSubGridIds = ",";
			gridReload();
		});
}

function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendOriginalReportList.asp",page:1,}).trigger("reloadGrid");
}

}); 

function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=attend");
	$("#divExport").show();
}

function Search(){
	strexpandSubGridIds = ",";
	$("#divSearch").load("../Equipment/search.asp?submitfun=SearchSubmit()");
	$("#divSearch").show();
}

function SearchSubmit(){
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendOriginalReportList.asp?search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString),page:1,}).trigger("reloadGrid");
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

