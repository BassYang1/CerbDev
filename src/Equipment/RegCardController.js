$(document).ready(function(){
CheckLoginStatus();  
//获取操作权限
var role = GetOperRole("RegCardController");
var iedit=false,iadd=false,idel=false,iview=false,irefresh=false,isearch=false,iexport=false,isync=false;
try{
	iedit=role.edit;
	iadd=role.add;
	idel=role.del;
	iview=role.view;
	irefresh=role.refresh;
	isearch=role.search;
	iexport=role.exportdata;
	isync=role.sync;
}
catch(exception) {
	alert(exception);
}

jQuery("#DataGrid").jqGrid({
	url:'RegCardControllerList.asp',
	datatype: "json",
	//colNames:['设备ID','设备编号','位置','设备IP','工作类型','服务器','已同步/未同步','同步状态'],
	colNames:[getlbl("con.ControllerId"),getlbl("con.ControllerIdNum"),getlbl("con.Location"),getlbl("con.IP"),getlbl("con.WorkType"),getlbl("con.ServerIP"),getlbl("con.SyncedUnsync"),getlbl("con.SyncStatus")],
	colModel :[
		{name:'ControllerId',index:'ControllerId',width:120,align:'center',viewable:true,formoptions:{rowpos:1,colpos:1},stype:"text", searchoptions:{ sopt:["eq","ne"]},},
		{name:'ControllerNumber',index:'ControllerNumber',align:'center',stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},title:getlbl("con.ClickDetail"),	//点击查看明细
			formatter:function(cellvalue, options, rowObject){
				return "<a href='RegCardDetail.html?ControllerId="+options.rowId +"' class='ui-jqGrid-linkbuttion'>"+cellvalue+"</a>";
			},
		},
		{name:'Location',index:'Location',align:'center',stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},},
		{name:'IP',index:'IP',align:'center',search:false,stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},},
		{name:'WorkType',index:'WorkType',align:'center',search:false,width:260,},
		{name:'ServerIP',index:'ServerIP',align:'center',stype:"text", searchoptions:{ sopt:["eq","ne"]},},
		{name:'SyncCount',index:'SyncCount',width:100,align:'center',search:false,viewable:false,editable:false,sortable:false,},
		{name:'SyncStatus',index:'SyncStatus',width:100,align:'center',search:false,viewable:false,editable:false,sortable:false,},
		], 
	caption:getlbl("con.RegCardTitle"),	//"注册卡号",
	imgpath:'/images',
	multiselect: false,
	rowNum:irowNum,
	rowList:[10,16,50,100,500,1000],
	prmNames: {search: "_search"},  
	//jsonReader: { repeatitems: false },
	pager: '#pager',
	//sortname: 'RecordID',
	multiselect: true,
	multiboxonly: true,
	viewrecords: true,
	sortorder: "asc",
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
			GetSyncStatus();
		}
	},
});

jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:false,add:false,del:false,view:false,refresh:false,search:false,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
		//selarrrow
	},  //  default settings for edit
	{
	},  //  default settings for add
	{
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,closeAfterSearch: true,caption:strsearchcaption,top:60} ,// search options
	{
		top:0,width:700,viewPagerButtons:false,drag:true,resize:true,
	}	//view parameters
	);

	var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
	$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
	$(".ui-paging-info", topPagerDiv).remove();
	$("#DataGrid_toppager_right").css("width","1%");
	$("#DataGrid_toppager_left").css("width","99%");
	if(iview){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("hr.View"),	//"查看",
			buttonicon:"ui-icon-document",
			title:getlbl("con.ViewTitle"),	//"查看设备注册卡号明细",
			id:"DataGrid_btnView",
			onClickButton: ViewRegCard,
			position:"first"
		});
	}
	if(iadd){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("con.Reg"),	//"注册",
			buttonicon:" ui-icon-plus",
			title:getlbl("con.RegTitle"),	//"注册人员",
			id:"DataGrid_btnRegCard",
			onClickButton: AddRegCard,
			position:"first"
		});	
	}
	if(isync){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("con.SyncToCon"),	//"同步到设备",
			buttonicon:"ui-icon-transferthick-e-w",
			title:getlbl("con.SyncRegCardTitle"),	//"将注册卡号数据同步到设备",
			id:"DataGrid_btnSync",
			onClickButton: SyncData,
			position:"last"
		});
	}
	if(isearch){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("hr.Search"),	//"查找",
			buttonicon:"ui-icon-search",
			title:getlbl("hr.Search"),	//"查找",
			id:"DataGrid_btnSearch",
			onClickButton: Search,
			position:"last"
		});
	}
	if(iview){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("hr.Refresh"),	//"刷新",
			buttonicon:"ui-icon-refresh",
			title:getlbl("hr.Refresh"),	//"刷新",
			id:"DataGrid_btnrefresh",
			onClickButton: Refresh,
			position:"last"
		});
	}
	if(iexport){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("hr.Export"),	//"导出",
			buttonicon:"ui-icon-bookmark",
			title:getlbl("hr.ExportToLocal"),	//"导出至本地",
			id:"DataGrid_btnSubmit",
			onClickButton: ExportData,
			//position:"first"
		});
	}

