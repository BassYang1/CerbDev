<%
dim strexportType
strexportType = trim(Request.QueryString("exportType"))
%>
<!--#include file="..\Conn\GetLbl.asp"-->
<style>
.progress-label {
	float: left;
	margin-left: 35%;
	margin-top: 5px;
	font-weight: bold;
	text-shadow: 1px 1px 0 #fff;
}
#progressbar {
	margin-top: 10%;
	margin-left: 10%;
	HEIGHT: 26px;
	width:200px;
} 
</style>
<div id="progressbar" style="position: absolute; z-index: 100002; display:none; top: 0px; left:0px;"><div class="progress-label"><%=GetToolLbl("Exporting")%><!--正在导出--></div></div>
<div id="divExportDetail" style="display:none"></div>

<div id="exportmodfbox_Custom" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable" style="height: auto; width: 370px; top: 120px; left: 314.5px; display: block;" tabindex="-1" role="dialog" aria-describedby="dialog-confirm-ExportData" aria-labelledby="ui-id-1">
	<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix" id="exportfbox_Custom"><span id="ui-id-1" class="ui-dialog-title"><%=GetToolLbl("SelExportFormat")%><!--选择导出格式--></span><button id="btnClose" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only ui-dialog-titlebar-close " role="button" aria-disabled="false" title="close"><span class="ui-button-icon-primary ui-icon ui-icon-closethick"></span><span class="ui-button-text">close</span></button></div>
	<div  style="width: auto; min-height: 0px; max-height: none; height: auto;" id="dialog-confirm-ExportData" class="ui-dialog-content ui-widget-content">
		<p></p><div id="IEPath" style="display:none" ><%=GetToolLbl("Path")%><!--&nbsp;路径&nbsp;--><span id="rootPath">C:\</span><input type="text" class="text ui-widget-content ui-corner-all" id="FileName" name="FileName">
		&nbsp;<button id="btnChangePath" style="height:22px;" type="button" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false"><span class="ui-button-text"><%=GetToolLbl("SelPath")%><!--选择路径--></span></button></div><p></p>
		<div class="ui-dialog-buttonset" style="float:left; margin:0 1px 10px 0;margin-left:88px"><button id="btnExportCSV" type="button" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false"><span class="ui-button-text"><%=GetToolLbl("ExportCSV")%><!--导出CSV--></span></button><button id="btnExportExcel" type="button" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="margin:0 3px" role="button" aria-disabled="false"><span class="ui-button-text"><%=GetToolLbl("ExportExcel")%><!--导出Excel--></span></button></div>
	</div>
	<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix" id="divMsgShow"><span style="float:left; margin:0 1px 5px 0;" class="ui-icon ui-icon-alert"></span><%=GetToolLbl("ExportAlertMsg")%><!--提示：CSV导出性能、速度优于Excel.<br />数据量较大时(约大于2万)，建议使用IE导出--></div>
</div>
<script language="javascript">
//IE浏览器导出，使用ActiveX组件，因此需要设置本地存储路径
//非IE浏览器导出，使用文件下载的文件
var defaultFileName = "<%=strexportType%>";
var strIE = "0";
//if (document.all) {
if(isIE()){
	//IE浏览器
	strIE = "1";
	var mydate = new Date();
	defaultFileName = defaultFileName+mydate.getFullYear().toString();
	defaultFileName=defaultFileName+(mydate.getMonth()>=9?(mydate.getMonth()+1).toString():'0' + (mydate.getMonth()+1));
	defaultFileName=defaultFileName+(mydate.getDate()>=10?mydate.getDate().toString():'0' + mydate.getDate());
	defaultFileName=defaultFileName+(mydate.getSeconds()>=10?mydate.getSeconds().toString():'0' + mydate.getSeconds());
	$("#FileName").val(defaultFileName);//设置默认的文件名
	$("#IEPath").show();
	$("#divMsgShow").html("<span style='float:left; margin:0 1px 5px 0;' class='ui-icon ui-icon-alert'></span>"+"<%=GetToolLbl("ExportAlertMsg2")%>");//"提示：CSV导出性能、速度优于Excel."
}
else{
	$("#FileName").val(defaultFileName);
	$("#IEPath").hide();
}
$('#btnClose').hover(function(){
		$(this).addClass('ui-state-hover');		
	},function(){
		$(this).removeClass('ui-state-hover');	
	}
);
$('#btnExportCSV').hover(function(){
		$(this).addClass('ui-state-hover');		
	},function(){
		$(this).removeClass('ui-state-hover');	
	}
);
$('#btnExportExcel').hover(function(){
		$(this).addClass('ui-state-hover');		
	},function(){
		$(this).removeClass('ui-state-hover');	
	}
);
$('#btnChangePath').hover(function(){
		$(this).addClass('ui-state-hover');		
	},function(){
		$(this).removeClass('ui-state-hover');	
	}
);
//关闭对话框 
$("#btnClose").click(function(){
	$("#exportmodfbox_Custom").parent().html("");
	$("#exportmodfbox_Custom").parent().hide();
})
//导出CSV 
$("#btnExportCSV").click(function(){
	if(strIE == "1"){
		if($("#FileName").val() == ""){
			//alert("请输入文件名");
			alert("<%=GetToolLbl("FileNameNull")%>");
			return;
		}
	}
	var IEFileName = $("#rootPath").html()+$("#FileName").val()+".csv";
	$("#exportmodfbox_Custom").hide();
	ShowExportMsg("<%=GetToolLbl("Exporting")%>");	//"正在导出"
	$("#progressbar").show();
	var htmlObj = $.ajax({url:'../Tools/ExportDataExec.asp?nd='+getRandom()+'&exportType=<%=strexportType%>&exportFlag=csv&isIE='+strIE+'&IEFileName='+IEFileName,async:false});
	$("#divExportDetail").html(htmlObj.responseText);
	$("#progressbar").hide();
	$("#btnClose").click();
})
//导出Excel
$("#btnExportExcel").click(function(){
	if(strIE == "1"){
		if($("#FileName").val() == ""){
			//alert("请输入文件名");
			alert("<%=GetToolLbl("FileNameNull")%>");
			return;
		}
	}
	var IEFileName = $("#rootPath").html()+$("#FileName").val()+".xls";
	$("#exportmodfbox_Custom").hide();
	ShowExportMsg("<%=GetToolLbl("Exporting")%>");	//"正在导出"
	$("#progressbar").show();
	var htmlObj = $.ajax({url:'../Tools/ExportDataExec.asp?nd='+getRandom()+'&exportType=<%=strexportType%>&exportFlag=excel&isIE='+strIE+'&IEFileName='+IEFileName,async:false});
	$("#divExportDetail").html(htmlObj.responseText);
	$("#progressbar").hide();
	$("#btnClose").click();
})

