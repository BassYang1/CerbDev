var strControllerId;
var strUrl;

$(document).ready(function(){
CheckLoginStatus();  
//获取操作权限
var role = GetOperRole("RegCardDetail");
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

var strsearch,strsearchField,strsearchOper,strsearchString;
strControllerId = Request( location.href,"ControllerId");
strsearch=Request( location.href,"search");
strsearchField=Request( location.href,"searchField");
strsearchOper=Request( location.href,"searchOper");
strsearchString=Request( location.href,"searchString");
//&search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+strsearchString
strUrl = 'RegCardDetailList.asp?ControllerId='+strControllerId;

if(strsearch == "true"){
	strUrl = strUrl+"&search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+strsearchString
}


jQuery("#DataGrid").jqGrid({
	url:strUrl,
	datatype: "json",
	//colNames:['RecordID','设备编号','部门','姓名','工号','卡号','验证方式','时间表','进出门','有照片','有指纹','同步状态','EmployeeID','ControllerID1'],
	colNames:['RecordID',getlbl("con.ControllerIdNum"),getlbl("hr.Dept"),getlbl("hr.Name"),getlbl("hr.Num"),getlbl("hr.Card"),getlbl("con.ValidateMode"),getlbl("con.Schedule"),getlbl("con.InOutDoor"),getlbl("con.HavePhoto"),getlbl("con.HaveFP"),getlbl("con.SyncStatus"),'EmployeeID','ControllerID1'],
	colModel :[
		{name:'RecordID',index:'RecordID',hidden:true,viewable:false,editrules:{edithidden:false},search:false},
		{name:'ControllerID',index:'ControllerID',align:'center',search:false,stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},},
		{name:'DepartmentID',index:'DepartmentID',align:'center',editable:false,
			stype:"select", searchoptions:{ dataUrl:"../Common/GetDepartment.asp",sopt:["eq","ne"],},},  
		{name:'Name',index:'Name',align:'center',editable:false,
			searchoptions:{sopt:["eq","ne",'cn','nc']},},
		{name:'Number',index:'Number',align:'center',editable:false,
			searchoptions:{sopt:["eq","ne",'cn','nc']}},
		{name:'Card',index:'Card',align:'center',editable:false,
			searchoptions:{sopt:["eq","ne",'lt','le','gt','ge']},}, 
		{name:'ValidateMode',index:'ValidateMode',search:false,align:'center',editable:false,
			formatter:function(cellvalue, options, rowObject){
				return cellvalue.substring(cellvalue.indexOf("-")+1,cellvalue.length);
			},
		}, 
		{name:'ScheduleCode',index:'ScheduleCode',search:false,align:'center',editable:false,}, 
		{name:'EmployeeDoor',index:'EmployeeDoor',search:false,align:'center',editable:false,
			formatter:function(cellvalue, options, rowObject){
				return cellvalue.substring(cellvalue.indexOf("-")+1,cellvalue.length);
			},
		}, 
		{name:'IsPhoto',index:'IsPhoto',width:100,align:'center',search:false,editable:false,sortable:false,}, 
		{name:'IsFingerPrint',index:'IsFingerPrint',width:150,align:'center',search:false,editable:false,sortable:false,}, 
		{name:'SyncStatus',index:'SyncStatus',width:120,align:'center',search:false,viewable:false,editable:false,sortable:false,
			formatter:function(cellvalue, options, rowObject){
				if(cellvalue == "True" || cellvalue == "true" || cellvalue == "1")
					return getlbl("con.Synced");//"已同步";
				else
					return getlbl("con.Unsync");//"未同步";
			},
		},
		{name:'EmployeeID',index:'EmployeeID',hidden:true,viewable:false,editrules:{edithidden:false},search:false},
		{name:'ControllerID1',index:'ControllerID1',hidden:true,viewable:false,editrules:{edithidden:false},search:false},
		], 
	caption:getlbl("con.RegCardDetail"),//"注册卡号明细",
	imgpath:'/images',
	multiselect: false,
	rowNum:20,
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
			//GetSyncStatus();
		}
	},
});

jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:iedit,add:iadd,del:idel,view:false,refresh:false,search:false,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
		addfunc:function(){
			AddRegCard();
		},
		editfunc:function(id){
			EditRegCard();
		},
		delfunc:function(id){
			DelRegCard();
		},
	}, 
	{
		//selarrrow
	},  //  default settings for edit
	{
		
	},  //  default settings for add
	{
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,caption:strsearchcaption,top:60} ,// search options
	{
		top:0,width:700,viewPagerButtons:false,drag:true,resize:true,
	}	//view parameters
);


	var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
	$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
	$(".ui-paging-info", topPagerDiv).remove();
	$("#DataGrid_toppager_right").css("width","1%");
	$("#DataGrid_toppager_left").css("width","99%");
	if(isync){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("con.SyncToCon"),//"同步到设备",
			buttonicon:"ui-icon-transferthick-e-w",
			title:getlbl("con.SyncRegCardTitle"),//"将注册卡号数据同步到设备",
			id:"DataGrid_btnSync",
			onClickButton: SyncData,
			position:"last"
		});
	}
	if(isearch){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("hr.Search"),//"查找",
			buttonicon:"ui-icon-search",
			title:getlbl("hr.Search"),//"查找",
			id:"DataGrid_btnSearch",
			onClickButton: Search,
			position:"last"
		});
	}
	if(iview){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("hr.Refresh"),//"刷新",
			buttonicon:"ui-icon-refresh",
			title:getlbl("hr.Refresh"),//"刷新",
			id:"DataGrid_btnrefresh",
			onClickButton: Refresh,
			position:"last"
		});
	}
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
}); 

function AddRegCard(){
	$("#dialog-confirm").html("<p><span class='ui-icon ui-icon-alert' style='float:left; margin:0 7px 20px 0;'></span>"+getlbl("con.Moment")+"</p>");
	$("#dialog-confirm").load("RegCard.asp?nd="+getRandom()+"&EmployeeID=&ControllerID="+strControllerId);
	var SubmitVal = getlbl("con.Submit");
	var CancelVal = getlbl("con.Cancel");
	
	$("#dialog-confirm").dialog({
		//resizable: true,
		minWidth:880,
		minHeight:100,
		//height:'auto',
		//width:'auto',
		modal: false,
		position:[10,10],
		buttons: {
			SubmitVal: function() {	//"提交"
				var t = RegCardSubmit();
				if(t == true || t == "true"){
					$("#DataGrid").trigger("reloadGrid");
					$( this ).dialog( "close" );
				}
			},
			CancelVal: function() {		//"取消"
				$( this ).dialog( "close" );
				//RegCardReset();
			}
		}
	});
}