setInterval("GetSyncStatus();",20000);//自动刷新状态
}); 

function AddRegCard(){
	var rowids,i;
	var rowidArr = $("#DataGrid").jqGrid("getGridParam", "selarrrow");
	rowids = "";
	for(i=0; i<rowidArr.length; i++){
		rowids=rowids+rowidArr[i]+",";
	}
	if(rowids != ""){
		rowids = rowids.substring(0,rowids.length-1);
	}
	$("#dialog-confirm").html("<p><span class='ui-icon ui-icon-alert' style='float:left; margin:0 7px 20px 0;'></span>"+getlbl("con.Moment")+"</p>");
	$("#dialog-confirm").load("RegCard.asp?nd="+getRandom()+"&EmployeeID=&ControllerID="+rowids+"");

	var obj = {
		//resizable: true,
		minWidth:880,
		minHeight:100,
		//height:'auto',
		//width:'auto',
		modal: false,
		position:[10,1],
		buttons : {},
	};
	var SubmitVal = getlbl("con.Submit");
	var CancelVal = getlbl("con.Cancel");
	obj.buttons[SubmitVal] = function(){
		var t = RegCardSubmit();
		if(t == true || t == "true"){
			$("#DataGrid").trigger("reloadGrid");
			$( this ).dialog( "close" );
		}
	}
	obj.buttons[CancelVal] = function(){
		$( this ).dialog( "close" );
	}
	$( "#dialog-confirm" ).dialog(obj);
}
//显示注册卡号
function ViewRegCard(){
	var rowids,i;
	var rowidArr = $("#DataGrid").jqGrid("getGridParam", "selarrrow");
	if(rowidArr == "" || rowidArr.length <= 0){
		//alert("请选择需要操作的数据行!");
		alert(getlbl("con.SelRowNull"));
		return;
	}
	rowids = "";
	for(i=0; i<rowidArr.length; i++){
		rowids=rowids+rowidArr[i]+",";
	}
	if(rowids != ""){
		rowids = rowids.substring(0,rowids.length-1);
	}
	window.location.href="RegCardDetail.html?ControllerId=" + rowids;
}
function GetSyncStatus(){
	var Ids;
	var rowIds = $("#DataGrid").jqGrid('getDataIDs');  //获取当前页所有行
	Ids = "";
	for(var i=0; i<rowIds.length; i++){
		Ids=Ids+rowIds[i]+",";
	}
	
	if(Ids != ""){
		Ids = Ids.substring(0,Ids.length-1);
	}
	
	$.ajax({
		type: 'Post',
		url: 'GetSyncStatus.asp?type=register',
		data:{"ControllerId":Ids},
		success: function(data) {
			try  {
				if(data != null || data != ""){
					eval(data);
					//$("#DataGrid").setRowData( Arr[0][1], { SyncStatus:"未同步"}); 
					for(var i=0; i<Arr[1].length; i++)
					{
						if(Arr[1][i] == 1){
							$("#DataGrid").setRowData( Arr[0][i], { SyncStatus:"<span><img src=../images/synced.gif></span>"}); 
						}
						else{
							$("#DataGrid").setRowData( Arr[0][i], { SyncStatus:"<span><img src=../images/unsync.gif></span>"}); 
						}
					}
				}
			}
			catch(exception) {
			}
		},
		error:function(XmlHttpRequest,textStatus, errorThrown){
		}
	});		
	
	//获取已同步/未同步条数
	$.ajax({
		type: 'Post',
		url: 'GetSyncStatus.asp?type=RegCardCount',
		data:{"ControllerId":Ids},
		success: function(data) {
			try  {
				if(data != null || data != ""){
					eval(data);
					for(var i=0; i<ArrCount[1].length; i++)
					{
						$("#DataGrid").setRowData( ArrCount[0][i], { SyncCount:"<span>"+ArrCount[1][i]+"</span>"}); 
					}
				}
			}
			catch(exception) {
			}
		},
		error:function(XmlHttpRequest,textStatus, errorThrown){
		}
	});		
}