//选择路径
$("#btnChangePath").click(function(){
	SelPath();
})

function SelPath(){
	try{    
  		var Message = "Select Folder";  //选择框提示信息    
  		var Shell = new ActiveXObject("Shell.Application");    
  		var Folder = Shell.BrowseForFolder(0,Message,0x0040,0x11);//起始目录为：我的电脑    
  		//var Folder = Shell.BrowseForFolder(0,Message,0); //起始目录为：桌面
  		if(Folder != null){    
    		Folder = Folder.items();  // 返回 FolderItems 对象    
    		Folder = Folder.item();  // 返回 Folderitem 对象    
    		Folder = Folder.Path;   // 返回路径    
    		if(Folder.charAt(Folder.length-1) != "\\"){    
      			Folder = Folder + "\\"; 
			} 
			if(Folder.substr(1,2) == ":\\") document.getElementById("rootPath").innerHTML = Folder;  
		}  
	}
	catch(e){ alert(e.message);} 
	return false;
}
function ShowExportMsg(strMsg) {
	var progressbar = $( "#progressbar" ),
		progressLabel = $( ".progress-label" );
	progressLabel.text(strMsg);
	
	progressbar.progressbar({
		value: false,
		change: function() {
			progressLabel.text( progressbar.progressbar( "value" ) + "%" );
		},
		/*complete: function() {
			progressLabel.text( "Complete!" );
		}*/
	});
};

drag("exportfbox_Custom");
function drag(obj)
{
	if (typeof obj == "string") {
		var obj = document.getElementById(obj);
		obj.orig_index=obj.style.zIndex;//设置当前对象永远显示在最上层
	}
	obj.onmousedown=function (a){//鼠标按下
		this.style.cursor="move";//设置鼠标样式
		this.style.zIndex=1000;
		var d=document;
		if(!a) a=window.event;//按下时创建一个事件
		var x=a.clientX;//x=鼠标相对于网页的x坐标-网页被卷去的宽-待移动对象的左外边距
		var y=a.clientY;//y=鼠标相对于网页的y左边-网页被卷去的高-待移动对象的左上边距
		//var OldLeft = parseInt(obj.style.left.replace("px",""));
		//var OldTop = parseInt(obj.style.top.replace("px",""));
		var OldLeft = parseInt($("#exportmodfbox_Custom").css('left').replace("px",""));
		var OldTop = parseInt($("#exportmodfbox_Custom").css('top').replace("px",""));
		d.onmousemove=function(a){//鼠标移动
			if(!a) a=window.event;//移动时创建一个事件
			var Newleft=OldLeft + a.clientX-x;
			var Newtop=OldTop + a.clientY-y;
			if (Newleft<0) Newleft = 0;
			if (Newtop<0) Newtop = 0;
			$("#exportmodfbox_Custom").css('left', Newleft + 'px').css('top', Newtop + 'px');
		}
		d.onmouseup=function (){//鼠标放开
			document.onmousemove=null;
			document.onmouseup = null;
			obj.style.cursor="normal";//设置放开的样式
			obj.style.zIndex=obj.orig_index;
		}
	}  
	
}
</script>