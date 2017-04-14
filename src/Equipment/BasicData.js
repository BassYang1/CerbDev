//校验IP合法性
function CheckIP(IP)
{
	var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	var reg = IP.match(exp);
	if(reg==null)
	{
		return false;
	}
	else
	{
		return true;	
	}
}

$(document).ready(function(){
CheckLoginStatus();  
jQuery("#DataGrid").jqGrid({
		url:'BasicDataList.asp',
		editurl:"BasicDataEdit.asp",
		datatype: "json",
		//colNames:['设备ID','设备编号','设备名称','位置','设备IP','子网掩码','网关','DNS','DNS2','启用DHCP','防遣返','工作类型','服务器','存储方式','指纹模块','门类型','读卡器1（彩屏机）','读卡器2','设备密码','数据上传间隔','屏保等待时间','屏幕关闭时间','下载相片','下载指纹','音量','BoardType','屏保图片1','屏保图片2','同步状态','在线状态'],
		colNames:[getlbl("con.ControllerId"),getlbl("con.ControllerIdNum"),getlbl("con.ControllerIdName"),getlbl("con.Location"),getlbl("con.IP"),getlbl("con.MASK"),getlbl("con.GateWay"),getlbl("con.DNS"),getlbl("con.DNS2"),getlbl("con.DHCP"),getlbl("con.AntiPassBackType"),getlbl("con.WorkType"),getlbl("con.ServerIP2"),getlbl("con.StorageMode"),getlbl("con.IsFingerprint"),getlbl("con.DoorType"),getlbl("con.CardReader1"),getlbl("con.CardReader2"),getlbl("con.SystemPassword"),getlbl("con.DataUpdateTime"),getlbl("con.WaitTime"),getlbl("con.CloseLightTime"),getlbl("con.DownPhoto"),getlbl("con.DownFingerprint"),getlbl("con.Sound"),'BoardType',getlbl("con.ScreenFile1"),getlbl("con.ScreenFile2"),getlbl("con.SyncStatus"),getlbl("con.ConnStatus")],
		colModel :[
			{name:'ControllerId',index:'ControllerId',width:120,align:'center',viewable:true,formoptions:{rowpos:1,colpos:1},stype:"text", searchoptions:{ sopt:["eq","ne"]},},
			{name:'ControllerNumber',index:'ControllerNumber',align:'center',editable:true,editrules:{required:true},
				stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:2,colpos:1}}, 
			{name:'ControllerName',index:'ControllerName',align:'center',editable:true,editrules:{required:true},
				stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:2,colpos:2}}, 
			{name:'Location',index:'Location',align:'center',editable:true,
				stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},formoptions:{rowpos:3,colpos:1}},
			{name:'IP',index:'IP',align:'center',search:false,editable:true,
				stype:"text", searchoptions:{ sopt:["eq","ne",'cn','nc']},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:3,colpos:2}},
			{name:'MASK',index:'MASK',search:false,hidden:true,editable:true,editrules:{edithidden:true},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:4,colpos:1}},
			{name:'GateWay',index:'GateWay',search:false,hidden:true,editable:true,editrules:{edithidden:true},formoptions:{rowpos:4,colpos:2}},
			{name:'DNS',index:'DNS',search:false,hidden:true,editable:true,editrules:{edithidden:true},formoptions:{rowpos:5,colpos:1}},
			{name:'DNS2',index:'DNS2',search:false,hidden:true,editable:true,editrules:{edithidden:true},formoptions:{rowpos:5,colpos:2}},
			{name:'EnableDHCP',index:'EnableDHCP',search:false,hidden:true,
				editable:true,editrules:{edithidden:true},
				edittype:'checkbox',editoptions: {value:"1:0"},formoptions:{rowpos:6,colpos:1}},
			{name:'AntiPassBackType',index:'AntiPassBackType',search:false,hidden:true,
				editable:true,editrules:{edithidden:true},
				edittype:'checkbox',editoptions: {value:"1:0"},formoptions:{rowpos:6,colpos:2}},
			{name:'WorkType',index:'WorkType',align:'center',editable:true,editrules:{required:true},search:false,width:260,
				edittype:'select', editoptions:{value:getlbl("con.WorkType0")+":"+getlbl("con.WorkType0")+";"+getlbl("con.WorkType1")+":"+getlbl("con.WorkType1")+";"+getlbl("con.WorkType2")+":"+getlbl("con.WorkType2")},//0 - 上下班:0 - 上下班;1 - 进出入:1 - 进出入;2 - 上下班+进出入
				formoptions:{rowpos:7,colpos:1}},
			{name:'ServerIP',index:'ServerIP',align:'center',hidden:false,width:155,
				editable:true,editrules:{edithidden:true},
				stype:"text", searchoptions:{ sopt:["eq","ne"]},
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:7,colpos:2},viewable:true},
			{name:'StorageMode',index:'StorageMode',editable:true,hidden:true,editrules:{required:true,edithidden:true},search:false,
				edittype:'select', editoptions:{value:getlbl("con.StorageMode0")+":"+getlbl("con.StorageMode0")+";"+getlbl("con.StorageMode1")+":"+getlbl("con.StorageMode1")},formoptions:{rowpos:8,colpos:1}}, // 0 - 所有刷卡:0 - 所有刷卡;1 - 仅注册卡:1 - 仅注册卡
			{name:'IsFingerprint',index:'IsFingerprint',search:false,hidden:true,
				editable:true,editrules:{edithidden:true},
				edittype:'checkbox',editoptions: {value:"1:0"},formoptions:{rowpos:8,colpos:2},viewable:true},
			
			{name:'DoorType',index:'DoorType',hidden:true,editable:false,editrules:{edithidden:false},search:false,
				edittype:'select', editoptions:{value:getlbl("con.DoorType0")+":"+getlbl("con.DoorType0")+";"+getlbl("con.DoorType1")+":"+getlbl("con.DoorType1")},},//"0 - 单门:0 - 单门;1 - 双门:1 - 双门"
			{name:'CardReader1',index:'CardReader1',hidden:true,editable:true,editrules:{edithidden:true},search:false,
				edittype:'select', editoptions:{value:getlbl("con.CardReaderVal0")+":"+getlbl("con.CardReaderVal0")+";"+getlbl("con.CardReaderVal1")+":"+getlbl("con.CardReaderVal1")},formoptions:{rowpos:9,colpos:1}},//"0 - 进:0 - 进;1 - 出:1 - 出"
			{name:'CardReader2',index:'CardReader2',hidden:true,editable:true,editrules:{edithidden:true},search:false,
				edittype:'select', editoptions:{value:getlbl("con.CardReaderVal0")+":"+getlbl("con.CardReaderVal0")+";"+getlbl("con.CardReaderVal1")+":"+getlbl("con.CardReaderVal1")},formoptions:{rowpos:9,colpos:2}},//"0 - 进:0 - 进;1 - 出:1 - 出"
			{name:'SystemPassword',index:'SystemPassword',hidden:true,
				editable:true,editrules:{required:true,edithidden:true,number:true},search:false,edittype:'password',
				formoptions:{elmsuffix:"<font color=#FF0000>*</font>",rowpos:10,colpos:1}},
			{name:'DataUpdateTime',index:'DataUpdateTime',hidden:true,editable:true,
				editrules:{required:true,edithidden:true,integer:true,minValue:10,maxValue:86400},search:false,
				formoptions:{elmsuffix:"<font color=#FF0000>*</font> "+getlbl("con.Second"),rowpos:10,colpos:2},viewable:true},//秒
			{name:'WaitTime',index:'WaitTime',hidden:true,editable:true,
				editrules:{required:true,edithidden:true,integer:true,minValue:0,maxValue:1440},search:false,
				formoptions:{elmsuffix:"<font color=#FF0000>*</font> "+getlbl("con.Minute"),rowpos:11,colpos:1}},//分钟
			{name:'CloseLightTime',index:'CloseLightTime',hidden:true,editable:true,
				editrules:{required:true,edithidden:true,integer:true,minValue:0,maxValue:1440},search:false,
				formoptions:{elmsuffix:"<font color=#FF0000>*</font> "+getlbl("con.Minute"),rowpos:11,colpos:2}},//分钟
			{name:'DownPhoto',index:'DownPhoto',search:false,hidden:true,
				editable:true,editrules:{edithidden:true},
				edittype:'checkbox',editoptions: {value:"1:0"},formoptions:{rowpos:12,colpos:1}},
			{name:'DownFingerprint',index:'DownFingerprint',search:false,hidden:true,
				editable:true,editrules:{edithidden:true},
				edittype:'checkbox',editoptions: {value:"1:0"},formoptions:{rowpos:12,colpos:2}},
			{name:'Sound',index:'Sound',hidden:true,editable:true,editrules:{required:true,edithidden:true},search:false,
				edittype:'select', editoptions:{value:"0:0;1:1;2:2;3:3;4:4;5:5;6:6;7:7;8:8;9:9;10:10"},formoptions:{elmsuffix:" "+getlbl("con.SoundVal"),rowpos:13,colpos:1}},//档
			{name:'BoardType',index:'BoardType',search:false,hidden:true,formoptions:{rowpos:13,colpos:2},viewable:false},
			{name:'ScreenFile11',index:'ScreenFile11',hidden:true,editable:true,
				editrules:{required:true,edithidden:true},search:false,
				formoptions:{rowpos:14,colpos:1}},
			{name:'ScreenFile21',index:'ScreenFile21',hidden:true,editable:true,
				editrules:{required:true,edithidden:true},search:false,
				formoptions:{rowpos:14,colpos:2}},	
			{name:'SyncStatus',index:'SyncStatus',width:80,align:'center',search:false,formoptions:{rowpos:15,colpos:1},viewable:false,editable:false,sortable:false,},
			{name:'ConnStatus',index:'ConnStatus',width:80,align:'center',search:false,formoptions:{rowpos:15,colpos:1},viewable:false,editable:false,sortable:false,},
			], 
		caption:getlbl("con.ConBasicData"),//设备基本资料
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
		width:'auto',
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
		}
});

