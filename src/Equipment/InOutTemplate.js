CheckLoginStatus();
//获取操作权限
var role = GetOperRole("InOutTemplate");
var iedit=false,iadd=false,idel=false,iview=false,irefresh=false,isearch=false;
try{
	iedit=role.edit;
	iadd=role.add;
	idel=role.del;
	iview=role.view;
	irefresh=role.refresh;
	isearch=role.search;
}
catch(exception) {
	alert(exception);
}

function FormatterOutput(cellvalue, options, rowObject)
{
	if(cellvalue == "0")
		return "";
	else
		return cellvalue;
}
function CheckOutputVal(value, colname) {
	if (value < 0) 
	   return [false,getlbl("con.OutputMin")];	//输出值不能小于0
	else if(value > 99999999)
		return [false,getlbl("con.OutputMax")];	//输出值不能大于99999999毫秒
	else
	   return [true,""];
}

$("#DataGrid").jqGrid({
	url:'InOutTemplateList.asp',
	editurl:"InOutTemplateEdit.asp",
	datatype: "json",
	//colNames:['TemplateId','输入/输出表名称'],
	colNames:['TemplateId',getlbl("con.InoutName")],
	colModel :[
		{name:'TemplateId',index:'TemplateId',width:10,hidden:true,editrules:{edithidden:false},search:false},
		{name:'TemplateName',index:'TemplateName',width:500,editable:true,editrules:{required:true},
			searchoptions:{sopt:["eq","ne",'cn','nc']},
			formoptions:{elmsuffix:"<font color=#FF0000>*</font>"}},
		], 
	caption:getlbl("con.InoutTemp"),//"输入/输出表模板",
	imgpath:'/images',
	rowNum:irowNum,
	rowList:[10,16,20,30],
	prmNames: {search: "_search"},  
	//jsonReader: { repeatitems: false },
	pager: '#pager',
	//sortname: 'RecordID',
	multiselect: true,
	multiboxonly: true,
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
			$("#DataGrid").jqGrid('clearGridData');
	}},
	subGrid: true,
	subGridRowExpanded: function(subgrid_id, row_id) {
		var subgrid_table_id, pager_id;
		subgrid_table_id = subgrid_id+"_t";
		pager_id = "p_"+subgrid_table_id;
		var lastEditiRow,lastEditiCol; //新增加行时，必须先取消编辑状态
		var rowIndex = new Array();//用于记录iRow
		$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
		$("#"+subgrid_table_id).jqGrid({
			url:"InOutTemplateDetailList.asp?TemplateId="+row_id,
			datatype: "json",
			//colNames:['RecordID','ControllerID','序号','说明','ScheduleID','时间表名称','一','二','三','四','五','OperType'],
			colNames:['RecordID','ControllerID',getlbl("con.SN"),getlbl("con.Explain"),'ScheduleID',getlbl("con.ScheduleName"),getlbl("con.Ouput1"),getlbl("con.Ouput2"),getlbl("con.Ouput3"),getlbl("con.Ouput4"),getlbl("con.Ouput5"),'OperType'],
			colModel :[
				{name:'RecordID',index:'RecordID',width:10,hidden:true,editrules:{edithidden:false}},
				{name:'ControllerID',index:'ControllerID',hidden:true,editrules:{edithidden:false}},  
				{name:'InoutPoint',index:'InoutPoint',sortable:false,width:60,editrules:{edithidden:false},editable:false},  
				{name:'InoutDesc',index:'InoutDesc',sortable:false,width:180,editable:true},
				{name:'ScheduleID',index:'ScheduleID',sortable:false,hidden:true,editrules:{edithidden:false}},  
				{name:'ScheduleName',index:'ScheduleName',sortable:false,width:180,editable:true},
				{name:'Out1',index:'Out1',sortable:false,width:70,editable:true,formatter:FormatterOutput,
					editrules:{integer:true,custom:true, custom_func:CheckOutputVal},},
				{name:'Out2',index:'Out2',sortable:false,width:70,editable:true,formatter:FormatterOutput,
					editrules:{integer:true,custom:true, custom_func:CheckOutputVal},},
				{name:'Out3',index:'Out3',sortable:false,width:70,editable:true,formatter:FormatterOutput,
					editrules:{integer:true,custom:true, custom_func:CheckOutputVal},},
				{name:'Out4',index:'Out4',sortable:false,width:70,editable:true,formatter:FormatterOutput,
					editrules:{integer:true,custom:true, custom_func:CheckOutputVal},},
				{name:'Out5',index:'Out5',sortable:false,width:70,editable:true,formatter:FormatterOutput,
					editrules:{integer:true,custom:true, custom_func:CheckOutputVal},},
				{name:'OperType',hidden:true},
				], 
			imgpath:'/images',
			rowNum:20,
			//rowList:[16,20,30],
			prmNames: {search: "_search"},  
			pager: pager_id,
			viewrecords: true,
			height: 'auto',
			width:910,
			forceFit:true, //调整列宽度不会改变表格的宽度
			hidegrid:false,//禁用控制表格显示、隐藏的按钮
			loadtext:strloadtext,
			toppager:true,
			cellsubmit: "clientArray",
			beforeEditCell: function(rowid,cellname,value,iRow,iCol) { 
				lastEditiRow = iRow;
				lastEditiCol = iCol;
			},
			afterEditCell: function(rowid,cellname,value,iRow,iCol) { 
				//InoutDesc(说明) 列仅序号1-5列可编辑
				if(cellname == "InoutDesc" && (iRow != 1 && iRow != 2 && iRow != 3 && iRow != 4 && iRow != 5)){
					$("#"+subgrid_table_id).saveCell(iRow, iCol);
				}
				//ScheduleName仅序号1-5及14-15可编辑，采用下拉框。该列的其它行不可编辑
				if(cellname == "ScheduleName" ){
					if(iRow != 1 && iRow != 2 && iRow != 3 && iRow != 4 && iRow != 5 && iRow != 14 && iRow != 15){
						$("#"+subgrid_table_id).saveCell(iRow, iCol);
					}
					else{
						$("#"+subgrid_table_id).saveCell(iRow, iCol);
						ShowScheduleNameSelect(iRow);
					}
				}
			},
			afterSaveCell: function(rowid,cellname,value,iRow,iCol) { 
				rowIndex[iRow] = rowid; //记录iRow与rowid关系，提交时会用到
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
			}},
			
		});
		$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager",{edit:false,add:false,del:false,search:false,refresh:false});
		
		var topPagerDiv = $("#"+subgrid_table_id + "_toppager")[0];         
		$("#"+subgrid_table_id + "_toppager_center", topPagerDiv).remove();
		$(".ui-paging-info", topPagerDiv).remove();
		$("#"+pager_id+"_center").remove();//去掉底部翻页按钮
		
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
				title:getlbl("con.SaveData"),	//"保存数据",
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
			//默认 提交和取消按钮不可用
			$("#"+subgrid_table_id+"_btnSubmit").addClass('ui-state-disabled'); 
			$("#"+subgrid_table_id+"_btnCancel").addClass('ui-state-disabled'); 
		}
		
		//合并表头
		$("#"+subgrid_table_id).jqGrid('setGroupHeaders', {  
			useColSpanStyle: true, //没有表头的列是否与表头列位置的空单元格合并  
			groupHeaders:[  
				{startColumnName: 'InoutDesc', numberOfColumns: 3, titleText: getlbl("con.InputFont"),align:'center'},	//输入
				{startColumnName: 'Out1', numberOfColumns: 5, titleText: getlbl("con.OutputFont")}	//输出(毫秒)
			]  
		}); 		

		//增加时间表选择下
		function ShowScheduleNameSelect(iRowNumber)
		{
			var strSelectScheduleID = subgrid_table_id+"_SelSchedule_"+iRowNumber;
			var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');
			var SelVal = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[iRowNumber-1]).ScheduleID;
		
			var htmlObj = $.ajax({url:"../Common/GetSchedule.asp?IsShowNULLSchedule=0&SelectID="+strSelectScheduleID,async:false});
			$("#"+subgrid_table_id).children().children().eq(iRowNumber).children().eq(5).html(htmlObj.responseText);
			$("#"+strSelectScheduleID).prepend("<option value='1'>"+getlbl("con.Schedule024")+"</option>"); 	//0 - 24H进出
			$("#"+strSelectScheduleID).prepend("<option value=''> </option>"); 	
		
			$("#"+strSelectScheduleID).css('width','180');
			$("#"+strSelectScheduleID).val(SelVal);
			$("#"+strSelectScheduleID).change(function(){
				$("#"+subgrid_table_id+"_btnSubmit").removeClass('ui-state-disabled'); 
				$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
			})
		}
		
		function subGridEdit(){
			$("#"+subgrid_table_id).resetSelection();  
			$("#"+subgrid_table_id).jqGrid('setGridParam',{cellEdit:true});
			var ids = $("#"+subgrid_table_id).jqGrid('getDataIDs'); 
			for(var i=0;i < ids.length;i++){ 
				var cl = ids[i]; 
				var inoutPoint= $("#"+subgrid_table_id).getCell(cl,"InoutPoint");
				$("#"+subgrid_table_id).jqGrid('setCell',cl,'Out1','','ui-jqGrid-cellEditing');
				$("#"+subgrid_table_id).jqGrid('setCell',cl,'Out2','','ui-jqGrid-cellEditing');
				$("#"+subgrid_table_id).jqGrid('setCell',cl,'Out3','','ui-jqGrid-cellEditing');
				$("#"+subgrid_table_id).jqGrid('setCell',cl,'Out4','','ui-jqGrid-cellEditing');
				$("#"+subgrid_table_id).jqGrid('setCell',cl,'Out5','','ui-jqGrid-cellEditing');
				if(inoutPoint>=1 && inoutPoint <= 5){
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'InoutDesc','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'ScheduleName','','ui-jqGrid-cellEditing');
				}
				if(inoutPoint>=14 && inoutPoint <= 15){
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'ScheduleName','','ui-jqGrid-cellEditing');
				}
			} 
			$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
		}
		
		function subGridSubmit(){
			//先保存正在编辑的单元格，否则会出问题
			if(lastEditiRow != 'undefined' && lastEditiCol != 'undefined'){
				$("#"+subgrid_table_id).saveCell(lastEditiRow, lastEditiCol);
			}
			var strEditData,strScheduleID;
			strEditData  = "";
			strScheduleID = "";
			//遍历所有行，查找有修改的行
			var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');  
			var len = rowIds.length;
			for(var i = 0; i < len; i++){
				var ret = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[i]);
				if(ret.OperType == "edit"){
					//alert(ret.WeekDay);
					strEditData += ret.RecordID+",,"+ret.InoutPoint+",,"+ret.InoutDesc.trim()+",,";
					strEditData += ret.Out1.trim()+",,"+ret.Out2.trim()+",,"+ret.Out3.trim()+",,"+ret.Out4.trim()+",,"+ret.Out5.trim()+"||";
				}
				//获取时间表。。若没有出现下拉框，则将传递undefined字符串到后台，后台处理时需注意
				var Inoutp = i+1;
				if((Inoutp >= 1 && Inoutp <= 5) || (Inoutp >= 14 && Inoutp <= 15)){
					if(ret.InoutPoint == Inoutp){
						var ScheduleID = $("#"+subgrid_table_id+"_SelSchedule_"+Inoutp).val();
						var ScheduleText = $("#"+subgrid_table_id+"_SelSchedule_"+Inoutp).find("option:selected").text();
						if(ScheduleID == undefined){
							//ScheduleID = "undefined";
							//ScheduleText = "undefined";
							ScheduleID = ret.ScheduleID;
							ScheduleText = ret.ScheduleName;
							if(ScheduleID == 0)
								ScheduleText="";
						}
						strScheduleID += ret.RecordID+",,"+ret.InoutPoint+",,"+ScheduleID+",,"+ScheduleText+"||";
					}
				}
				//常开常闭必须选择时间表
				if(ret.InoutPoint == 14 || ret.InoutPoint == 15){
					if(ret.Out1.trim() != "" || ret.Out2.trim() != "" || ret.Out3.trim() != "" || ret.Out4.trim() != "" || ret.Out5.trim() != "" ){
						var ScheduleID = $("#"+subgrid_table_id+"_SelSchedule_"+ret.InoutPoint).val();
						if(ScheduleID == undefined){
							ScheduleID = ret.ScheduleID;
						}
						if(ScheduleID == 0 || ScheduleID.trim() == ""){
							alert("["+ret.InoutDesc+"]" + getlbl("con.MustSelSchedule"));//"必须选择时间表"
							return false;
						}
					}
				}
			}
			if(strEditData != ""){
				strEditData = strEditData.substring(0,strEditData.length-2);
			}
			if(strScheduleID != ""){
				strScheduleID = strScheduleID.substring(0,strScheduleID.length-2);
			}
			$.ajax({
				type: 'Post',
				url: 'InOutTemplateDetailEdit.asp',
				data:{"TemplateId":row_id,"strScheduleID":strScheduleID,"strEdit":strEditData},
				success: function(data) {
					try  {
						var responseMsg = $.parseJSON(data);
						if(responseMsg.success == false){
							alert(responseMsg.message);
						}else if(responseMsg.success == true){
							//保存成功后，清空参数，按钮置为禁用
							strEditData = "";
							$("#"+subgrid_table_id+"_btnSubmit").addClass('ui-state-disabled'); 
							$("#"+subgrid_table_id+"_btnCancel").addClass('ui-state-disabled'); 
							$("#"+subgrid_table_id).jqGrid('setGridParam',{cellEdit:false});
							$("#"+subgrid_table_id).trigger("reloadGrid");
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


	},
	subGridRowColapsed: function(subgrid_id, row_id) {
		// this function is called before removing the data
		//var subgrid_table_id;
		//subgrid_table_id = subgrid_id+"_t";
		//$("#"+subgrid_table_id).remove();
	},
});

$("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:iedit,add:iadd,del:idel,view:false,refresh:irefresh,search:isearch,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
		top:0,
		reloadAfterSubmit :true,
		closeAfterEdit: true,
		afterSubmit:getEditafterSubmit,
		//selarrrow
	},  //  default settings for edit
	{
		top:0,
		reloadAfterSubmit :true,
		afterSubmit:getAddafterSubmit
	},  //  default settings for add
	{
		top:0,
		reloadAfterSubmit :true,
		afterSubmit:getDelafterSubmit
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,caption:strsearchcaption,top:60} ,// search options
	{top:0,}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css("width","1%");
$("#DataGrid_toppager_left").css("width","99%");

function AutoSyncData(templateId){

	var obj = {
		resizable: false,
		height:140,
		modal: true,
		buttons : {},
	};
	var yes = getlbl("con.Yes");
	var no = getlbl("con.No");
	obj.buttons[yes] = function(){
		$( this ).dialog( "close" );
		SyncData(templateId);
	}
	obj.buttons[no] = function(){
		$( this ).dialog( "close" );
	}
	$( "#dialog-confirm" ).dialog(obj);
};

function SyncData(templateId){
	$.ajax({
		type: 'Post',
		url: 'SyncData.asp?type=schedule',
		data:{"ControllerId":'',"TemplateId":templateId},
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					alert(responseMsg.message);
				}else if(responseMsg.success == true){
					//成功
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
