
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
		url:'AttendOtTotalList.asp',
		datatype: "json",
		//colNames:['月份','部门','Employeeid','姓名','工号','超時加班','加班次數','休息日加班','節假日加班'],
		colNames:[getlbl("rep.Month"),getlbl("hr.Dept"),'Employeeid',getlbl("hr.Name"),getlbl("hr.Num"),getlbl("rep.AttendOTTime"),getlbl("rep.AttendOTCount"),getlbl("rep.AttendRestday"),getlbl("rep.AttendHoliday"),],
		colModel :[
			{name:'AttendMonth',index:'AttendMonth',editable:true,width:70,align:'center',search:false,}, 
			{name:'DepartmentName',index:'DepartmentName',width:100,align:'center',search:false,},  
			{name:'Employeeid',index:'Employeeid',width:10,hidden:true,viewable:false,editrules:{edithidden:false},search:false},
			{
				name:'Name',index:'Name',editable:true,width:100,align:'center',
				searchoptions:{sopt:["eq","ne",'cn','nc']},
				// formatter:function(cellvalue, options, rowObject){
				// 	return "<a href = 'AttendOriginalCard.html?EmployeeId="+rowObject[0]+"&startTime="+$("#startTime").val()+"'>"+cellvalue+"</a>";
				// },
			}, 
			{
				name:'Number',index:'Number',editable:true,width:100,align:'center',
				searchoptions:{sopt:["eq","ne",'cn','nc']},
			}, 
			{name:'OtTime_0',index:'OtTime_0',width:70,align:'center',search:false,}, 
			{name:'TotalCount',index:'TotalCount',width:80,align:'center',search:false,}, 
			{name:'WorkTime_1',index:'WorkTime_1',width:70,align:'center',search:false,}, 
			{name:'WorkTime_2',index:'WorkTime_2',width:80,align:'center',search:false,}, 
			], 
		caption:getlbl("rep.AttendOtTotalReport"),//"加班汇总报表",
		imgpath:'/images',
		multiselect: false,
		rowNum:irowNum,
		rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		postData:{
				  DepartmentId: function() { return GetDeptSelChildIds("selDept") /*$("#selDept").val()*/; },
				  startTime: function() { return $("#startTime").val(); },
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
			if(data == null || data.records==0){ 
				jQuery("#DataGrid").jqGrid('clearGridData');
			}

			showTotal(); //显示总计
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

function showTotal(){
	var totalTime = 0, totalCount = 0, totalTime1 = 0, totalTime2 = 0;
	var cellText;
	var $cells = $("#DataGrid tr").find("td:eq(5)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^[\d|\.]+$/.test(cellText)){
			totalTime += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(6)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			totalCount += parseInt(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(7)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^[\d|\.]+$/.test(cellText)){
			totalTime1 += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(8)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^[\d|\.]+$/.test(cellText)){
			totalTime2 += parseFloat(cellText);
		}
	});

	var html = "<tr role='row' tabindex='0' class='ui-widget-content jqgrow ui-row-ltr ui-state-highlight' aria-selected='true'>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_AttendMonth'>" + getlbl("rep.AttendTotal") + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_DepartmentName'></td>";
	html += "<td role='gridcell' style='display:none;' aria-describedby='DataGrid_Employeeid'></td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_Name'></td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_Number'></td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_OtTime_0'>" + totalTime + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_TotalCount'>" + totalCount + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_WorkTime_1'>" + totalTime1 + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_WorkTime_2'>" + totalTime2 + "</td>";
	html += "</tr>";

	$("#DataGrid").find("tr:last").after(html);
}

function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendOtTotalList.asp",page:1,}).trigger("reloadGrid");
}

function gridReload2(){
	//日期控件改变值时触发。这里当控件日期发生变化时，$("#startTime")此时还没有获取到最新值，因此使用下面方法
	var  year = $dp.cal.newdate.y;
	var Month = $dp.cal.newdate.M;
	if (Month <= 9)  Month = "0" + Month;
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendOtTotalList.asp?_startTime="+year+"-"+Month,page:1,}).trigger("reloadGrid");
}


}); 

function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=attendottotal");
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
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendOtTotalList.asp?search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString),page:1,}).trigger("reloadGrid");
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
