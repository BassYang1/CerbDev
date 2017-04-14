CheckLoginStatus();
//获取操作权限
var role = GetOperRole("HolidayTemplate");
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
$("#DataGrid").jqGrid({
		url:'HolidayTemplateList.asp',
		editurl:"HolidayTemplateEdit.asp",
		datatype: "json",
		//colNames:['TemplateId','假期表名称'],
		colNames:['TemplateId',getlbl("con.HolidayName")],
		colModel :[
			{name:'TemplateId',index:'TemplateId',width:10,hidden:true,editrules:{edithidden:false},search:false},
			{name:'TemplateName',index:'TemplateName',width:500,editable:true,editrules:{required:true},
				searchoptions:{sopt:["eq","ne",'cn','nc']},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>"}},
			], 
		caption:getlbl("con.HolidayTemp"),//"假期表模板",
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
		sortorder: "asc",
		height: 'auto',
		width:700,
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
			//alert(subgrid_table_id);
			//alert(pager_id);
			$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
			$("#"+subgrid_table_id).jqGrid({
				url:"HolidayTemplateDetailList.asp?TemplateId="+row_id,
				datatype: "json",
				//colNames:['序号','假期名称','日期','OperType'],
				colNames:[getlbl("con.SN"),getlbl("con.HoliName"),getlbl("con.HolidayDate"),'OperType'],
				colModel :[
					//{name:'RecordID',index:'RecordID',width:10,hidden:true,editrules:{edithidden:false},search:false},
					//{name:'ID',index:'ID',width:10,hidden:true,editrules:{edithidden:false},search:false},
					{name:'HolidayNumber',index:'HolidayNumber',width:60,editrules:{edithidden:false},search:false},  
					{name:'HolidayName',index:'HolidayName',editable:true,editrules:{edithidden:false},search:false},  
					{name:'HolidayDate',index:'HolidayDate',editable:true,editrules:{required:true},search:false,
						formatter:'date',sorttype:'date',
						formatoptions: {srcformat:'m-d',newformat:'m-d'},datefmt:'m-d', 
						editoptions:{size:20,maxlengh:20,dataInit:function(element){$(element).bind('focus',function(){WdatePicker({isShowClear:false,dateFmt:'MM-dd'})})}}},
					{name:'OperType',hidden:true},
					],  
				rowNum:20,
				rowList:[10,16,20,30],
				pager: pager_id,
				sortname: 'HolidayNumber',
				sortorder: "desc",
				multiselect: true,
       			multiboxonly: true,
				viewrecords: true,
				height: 'auto',
				width:630,
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
				}},
			});
			$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager",{edit:false,add:false,del:false,search:false,refresh:false});
			
			var topPagerDiv = $("#"+subgrid_table_id + "_toppager")[0];         
			$("#"+subgrid_table_id + "_toppager_center", topPagerDiv).remove();
			$(".ui-paging-info", topPagerDiv).remove();
			$("#"+subgrid_table_id + "_toppager_left").css("width","95%");
			
			if(iedit){
				//DataGrid_1_t_toppager   DataGrid_1_t_toppager_right
				$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
					caption:getlbl("con.Del"),//"删除",
					buttonicon:"ui-icon-trash",
					title:getlbl("con.DelTitle"),//"删除所选记录",
					id:subgrid_table_id+"_btnDel",
					onClickButton: subGridDel,
					position:"first"
				});
				$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
					caption:getlbl("con.Edit"),//"修改",
					buttonicon:"ui-icon-pencil",
					title:getlbl("con.EditTitle"),//"修改单元格，颜色改变的单元格为可编辑，点击可进入编辑状态",
					id:subgrid_table_id+"_btnEdit",
					onClickButton: subGridEdit,
					position:"first"
				});
				
				$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
					caption:getlbl("con.Add"),//"增加",
					buttonicon:"ui-icon-plus",
					title:getlbl("con.AddTitle"),//"添加新记录",
					id:subgrid_table_id+"_btnQuery",
					onClickButton: subGridAdd,
					position:"first"
				});
				$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
					caption:getlbl("con.Submit"),//"提交",
					buttonicon:"ui-icon-disk",
					title:getlbl("con.SubmitTitle"),//"保存数据，且自动同步到设备",
					id:subgrid_table_id+"_btnSubmit",
					onClickButton: subGridSubmit,
					//position:"first"
				});
				$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager_left").jqGrid('navButtonAdd',"#"+subgrid_table_id+"_toppager_left",{
					caption:getlbl("con.Cancel"),//"取消",
					buttonicon:"ui-icon-cancel",
					title:getlbl("con.CancelTitle"),//"取消保存",
					id:subgrid_table_id+"_btnCancel",
					onClickButton: subGridCancel,
					position:"last"
				});
				//默认 提交和取消按钮不可用
				$("#"+subgrid_table_id+"_btnSubmit").addClass('ui-state-disabled'); 
				$("#"+subgrid_table_id+"_btnCancel").addClass('ui-state-disabled'); 
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
				var htmlObj = $.ajax({url:"GetHolidayTemplateMaxNumber.asp?TemplateId="+row_id+"&nd="+getRandom(),async:false});
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
					HolidayNumber: newrowid,
					HolidayName: "",
					HolidayDate: "",
					OperType:"add"
				};   
				$("#"+subgrid_table_id).jqGrid("addRowData", newrowid, dataRow, "first");      
				subGridEdit()  ;  
			} ;
			function subGridEdit(){
				$("#"+subgrid_table_id).resetSelection();  
				$("#"+subgrid_table_id).jqGrid('setGridParam',{cellEdit:true});
				var ids = $("#"+subgrid_table_id).jqGrid('getDataIDs'); 
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i]; 
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'HolidayName','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'HolidayDate','','ui-jqGrid-cellEditing');
				} 
				$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
			}
		
			var strDelRowID = "";//记录删除的ID，提交到后台用到
			function subGridDel(){
				if(lastEditiRow != 'undefined' && lastEditiCol != 'undefined'){
					$("#"+subgrid_table_id).saveCell(lastEditiRow, lastEditiCol);
				}
				var selectedRowIds = $("#"+subgrid_table_id).jqGrid("getGridParam", "selarrrow");
				if (selectedRowIds.length < 1) {
					//$("#"+subgrid_table_id).message("成功添加"); 
					//viewModal('#alertmod', { gbox: '#gbox_', jqm: true });
					//$().message("test");
					//$().showMessage("请先保存"); alertmod_DataGrid_1_t
					//$("#alertmod_DataGrid_1_t" ).dialog( "open" );
					//alert("请选择需要操作的数据行!");
					alert(getlbl("con.SelRowNull"));
					return false;
				}
				var len = selectedRowIds.length;  
				for(var i = 0;i < len ;i ++) {  
					strDelRowID += selectedRowIds[0] + "||";
					$("#"+subgrid_table_id).jqGrid("delRowData", selectedRowIds[0]);  
				}
				$("#"+subgrid_table_id+"_btnSubmit").removeClass('ui-state-disabled'); 
				$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled');   
			};
			function subGridSubmit(){
				//先保存正在编辑的单元格，否则会出问题
				if(lastEditiRow != 'undefined' && lastEditiCol != 'undefined'){
					$("#"+subgrid_table_id).saveCell(lastEditiRow, lastEditiCol);
				}
				var strEditData,strAddData,strTempName;
				strEditData  = "";
				strAddData = "";
				strTempName = "";
				//遍历所有行，查找有修改和新增加的行
				var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');  
				var len = rowIds.length;
				for(var i = 0; i < len; i++){
					var ret = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[i]);
					if(ret.OperType == "add"){
						if(ret.HolidayDate.trim() == ""){
							//alert("序号["+ret.HolidayNumber+"]日期为空!");
							alert(getlbl("con.SN")+"["+ret.HolidayNumber+"]"+getlbl("con.DateNull")+"!");
							return false;
						}
						strAddData += ret.HolidayNumber+",,"+ret.HolidayName+",,"+ret.HolidayDate+"||";
					}else if(ret.OperType == "edit"){
						if(ret.HolidayDate.trim() == ""){
							//alert("序号["+ret.HolidayNumber+"]日期为空!");
							alert(getlbl("con.SN")+"["+ret.HolidayNumber+"]"+getlbl("con.DateNull")+"!");
							return false;
						}
						strEditData += ret.HolidayNumber+",,"+ret.HolidayName+",,"+ret.HolidayDate+"||";
					}
				}
				if(strAddData != ""){
					strAddData = strAddData.substring(0,strAddData.length-2);
				}
				if(strEditData != ""){
					strEditData = strEditData.substring(0,strEditData.length-2);
				}
				if(strDelRowID != ""){
					strDelRowID = strDelRowID.substring(0,strDelRowID.length-2);
				}
				var retTemp = $("#DataGrid").jqGrid("getRowData",row_id);
				strTempName =retTemp.TemplateName;
				$.ajax({
					type: 'Post',
					url: 'HolidayTemplateDetailEdit.asp',
					data:{"TemplateId":row_id,"strAdd":strAddData,"strEdit":strEditData,"strDel":strDelRowID,"strTempName":strTempName},
					success: function(data) {
						try  {
							var responseMsg = $.parseJSON(data);
							if(responseMsg.success == false){
								alert(responseMsg.message);
							}else if(responseMsg.success == true){
								//保存成功后，清空参数，按钮置为禁用
								strAddData = "";
								strEditData = "";
								strDelRowID = "";
								$("#"+subgrid_table_id+"_btnSubmit").addClass('ui-state-disabled'); 
								$("#"+subgrid_table_id+"_btnCancel").addClass('ui-state-disabled'); 
								$("#"+subgrid_table_id).jqGrid('setGridParam',{cellEdit:false});
								$("#"+subgrid_table_id).trigger("reloadGrid");
								AutoSyncData(row_id);
							}else{
								alert(getlbl("con.SaveEx"));
								//alert("保存数据异常");
							}
						}
						catch(exception) {
							alert(exception);
						}
					}
				});
			};
			function subGridCancel(){
				strAddData = "";
				strEditData = "";
				strDelRowID = "";
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
	{multipleSearch:false, multipleGroup:false, showQuery: false,closeAfterSearch: true,caption:strsearchcaption,top:60} ,// search options
	{top:0,}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();
$("#DataGrid_toppager_right").css("width","1%");
$("#DataGrid_toppager_left").css("width","99%");

function AutoSyncData(templateId){
	SyncData(templateId);
};

function SyncData(templateId){
	$.ajax({
		type: 'Post',
		url: 'SyncData.asp?type=holiday',
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
