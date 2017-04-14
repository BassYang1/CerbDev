<%
	dim EmId 
	EmId = Request.QueryString("id")
	if EmId= "" then EmId = 0
%>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" media="screen" href="../css/jquery-ui-1.10.2.redmond.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../css/ui.jqgrid.css"/>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/lang/lang.js"></script>
<script>
	document.write("<scr"+"ipt type='text/javascript' src='../js/lang/"+getLan()+"'><\/script>");
</script>
<script type="text/javascript" src="../js/plugins/jquery.form.js"></script>
<script type="text/javascript" src="../js/custom/system.js"></script>
</head>
<style type="text/css">
.file-box{ position:relative;width:53px; top:3px; }
.btn{ background-color:#FFF; border:1px solid #CDCDCD;height:24px; width:52px;}
.file{ position:absolute; top:0; left:-3px; height:26px; filter:alpha(opacity:0);opacity: 0;width:52px }
</style>

<body topmargin="0" style="width:100%">
<form name="frmImage" id="frmImage" method="post" target="ImageUp" enctype="multipart/form-data">
<table align="left" cellspacing="0" cellpadding=0 border=0 width="105">
	<tr align="center"><td>
	<div id="divImg" style='width:105px; height:125px; '> 
	<img name="Imgsrc" src="" id="img" width="105" height="125" border="1">
	</div> 
	</td></tr>
	<tr><td>
	<div class="file-box" style="position:relative; float:left; display:inline">
	 <input type='button' class='btn FormElement ui-widget-content ui-corner-all' id="btnBrowse" value='Browse...' />
	 <input type="file" name="file" class="file" id="iFile" size="9" onChange="ImageChange()" onKeyDown="return false;" onKeyPress="return false;" onpaste="return false" ondragenter="return false" />
	</div>
     <input type="button" class='btn FormElement ui-widget-content ui-corner-all' value="Delete" id="btnDel" style="position:relative; float:left; display:inline;top:3px; "/>
	</td></tr>
</table>
</form>
<br>
</body>
<iframe src="" name="ImageUp" width="0" height="0" scrolling="auto" frameborder="0" id="ImageUp" style="display:none"></iframe>

<script language="javascript">
var strData;
var isChangePhoto = false;
var delPhoto = 0;
$("#btnBrowse").val(getlbl("hr.Browse"));
$("#btnDel").val(getlbl("hr.Delete"));

<% if clng(EmId) > 0 then %>
var strUrl = 'DisplayImg.asp?nd='+getRandom()+'&id='+<%response.Write(EmId)%>;
var htmlObj = $.ajax({url:strUrl,async:false});
strData = htmlObj.responseText;
<% end if %>

if(strData){
	var pic = document.getElementById("img");
	pic.src='DisplayImg.asp?nd='+getRandom()+'&id='+<%response.Write(EmId)%>;
}
else{
	var pic = document.getElementById("img");
	//pic.src="../images/photo.gif";
	pic.src="../"+getlbl("login.photo");
}

function ImageChange() {
	var pic = document.getElementById("img");
	var file = document.getElementById("iFile");
	var ext=file.value.substring(file.value.lastIndexOf(".")+1).toLowerCase();
	// gif在IE浏览器暂时无法显示
	if(ext!='png'&&ext!='jpg'&&ext!='jpeg'&&ext!='gif'&&ext!='bmp'){
		//alert("仅支持png|jpg|jpeg|gif|bmp格式图片！"); 
		alert(getlbl("hr.SupportPhotoFormat")); 
		return;
	}
	// IE浏览器 
	if (document.all) {
		file.select();
		//file.blur();
		document.getElementById("btnDel").focus();//不加这句，IE10下报document.selection.createRange()拒绝访问
		var reallocalpath = document.selection.createRange().text;
		document.getElementById("divImg").innerHTML=""; 
		document.getElementById("divImg").style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\"" + reallocalpath + "\")";//使用滤镜效果 
		document.getElementById('divImg').style.border="1px solid #000";
	}else{
		//FF及 IE11(IE11在上面判断失效)
		html5Reader(file);
	}
	isChangePhoto = true;
	delPhoto = 0;
}
 
function html5Reader(file){
	var file = file.files[0];
	var reader = new FileReader();
	reader.readAsDataURL(file);
	reader.onload = function(e){
		//var pic = document.getElementById("img");
		//pic.src=this.result;
		$("#img").attr("src",this.result) ;
		//checkSize();
	}
}

$("#btnDel").click(function(){
	delPhoto = 1;
	if (document.all){
		document.getElementById("divImg").innerHTML=""; 
		document.getElementById("divImg").style.filter = "";//使用滤镜效果 
		document.getElementById('divImg').style.border="1px solid #000";
	}
	else{
		//$("#img").attr("src","../images/photo.gif") ;
		$("#img").attr("src","../"+getlbl("login.photo")) ;
	}
});

function fSubmit( id )
{
	if(!isChangePhoto && delPhoto != 1)
		return true;
	var RetVal = false;
	$("#frmImage").ajaxSubmit({
		async:false,
		url: 'ImageUp.asp?nd='+getRandom()+'&id='+id+'&delPhoto='+delPhoto,
		type: "post",
		dataType: "json",	
		success: function(data) {
			try{
				//var responseMsg = $.parseJSON(data);
				var responseMsg = data;
				if(responseMsg.success == false){
					alert(responseMsg.message);
				}else if(responseMsg.success == true){
					//上传成功
					RetVal = true;
					//alert(responseMsg.message);
				}else{
					alert(getlbl("hr.UpPhotoEx"));
					//alert("上传照片异常");
				}
			}
			catch(exception) {
				alert(exception);
			}
		},
		error: function(data, status, e) {
			alert(getlbl("hr.UpPhotoFail") + e);
		   //alert("上传照片失败，可能原因：照片超过10K. 错误信息：" + e);
		}
	});
	//IE低版本不支持html5的formdata对象，所以用的iframe来模拟，设置的async无效。
	if(document.all){ 
		//IE下直接返回true. 无法取得success后的值 。因此先返回true.
		return true;
	}
	else{
		return RetVal;
	}
}

</script>
</html>



