$(document).ready(function(){
CheckLoginStatus();  
//获取操作权限
var role = GetOperRole("InOutController");
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

function GetTime(){
	WdatePicker({isShowClear:true,dateFmt:'HH:mm',isShowToday:false,qsEnabled:false});
};
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

jQuery("#DataGrid").jqGrid({
	url:'InOutControllerList.asp',
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
	caption:getlbl("con.ConInout"),//"设备输入输出表",
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
	subGrid: true,
	subGridRowExpanded: function(subgrid_id, row_id) {
		var subgrid_table_id, pager_id;
		subgrid_table_id = subgrid_id+"_t";
		pager_id = "p_"+subgrid_table_id;
		var lastEditiRow,lastEditiCol; //新增加行时，必须先取消编辑状态
		var rowIndex = new Array();//用于记录iRow
		//alert(subgrid_table_id);
		//alert(pager_id);
		$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
		$("#"+subgrid_table_id).jqGrid({
			url:"InOutControllerDetailList.asp?ControllerId="+row_id,
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
			width:930,
			forceFit:true, //调整列宽度不会改变表格的宽度
			hidegrid:false,//禁用控制表格显示、隐藏的按钮
			loadtext:strloadtext,
			toppager:true,
			cellsubmit: "clientArray",
			loadComplete:function(data){ //完成服务器请求后，回调函数 
				if(data == null || data.records==0){ 
					$("#"+subgrid_table_id).jqGrid('clearGridData');
				}
			},
			beforeEditCell: function(rowid,cellname,value,iRow,iCol) { 
				lastEditiRow = iRow;
				lastEditiCol = iCol;
			},
			afterEditCell: function(rowid,cellname,value,iRow,iCol) { 
				//InoutDesc(说明) 列仅序号1-5列可编辑
				//20160705 edit
				if(cellname == "InoutDesc"){
					if(iRow==2 || iRow == 4){
						$("#"+subgrid_table_id).saveCell(iRow, iCol);
						ShowMenCiSelect(iRow);
						var ret = $("#"+subgrid_table_id).jqGrid('getRowData',rowid);
						if(ret.OperType == ""){
							$("#"+subgrid_table_id).jqGrid('setRowData',rowid,{OperType:"edit"});
						}
					}
					else if(iRow==1 || iRow == 3 || iRow == 5){
					}
					else{ 
						$("#"+subgrid_table_id).saveCell(iRow, iCol);
					}
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
				
				//如果选择的是门磁，输入2只能对应输出2，输入4只能输出4
				if(iRow == 2 || iRow == 4){
					var strINPUT = subgrid_table_id+"_INPUT_"+iRow;
					if($("#"+strINPUT).length > 0 ){
						var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');  
						if($("#"+strINPUT).val() != "" && $("#"+strINPUT).val().substring(0,1)=="1" ){
							//选择的是门磁
							if(iRow == 2 && (iCol == 5 || iCol == 6 || iCol == 8 || iCol == 9 || iCol == 10) )
								$("#"+subgrid_table_id).saveCell(iRow, iCol);
							if(iRow == 4 && (iCol == 5 || iCol == 6 || iCol == 7 || iCol == 8 || iCol == 10) )
								$("#"+subgrid_table_id).saveCell(iRow, iCol);
							$("#"+subgrid_table_id).jqGrid('setRowData',rowIds[iRow-1],{ScheduleID:0});
							$("#"+subgrid_table_id).jqGrid('setRowData',rowIds[iRow-1],{ScheduleName:""});
						}
					}
					else{
						//当前值为1-门磁
						var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');  
						var strINPUTVal = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[iRow-1]).InoutDesc;
						if(strINPUTVal != "" &&strINPUTVal.substring(0,1)=="1" ){
							//选择的是门磁
							if(iRow == 2 && (iCol == 5 || iCol == 6 || iCol == 8 || iCol == 9 || iCol == 10) )
								$("#"+subgrid_table_id).saveCell(iRow, iCol);
							if(iRow == 4 && (iCol == 5 || iCol == 6 || iCol == 7 || iCol == 8 || iCol == 10) )
								$("#"+subgrid_table_id).saveCell(iRow, iCol);
							$("#"+subgrid_table_id).jqGrid('setRowData',rowIds[iRow-1],{ScheduleID:0});
							$("#"+subgrid_table_id).jqGrid('setRowData',rowIds[iRow-1],{ScheduleName:""});
						}
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
			
			//设置右边模板选择下拉框
			$("#"+subgrid_table_id+"_toppager_left").attr("style","width:30%;");
			var strSelectInOutID = subgrid_table_id+"_SelInOut";
			var strTemplateTableID = subgrid_table_id+"_toppager_right_tmp"
			var htmlObj = $.ajax({url:"../Common/GetInOut.asp?ControllerID="+row_id+"&SelectID="+strSelectInOutID,async:false});
			var strHtml = "<table id='"+strTemplateTableID+"' class='ui-pg-table navtable' cellspacing='0' cellpadding='0' border='0' style='float:left;table-layout:auto;'><tbody><tr><td>"+getlbl("con.SelTemp")+"</td><td >"+htmlObj.responseText+"</td></tr></tbody></table>"
			$("#"+subgrid_table_id+"_toppager_right").html(strHtml);
			$("#"+strSelectInOutID).change(function(){
				var templateId = $("#"+strSelectInOutID).val();
				//将模板数据加载到当前表格
				$("#"+subgrid_table_id).jqGrid('setGridParam',{url : "InOutTemplateDetailList.asp?TemplateId="+templateId}).trigger("reloadGrid");
				$("#"+subgrid_table_id).jqGrid('setGridParam',{
					gridComplete: function(){
						subGridEdit();//表格下载完后，保持原来的编辑状态
						
						$("#"+subgrid_table_id).jqGrid('setGridParam',{gridComplete: function(){;} }); //执行完subGridEdit()后，又去掉gridComplete函数
						$("#"+subgrid_table_id).jqGrid('setGridParam',{url : "InOutControllerDetailList.asp?ControllerId="+row_id}) //执行完后，将URL也修改原来的
						
						var ids = $("#"+subgrid_table_id).jqGrid('getDataIDs'); 
						for(var i=0;i < ids.length;i++){ 
							var inoutPoint= $("#"+subgrid_table_id).getCell(ids[i],"InoutPoint");
							rowIndex[inoutPoint] = ids[i]; //记录iRow与rowid关系，提交时会用到
							var ret = $("#"+subgrid_table_id).jqGrid('getRowData',ids[i]);
							if(ret.OperType == ""){
								$("#"+subgrid_table_id).jqGrid('setRowData',ids[i],{OperType:"edit"}); //标记所有行都已修改
							}
						}
			
						$("#"+subgrid_table_id+"_btnSubmit").removeClass('ui-state-disabled'); 
						$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
					} 
				}); 
			})
			$("#"+strTemplateTableID).hide(); //默认模板不可见，当点击修改后，才可见
			//设置右边模板选择 结束 
			
			
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
		
			var htmlObj = $.ajax({url:"../Common/GetSchedule.asp?IsShowNULLSchedule=1&ControllerID="+row_id+"&SelectID="+strSelectScheduleID,async:false});
			$("#"+subgrid_table_id).children().children().eq(iRowNumber).children().eq(5).html(htmlObj.responseText);
			$("#"+strSelectScheduleID).css('width','180');
			$("#"+strSelectScheduleID).val(SelVal);
			$("#"+strSelectScheduleID).change(function(){
				$("#"+subgrid_table_id+"_btnSubmit").removeClass('ui-state-disabled'); 
				$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
			})
		}
		
		//增加磁禁或按钮下拉框选择
		function ShowMenCiSelect(iRowNumber)
		{
			var strSelectScheduleID = subgrid_table_id+"_INPUT_"+iRowNumber;
			var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');
			var SelVal = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[iRowNumber-1]).InoutDesc;
			//var strHtml = "<select id='"+strSelectScheduleID+"'><option value='0-按钮'>0-按钮</option><option value='1-门磁'>1-门磁</option></select>"
			var strHtml = "<select id='"+strSelectScheduleID+"'><option value='"+getlbl("con.IN_button")+"'>"+getlbl("con.IN_button")+"</option><option value='"+getlbl("con.IN_MenCi")+"'>"+getlbl("con.IN_MenCi")+"</option></select>"
			$("#"+subgrid_table_id).children().children().eq(iRowNumber).children().eq(3).html(strHtml);
			$("#"+strSelectScheduleID).css('width','180');
			$("#"+strSelectScheduleID).val(SelVal);
			$("#"+strSelectScheduleID).change(function(){
				$("#"+subgrid_table_id+"_btnSubmit").removeClass('ui-state-disabled'); 
				$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
			})
		}
		
		//设置表格进入编辑状态
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
			$("#"+strTemplateTableID).show();
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
					if(ret.InoutPoint == 2 || ret.InoutPoint == 4){
						//2和4可以设为门磁， 下拉框选择
						var strINPUT = $("#"+subgrid_table_id+"_INPUT_"+ret.InoutPoint).val();
						if(strINPUT != undefined && strINPUT != ""){
							ret.InoutDesc = strINPUT;
							//alert(ret.InoutDesc);
						}
					}
					strEditData += ret.RecordID+",,"+ret.InoutPoint+",,"+ret.InoutDesc.trim()+",,";
					strEditData += ret.Out1.trim()+",,"+ret.Out2.trim()+",,"+ret.Out3.trim()+",,"+ret.Out4.trim()+",,"+ret.Out5.trim()+"||";
				}
				//获取时间表。。若没有出现下拉框，则将传递undefined字符串到后台，后台处理时需注意
				var Inoutp = i+1;
				if((Inoutp >= 1 && Inoutp <= 5) || (Inoutp >= 14 && Inoutp <= 15)){
					if(ret.InoutPoint == Inoutp){
						var ScheduleID = $("#"+subgrid_table_id+"_SelSchedule_"+Inoutp).val();
						var ScheduleText = $("#"+subgrid_table_id+"_SelSchedule_"+Inoutp).find("option:selected").text();
						if(ScheduleID == undefined ){
							//ScheduleID = "undefined";
							//ScheduleText = "undefined";
							//alert("undefined");
							//这里如果是undefined，则认为是没有出现下拉框，直接读取现有值。 因为如果是通过选择模板修改的数据，是没有下拉框的
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
				url: 'InOutControllerEdit.asp',
				data:{"ControllerID":row_id,"strScheduleID":strScheduleID,"strEdit":strEditData},
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
							$("#"+strTemplateTableID).hide();
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
			$("#"+strTemplateTableID).hide();
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
	$("#DataGrid_toppager_right").css("width","1%");
	$("#DataGrid_toppager_left").css("width","99%");
	if(isync){
		$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
			caption:getlbl("con.SyncToCon"),//"同步到设备",
			buttonicon:"ui-icon-transferthick-e-w",
			title:getlbl("con.SyncInoutTitle"),//""将输入输出表数据同步到设备",
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
		url: 'GetSyncStatus.asp?type=inout',
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
		url: 'SyncData.asp?type=inout',
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
			alert(textStatus+":SyncData.asp,"+XmlHttpRequest.responseText);
		}
	});
}
function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=inout");
	$("#divExport").show();
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
