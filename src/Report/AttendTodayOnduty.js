
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
	
	$("#startTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd',Mchanged:gridReload2,ychanged:gridReload2})});
	// $("#endTime").click(function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'})});
	var d,strMonth,strDay,time1;
	d = new Date();
	d.setDate(d.getDate()-1);
	
	strMonth = d.getMonth() + 1;
	strDay = d.getDate();
	if (strMonth <= 9)  strMonth = "0" + strMonth;
	if (strDay <= 9)    strDay = "0" + strDay;
	startTime.value = d.getFullYear() + "-" + strMonth + "-" + strDay;

	var strexpandSubGridIds = ","; //记录已展开的行ID

jQuery("#DataGrid").jqGrid({
		url:'AttendTodayOnduty.asp',
		datatype: "json",
		//colNames:['DepartmentId','部門','編制人數','本日實到','遲到','事假','病假','出差','其他假別','曠職' ],
		colNames:['DepartmentId',getlbl("hr.Dept"),getlbl("rep.EmpCount"),getlbl("rep.EmpTodayCount"),getlbl("hr.Late"),getlbl("hr.Private"),getlbl("hr.Sick"),getlbl("hr.Trip"),getlbl("hr.OtherLeave"),getlbl("hr.Abnormity"),],
		colModel :[
			{name:'DepartmentId',index:'DepartmentId',width:10,hidden:true,viewable:false,editrules:{edithidden:false},search:false},
			{name:'DepartmentName',index:'DepartmentName',width:100,align:'center',},  
			{name:'EmpCount',index:'EmpCount',editable:true,width:70,align:'center',search:false,}, 
			{name:'EmpTodayCount',index:'EmpTodayCount',editable:true,width:100,align:'center',search:false,}, 
			{name:'LateCount',index:'LateCount',editable:true,width:100,align:'center',search:false,}, 
			{name:'PrivateCount',index:'PrivateCount',width:70,align:'center',search:false,}, 
			{name:'SickCount',index:'SickCount',width:80,align:'center',search:false,}, 
			{name:'TripCount',index:'TripCount',width:70,align:'center',search:false,}, 
			{name:'OtherCount',index:'OtherCount',width:80,align:'center',search:false,}, 
			{name:'AbsCount',index:'AbsCount',width:70,align:'center',search:false,}, 
			], 
		caption:getlbl("rep.AttendTodayOndutyReport"),//"今日上班",
		imgpath:'/images',
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
		subGrid: true,
		subGridRowColapsed: function(subgrid_id, row_id) {
			//点"-"收起子表格
			strexpandSubGridIds = strexpandSubGridIds.replace(","+row_id+",",",");
		},
		subGridRowExpanded: function(subgrid_id, row_id) {
			//detail
			if(strexpandSubGridIds.indexOf(","+row_id+",") < 0){
				strexpandSubGridIds = strexpandSubGridIds + row_id+","; //记录已展开的ID行　
			}

			var subgrid_table_id, pager_id;
			subgrid_table_id = subgrid_id+"_t";
			pager_id = "p_"+subgrid_table_id;
			$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
			$("#"+subgrid_table_id).jqGrid({
				datatype: "local",
				colNames:["Id", ""],
				colModel :[
		           {name:'Id',index:'Id', width:60, sorttype:"int", hidden:true},
		           {name:'DataLink',index:'DataLink', width:90, sorttype:"date"},
		           ], 
				viewrecords: true,
				height: 'auto',
				width: 'auto',
				autowidth: true,
				loadComplete:function(data){

				},
				subGrid: true,					
				subGridRowExpanded: function(subdetail_id, rowdetail_id) {
					var subdetail_table_id, detail_pager_id;
					subdetail_table_id = subdetail_id+"_t";
					detail_pager_id = "p_"+subdetail_table_id;
					$("#"+subdetail_id).html("<table id='"+subdetail_table_id+"' class='scroll'></table><div id='"+detail_pager_id+"' class='scroll'></div>");
					
					if(rowdetail_id == "1"){ //实上班人员
						$("#"+subdetail_table_id).jqGrid({
							url:'AttendTodayOndutyDetail.asp?link=' + rowdetail_id,
							datatype: "json",
							//colNames:['EmployeeId','姓名','性別','編號','卡號','職務','第一次刷卡時間']
							colNames:["EmployeeId", getlbl("rep.Name"), getlbl("rep.Sex"), getlbl("rep.Number"), getlbl("rep.CardNo"), getlbl("rep.Headship"), getlbl("rep.FirstBrush")],
							colModel :[
					           {name:'EmployeeId',index:'EmployeeId', width:60, sorttype:"int", hidden:true},
					           {name:'Name',index:'Name', width:90},
					           {name:'Sex',index:'Sex', width:90},
					           {name:'Number',index:'Number', width:90},
					           {name:'Card',index:'Card', width:90},
					           {name:'Headship',index:'Headship', width:90},
					           {
						           	name:'BrushTime',index:'BrushTime', width:90, sorttype:"date",
						       		formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', 
						       	},
					           ], 
							rowNum:1000,
							rowList:[10,16,20,30],
							viewrecords: true,
							pager: detail_pager_id + "_" + row_id + "_" + detail_pager_id,
							height: 'auto',
							width: 'auto',
							autowidth: true,
							postData:{
								  deptId: row_id,
								  startTime: $("#startTime").val(),									  
								  detailLink: rowdetail_id,
							},
						});
					}
					else if(rowdetail_id == "2"){ //请假人员报表
						$("#"+subdetail_table_id).jqGrid({
							url:'AttendTodayOndutyDetail.asp?link=' + rowdetail_id,
							datatype: "json",
							//colNames:['EmployeeId','姓名','性別','編號','卡號','職務','入職日期','假別']
							colNames:["EmployeeId", getlbl("rep.Name"), getlbl("rep.Sex"), getlbl("rep.Number"), getlbl("rep.CardNo"), getlbl("rep.Headship"), getlbl("rep.JoinDate"),getlbl("rep.LeaveType")],
							colModel :[
					           {name:'EmployeeId',index:'EmployeeId', width:60, sorttype:"int", hidden:true},
					           {name:'Name',index:'Name', width:90},
					           {name:'Sex',index:'Sex', width:90,},
					           {name:'Number',index:'Number', width:90},
					           {name:'Card',index:'Card', width:90},
					           {name:'Headship',index:'Headship', width:90},
					           {
						           	name:'JoinDate',index:'JoinDate', width:90, sorttype:"date",
						       		formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', 
						       	},
					           {name:'LeaveType',index:'LeaveType', width:90},
					           ], 
							rowNum:1000,
							rowList:[10,16,20,30],
							viewrecords: true,
							pager: detail_pager_id + "_" + row_id + "_" + detail_pager_id,
							height: 'auto',
							width: 'auto',
							autowidth: true,
							postData:{
								  deptId: row_id,
								  startTime: $("#startTime").val(),									  
								  detailLink: rowdetail_id,
							},
						});
					}
					else if(rowdetail_id == "3"){ //未上班人员报表
						$("#"+subdetail_table_id).jqGrid({
							url:'AttendTodayOndutyDetail.asp?link=' + rowdetail_id,
							datatype: "json",
							//colNames:['EmployeeId','姓名','性別','編號','卡號','職務','入職日期','假別']
							colNames:["EmployeeId", getlbl("rep.Name"), getlbl("rep.Sex"), getlbl("rep.Number"), getlbl("rep.CardNo"), getlbl("rep.Headship"), getlbl("rep.JoinDate")],
							colModel :[
					           {name:'EmployeeId',index:'EmployeeId', width:60, sorttype:"int", hidden:true},
					           {name:'Name',index:'Name', width:90},
					           {name:'Sex',index:'Sex', width:90},
					           {name:'Number',index:'Number', width:90},
					           {name:'Card',index:'Card', width:90},
					           {name:'Headship',index:'Headship', width:90},
					           {
						           	name:'JoinDate',index:'JoinDate', width:90, sorttype:"date",
						       		formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', 
						       	},
					           ], 
							rowNum:1000,
							rowList:[10,16,20,30],
							viewrecords: true,
							pager: detail_pager_id + "_" + row_id + "_" + detail_pager_id,
							height: 'auto',
							width: 'auto',
							autowidth: true,
							postData:{
								  deptId: row_id,
								  startTime: $("#startTime").val(),									  
								  detailLink: rowdetail_id,
							},
						});
					}
					else if(rowdetail_id == "4"){ //迟到人员报表
						$("#"+subdetail_table_id).jqGrid({
							url:'AttendTodayOndutyDetail.asp?link=' + rowdetail_id,
							datatype: "json",
							//colNames:['EmployeeId','姓名','性別','編號','卡號','職務','入職日期','假別']
							colNames:["EmployeeId", getlbl("rep.Name"), getlbl("rep.Sex"), getlbl("rep.Number"), getlbl("rep.CardNo"), getlbl("rep.Headship"), getlbl("rep.JoinDate"), getlbl("rep.FirstBrush")],
							colModel :[
					           {name:'EmployeeId',index:'EmployeeId', width:60, sorttype:"int", hidden:true},
					           {name:'Name',index:'Name', width:90},
					           {name:'Sex',index:'Sex', width:90},
					           {name:'Number',index:'Number', width:90},
					           {name:'Card',index:'Card', width:90},
					           {name:'Headship',index:'Headship', width:90},
					           {
						           	name:'JoinDate',index:'JoinDate', width:90, sorttype:"date",
						       		formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', 
						       	},
					           {
						           	name:'BrushTime',index:'BrushTime', width:90, sorttype:"date",
						       		formatoptions: {srcformat:'Y-m-d',newformat:'Y-m-d'},datefmt:'Y-m-d', 
						       	},
					           ], 
							rowNum:1000,
							rowList:[10,16,20,30],
							viewrecords: true,
							pager: detail_pager_id + "_" + row_id + "_" + detail_pager_id,
							height: 'auto',
							width: 'auto',
							autowidth: true,
							postData:{
								  deptId: row_id,
								  startTime: $("#startTime").val(),									  
								  detailLink: rowdetail_id,
							},
						});
					}
				},
			});

			//detail 列表			
			$("#gview_DataGrid_" + row_id + "_t").children(".ui-jqgrid-hdiv").hide();

			var links = [
			        {Id:"1",DataLink:getlbl("rep.RegEmp")},
			        {Id:"2",DataLink:getlbl("rep.LeaveEmp")},
			        {Id:"3",DataLink:getlbl("rep.AbsEmp")},
			        {Id:"4",DataLink:getlbl("rep.LateEmp")},
			        ];
			for(var i=0;i<=links.length;i++){
			    jQuery("#"+subgrid_table_id).jqGrid('addRowData',i+1,links[i]);
			}
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
		//$("#selDept").prepend("<option value='0'>"+getlbl("rep.MyRecord0")+"</option>"); 	//0 - 我的记录
		$("#selDept").val(-1);	//选择value为0的项
		$("#selDept").change(function(){
			strexpandSubGridIds = ",";
			gridReload();
		});
}

function showTotal(){
	var empCount = 0, todayCount = 0, lateCount = 0, privateCount = 0, sickCount = 0, tripCount = 0, otherCount = 0, absCount = 0;
	var cellText;
	var $cells = $("#DataGrid tr").find("td:eq(3)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			empCount += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(4)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			todayCount += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(5)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			lateCount += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(6)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			privateCount += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(7)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			sickCount += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(8)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			tripCount += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(9)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			otherCount += parseFloat(cellText);
		}
	});

	$cells = $("#DataGrid tr").find("td:eq(10)");
	$cells.each(function(i){
		cellText = $cells[i].innerText;

		if(/^\d+$/.test(cellText)){
			absCount += parseFloat(cellText);
		}
	});

	var html = "<tr role='row' tabindex='0' class='ui-widget-content jqgrow ui-row-ltr ui-state-highlight' aria-selected='true'>";
	html += "<td role='gridcell' aria-describedby='DataGrid_subgrid' class='ui-sgcollapsed sgcollapsed' style=''></td>";
	html += "<td role='gridcell' style='display:none;' aria-describedby='DataGrid_DepartmentId'></td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_DepartmentName'>" + getlbl("rep.AttendTotal") + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_EmpCount'>" + empCount + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_EmpTodayCount'>" + todayCount + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_LateCount'>" + lateCount + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_PrivateCount'>" + privateCount + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_SickCount'>" + sickCount + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_TripCount'>" + tripCount + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_OtherCount'>" + otherCount + "</td>";
	html += "<td role='gridcell' style='text-align:center;' aria-describedby='DataGrid_AbsCount'>" + absCount + "</td>";
	html += "</tr>";

	$("#DataGrid").find("tr:last").after(html);
}

function gridReload(){
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendTodayOnduty.asp",page:1,}).trigger("reloadGrid");
}

function gridReload2(){
	//日期控件改变值时触发。这里当控件日期发生变化时，$("#startTime")此时还没有获取到最新值，因此使用下面方法
	var  year = $dp.cal.newdate.y;
	var Month = $dp.cal.newdate.M;
	var day = $dp.cal.newdate.d;
	if (Month <= 9)  Month = "0" + Month;
	if (day <= 9)  day = "0" + day;
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendTodayOnduty.asp?_startTime="+year+"-"+Month+"-"+day,page:1,}).trigger("reloadGrid");
}


}); 

function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=attendtodayonduty");
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
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendTodayOnduty.asp?search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString),page:1,}).trigger("reloadGrid");
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
