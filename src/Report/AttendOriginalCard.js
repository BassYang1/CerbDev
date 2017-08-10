var strUrl;
$(document).ready(function(){  
	CheckLoginStatus();
	InitForm();
	//获取操作权限
	var role = GetOperRole("AttendOriginalCard");
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

	//这里从考勤汇总通过点击姓名，查看考勤卡明细
	var strEmployeeId,strStartTime;
	strEmployeeId = Request( location.href,"EmployeeId");
	strStartTime=Request( location.href,"startTime");
	strUrl = 'AttendOriginalCardList.asp';
	if(strStartTime != "" && strStartTime != ""){
		strUrl = strUrl + "?search=true&searchField=Employeeid&searchOper=eq&searchString="+strEmployeeId;
		startTime.value = strStartTime;
	}

	var strexpandSubGridIds = ","; //记录已展开的行ID

jQuery("#DataGrid").jqGrid({
		url:strUrl,
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
		caption:getlbl("rep.AttendOriginalCard"),//"考勤刷卡报表",
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
				url:"AttendOriginalCardDetailList.asp?EmployeeId="+row_id,
				datatype: "json",
				//colNames:['日期','Nobrushcard','班次','上班','下班','上班','下班','上班','下班','Result1','Result2','Result3','Result4','Result5','Result6','工时(M)','LateTime1','LateTime2','LateTime3','迟到(M)','LeaveEarlyTime1','LeaveEarlyTime2','LeaveEarlyTime3','早退(M)','Absent','SignInFlag','OTtime'],
				colNames:[getlbl("rep.BCDate"),'Nobrushcard',getlbl("rep.Shift"),getlbl("rep.OnDuty"),getlbl("rep.OffDuty"),getlbl("rep.OnDuty"),getlbl("rep.OffDuty"),getlbl("rep.OnDuty"),getlbl("rep.OffDuty"),getlbl("rep.Remark"),'Result1','Result2','Result3','Result4','Result5','Result6',getlbl("rep.WorkTime"),'LateTime1','LateTime2','LateTime3',getlbl("rep.LateTime"),'LeaveEarlyTime1','LeaveEarlyTime2','LeaveEarlyTime3',getlbl("rep.LeaveEarly"),'Absent','SignInFlag','OTtime'],
				colModel :[
					{
						name:'OnDutyDate1',width:60,hidden:false,align:'center',sortable:false,
						formatter: function (cellvalue, options, rowObject) { 
							if(cellvalue && !isNaN(cellvalue)){
								var dt = new Date($("#startTime").val() + "-" + cellvalue);
								var day = checkWeekday(dt.getDay());

								if(day == "") return cellvalue;

								return cellvalue + "(" + day + ")";
							}

							return cellvalue;
						},
					},
					{name:'Nobrushcard',width:10,hidden:true,},
					{name:'ShiftName',width:20,hidden:true,align:'center',sortable:false,},
					{name:'OnDuty1',width:120,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(rowObject[17] != undefined && rowObject[17] != "" && rowObject[17] != "0"){
								return "<font color=#FF0000>"+cellvalue+"</font>";
							}
							else{
								return cellvalue;
							}
						}
					},
					{name:'OffDuty1',width:120,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(rowObject[21] != undefined && rowObject[21] != "" && rowObject[21] != "0"){
								return "<font color=#FF0000>"+cellvalue+"</font>";
							}
							else{
								return cellvalue;
							}
						}
					},
					{name:'OnDuty2',width:120,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(rowObject[18] != undefined && rowObject[18] != "" && rowObject[18] != "0"){
								return "<font color=#FF0000>"+cellvalue+"</font>";
							}
							else{
								return cellvalue;
							}
						}
					},
					{name:'OffDuty2',width:120,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(rowObject[22] != undefined && rowObject[22] != "" && rowObject[22] != "0"){
								return "<font color=#FF0000>"+cellvalue+"</font>";
							}
							else{
								return cellvalue;
							}
						}
					},
					{name:'OnDuty3',width:120,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(rowObject[19] != undefined && rowObject[19] != "" && rowObject[19] != "0"){
								return "<font color=#FF0000>"+cellvalue+"</font>";
							}
							else{
								return cellvalue;
							}
						}
					},
					
					{name:'OffDuty3',width:120,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(rowObject[23] != undefined && rowObject[23] != "" && rowObject[23] != "0"){
								return "<font color=#FF0000>"+cellvalue+"</font>";
							}
							else{
								return cellvalue;
							}
						}
					},
					{name:'Remark',width:40,hidden:false,align:'center',},
					{name:'Result1',width:10,hidden:true,},
					{name:'Result2',width:10,hidden:true,},
					{name:'Result3',width:10,hidden:true,},
					{name:'Result4',width:10,hidden:true,},
					{name:'Result5',width:10,hidden:true,},
					{name:'Result6',width:10,hidden:true,},
					{name:'worktime',width:50,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(cellvalue != undefined && cellvalue == "0"){
								return "";
							}
							else{
								return cellvalue;
							}
						}
					},
					{name:'LateTime1',width:10,hidden:true,},
					{name:'LateTime2',width:10,hidden:true,},
					{name:'LateTime3',width:10,hidden:true,},
					{name:'LateTime',width:50,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(cellvalue != undefined && cellvalue != "" && cellvalue != "0"){
								return "<font color=#FF0000>"+cellvalue+"</font>";
							}
							else if(cellvalue != undefined && cellvalue == "0"){
								return "";
							}
							else{
								return cellvalue;
							}
						}
					},
					{name:'LeaveEarlyTime1',width:10,hidden:true,},
					{name:'LeaveEarlyTime2',width:10,hidden:true,},
					{name:'LeaveEarlyTime3',width:10,hidden:true,},
					{name:'LeaveEarlyTime',width:50,hidden:false,align:'center',sortable:false,
						formatter:function(cellvalue, options, rowObject){
							if(cellvalue != undefined && cellvalue != "" && cellvalue != "0"){
								return "<font color=#FF0000>"+cellvalue+"</font>";
							}
							else if(cellvalue != undefined && cellvalue == "0"){
								return "";
							}
							else{
								return cellvalue;
							}
						}
					},
					{name:'Absent',width:10,hidden:true,},
					{name:'SignInFlag',width:10,hidden:true,},
					{name:'OTtime',width:10,hidden:true,},
					], 
				imgpath:'/images',
				rowNum:1000,
				//rowList:[16,20,30],
				prmNames: {search: "_search"},  
				postData:{
					startTime: function() { return $("#startTime").val(); },
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
					var htmlObj = $.ajax({url:'AttendOriginalCardTotal.asp?nd='+getRandom()+'&EmployeeId='+row_id+'&startTime='+$("#startTime").val(),async:false});
					$("#gview_"+subgrid_table_id).prepend(htmlObj.responseText);
				},
			});
			$("#"+pager_id+"_center").remove();//去掉底部翻页按钮
			$("#"+pager_id+"_left").html(" ");
			//合并表头
			$("#"+subgrid_table_id).jqGrid('setGroupHeaders', {  
				useColSpanStyle: true, //没有表头的列是否与表头列位置的空单元格合并  
				groupHeaders:[  
					{startColumnName: 'OnDuty1', numberOfColumns: 2, titleText: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+getlbl("rep.First"),align:'center'},	//第一次
					{startColumnName: 'OnDuty2', numberOfColumns: 2, titleText: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+getlbl("rep.Second"),align:'center'},	//第二次
					{startColumnName: 'OnDuty3', numberOfColumns: 2, titleText: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+getlbl("rep.Third"),align:'center'}	//第三次	//getlbl("rep.OffDuty")
				]  
			}); 	
			
			
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

function InitForm(){
	 GetDepartments();
	 $("#selDept").change(function(){
			gridReload();
		});
	//$("#startTime").bind("keypress",function(){
	//	gridReload();
	//});

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
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendOriginalCardList.asp",page:1,}).trigger("reloadGrid");
}

function gridReload2(){
	//日期控件改变值时触发。这里当控件日期发生变化时，$("#startTime")此时还没有获取到最新值，因此使用下面方法
	var  year = $dp.cal.newdate.y;
	var Month = $dp.cal.newdate.M;
	if (Month <= 9)  Month = "0" + Month;
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendOriginalCardList.asp?_startTime="+year+"-"+Month,page:1,}).trigger("reloadGrid");
}


}); 

function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=attendcard");
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
	$("#DataGrid").jqGrid('setGridParam',{url:"AttendOriginalCardList.asp?search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString),page:1,}).trigger("reloadGrid");
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