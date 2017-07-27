$(function(){
	var userId = getCookie(cookieUserId); 
	var strUrl = "AttendOptionList.asp?nd=" + getRandom() + "&userId=" + userId;
	var optObj = null;
	$.ajax({
				type: "get", 
				url: strUrl,
				async: false, 		
				success: function(data) {
					optObj = $.parseJSON(data);
				},
				error:function(XmlHttpRequest,textStatus, errorThrown){
					alert(errorThrown);
				}
			});

	var html = "";
	$("#frm_Caption").text(getlbl("tool.AttendOption"));

	//迟到规则
	var strLate = getOptionValue("strLate", optObj);
	var arrLate = (strLate ? strLate : "").split(",");
	html = getlbl("tool.StrLateDetail");
	html = html.replace("{{textbox}}", "<input type='text' id='LateTime' name='LateTime' value='" + (arrLate.length > 0 && !isNaN(arrLate[0]) ? arrLate[0] : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace("{{checkbox}}", "<input type='checkbox' id='HasLateTime' name='HasLateTime' " + (arrLate.length > 1 && arrLate[1] == "1" ? "checked" : "") + " role='checkbox' class='FormElement' checked='checked'>");
	$("#tr_StrLate").children(".CaptionTD").text(getlbl("tool.StrLate"));
	$("#tr_StrLate").children(".DataTD").html(html);

	//早退规则
	var strEarly = getOptionValue("strLeaveEarly", optObj);
	var arrEarly = (strEarly ? strEarly : "").split(",");
	html = getlbl("tool.StrEarlyDetail");
	html = html.replace("{{textbox}}", "<input type='text' id='EarlyTime' name='EarlyTime' value='" + (arrEarly.length > 0 && !isNaN(arrEarly[0]) ? arrEarly[0] : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace("{{checkbox}}", "<input type='checkbox' id='HasEarlyTime' name='HasEarlyTime' " + (arrEarly.length > 1 && arrEarly[1] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	$("#tr_StrEarly").children(".CaptionTD").text(getlbl("tool.StrEarly"));
	$("#tr_StrEarly").children(".DataTD").html(html);

	//请假超时
	// var strLeaveOt = getOptionValue("strAskForLeaveOT", optObj);
	// var arrLeaveOt = (strLeaveOt ? strLeaveOt : "").split(",");
	// html = getlbl("tool.StrLeaveOTDetail");
	// html = html.replace("{{textbox}}", "<input type='text' id='LeaveOTTime' name='LeaveOTTime' value='" + (arrLeaveOt.length > 0 && !isNaN(arrLeaveOt[0]) ? arrLeaveOt[0] : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	// html = html.replace("{{checkbox}}", "<input type='checkbox' id='HasLeaveOTTime' name='HasLeaveOTTime' " + (arrLeaveOt.length > 1 && arrLeaveOt[1] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	// $("#tr_StrLeaveOT").children(".CaptionTD").text(getlbl("tool.StrLeaveOT"));
	// $("#tr_StrLeaveOT").children(".DataTD").html(html);
	// $("#tr_StrLeaveOT").hide();
	
	//超时未上班
	// var strAbsent = getOptionValue("strAbsent", optObj);
	// var arrAbsent = (strAbsent ? strAbsent : "").split(",");
	// html = getlbl("tool.StrAbsentDetail");
	// html = html.replace("{{textbox}}", "<input type='text' id='AbsentTime' name='AbsentTime' value='" + (arrAbsent.length > 0 && !isNaN(arrAbsent[0]) ? arrAbsent[0] : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	// html = html.replace("{{checkbox}}", "<input type='checkbox' id='HasAbsentTime' name='HasAbsentTime' " + (arrAbsent.length > 1 && arrAbsent[1] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	// $("#tr_StrAbsent").children(".CaptionTD").text(getlbl("tool.StrAbsent"));
	// $("#tr_StrAbsent").children(".DataTD").html(html);
	// $("#tr_StrAbsent").hide();
	
	//异常处理
	var strAbnormity = getOptionValue("strAbnormity", optObj);
	html = getlbl("tool.StrAbnormityDetail");
	html = html.replace("{{checkbox}}", "<input type='checkbox' id='IsAbnormity' name='IsAbnormity' " + (strAbnormity && strAbnormity == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	$("#tr_StrAbnormity").children(".CaptionTD").text(getlbl("tool.StrAbnormity"));
	$("#tr_StrAbnormity").children(".DataTD").html(html);
	
	//申请加班
	var strOnduty = getOptionValue("strOnduty", optObj);
	var arrOnduty = (strOnduty ? strOnduty : "").split(",");
	html = getlbl("tool.StrOtApplyDetail");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsOtOn' name='IsOtOn' " + (arrOnduty.length > 0 && arrOnduty[0] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsOtOff' name='IsOtOff' " + (arrOnduty.length > 1 && arrOnduty[1] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	$("#tr_StrOtApply").children(".CaptionTD").text(getlbl("tool.StrOtApply"));
	$("#tr_StrOtApply").children(".DataTD").html(html);
	
	//超时加班
	var strOTType = getOptionValue("strOTType", optObj);
	var arrOTType = (strOTType ? strOTType : "").split(",");
	html = getlbl("tool.StrOtOverDetail");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsEarlyOt' name='IsEarlyOt' " + (arrOTType.length > 0 && arrOTType[0] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsLateOt' name='IsLateOt' " + (arrOTType.length > 1 && arrOTType[1] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' checked='checked' id='IsOtAll' name='OtOver' " + (arrOTType.length > 2 && arrOTType[2] == "1" ? "checked" : "") + " role='radiobox' class='FormElement'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' id='IsOtBase' name='OtOver' " + (arrOTType.length > 3 && arrOTType[3] == "1" ? "checked" : "") + " role='radiobox' class='FormElement'>");
	html = html.replace("{{textbox}}", "<input type='text' id='OtBase' name='OtBase' value='" + (arrOTType.length > 4 && !isNaN(arrOTType[4]) ? arrOTType[4] : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	$("#tr_StrOtOver").children(".CaptionTD").text(getlbl("tool.StrOtOver"));
	$("#tr_StrOtOver").children(".DataTD").html(html);

	$("#IsOtAll").change(function(){
		if($(this).is(":checked")){
			$("#OtBase").attr("disabled", true);
		}
	});

	$("#IsOtBase").change(function(){
		if($(this).is(":checked")){
			$("#OtBase").removeAttr("disabled");
		}
	});

	$("#IsOtAll").change();

	//结算周期
	var strTotalCycle = getOptionValue("strTotalCycle", optObj);
	var arrTotalCycle = (strTotalCycle ? strTotalCycle : "").split(",");
	var opts = "";
	for(var i = 1; i <= 31; i ++){
		if(i < 10){
			opts += "<option role='option' value='" + i + "'>0" + i + "</option>";
		}
		else{
			opts += "<option role='option' value='" + i + "'>" + i + "</option>";
		}
	}

	html = getlbl("tool.StrTotalCycleDetail");
	html = html.replace(/{{dropdownlist}}/, "<select role='select' maxlengh='20' id='StartMonth' name='StartMonth' size='1' class='FormElement ui-widget-content ui-corner-all'><option role='option' value='0'>0 - " + getlbl("tool.CurrentMonth") + "</option><option role='option' " + (arrTotalCycle.length > 0 && arrTotalCycle[0] == "1" ? "selected" : "") + " value='1'>1 - " + getlbl("tool.LastMonth") + "</option></select>");
	html = html.replace(/{{dropdownlist}}/, "&nbsp;<select role='select' maxlengh='20' id='StartDay' name='StartDay' size='1' class='FormElement ui-widget-content ui-corner-all'>" + opts + "</select>");
	html = html.replace(/{{dropdownlist}}/, "<select role='select' maxlengh='20' id='EndMonth' name='EndMonth' size='1' class='FormElement ui-widget-content ui-corner-all'><option role='option' value='0'>0 - " + getlbl("tool.CurrentMonth") + "</option><option role='option' " + (arrTotalCycle.length > 2 && arrTotalCycle[2] == "1" ? "selected" : "") + " value='1'>1 - " + getlbl("tool.LastMonth") + "</option></select>");
	html = html.replace(/{{dropdownlist}}/, "&nbsp;<select role='select' maxlengh='20' id='EndDay' name='EndDay' size='1' class='FormElement ui-widget-content ui-corner-all'>" + opts + "</select>");
	$("#tr_StrTotalCycle").children(".CaptionTD").text(getlbl("tool.StrTotalCycle"));
	$("#tr_StrTotalCycle").children(".DataTD").html(html);
	
	if(arrTotalCycle.length > 1){
		$("#StartDay option[value='" + arrTotalCycle[1] + "']").attr("selected", true);
	}
	
	if(arrTotalCycle.length > 3){
		$("#StartDay option[value='" + arrTotalCycle[3] + "']").attr("selected", true);
	}
	
	//分析下班刷卡
	var strAnalyseOffDuty = getOptionValue("strAnalyseOffDuty", optObj);
	var isFirstOff = (strAnalyseOffDuty && strAnalyseOffDuty == "0" ? true : false);
	html = getlbl("tool.StrAnalyseOffDutyDetail");
	html = html.replace(/{{radiobox}}/, "<input type='radio' " + (isFirstOff ? "checked" : "") + " id='IsFirstOff' name='AnalyseOffDuty' role='radiobox' class='FormElement'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' " + (isFirstOff ? "" : "checked") + " id='IsLastOff' name='AnalyseOffDuty' role='radiobox' class='FormElement'>");
	$("#tr_StrAnalyseOffDuty").children(".CaptionTD").text(getlbl("tool.StrAnalyseOffDuty"));
	$("#tr_StrAnalyseOffDuty").children(".DataTD").html(html);

	//出勤天数
	var blnAnalyseWorkDay = getOptionValue("blnAnalyseWorkDay", optObj);
	var isWorkDay = (blnAnalyseWorkDay && blnAnalyseWorkDay == "0" ? true : false);
	html = getlbl("tool.StrWorkDayDetail");
	html = html.replace(/{{radiobox}}/, "<input type='radio' " + (isWorkDay ? "checked" : "") + " id='IsWorkDay' name='WorkTime' role='radiobox' class='FormElement'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' " + (isWorkDay ? "" : "checked") + " id='IsWorkHour' name='WorkTime' role='radiobox' class='FormElement'>");
	$("#tr_StrWorkDay").children(".CaptionTD").text(getlbl("tool.StrWorkDay"));
	$("#tr_StrWorkDay").children(".DataTD").html(html);

	//流程审批
	var strWorkflowApproval = getOptionValue("strWorkflowApproval", optObj);
	var arrWorkflowApproval = (strWorkflowApproval ? strWorkflowApproval : "").split(",");
	html = getlbl("tool.StrWorkflowDetail");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' " + (arrWorkflowApproval.length > 0 && arrWorkflowApproval[0] == "1" ? "checked" : "") + " id='IsApproval' name='IsApproval' role='radiobox' class='FormElement'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' " + (arrWorkflowApproval.length > 1 && arrWorkflowApproval[1] == "1" ? "checked" : "") + " id='IsEmp' name='Approver' role='radiobox' class='FormElement'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='EmpCode' name='EmpCode' value='" + (arrWorkflowApproval.length > 2 && !isNaN(arrWorkflowApproval[2]) ? arrWorkflowApproval[2] : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 120px;'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' id='IsAdmin' " + (arrWorkflowApproval.length > 3 && arrWorkflowApproval[3] == "1" ? "checked" : "") + " name='Approver' role='radiobox' class='FormElement'>");
	$("#tr_StrWorkflow").children(".CaptionTD").text(getlbl("tool.StrWorkflow"));
	$("#tr_StrWorkflow").children(".DataTD").html(html);

	$("#IsApproval").change(function(){
		if($(this).is(":checked")){
			$("#IsEmp, #EmpCode, #IsAdmin").removeAttr("disabled");

			if($("#IsAdmin").is(":checked") == false){
				$("#IsEmp").attr("checked", true);
				$("#EmpCode").removeAttr("disabled");
			}
		}
		else{
			$("#IsEmp, #EmpCode, #IsAdmin").attr("disabled", true);
		}
	});
	$("#IsApproval").change();

	$("#IsAdmin").change(function(){
		if($(this).is(":checked")){
			$("#EmpCode").attr("disabled", true);
		}
	});
	$("#IsAdmin").change();

	$("#IsEmp").change(function(){
		if($(this).is(":checked")){
			$("#EmpCode").removeAttr("disabled");
		}
	});

	//$("#Approver").focus(Search);
	
	//自动统计
	var blnautoTotal = getOptionValue("blnautoTotal", optObj);
	var datAutotime = getOptionValue("datAutotime", optObj);
	var arrAutotime = (datAutotime ? datAutotime : "").split(":");
	html = getlbl("tool.StrAutoTotalDetail");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' " + (blnautoTotal && blnautoTotal == "1" ? "checked" : "") + " id='IsAutoTotal' name='IsAutoTotal' role='radiobox' class='FormElement'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='TotalHour' name='TotalHour' value='" + (arrAutotime.length > 0 && !isNaN(arrAutotime[0]) ? arrAutotime[0] : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='TotalMinute' name='TotalMinute' value='" + (arrAutotime.length > 1 && !isNaN(arrAutotime[1]) ? arrAutotime[1] : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	$("#tr_StrAutoTotal").children(".CaptionTD").text(getlbl("tool.StrAutoTotal"));
	$("#tr_StrAutoTotal").children(".DataTD").html(html);
	$("#IsAutoTotal").change(function(){
		if($(this).is(":checked")){
			$("#TotalHour, #TotalMinute").removeAttr("disabled");
		}
		else{
			$("#TotalHour, #TotalMinute").attr("disabled", true);
		}
	});
	$("#IsAutoTotal").change();

	$("#sData").html(getlbl("comm.Save") + "<span class='ui-icon ui-icon-disk'>");
	$("#sData").click(function(){		
		var strUrl = "AttendOptionEdit.asp?nd=" + getRandom() + "&userId=" + userId;
		var data = fGetFormData();
		var htmlObj = $.ajax({
				type: "post", 
				url: strUrl, 
				data: data, 
				async: false, 		
				success: function(data) {
					var responseMsg = $.parseJSON(data);

					if(responseMsg && responseMsg.message){
						alert(responseMsg.message);
					}
				},
				error:function(XmlHttpRequest,textStatus, errorThrown){
					alert(errorThrown);
				}
			});
	});

	$(".DataTD").find("div").css({"line-height": "20px"});
	$(".DataTD").css({"margin": "5px 0px"});
	$(".DataTD").find("input:checkbox").css({"vertical-align": "-3px"});
	$(".DataTD").find("input:radio").css({"vertical-align": "-3px"});
});

//获取数据
function fGetFormData(){
	var data = {};

	//迟到规则
	data.LateTime = $("#LateTime").val();
	data.HasLateTime = $("#HasLateTime").is(":checked") ? "1" : "0";

	if(isNaN(data.LateTime)){
		alert(getlbl("tool.LateMinMsg"));
		return null;
	}

	//早退规则
	data.EarlyTime = $("#EarlyTime").val();
	data.HasEarlyTime = $("#HasEarlyTime").is(":checked") ? "1" : "0";

	if(isNaN(data.EarlyTime)){
		alert(getlbl("tool.EarlyMinMsg"));
		return null;
	}

	//异常处理
	data.IsAbnormity = $("#IsAbnormity").is(":checked") ? "1" : "0";

	//申请加班
	data.IsOtOn = $("#IsOtOn").is(":checked") ? "1" : "0";
	data.IsOtOff = $("#IsOtOff").is(":checked") ? "1" : "0";

	//超时加班
	data.IsEarlyOt = $("#IsEarlyOt").is(":checked") ? "1" : "0";
	data.IsLateOt = $("#IsLateOt").is(":checked") ? "1" : "0";
	data.IsOtAll = $("#IsOtAll").is(":checked") ? "1" : "0";
	data.IsOtAll = $("#IsOtBase").is(":checked") ? "1" : "0";
	data.OtBase = $("#OtBase").val();

	//结算周期
	data.StartMonth = $("#StartMonth").val();
	data.StartDay = $("#StartDay").val();
	data.EndMonth = $("#EndMonth").val();
	data.EndDay = $("#EndDay").val();

	//分析下班刷卡
	data.AnalyseOffDuty = $("#IsLastOff").is(":checked") ? "1" : "0";

	//出勤天数
	data.AnalyseWorkDay = $("#IsWorkHour").is(":checked") ? "1" : "0";

	//流程审批
	data.IsApproval = $("#IsApproval").is(":checked") ? "1" : "0";
	data.IsEmp = $("#IsEmp").is(":checked") ? "1" : "0";
	data.EmpCode = $("#EmpCode").val();
	data.IsAdmin = $("#IsAdmin").is(":checked") ? "1" : "0";

	//自动统计
	data.IsAutoTotal = $("#IsAutoTotal").is(":checked") ? "1" : "0";
	data.TotalHour = $("#TotalHour").val();
	data.TotalMinute = $("#TotalMinute").val();
	
	return data;
}

function Search(){
	$("#divSearch").load("../Equipment/search.asp?submitfun=SearchSubmit()");
	$("#divSearch").show();
}

function SearchSubmit(){
	var strsearchField=$("#searRetColVal").html();
	var strsearchOper=$("#searRetOperVal").html();
	var strsearchString=$("#searRetDataVal").html();
}

function getOptionValue(name, options){
	if(options == undefined || options == null || name == "" || name == undefined){
		return null;
	}

	for(var i in options){
		if(options[i].name == name){
			return options[i].value;
		}
	}

	return null;
}
