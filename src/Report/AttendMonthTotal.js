
$(document).ready(function(){  
	CheckLoginStatus();
	InitForm();
	//获取操作权限
	var role = GetOperRole("AttendTotal");
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
	
	$("#startTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM',Mchanged:gridReload2,ychanged:gridReload2})});
	// $("#endTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})});
	var d,strMonth,strDay,time1;
	d = new Date();
	d.setDate(d.getDate()-1);
	
	strMonth = d.getMonth() + 1;
	strDay = d.getDate();
	if (strMonth <= 9)  strMonth = "0" + strMonth;
	if (strDay <= 9)    strDay = "0" + strDay;
	startTime.value = d.getFullYear() + "-" + strMonth;

	var strexpandSubGridIds = ","; //记录已展开的行ID

jQuery("#DataGrid").jqGrid({
		url:'AttendMonthTotal.asp',
		datatype: "json",
		//colNames:[EmployeeId,'姓名','上下班','01','02','03','04','05','06','07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31','出勤天數','应到天數'],
		colNames:['EmployeeId',getlbl("rep.Name"),getlbl("rep.IoDesc"),cName(1),cName(2),cName(3),cName(4),cName(5),cName(6),cName(7),cName(8),cName(9),cName(10),cName(11),cName(12),cName(13),cName(14),cName(15),cName(16),cName(17),cName(18),cName(19),cName(20),cName(21),cName(22),cName(23),cName(24),cName(25),cName(26),cName(27),cName(28),cName(29),cName(30),cName(31),getlbl("rep.WorkDay_0"),getlbl("rep.WorkDay_1")],
		colModel :[
			{name:'Employeeid',index:'Employeeid',width:10,hidden:true,viewable:false,editrules:{edithidden:false},search:false},
			{name:'Name',index:'Name',editable:true,width:150,align:'center',search:true,searchoptions:{sopt:["eq","ne",'cn','nc']},}, 
			{name:'Io',index:'Io',width:130, height:'auto', align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(getlbl("rep.Io"));}},   
			{name:'day1',index:'day1',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day2',index:'day2',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day3',index:'day3',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day4',index:'day4',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day5',index:'day5',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day6',index:'day6',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day7',index:'day7',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day8',index:'day8',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day9',index:'day9',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day10',index:'day10',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day11',index:'day11',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day12',index:'day12',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day13',index:'day13',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day14',index:'day14',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day15',index:'day15',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day16',index:'day16',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day17',index:'day17',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day18',index:'day18',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day19',index:'day19',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day20',index:'day20',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day21',index:'day21',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day22',index:'day22',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day23',index:'day23',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day24',index:'day24',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day25',index:'day25',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day26',index:'day26',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day27',index:'day27',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day28',index:'day28',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day29',index:'day29',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day30',index:'day30',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'day31',index:'day31',width:70,align:'center',sortable:false,search:false,formatter:function(cellvalue, options, rowObject){return fmtText(cellvalue);}},   
			{name:'WorkTime_0',index:'WorkTime_0',width:70,sortable:false,align:'center',search:false,}, 
			{name:'WorkTime_1',index:'WorkTime_1',width:70,sortable:false,align:'center',search:false,}, 			
			], 
		caption:getlbl("rep.AttendMonthTotal"),//"月份出勤报表",
		imgpath:'/images',
		multiselect: false,
		rowNum:irowNum,
		rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		postData:{
				  DepartmentId: function() { return GetDeptSelChildIds("selDept") /*$("#selDept").val()*/; },
				  startTime: function() { return $("#startTime").val(); },
				  days: function(){
				  	return getDays($("#startTime").val());
				  } 
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
		//width:1024,
		forceFit:true, //调整列宽度不会改变表格的宽度
		hidegrid:false,//禁用控制表格显示、隐藏的按钮
		loadtext:strloadtext,
		toppager:true,
		loadComplete:function(data){ //完成服务器请求后，回调函数 
			var days = getDays($("#startTime").val());
			for(var i = 1; i <= 31 - days; i ++){ //要隐藏的列数: 31(每月最大天数) - days(当月实际天数)
				$(".ui-jqgrid-htable").find("tr").find("th:eq(" + (days + 3 + i - 1)+")").hide(); //要隐藏第几列(列索引):days + 3 + i - 1
				$(".ui-jqgrid-btable").find("tr").find("td:eq(" + (days + 3 + i - 1)+")").hide();
			}

			jQuery("#DataGrid").jqGrid('setCaption', getlbl("rep.AttendMonthTotal") + "(" + $("#startTime").val() + ")") ;
			
			if(data == null || data.records==0){ 
				jQuery("#DataGrid").jqGrid('clearGridData');
			}
		},
});

jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:false,add:false,del:false,view:false,refresh:irefresh,search:isearch,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
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
$("#DataGrid_toppager_right").css('width','75%');
$("#DataGrid_toppager_left").css("width","25%");

// if(isearch){
// 	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
// 		caption:getlbl("hr.Search"),//"查找",
// 		buttonicon:"ui-icon-search",
// 		title:getlbl("hr.Search"),//"查找",
// 		id:"DataGrid_btnSearch",
// 		onClickButton: Search,
// 		position:"first"
// 	});
// }

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

function InitForm(){
	 GetDepartments();
	 $("#selDept").change(function(){
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
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendMonthTotal.asp",page:1,}).trigger("reloadGrid");
}

function gridReload2(){
	//日期控件改变值时触发。这里当控件日期发生变化时，$("#startTime")此时还没有获取到最新值，因此使用下面方法
	var  year = $dp.cal.newdate.y;
	var Month = $dp.cal.newdate.M;
	if (Month <= 9)  Month = "0" + Month;
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendMonthTotal.asp?_startTime="+year+"-"+Month,page:1,}).trigger("reloadGrid");
}

function cName(day){
	var wk = (new Date($("#startTime").val() + "-" + day)).getDay();
	return "<span class='blk'>" + (day > 9 ? "" : "0") + day + "</span><span>" + checkWeekday(wk) + "</span>";
}

function fmtText(text){
	if(text){
		var arr = text.split(",");
		text = "";
		if (arr.length >= 1) text += "<span class='blk'>" + arr[0] + "</span>";
		if (arr.length >= 2) text += "<span class='blk'>" + arr[1] + "</span>";
	}

	return text;
}
}); 

function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=attendmonthtotal");
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
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendMonthTotal.asp?search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString),page:1,}).trigger("reloadGrid");
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