//获取操作权限
var role = GetOperRole("BasicDataController");
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

jQuery("#DataGrid").jqGrid('navGrid','#DataGrid_toppager', 
	{
		edit:iedit,add:iadd,del:idel,view:iview,refresh:irefresh,search:isearch,edittext:stredittext,addtext:straddtext,deltext:strdeltext,searchtext:strsearchtext,refreshtext:strrefreshtext,viewtext:strviewtext,
		alerttext : stralerttext ,
	}, 
	{
		top:0,width:850,labelswidth:'70px',
		reloadAfterSubmit :true,
		closeAfterEdit: document.all ? false:true,	//IE下修改后，对话框不关闭。主要是上传照片Ajax无法同步执行
		jqModal:true, closeOnEscape:false,
		afterSubmit:function(response, postdata){
			try{
				var responseMsg = $.parseJSON(response.responseText);
				var $infoTr = $("#TblGrid_" + $.jgrid.jqID(this.id) + ">tbody>tr.tinfo"),
				     $infoTd = $infoTr.children("td.topinfo");//信息栏
				//var e = eval('('+response.responseText+')');
				if(responseMsg.id != ""){
					var retVal = $("#iMage1")[0].contentWindow.fSubmit(responseMsg.id);
					var retVal2 = $("#iMage2")[0].contentWindow.fSubmit(responseMsg.id);
					if(retVal && retVal2){
						if (responseMsg.success) {
							var myInfo = '<div class="ui-state-highlight ui-corner-all">' + '<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>' + responseMsg.message + '</div>'
							$infoTd.html(myInfo);
							$infoTr.show();
							return [responseMsg.success,responseMsg.message];
						} else {
							//错误信息是在id为FormError的单元格显示
							$infoTr.hide();//隐藏信息栏以免同时显示info和FormError
							return [responseMsg.success,responseMsg.message];
						}						
					}
					else
						return [false,getlbl("hr.UpPhotoFail")];//"照片上传失败"
				}
				else{
					return [responseMsg.success,responseMsg.message];
				}
			}
			catch(exception) {
				alert(exception);
			}
		},
		beforeShowForm:function(form){
			//return;
		},
		afterShowForm:function(formid){
			//初始化窗体
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
			InitEditForm("edit",rowid);
		},
		beforeSubmit:function(postdata, formid){
			if($("#EnableDHCP").get(0).checked == false){
				//未启用DHCP, IP与Mask必填
				if($("#IP").val() == ""){
					$('#IP').focus();
					return[false,getlbl("con.IPNull")]; //设备IP: 此字段必需
				}else if($("#MASK").val() == ""){
					$('#MASK').focus();
					return[false,getlbl("con.MASKNull")]; //子网掩码: 此字段必需
				}
				else if(CheckIP($("#IP").val()) == false){
					$('#IP').focus();
					return[false,getlbl("con.IPIllegal")]; //IP地址非法
				}
				else if(CheckIP($("#MASK").val()) == false){
					$('#MASK').focus();
					return[false,getlbl("con.MASKIllegal")]; //子网掩码非法
				}
				else if($("#GateWay").val()!="" && CheckIP($("#GateWay").val()) == false){
					$('#GateWay').focus();
					return[false,getlbl("con.GateWayIllegal")]; //网关非法
				}
				else if($("#DNS").val()!="" && CheckIP($("#DNS").val()) == false){
					$('#DNS').focus();
					return[false,getlbl("con.DNSIllegal")]; //DNS非法
				}
				else if($("#DNS2").val()!="" && CheckIP($("#DNS2").val()) == false){
					$('#DNS2').focus();
					return[false,getlbl("con.DNS2Illegal")]; //DNS2非法
				}
			}
			return[true,''];
		},
		//selarrrow
	},  //  default settings for edit
	{
		top:0,width:850,labelswidth:'70px',
		reloadAfterSubmit :true,
		closeAfterAdd:  document.all ? false:true,	//IE下修改后，对话框不关闭。主要是上传照片Ajax无法同步执行
		afterSubmit:function(response, postdata){
			try{
				var responseMsg = $.parseJSON(response.responseText);
				var $infoTr = $("#TblGrid_" + $.jgrid.jqID(this.id) + ">tbody>tr.tinfo"),
				     $infoTd = $infoTr.children("td.topinfo");//信息栏
				//var e = eval('('+response.responseText+')');
				if(responseMsg.id != ""){
					var retVal = $("#iMage1")[0].contentWindow.fSubmit(responseMsg.id);
					var retVal2 = $("#iMage2")[0].contentWindow.fSubmit(responseMsg.id);
					if(retVal && retVal2){
						if (responseMsg.success) {
							var myInfo = '<div class="ui-state-highlight ui-corner-all">' + '<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>' + responseMsg.message + '</div>'
							$infoTd.html(myInfo);
							$infoTr.show();
							return [responseMsg.success,responseMsg.message];
						} else {
							//错误信息是在id为FormError的单元格显示
							$infoTr.hide();//隐藏信息栏以免同时显示info和FormError
							return [responseMsg.success,responseMsg.message];
						}						
					}
					else
						return [false,getlbl("hr.UpPhotoFail")];//"照片上传失败"
				}
				else{
					return [responseMsg.success,responseMsg.message];
				}
			}
			catch(exception) {
				alert(exception);
			}
		},
		afterShowForm:function(formid){
			$.ajax({
				type: 'Post',
				url: 'GetControllerSameParm.asp',
				data:{},
				success: function(data) {
					try{
						var arr = data.split("|");
						//alert(arr.length);
						$("#IP").val(arr[0]);
						$("#MASK").val(arr[1]);
						$("#GateWay").val(arr[2]);
						$("#DNS").val(arr[3]);
						$("#DNS2").val(arr[4]);
						$("#ServerIP").val(arr[5]);
						$("#WorkType").val(arr[6]);
						$("#DataUpdateTime").val(arr[7]);
						$("#WaitTime").val(arr[8]);
						$("#CloseLightTime").val(arr[9]);
						$("#Sound").val(arr[10]);
						if(arr[11] == 1){
							$("#DownPhoto").val(arr[11]);
							$("#DownPhoto").attr("checked",'true');
						}
						if(arr[12] == 1){
							$("#DownFingerprint").val(arr[12]);
							$("#DownFingerprint").attr("checked",'true');
						}
						//20160704 add 
						if(arr.length >= 14){
							if(arr[13] == 1){
								$("#IsFingerprint").val(arr[13]);
								$("#IsFingerprint").attr("checked",'true');
							}
						}
						$("#SystemPassword").val("666666");
						//alert(data);
					}
					catch(exception) {
						//alert(exception);
					}
				}
			});
			//初始化窗体
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
			InitEditForm("add",rowid);
		},
		beforeSubmit:function(postdata, formid){
			if($("#EnableDHCP").get(0).checked == false){
				//未启用DHCP, IP与Mask必填
				if($("#IP").val() == ""){
					$('#IP').focus();
					return[false,getlbl("con.IPNull")]; //设备IP: 此字段必需
				}else if($("#MASK").val() == ""){
					$('#MASK').focus();
					return[false,getlbl("con.MASKNull")]; //子网掩码: 此字段必需
				}
				else if(CheckIP($("#IP").val()) == false){
					$('#IP').focus();
					return[false,getlbl("con.IPIllegal")]; //IP地址非法
				}
				else if(CheckIP($("#MASK").val()) == false){
					$('#MASK').focus();
					return[false,getlbl("con.MASKIllegal")]; //子网掩码非法
				}
				else if($("#GateWay").val()!="" && CheckIP($("#GateWay").val()) == false){
					$('#GateWay').focus();
					return[false,getlbl("con.GateWayIllegal")]; //网关非法
				}
				else if($("#DNS").val()!="" && CheckIP($("#DNS").val()) == false){
					$('#DNS').focus();
					return[false,getlbl("con.DNSIllegal")]; //DNS非法
				}
				else if($("#DNS2").val()!="" && CheckIP($("#DNS2").val()) == false){
					$('#DNS2').focus();
					return[false,getlbl("con.DNS2Illegal")]; //DNS2非法
				}
			}
			return[true,''];
		},
	},  //  default settings for add
	{
		top:0,width:'700px',labelswidth:'70px',
		reloadAfterSubmit :false,
		afterSubmit:getDelafterSubmit
	},  // delete instead that del:false we need this
	{multipleSearch:false, multipleGroup:false, showQuery: false,closeAfterSearch: true,caption:strsearchcaption,top:60} ,// search options
	{
		top:0,width:850,viewPagerButtons:false,drag:true,resize:true,
		beforeShowForm:function(form){
			$('#trv_ControllerId').children().eq(0).css("width", "23%"); //设置标签宽度
			$('#trv_ControllerId').children().eq(2).css("width", "23%"); //设置标签宽度
			if($('#v_EnableDHCP').text().trim() == "1")
				$('#v_EnableDHCP').html("<span> "+getlbl("con.Yes")+"</span>"); //是
			else
				$('#v_EnableDHCP').html("<span> "+getlbl("con.No")+"</span>"); //否
			if($('#v_AntiPassBackType').text().trim() == "1")
				$('#v_AntiPassBackType').html("<span> "+getlbl("con.Yes")+"</span>"); //是
			else
				$('#v_AntiPassBackType').html("<span> "+getlbl("con.No")+"</span>"); //否
			if($('#v_IsFingerprint').text().trim() == "1")
				$('#v_IsFingerprint').html("<span> "+getlbl("con.Have")+"</span>"); //有
			else
				$('#v_IsFingerprint').html("<span> "+getlbl("con.NotHave")+"</span>"); //无
			$('#v_SystemPassword').html("<span>******</span>"); 
			$('#v_DataUpdateTime').html($('#v_DataUpdateTime').text() + " "+getlbl("con.Second")); //秒
			$('#v_WaitTime').html($('#v_WaitTime').text() + " "+getlbl("con.Minute")); //分钟
			$('#v_CloseLightTime').html($('#v_CloseLightTime').text() + " "+getlbl("con.Minute")); //分钟
			if($('#v_DownPhoto').text().trim() == "1")
				$('#v_DownPhoto').html("<span> "+getlbl("con.Yes")+"</span>"); //是
			else
				$('#v_DownPhoto').html("<span> "+getlbl("con.No")+"</span>"); //否
			if($('#v_DownFingerprint').text().trim() == "1")
				$('#v_DownFingerprint').html("<span> "+getlbl("con.Yes")+"</span>"); //是
			else
				$('#v_DownFingerprint').html("<span> "+getlbl("con.No")+"</span>");  //否
			$('#v_Sound').html($('#v_Sound').text() + " "+getlbl("con.SoundVal")); //档
			
			var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
			$("#trv_ScreenFile11").children().eq(1).html("<iframe name='iMage1' id='iMage1' src='ImageBrowse.asp?nd="+getRandom()+"&ScreenFile=1&id="+rowid+"' width='170' height='130' scrolling='no' frameborder=0></iframe>");
			$("#trv_ScreenFile11").children().eq(3).html("<iframe name='iMage2' id='iMage2' src='ImageBrowse.asp?nd="+getRandom()+"&ScreenFile=2&id="+rowid+"' width='170' height='130' scrolling='no' frameborder=0></iframe>");
			
			$("#pData").hide();
			$("#nData").hide();
			return;
			$('td.CaptionTD').attr('width','100px');
			$("#trv_ControllerId").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_ControllerNumber").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_Location").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_MASK").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_DNS").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_EnableDHCP").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_WorkType").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_StorageMode").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_CardReader1").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_SystemPassword").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_WaitTime").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#trv_Sound").addClass('ui-widget-content jqgrow ui-row-ltr');
			$("#viewmodDataGrid").addClass('ui-jqgrid');
			$("#ViewGrid_DataGrid").addClass('ui-c-boarder-top-left');
			$('#ViewTbl_DataGrid').attr('cellspacing', '0px');
			$('#ViewTbl_DataGrid').attr('cellpadding', '0px');
			$('#ViewTbl_DataGrid').attr('border', '0px');
			//alert($("#IP").val());
		},
		afterShowForm:function(form){
		}
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
		title:getlbl("con.SyncTitle"),//"将全部数据(基本资料、时间表、假期表、输入输出表及注册卡号)同步到设备",
		id:"DataGrid_btnSync",
		onClickButton: SyncData,
		//position:"first"
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