function EditRegCard(){
	var rowids,i;
	var Conids;
	var rowidArr = $("#DataGrid").jqGrid("getGridParam", "selarrrow");
	rowids = "";
	Conids = "";
	for(i=0; i<rowidArr.length; i++){
		var ret = $("#DataGrid").jqGrid('getRowData',rowidArr[i]);
		if(rowids.indexOf(ret.EmployeeID) < 0 )
		{
			rowids=rowids+ret.EmployeeID+",";
		}
		if(Conids.indexOf(ret.ControllerID1) < 0 )
		{
			Conids=Conids+ret.ControllerID1+",";
		}
	}
	if(rowids != ""){
		rowids = rowids.substring(0,rowids.length-1);
	}
	if(Conids != ""){
		Conids = Conids.substring(0,Conids.length-1);
	}
	$("#dialog-confirm").html("<p><span class='ui-icon ui-icon-alert' style='float:left; margin:0 7px 20px 0;'></span>"+getlbl("con.Moment")+"</p>");
	$("#dialog-confirm").load("RegCard.asp?nd="+getRandom()+"&EmployeeID="+rowids+"&ControllerID="+Conids);

	var obj = {
		//resizable: true,
		minWidth:880,
		minHeight:100,
		//height:'auto',
		//width:'auto',
		modal: false,
		position:[10,10],
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


function DelRegCard(){
	var rowids,i;
	var Conids;
	var rowidArr = $("#DataGrid").jqGrid("getGridParam", "selarrrow");
	if(rowidArr == "" || rowidArr.length <= 0){
		//alert("请选择需要操作的数据行!");
		alert(getlbl("con.SelRowNull"));
		return;
	}
	Conids = "";
	rowids = "";
	for(i=0; i<rowidArr.length; i++){
		var ret = $("#DataGrid").jqGrid('getRowData',rowidArr[i]);
		rowids=rowids+rowidArr[i]+",";
		if(Conids.indexOf(ret.ControllerID1) < 0 )
		{
			Conids=Conids+ret.ControllerID1+",";
		}
	}
	if(rowids != ""){
		rowids = rowids.substring(0,rowids.length-1);
	}
	if(Conids != ""){
		Conids = Conids.substring(0,Conids.length-1);
	}

	var obj = {
		minWidth:120,
		minHeight:60,
		modal: false,
		position:[10,10],
		buttons : {},
	};
	var Del = getlbl("hr.Del");
	var Cancel = getlbl("con.Cancel");
	obj.buttons[Del] = function(){
		$( this ).dialog( "close" );
		$.ajax({
			type: 'Post',
			url: 'RegcardEdit.asp',
			data:{'oper':'del','RecordID':rowids,'Convalues':Conids},
			async:false,
			success: function(data) {
				try  {
					var responseMsg = $.parseJSON(data);
					if(responseMsg.success == false){
						alert(responseMsg.message);
					}else if(responseMsg.success == true){
						//成功
						$("#DataGrid").trigger("reloadGrid");
						
					}else{
						alert("exception");
					}
				}
				catch(exception) {
					alert(exception+"," + data);
				}
			},
			error:function(XmlHttpRequest,textStatus, errorThrown){
				alert(textStatus+XmlHttpRequest.responseText);
			}
		});
				
	}
	obj.buttons[Cancel] = function(){
		$( this ).dialog( "close" );
	}
	$( "#dialog-confirm-del" ).dialog(obj);

}

function SyncData(){
	var rowids,i;
	var Conids;
	var rowidArr = $("#DataGrid").jqGrid("getGridParam", "selarrrow");
	if(rowidArr == "" || rowidArr.length <= 0){
		//alert("请选择需要操作的数据行!");
		alert(getlbl("con.SelRowNull"));
		return;
	}
	rowids = "";
	Conids = "";
	for(i=0; i<rowidArr.length; i++){
		var ret = $("#DataGrid").jqGrid('getRowData',rowidArr[i]);
		rowids=rowids+rowidArr[i]+",";
		if(Conids.indexOf(ret.ControllerID1) < 0 )
		{
			Conids=Conids+ret.ControllerID1+",";
		}
	}
	if(rowids != ""){
		rowids = rowids.substring(0,rowids.length-1);
	}
	if(Conids != ""){
		Conids = Conids.substring(0,Conids.length-1);
	}
	$.ajax({
		type: 'Post',
		url: 'SyncData.asp?type=register&syncOpt=part',
		data:{"RecordID":rowids,"ControllerId":Conids},
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					alert(responseMsg.message);
				}else if(responseMsg.success == true){
					//这里与其它页面不同，同步后刷新本页
					$("#DataGrid").trigger("reloadGrid");
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
}

function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=registerdetail");
	$("#divExport").show();
}
function Search(){
	$("#divSearch").load("search.asp?submitfun=SearchRegCardSubmit()");
	$("#divSearch").show();
}

function Refresh(){
	$("#DataGrid").jqGrid('setGridParam',{url : strUrl}).trigger("reloadGrid");
}

function SearchRegCardSubmit(){
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();
	//保存查找的条件，以便点刷新后都是查找后的内容
	strUrl = "RegCardDetailList.asp?ControllerId="+strControllerId+"&search=true&searchField="+strsearchField+"&searchOper="+strsearchOper+"&searchString="+encodeURI(strsearchString);
	$("#DataGrid").jqGrid('setGridParam',{url : strUrl}).trigger("reloadGrid");
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