function SyncData(){
	//var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
	var rowids,i;
	var rowidArr = $("#DataGrid").jqGrid("getGridParam", "selarrrow");
	if(rowidArr == "" || rowidArr.length <= 0){
		//alert("请选择需要操作的数据行!");
		alert(getlbl("con.SelRowNull"));
		return;
	}
	rowids = "";
	for(i=0; i<rowidArr.length; i++){
		rowids=rowids+rowidArr[i]+",";
	}
	if(rowids != ""){
		rowids = rowids.substring(0,rowids.length-1);
	}
	
	var obj = {
		resizable: false,
		height:180,
		width:320,		
		modal: true,
		buttons : {},
	};
	var SyncChange = getlbl("con.SyncChange");	//同步变更
	var SyncAll = getlbl("con.SyncAll");		//同步所有
	obj.buttons[SyncChange] = function(){
		$.ajax({
			type: 'Post',
			url: 'SyncData.asp?type=register&syncOpt=change',
			data:{"ControllerId":rowids},
			success: function(data) {
				try  {
					var responseMsg = $.parseJSON(data);
					if(responseMsg.success == false){
						alert(responseMsg.message);
					}else if(responseMsg.success == true){
						//成功
						GetSyncStatus();
						$("#DataGrid").resetSelection();
					}else{
						//alert("同步异常");
						alert(getlbl("con.SyncEx"));
					}
				}
				catch(exception) {
					alert(exception+"," + data);
				}
			},
			error:function(XmlHttpRequest,textStatus, errorThrown){
				alert(textStatus+":SyncData.asp,"+XmlHttpRequest.responseText);
			}
		});
		$( this ).dialog( "close" );		
	}
	
	obj.buttons[SyncAll] = function(){
		$.ajax({
			type: 'Post',
			url: 'SyncData.asp?type=register&syncOpt=all',
			data:{"ControllerId":rowids},
			success: function(data) {
				try  {
					var responseMsg = $.parseJSON(data);
					if(responseMsg.success == false){
						alert(responseMsg.message);
					}else if(responseMsg.success == true){
						//成功
						GetSyncStatus();
						$("#DataGrid").resetSelection();
					}else{
						//alert("同步异常");
						alert(getlbl("con.SyncEx"));
					}
				}
				catch(exception) {
					alert(exception+"," + data);
				}
			},
			error:function(XmlHttpRequest,textStatus, errorThrown){
				alert(textStatus+":SyncData.asp,"+XmlHttpRequest.responseText);
			}
		});

		$( this ).dialog( "close" );
	}
	$( "#dialog-confirm-SyncData" ).dialog(obj);
}
function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=register");
	$("#divExport").show();
}

function Search(){
	$("#divSearch").load("search.asp?submitfun=SearchRegCardSubmit()");
	$("#divSearch").show();
}

function Refresh(){
	$("#DataGrid").jqGrid('setGridParam',{url : 'RegCardControllerList.asp?search=false'}).trigger("reloadGrid");
}

function SearchRegCardSubmit(){
	var rowids,i;
	var rowidArr = $("#DataGrid").jqGrid("getGridParam", "selarrrow");
	rowids = "";
	for(i=0; i<rowidArr.length; i++){
		rowids=rowids+rowidArr[i]+",";
	}
	if(rowids != ""){
		rowids = rowids.substring(0,rowids.length-1);
	}
	
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();
	
	window.location.href="RegCardDetail.html?ControllerId=" + rowids+"&search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString)

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