function InitEditForm(oper,rowid)
{
	var $tr = $("#tr_ControllerNumber"), 
		$label = $tr.children("td.CaptionTD"),
		$data = $tr.children("td.DataTD");
		$label.css("width", "16%"); //设置标签宽度
	$("#EnableDHCP").click(function(){
		if($("#EnableDHCP").get(0).checked == true){
			$('#tr_Location').children().eq(2).hide(); //IP
			$('#tr_Location').children().eq(3).hide();
			$('#tr_MASK').hide(); //MASK GateWay
			$('#tr_DNS').hide();  //DNS DNS2
			$('#FormError').show();
			$('#FormError').children().eq(0).html("<td class='ui-state-highlight' colspan='2'>"+getlbl("con.DHCPMsg")+"</td>");  //启用DHCP，您可能无法得知设备IP
			//alert("选中");
		}else{
			$('#tr_Location').children().eq(2).show(); //IP
			$('#tr_Location').children().eq(3).show();
			$('#tr_MASK').show(); //MASK GateWay
			$('#tr_DNS').show();  //DNS DNS2
			$('#FormError').hide();
			$('#FormError').children().eq(0).html("<td class='i-state-error' colspan='2'></td>");  
			//alert("未选中");
		}
	});
	$("#IsFingerprint").click(function(){
		if($("#IsFingerprint").get(0).checked == true){
			$('#DownFingerprint').get(0).checked = true;
		}else{
			$('#DownFingerprint').get(0).checked = false;
		}
	});
	$("#WorkType").change(function(){
		var WorkTypeVal = $(this).children('option:selected').val();
		if(WorkTypeVal != null && WorkTypeVal.length > 1)
			WorkTypeVal = WorkTypeVal.substring(0,1);
		if(WorkTypeVal == "0"){
			$('#tr_EnableDHCP').children().eq(2).hide(); //AntiPassBackType
			$('#tr_EnableDHCP').children().eq(3).hide();
			$('#tr_CardReader1').hide();
			$('#tr_CardReader2').hide();
		}else{
			//$('#tr_AntiPassBackType').show();
			$('#tr_EnableDHCP').children().eq(2).show(); //AntiPassBackType
			$('#tr_EnableDHCP').children().eq(3).show();
			$('#tr_CardReader1').show();
			$('#tr_CardReader2').show();
		}
	});

	if(oper == "add")
		rowid = 0;
	$("#tr_ScreenFile11").children().eq(1).html("<iframe name='iMage1' id='iMage1' src='Image.asp?nd="+getRandom()+"&ScreenFile=1&id="+rowid+"' width='170' height='165' scrolling='no' frameborder=0></iframe>");
	$("#tr_ScreenFile11").children().eq(3).html("<iframe name='iMage2' id='iMage2' src='Image.asp?nd="+getRandom()+"&ScreenFile=2&id="+rowid+"' width='170' height='165' scrolling='no' frameborder=0></iframe>");	
		
	$("#EnableDHCP").click();
	$("#EnableDHCP").click();
	$("#WorkType").change();

	$("#pData").hide();
	$("#nData").hide();
}

function GetSyncStatus(){
	GetConnStatus();
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
		url: 'GetSyncStatus.asp?type=controller',
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
		url: 'GetConnStatus.asp',
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
		url: 'SyncData.asp?type=all',
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
			alert(textStatus+":ExportData.asp,"+XmlHttpRequest.responseText);
		}
	});
}
function ExportData(){
	$("#divExport").load("../Tools/ExportDataUI.asp?nd="+getRandom()+"&exportType=controllers");
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
