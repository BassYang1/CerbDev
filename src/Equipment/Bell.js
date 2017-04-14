CheckLoginStatus();
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
var lastEditiRow,lastEditiCol; 
var rowIndex = new Array();//用于记录iRow
$("#DataGrid").jqGrid({
	url:"BellList.asp?ControllerId=1",
	datatype: "json",
	colNames:['RecordID','星期','是否启用','声音','输出','时间1','时间2','时间3','时间4','时间5','时间6','时间7','时间8','时间9','时间10','OperType'],
	colModel :[
		{name:'RecordID',index:'RecordID',hidden:true},  
		{name:'WeekDay',index:'WeekDay',sortable:false,width:80,editable:true,search:false,align:'center',
			formatter:function(cellvalue, options, rowObject){
				switch(cellvalue){
					case '1': return "周一";break;
					case '2': return "周二";break;
					case '3': return "周三";break;
					case '4': return "周四";break;
					case '5': return "周五";break;
					case '6': return "周六";break;
					case '7': return "周日";break;
					default: return cellvalue;break;
				}
			},
		},  
		{name:'EnableBell',index:'EnableBell',search:false,width:60,
				editable:true,editrules:{required:true,edithidden:true},
				edittype:'checkbox',editoptions: {value:"是:否"},},
		{name:'Voice',index:'Voice',editable:true,search:false,width:120,
				edittype:'select', editoptions:{value:":;111:111;Ring-Afternoon:Ring-Afternoon;Ring-Birds:Ring-Birds;Bella:Bella"}},
		{name:'Out',index:'Out',editable:true,search:false,width:70,
				formatter:function(cellvalue, options, rowObject){
					if(cellvalue >= '1' && cellvalue <= '7')
						return "输出"+cellvalue;
					else
						return "";
				},
				edittype:'select', editoptions:{value:":;1:输出1;2:输出2;3:输出3;4:输出4;5:输出5"}},
		{name:'Time1',index:'Time1',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time2',index:'Time2',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time3',index:'Time3',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time4',index:'Time4',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time5',index:'Time5',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time6',index:'Time6',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time7',index:'Time7',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time8',index:'Time8',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time9',index:'Time9',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'Time10',index:'Time10',sortable:false,width:50,editable:true,editrules:{required:false},search:false,align:'center',
			editoptions:{size:10,maxlengh:10,dataInit:function(element){$(element).bind('focus',GetTime)}}},
		{name:'OperType',hidden:true},
		],  
	caption:"铃响",
	imgpath:'/images',
	rowNum:irowNum,
	rowList:[10,16,20,30],
	prmNames: {search: "_search"},  
	//jsonReader: { repeatitems: false },
	pager: '#pager',
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
	cellEdit: isAdmin,
	cellsubmit: "clientArray",
	beforeEditCell: function(rowid,cellname,value,iRow,iCol) { 
		lastEditiRow = iRow;
		lastEditiCol = iCol;
	},
	afterEditCell: function(rowid,cellname,value,iRow,iCol) { 
		//WeekDay(星期) 列不可编辑。文本框不可见
		if(cellname == "WeekDay"){
			$("#DataGrid").saveCell(iRow, iCol);
		}
	},
	afterSaveCell: function(rowid,cellname,value,iRow,iCol) { 
		//alert("afterEditCell");
		rowIndex[iRow] = rowid; //记录iRow与rowid关系，提交时会用到
		var ret = $("#DataGrid").jqGrid('getRowData',rowid);
		if(ret.OperType == ""){
			$("#DataGrid").jqGrid('setRowData',rowid,{OperType:"edit"});
		}

		$("#DataGrid_btnSubmit").removeClass('ui-state-disabled'); 
		$("#DataGrid_btnCancel").removeClass('ui-state-disabled'); 
	},
	loadComplete:function(data){ //完成服务器请求后，回调函数 
		if(data == null || data.records==0){ 
			$("#DataGrid").jqGrid('clearGridData');
	}},
});
 
