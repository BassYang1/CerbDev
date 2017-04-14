
CheckLoginStatus();
//获取操作权限
var role = GetOperRole("ScheduleTemplate");
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
function GetTime(){
	WdatePicker({isShowClear:true,dateFmt:'HH:mm',isShowToday:false,qsEnabled:false});
};
function CompareTime(startTime,endTime)
{
	if(startTime == "" && endTime == "")
		return 0;
	if(startTime == "" && endTime != "")
		return 1;
	if(startTime != "" && endTime == "")
		return 2;
	var arrStartTime = startTime.split(":");
	var arrEndTime = endTime.split(":");
	if(arrStartTime.length !=2)
		return 3;
	if(arrEndTime.length !=2)
		return 4;
	if((arrStartTime[0] > arrEndTime[0]) || (arrStartTime[0] == arrEndTime[0] && arrStartTime[1] >= arrEndTime[1])){
		return 5;
	}
	return 0;
}

$("#DataGrid").jqGrid({
		url:'ScheduleTemplateList.asp',
		editurl:"ScheduleTemplateEdit.asp",
		datatype: "json",
		//colNames:['TemplateId','时间表名称'],
		colNames:['TemplateId',getlbl("con.ScheduleName")],
		colModel :[
			{name:'TemplateId',index:'TemplateId',width:10,hidden:true,editrules:{edithidden:false},search:false},
			{name:'TemplateName',index:'TemplateName',width:500,editable:true,editrules:{required:true},
				searchoptions:{sopt:["eq","ne",'cn','nc']},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>"}},
			], 
		caption:getlbl("con.ScheduleTemp"),//"时间表模板",
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
			// we pass two parameters
			// subgrid_id is a id of the div tag created whitin a table data
			// the id of this elemenet is a combination of the "sg_" + id of the row
			// the row_id is the id of the row
			// If we wan to pass additinal parameters to the url we can use
			// a method getRowData(row_id) - which returns associative array in type name-value
			// here we can easy construct the flowing
			var subgrid_table_id, pager_id;
			subgrid_table_id = subgrid_id+"_t";
			pager_id = "p_"+subgrid_table_id;
			var lastEditiRow,lastEditiCol; //新增加行时，必须先取消编辑状态
			//alert(subgrid_table_id);
			//alert(pager_id);
			var rowIndex = new Array();//用于记录iRow
			$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
			$("#"+subgrid_table_id).jqGrid({
				url:"ScheduleTemplateDetailList.asp?ScheduleID="+row_id,
				datatype: "json",
				//colNames:['RecordID','星期','TemplateName','开始','截止','开始','截止','开始','截止','开始','截止','开始','截止','OperType'],
				colNames:['RecordID',getlbl("con.Week"),'TemplateName',getlbl("con.Start"),getlbl("con.End"),getlbl("con.Start"),getlbl("con.End"),getlbl("con.Start"),getlbl("con.End"),getlbl("con.Start"),getlbl("con.End"),getlbl("con.Start"),getlbl("con.End"),'OperType'],
				colModel :[
					{name:'RecordID',index:'RecordID',hidden:true},  
					{name:'WeekDay',index:'WeekDay',sortable:false,width:160,editable:true,search:false,align:'center',
						formatter:function(cellvalue, options, rowObject){
							switch(cellvalue){
								case '1': return getlbl("con.Monday");break;	//周一
								case '2': return getlbl("con.Tuesday");break;	//周二
								case '3': return getlbl("con.Wednesday");break;	//周三
								case '4': return getlbl("con.Thursday");break;	//周四
								case '5': return getlbl("con.Friday");break;	//周五
								case '6': return getlbl("con.Saturday");break;	//周六
								case '7': return getlbl("con.Sunday");break;	//周日
								default: 
									if(cellvalue == "holiday")
										if(rowObject[2].trim() == "")
											return "("+getlbl("con.NotHoliSchedule")+")";	//无假期时间表
										else
											return rowObject[2]+" ("+getlbl("con.HoliSchedule")+")";//假期时间表
									else
										return cellvalue;
									break;
							}
						},
					},  
					{name:'TemplateName',index:'TemplateName',sortable:false,hidden:true},  
					{name:'StartTime1',index:'StartTime1',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'EndTime1',index:'EndTime1',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'StartTime2',index:'StartTime2',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'EndTime2',index:'EndTime2',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'StartTime3',index:'StartTime3',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'EndTime3',index:'EndTime3',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'StartTime4',index:'StartTime4',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'EndTime4',index:'EndTime4',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'StartTime5',index:'StartTime5',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'EndTime5',index:'EndTime5',sortable:false,width:70,editable:true,editrules:{required:false},search:false,align:'center',
						editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
					{name:'OperType',hidden:true},
					],  
				rowNum:20,
				pager: pager_id,
				sortname: 'WeekDay',
				sortorder: "desc",
				multiselect: false,
       			multiboxonly: false,
				viewrecords: true,
				height: 'auto',
				width:'auto',
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
					//WeekDay(星期) 列不可编辑。文本框不可见
					if(cellname == "WeekDay" && iRow != 1){
						$("#"+subgrid_table_id).saveCell(iRow, iCol);
					}
					//假期行的WeekDay(星期) 列可编辑。并用下拉框显示
					if(cellname == "WeekDay" && iRow == 1){
						$("#"+subgrid_table_id).saveCell(iRow, iCol);
						ShowHolidaySelect();
					}
				},
				afterSaveCell: function(rowid,cellname,value,iRow,iCol) { 
					//alert("afterEditCell");
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
			$("#"+subgrid_table_id).jqGrid('setGroupHeaders', {  
				useColSpanStyle: true, //没有表头的列是否与表头列位置的空单元格合并  
				groupHeaders:[  
					{startColumnName: 'StartTime1', numberOfColumns: 2, titleText: getlbl("con.Times1"),align:'center'},	//时段1
					{startColumnName: 'StartTime2', numberOfColumns: 2, titleText: getlbl("con.Times2")},		//时段2
					{startColumnName: 'StartTime3', numberOfColumns: 2, titleText: getlbl("con.Times3")},		//时段3
					{startColumnName: 'StartTime4', numberOfColumns: 2, titleText: getlbl("con.Times4")},		//时段4
					{startColumnName: 'StartTime5', numberOfColumns: 2, titleText: getlbl("con.Times5")}		//时段5
				]  
			});  
			$("#"+subgrid_table_id).jqGrid('navGrid',"#"+subgrid_table_id+"_toppager",{edit:false,add:false,del:false,search:false,refresh:false});
			
			var topPagerDiv = $("#"+subgrid_table_id + "_toppager")[0];         
			$("#"+subgrid_table_id + "_toppager_center", topPagerDiv).remove();
			$(".ui-paging-info", topPagerDiv).remove();
			$("#"+pager_id+"_center").remove();//去掉底部翻页按钮
			
			if(iedit){
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
				//默认 提交和取消按钮不可用
				$("#"+subgrid_table_id+"_btnSubmit").addClass('ui-state-disabled'); 
				$("#"+subgrid_table_id+"_btnCancel").addClass('ui-state-disabled'); 
			}
			
			//增加假期表选择下拉框，在第一行第一列处
			var SelectHolidayID = subgrid_table_id+"_SelHoliday";
			function ShowHolidaySelect()
			{
				//var htmlObj = $.ajax({url:"../Common/GetHoliday.asp?ControllerID=1&SelectID="+SelectHolidayID,async:false});
				var htmlObj = $.ajax({url:"../Common/GetHoliday.asp?Type=all&SelectID="+SelectHolidayID,async:false});
				$("#"+subgrid_table_id).children().children().eq(1).children().eq(1).html(htmlObj.responseText);
				$("#"+SelectHolidayID).css('width','150');
				var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');
				var SelVal = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[0]).TemplateName;
				//$("#SelHoliday").get(0).selectedIndex=1;
				var count=$("#"+SelectHolidayID+" option").length;
				for(var i=0;i<count;i++){
					if($("#"+SelectHolidayID).get(0).options[i].text == SelVal){  
						$("#"+SelectHolidayID).get(0).options[i].selected = true;  
						break;  
					}  
				}
				$("#"+SelectHolidayID).change(function(){
					//alert($("#"+SelectHolidayID).val());
					$("#"+subgrid_table_id+"_btnSubmit").removeClass('ui-state-disabled'); 
					$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
				})
			}
			//ShowHolidaySelect();
			
			function subGridEdit(){
				$("#"+subgrid_table_id).resetSelection();  
				$("#"+subgrid_table_id).jqGrid('setGridParam',{cellEdit:true});
				var ids = $("#"+subgrid_table_id).jqGrid('getDataIDs'); 
				for(var i=0;i < ids.length;i++){ 
					var cl = ids[i]; 
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'StartTime1','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'EndTime1','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'StartTime2','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'EndTime2','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'StartTime3','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'EndTime3','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'StartTime4','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'EndTime4','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'StartTime5','','ui-jqGrid-cellEditing');
					$("#"+subgrid_table_id).jqGrid('setCell',cl,'EndTime5','','ui-jqGrid-cellEditing');
					//假期表选择，在第一行处
					if(i == 0){
						$("#"+subgrid_table_id).jqGrid('setCell',cl,'WeekDay','','ui-jqGrid-cellEditing');
					}
				} 
				$("#"+subgrid_table_id+"_btnCancel").removeClass('ui-state-disabled'); 
			}
			
			function subGridSubmit(){
				//先保存正在编辑的单元格，否则会出问题
				if(lastEditiRow != 'undefined' && lastEditiCol != 'undefined'){
					$("#"+subgrid_table_id).saveCell(lastEditiRow, lastEditiCol);
				}
				var strEditData,strTempName;
				strEditData  = "";
				strTempName = "";
				//遍历所有行，查找有修改的行
				var rowIds = $("#"+subgrid_table_id).jqGrid('getDataIDs');  
				var len = rowIds.length;
				for(var i = 0; i < len; i++){
					var ret = $("#"+subgrid_table_id).jqGrid("getRowData", rowIds[i]);
					if(ret.OperType == "edit"){
						var iRow;
						for(var j = 1; j < rowIndex.length; j++){
							if(rowIndex[j] == rowIds[i]){
								iRow = j;
								break;
							}
						}
						var RetVal ;
						//时段1
						RetVal = CompareTime(ret.StartTime1.trim(),ret.EndTime1.trim());
						switch(RetVal){
							case 1:alert(getlbl("con.StartTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 3, true); return false;	//[开始时间]不能为空！
							case 2:alert(getlbl("con.EndTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 4, true); return false; //[截止时间]不能为空！
							case 3:alert(getlbl("con.StartTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 3, true); return false;	//[开始时间]非法！
							case 4:alert(getlbl("con.EndTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 4, true); return false;	//[截止时间]非法！
							case 5:alert(getlbl("con.EndTimeLtStartTime"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 4, true); return false;	//[截止时间]不能小于等于[开始时间]！
						}
						strEditData += ret.RecordID+",,"+ret.StartTime1.trim()+",,"+ret.EndTime1.trim()+",,";
						//时段2
						RetVal = CompareTime(ret.StartTime2.trim(),ret.EndTime2.trim());
						switch(RetVal){
							case 1:alert(getlbl("con.StartTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 5, true); return false;
							case 2:alert(getlbl("con.EndTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 6, true); return false;
							case 3:alert(getlbl("con.StartTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 5, true); return false;
							case 4:alert(getlbl("con.EndTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 6, true); return false;
							case 5:alert(getlbl("con.EndTimeLtStartTime"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 6, true); return false;
						}
						strEditData += ret.StartTime2.trim()+",,"+ret.EndTime2.trim()+",,";
						//时段3
						RetVal = CompareTime(ret.StartTime3.trim(),ret.EndTime3.trim());
						switch(RetVal){
							case 1:alert(getlbl("con.StartTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 7, true); return false;
							case 2:alert(getlbl("con.EndTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 8, true); return false;
							case 3:alert(getlbl("con.StartTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 7, true); return false;
							case 4:alert(getlbl("con.EndTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 8, true); return false;
							case 5:alert(getlbl("con.EndTimeLtStartTime"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 8, true); return false;
						}
						strEditData += ret.StartTime3.trim()+",,"+ret.EndTime3.trim()+",,";
						//时段4
						RetVal = CompareTime(ret.StartTime4.trim(),ret.EndTime4.trim());
						switch(RetVal){
							case 1:alert(getlbl("con.StartTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 9, true); return false;
							case 2:alert(getlbl("con.EndTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 10, true); return false;
							case 3:alert(getlbl("con.StartTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 9, true); return false;
							case 4:alert(getlbl("con.EndTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 10, true); return false;
							case 5:alert(getlbl("con.EndTimeLtStartTime"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 10, true); return false;
						}
						strEditData += ret.StartTime4.trim()+",,"+ret.EndTime4.trim()+",,";
						//时段5
						RetVal = CompareTime(ret.StartTime5.trim(),ret.EndTime5.trim());
						switch(RetVal){
							case 1:alert(getlbl("con.StartTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 11, true); return false;
							case 2:alert(getlbl("con.EndTimeNull"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 12, true); return false;
							case 3:alert(getlbl("con.StartTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 11, true); return false;
							case 4:alert(getlbl("con.EndTimeIllegal"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 12, true); return false;
							case 5:alert(getlbl("con.EndTimeLtStartTime"));$("#"+subgrid_table_id).jqGrid('editCell', iRow, 12, true); return false;
						}
						//alert(ret.WeekDay);
						strEditData += ret.StartTime5.trim()+",,"+ret.EndTime5.trim()+"||";
					}
				}
				if(strEditData != ""){
					strEditData = strEditData.substring(0,strEditData.length-2);
				}
				//取假期表ID。若没有出现下拉框，则将传递undefined字符串到后台，后台处理时需注意
				var HolidayTemplateId = $("#"+SelectHolidayID).val();
				if(HolidayTemplateId == undefined)
					HolidayTemplateId = "undefined";
					
				var retTemp = $("#DataGrid").jqGrid("getRowData",row_id);
				strTempName =retTemp.TemplateName;
				$.ajax({
					type: 'Post',
					url: 'ScheduleTemplateDetailEdit.asp',
					data:{"TemplateId":row_id,"HolidayTemplateId":HolidayTemplateId,"strEdit":strEditData,"strTempName":strTempName},
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
								AutoSyncData(row_id);
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
	{multipleSearch:false, multipleGroup:false, showQuery: false,closeAfterSearch: true,caption:strsearchcaption,top:60} ,// search options
	{top:0,}	//view parameters
	);

var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
$("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
$(".ui-paging-info", topPagerDiv).remove();


function AutoSyncData(templateId){
	SyncData(templateId);
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
