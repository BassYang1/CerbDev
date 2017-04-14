
$(document).ready(function(){
CheckLoginStatus();  
//获取操作权限
var role = GetOperRole("ScheduleController");
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
	url:'ScheduleControllerList.asp',
	datatype: "json",
	//colNames:['设备ID','设备编号','设备名称','位置','设备IP','工作类型','服务器','同步状态'],
	colNames:[getlbl("con.ControllerId"),getlbl("con.ControllerIdNum"),getlbl("con.ControllerIdName"),getlbl("con.Location"),getlbl("con.IP"),getlbl("con.WorkType"),getlbl("con.ServerIP"),getlbl("con.SyncStatus")],
	colModel :[
		{name:'ControllerId',index:'ControllerId',width:120,align:'center',viewable:true,formoptions:{rowpos:1,colpos:1},stype:"text", searchoptions:{ sopt:["eq","ne"]},},
		{name:'ControllerNumber',index:'ControllerNumber',align:'center',stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},},
		{name:'ControllerName',index:'ControllerName',align:'center',stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},}, 
		{name:'Location',index:'Location',align:'center',stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},},
		{name:'IP',index:'IP',align:'center',search:false,stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},},
		{name:'WorkType',index:'WorkType',align:'center',search:false,width:260,},
		{name:'ServerIP',index:'ServerIP',align:'center',stype:"text", searchoptions:{ sopt:["eq","ne"]},},
		{name:'SyncStatus',index:'SyncStatus',width:100,align:'center',search:false,formoptions:{rowpos:14,colpos:1},viewable:false,editable:false,sortable:false,},
		], 
	caption:getlbl("con.ConSchedule"),//"设备时间表",
	imgpath:'/images',
	multiselect: false,
	rowNum:irowNum,
	rowList:[10,16,20,30],
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
	subGrid: true,
	subGridRowExpanded: function(subgrid_id, row_id) {
		var subgrid_table_id, pager_id;
		subgrid_table_id = subgrid_id+"_t";
		pager_id = "p_"+subgrid_table_id;
		var lastEditiRow,lastEditiCol; //新增加行时，必须先取消编辑状态
		//alert(subgrid_table_id);
		//alert(pager_id);
		$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
		$("#"+subgrid_table_id).jqGrid({
			url:"ScheduleControllerDetailList.asp?ControllerId="+row_id,
			datatype: "json",
			//colNames:['序号','TemplateId','时间表名称','OperType'],
			colNames:[getlbl("con.SN"),'TemplateId',getlbl("con.ScheduleName"),'OperType'],
			colModel :[
				{name:'ScheduleCode',index:'ScheduleCode',width:40,editrules:{edithidden:false},search:false,sortable:false},  
				{name:'TemplateId',index:'TemplateId',width:60,hidden:true,editrules:{edithidden:false},search:false},  
				{name:'TemplateName',index:'TemplateName',editable:true,editrules:{edithidden:false},search:false,sortable:false},  
				{name:'OperType',hidden:true},
				],  
			rowNum:50,
			rowList:[20,50,100,1000,10000],
			pager: pager_id,
			sortname: 'ScheduleCode',
			sortorder: "asc",
			multiselect: false,
			multiboxonly: false,
			viewrecords: true,
			height: 'auto',
			width:650,
			forceFit:true, //调整列宽度不会改变表格的宽度
			hidegrid:false,//禁用控制表格显示、隐藏的按钮
			loadtext:strloadtext,
			toppager:true,
			cellsubmit: "clientArray",
			beforeEditCell: function(rowid,cellname,value,iRow,iCol) { 
				lastEditiRow = iRow;
				lastEditiCol = iCol;
				//alert('beforeSubmitCell: ' + cellname);
			},
			afterEditCell: function(rowid,cellname,value,iRow,iCol) { 
					//alert("rowid="+rowid+","+"cellname="+cellname+",value="+value+",iRow="+iRow+",iCol="+iCol);
					//序号1为默认的0-24小时时间表，不可以修改
					if(rowid != 1){
						$("#"+subgrid_table_id).saveCell(iRow, iCol);
						ShowScheduleSelect(rowid);
					}
					else{
						$("#"+subgrid_table_id).saveCell(iRow, iCol);	
					}
				},
			afterSaveCell: function(rowid,cellname,value,iRow,iCol) { 
				var ret = $("#"+subgrid_table_id).jqGrid('getRowData',rowid);
				if(ret.OperType == ""){
					$("#"+subgrid_table_id).jqGrid('setRowData',rowid,{OperType:"edit"});
				}
				$("#"+subgrid_table_id+"_btnSubmit").removeClass('ui-state-disabled'); 
				$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
			},
			loadComplete:function(data){ //完成服务器请求后，回调函数 
				if(data == null || data.records==0){ 
					$("#"+subgrid_table_id).jqGrid('clearGridData');
				}
				var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');  
				var iUse = 0;
				for(var i = 0; i < rowIds.length; i++){
					var ret = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[i]);
					if(ret.TemplateId != "" && ret.TemplateId != "0"){
						iUse ++ ;
					}
					if(iUse >=14)
						break;
				}
				//时间表使用超过14个的，则允许用户再继续增加。
				if(iUse >=14){
					$("#"+subgrid_table_id+"_btnAdd").removeClass('ui-state-disabled'); 
				}else{
					$("#"+subgrid_table_id+"_btnAdd").addClass('ui-state-disabled'); 
				}
			},
		});
		$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager",{edit:false,add:false,del:false,search:false,refresh:false});
		
		var topPagerDiv = $("#"+subgrid_table_id + "_toppager")[0];         
		$("#"+subgrid_table_id + "_toppager_center", topPagerDiv).remove();
		$(".ui-paging-info", topPagerDiv).remove();
		//$("#"+pager_id+"_center").remove();//去掉底部翻页按钮
		$("#"+subgrid_table_id + "_toppager_left").css("width","95%");
		
		if(iedit){
			//DataGrid_1_t_toppager   DataGrid_1_t_toppager_right
			$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
				caption:getlbl("con.Edit"),	//"修改",
				buttonicon:"ui-icon-pencil",
				title:getlbl("con.EditTitle"),//"修改单元格，颜色改变的单元格为可编辑，点击可进入编辑状态",
				id:subgrid_table_id+"_btnEdit",
				onClickButton: subGridEdit,
				position:"first"
			});
						
			$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
				caption:getlbl("con.Submit"),	//"提交",
				buttonicon:"ui-icon-disk",
				title:getlbl("con.SubmitTitle"),	//"保存数据，且自动同步到设备",
				id:subgrid_table_id+"_btnSubmit",
				onClickButton: subGridSubmit,
				//position:"first"
			});
			$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
				caption:getlbl("con.Cancel"),	//"取消",
				buttonicon:"ui-icon-cancel",
				title:getlbl("con.CancelTitle"),	//"取消保存",
				id:subgrid_table_id+"_btnCancel",
				onClickButton: subGridCancel,
				position:"last"
			});
			
			$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
				caption:getlbl("con.Add"),	//"增加",
				buttonicon:"ui-icon-plus",
				title:getlbl("con.AddTitle"),//"添加新记录",
				id:subgrid_table_id+"_btnAdd",
				onClickButton: subGridAdd,
				position:"last"
			});
			//默认 提交和取消按钮不可用
			$("#"+subgrid_table_id+"_btnSubmit").addClass('ui-state-disabled'); 
			$("#"+subgrid_table_id+"_btnCancel").addClass('ui-state-disabled'); 
			//增加按钮默认不可使用，在前面判断使用的时间表是否有超过14个。
			$("#"+subgrid_table_id+"_btnAdd").addClass('ui-state-disabled'); 
		}
		
		//增加时间表下拉框
		function ShowScheduleSelect(ScheduleCode)
		{
			var SelectScheduleID = subgrid_table_id+"_SelSchedule_"+ScheduleCode;
			
			var htmlObj = $.ajax({url:"../Common/GetSchedule.asp?type=all&IsShowNULLSchedule=1&SelectID="+SelectScheduleID,async:false});
			//$("#"+subgrid_table_id).children().children().eq(ScheduleCode).children().eq(2).html(htmlObj.responseText);
			//20150722 改为以下方法：
			$("#"+subgrid_table_id + " tr[id='"+ScheduleCode+"']").children().eq(2).html(htmlObj.responseText);
			
			var SelVal = $("#"+subgrid_table_id).jqGrid("getRowData",ScheduleCode).TemplateId;
			$("#"+SelectScheduleID).val(SelVal);
			/*
			var count=$("#"+SelectScheduleID+" option").length;
			for(var i=0;i<count;i++){
				if($("#"+SelectScheduleID).get(0).options[i].value == SelVal){  
					$("#"+SelectScheduleID).get(0).options[i].selected = true;  
					break;  
				}  
			}*/
			$("#"+SelectScheduleID).change(function(){
				//alert($("#"+SelectScheduleID).val());
				$("#"+subgrid_table_id).setRowData( ScheduleCode, { TemplateId:$("#"+SelectScheduleID).val()}); 
				$("#"+subgrid_table_id+"_btnSubmit").removeClass('ui-state-disabled'); 
				$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
			})
		}
		
		//保存添加行的id编号
		var newrowids = new Array() ;
		function subGridAdd(){
			//先保存正在编辑的单元格，否则会出问题
			if(lastEditiRow != 'undefined' && lastEditiCol != 'undefined'){
				$("#"+subgrid_table_id).saveCell(lastEditiRow, lastEditiCol);
			}
			var selectedId = $("#"+subgrid_table_id).jqGrid("getGridParam", "selrow"); 
			var selectedId2 = $("#"+subgrid_table_id).jqGrid("getGridParam", "selCol"); 
			//获得jqgrid所有行号  
			var ids = $("#"+subgrid_table_id).jqGrid('getDataIDs');  
			
			//获得第一行的role  
			var $firstTrRole = $("#"+subgrid_table_id).find("tr").eq(1).attr("role");  
			//如果jqgrid中没有数据 定义最大行号为0 ，否则取当前最大行号  
			var rowid = $firstTrRole == "row" ? Math.max.apply(Math,ids):0;  
			//获得新添加行的行号（数据编号）  
			var newrowid = parseInt(rowid)+1;  
			//20150416 从数据库中获取一次最大ID，以避免有超过一页时，直接从当前页面取值可能不正确
			var htmlObj = $.ajax({url:"GetControllerScheduleMaxScheduleCode.asp?ControllerId="+row_id+"&nd="+getRandom(),async:false});
			var newrowidDb = htmlObj.responseText;
			if(newrowidDb == 'undefined' ){
				newrowidDb = 1;
			}
			else{
				newrowidDb = parseInt(newrowidDb);
			}
			//这里不能以数据库中最大ID计算，因为可能增加了多行而未提交到数据库
			newrowid = newrowidDb>newrowid ? newrowidDb:newrowid;
			
			newrowids[newrowids.length]= newrowid ;  
			var dataRow = {  
				ScheduleCode: newrowid,
				TemplateId: "",
				TemplateName: "",
				OperType:"add"
			};   
			$("#"+subgrid_table_id).jqGrid("addRowData", newrowid, dataRow, "first");      
			subGridEdit();  
		} ;
			
		function subGridEdit(){
			$("#"+subgrid_table_id).resetSelection();  
			$("#"+subgrid_table_id).jqGrid('setGridParam',{cellEdit:true});
			var ids = $("#"+subgrid_table_id).jqGrid('getDataIDs'); 
			for(var i=0;i < ids.length;i++){ 
				var cl = ids[i]; 
				var scheduleCode= $("#"+subgrid_table_id).getCell(cl,"ScheduleCode");
				if(scheduleCode != 1){
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'TemplateName','','ui-jqGrid-cellEditing');
				}
			} 
			$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
		}
		
		function subGridSubmit(){
			//先保存正在编辑的单元格，否则会出问题
			if(lastEditiRow != 'undefined' && lastEditiCol != 'undefined'){
				$("#"+subgrid_table_id).saveCell(lastEditiRow, lastEditiCol);
			}
			var strEditData,strTempName,strAddData;
			strEditData  = "";
			strTempName = "";
			strAddData = "";
			//遍历所有行，查找下拉框存在的
			var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');  
			var len = rowIds.length;
			for(var i = 0; i < len; i++){
				var ret = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[i]);
				var SelectScheduleID = subgrid_table_id+"_SelSchedule_"+rowIds[i];
				var TemplateId = $("#"+SelectScheduleID).val();
				var TemplateName = "";
				//下拉框存在
				if($("#"+SelectScheduleID).length>0)
				{
					//这里存在下拉框，但TemplateId仍为NULL，表示下拉框没有选择任何值，需特殊处理。否则在后面从jqGrid取HTML值会有问题
					if(TemplateId == undefined){
						TemplateId=0;
						TemplateName="";
					}else{
						TemplateName=$("#"+SelectScheduleID).find("option:selected").text();
					}
				}
				if(ret.OperType == "add"){
					if(TemplateId != undefined){
						//提交的字段顺序 ScheduleCode,TemplateId,TemplateName 
						strAddData += rowIds[i]+",,"+TemplateId+",,"+TemplateName+"||";
					}
				}else{
					if(TemplateId != undefined){
						//提交的字段顺序 ScheduleCode,TemplateId,TemplateName 
						strEditData += rowIds[i]+",,"+TemplateId+",,"+TemplateName+"||";
					}
					else{
						//没有修改过的数据，如果不为空，也重新提交到后台，主要目的是判断是否选择有重复
						var row = $("#"+subgrid_table_id).jqGrid("getRowData",rowIds[i]);
						if(row.TemplateName != ""){
							//提交的字段顺序 ScheduleCode,TemplateId,TemplateName 
							strEditData += rowIds[i]+",,"+row.TemplateId+",,"+row.TemplateName+"||";
						}
					}
				}
			}
			if(strEditData != ""){
				strEditData = strEditData.substring(0,strEditData.length-2);
			}
			if(strAddData != ""){
				strAddData = strAddData.substring(0,strAddData.length-2);
			}
				
			$.ajax({
				type: 'Post',
				url: 'ScheduleControllerEdit.asp',
				data:{"ControllerID":row_id,"strEdit":strEditData,"strAdd":strAddData},
				success: function(data) {
					try  {
						var responseMsg = $.parseJSON(data);
						if(responseMsg.success == false){
							alert(responseMsg.message);
						}else if(responseMsg.success == true){
							//保存成功后，清空参数，按钮置为禁用
							strEditData = "";
							strAddData = "";
							$("#"+subgrid_table_id+"_btnSubmit").addClass('ui-state-disabled'); 
							$("#"+subgrid_table_id+"_btnCancel").addClass('ui-state-disabled'); 
							$("#"+subgrid_table_id).jqGrid('setGridParam',{cellEdit:false});
							$("#"+subgrid_table_id).trigger("reloadGrid");
							GetSyncStatus(); //立即获取同步状态图标
						}else{
							//alert("保存数据异常");
							alert(getlbl("con.SaveEx"));
						}
					}
					catch(exception) {
						alert(exception);
					}
				}
			});
		};
		function subGridCancel(){
			strEditData = "";
			$("#"+subgrid_table_id+"_btnSubmit").addClass('ui-state-disabled'); 
			$("#"+subgrid_table_id+"_btnCancel").addClass('ui-state-disabled'); 
			$("#"+subgrid_table_id).jqGrid('setGridParam',{cellEdit:false});
			$("#"+subgrid_table_id).trigger("reloadGrid");
		};
			
	}
});

jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:false,add:false,del:false,view:false,refresh:irefresh,search:isearch,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
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
	
	if(isync){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("con.SyncToCon"),//"同步到设备",
			buttonicon:"ui-icon-transferthick-e-w",
			title:getlbl("con.SyncScheduleTitle"),//"将时间表数据同步到设备",
			id:"DataGrid_btnSync",
			onClickButton: SyncData,
			position:"first"
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

setInterval("GetSyncStatus();",5000);//自动刷新状态
}); 



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
		url: 'GetSyncStatus.asp?type=schedule',
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
				//alert(exception+"," + data);
			}
		},
		error:function(XmlHttpRequest,textStatus, errorThrown){
			//alert(textStatus+":ExportData.asp,"+XmlHttpRequest.responseText);
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
	$.ajax({
		type: 'Post',
		url: 'SyncData.asp?type=schedule',
		data:{"ControllerId":rowids},
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					alert(responseMsg.message);
				}else if(responseMsg.success == true){
					//成功
					//$("#DataGrid").trigger("reloadGrid");
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
			alert(textStatus+XmlHttpRequest.responseText);
		}
	});
}
function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=schedule");
	$("#divExport").show();
}

$(function(){
	$("#DataGrid").setGridWidth($(window).width()-20);　 
	$(window).resize(function(){　　
		$("#DataGrid").setGridWidth($(window).width()-20);
	});　　
});