//获取操作权限
var role = GetOperRole("bell");
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

$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager",{edit:iedit,add:iadd,del:idel,refresh:irefresh,search:isearch});

var topPagerDiv = $("#DataGrid_toppager")[0];         
$("#DataGrid_toppager_center", topPagerDiv).remove();
$(".ui-paging-info", topPagerDiv).remove();

if(isAdmin){
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:"提交",
		buttonicon:"ui-icon-disk",
		title:"保存数据",
		id:"DataGrid_btnSubmit",
		onClickButton: subGridSubmit,
		//position:"first"
	});
	$("#DataGrid").jqGrid('navGrid',"#DataGrid_toppager_left").jqGrid('navButtonAdd',"#DataGrid_toppager_left",{
		caption:"取消",
		buttonicon:"ui-icon-cancel",
		title:"取消保存",
		id:"DataGrid_btnCancel",
		onClickButton: subGridCancel,
		position:"last"
	});
	//默认 提交和取消按钮不可用
	$("#DataGrid_btnSubmit").addClass('ui-state-disabled'); 
	$("#DataGrid_btnCancel").addClass('ui-state-disabled'); 
}


function subGridSubmit(){
	//先保存正在编辑的单元格，否则会出问题
	if(lastEditiRow != 'undefined' && lastEditiCol != 'undefined'){
		$("#DataGrid").saveCell(lastEditiRow, lastEditiCol);
	}
	var strEditData;
	strEditData  = "";
	//遍历所有行，查找有修改的行
	var rowIds = $("#DataGrid").jqGrid('getDataIDs');  
	var len = rowIds.length;
	for(var i = 0; i < len; i++){
		var ret = $("#DataGrid").jqGrid("getRowData", rowIds[i]);
		if(ret.OperType == "edit"){
			var iRow,enableBell,voice,out;
			for(var j = 1; j < rowIndex.length; j++){
				if(rowIndex[j] == rowIds[i]){
					iRow = j;
					break;
				}
			}
			enableBell = ret.EnableBell; //是否启用字段
			voice = ret.Voice;  //语音字段
			out = ret.Out;		//输出
			if(enableBell == "是")
				enableBell = 1;
			else
				enableBell = 0;
			out = out.replace("输出","");
			
			strEditData += ret.RecordID+",,"+enableBell+",,"+voice+",,"+out+",,";
			strEditData += ret.Time1.trim()+",,"+ret.Time2.trim()+",,";
			strEditData += ret.Time3.trim()+",,"+ret.Time4.trim()+",,";
			strEditData += ret.Time5.trim()+",,"+ret.Time6.trim()+",,";
			strEditData += ret.Time7.trim()+",,"+ret.Time8.trim()+",,";
			strEditData += ret.Time9.trim()+",,"+ret.Time10.trim()+"||";
		}
	}
	if(strEditData != ""){
		strEditData = strEditData.substring(0,strEditData.length-2);
	}
	$.ajax({
		type: 'Post',
		url: 'BellEdit.asp',
		data:{"strEdit":strEditData},
		success: function(data) {
			try  {
				var responseMsg = $.parseJSON(data);
				if(responseMsg.success == false){
					alert(responseMsg.message);
				}else if(responseMsg.success == true){
					//保存成功后，清空参数，按钮置为禁用
					strEditData = "";
					$("#DataGrid_btnSubmit").addClass('ui-state-disabled'); 
					$("#DataGrid_btnCancel").addClass('ui-state-disabled'); 
					$("#DataGrid").trigger("reloadGrid");
				}else{
					alert("保存数据异常");
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
	strEditData = "";
	$("#DataGrid_btnSubmit").addClass('ui-state-disabled'); 
	$("#DataGrid_btnCancel").addClass('ui-state-disabled'); 
	$("#DataGrid").trigger("reloadGrid");
};

