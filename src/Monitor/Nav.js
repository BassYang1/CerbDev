$(document).ready(function(){
CheckLoginStatus();  
jQuery("#DataGrid").jqGrid({
		url:'NavList.asp',
		editurl:"",
		datatype: "json",
		//colNames:['设备ID',"设备",
		colNames:[getlbl("con.ControllerId"),getlbl("mon.AllCon"),''],
		colModel :[
			{name:'ControllerId',index:'ControllerId',width:120,align:'center',viewable:true,hidden:true,formoptions:{rowpos:1,colpos:1},stype:"text", searchoptions:{ sopt:["eq","ne"]},},
			{name:'ControllerNumber',index:'ControllerNumber',width:102,align:'center',editable:true,editrules:{required:true},
				stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},sortable:false}, 
			{name:'ConnStatus',index:'ConnStatus',width:18,align:'center',editable:true,sortable:false}, 
			], 
		caption:getlbl("mon.AllCon"),//所有设备
		imgpath:'/images',
		multiselect: false,
		rowNum:5000,
		//rowList:[10,16,20,30],
		prmNames: {search: "_search"},  
		//jsonReader: { repeatitems: false },
		pager: '#pager',
		//sortname: 'RecordID',
		multiselect: true,
        multiboxonly: true,
		viewrecords: true,
		sortorder: "asc",
		height: 'auto',
		width:'auto',
		forceFit:true, //调整列宽度不会改变表格的宽度
		hidegrid:false,//禁用控制表格显示、隐藏的按钮
		loadtext:strloadtext,
		toppager:true,
		loadComplete:function(data){ //完成服务器请求后，回调函数 
			if(data == null || data.records==0){ 
				jQuery("#DataGrid").jqGrid('clearGridData');
			}else{
				GetConnStatus();
			}
		}
});



var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager").hide();
$("#pager_center").hide();
$("#pager_left").hide();
$("#DataGrid_toppager_right").css("width","1%");
$("#DataGrid_toppager_left").css("width","99%");
$("#gview_DataGrid").children().eq(3).css("overflow","auto").css("height","500px");
//
setInterval("GetConnStatus();",20000);//自动刷新状态
}); 

function GetConnStatus(){
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
		url: '../Equipment/GetConnStatus.asp',
		data:{"ControllerId":Ids},
		success: function(data) {
			try  {
				if(data != null || data != ""){
					eval(data);
					//$("#DataGrid").setRowData( Arr[0][1], { SyncStatus:"未同步"}); 
					for(var i=0; i<Arr[1].length; i++)
					{
						if(Arr[1][i] == "1"){
							$("#DataGrid").setRowData( Arr[0][i], { ConnStatus:"<span><img src=../images/conned.gif></span>"}); 
						}
						else{
							$("#DataGrid").setRowData( Arr[0][i], { ConnStatus:"<span><img src=../images/unconn.gif></span>"}); 
						}
					}
				}
			}
			catch(exception) {
				//alert(exception+"," + data);
			}
		},
		error:function(XmlHttpRequest,textStatus, errorThrown){
			//alert(textStatus+":ExportData.asp,"+XmlHttpRequest.responseText);
		}
	});		
}

function ReSize(){
	var iWidth = $(window).width()-40;
	var iHeight = $(window).height()-85;
	$("#gview_DataGrid").children().eq(3).css("overflow","auto").css("height",iHeight);
}

$(window).resize(function(){
   ReSize();
});

$(function(){
	ReSize();
});