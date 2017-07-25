$(function(){
	var userId = getCookie(cookieUserId); 
	var strUrl = "LeaveOptionList.asp?nd=" + getRandom() + "&userId=" + userId;
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
	$("#frm_Caption").text(getlbl("tool.LeaveOption"));

	//可休年假职员
	var deptHtml = "<iframe id='depframe' name='depframe' width='90%' height='180' marginheight='0' marginwidth='0' frameborder='0' align='center' src='../Tools/GetUserEditDept.html?nd=" + getRandom() + "&oper=annaloption&option=strAnnalDeptEmps&userId=" + userId + "'></iframe>";
	html = getlbl("tool.StrAnnalEmpDetail");
	html = html.replace(/{{dropdownlist}}/, deptHtml);
	$("#tr_StrAnnalEmp").children(".CaptionTD").text(getlbl("tool.StrAnnalEmp"));
	$("#tr_StrAnnalEmp").children(".DataTD").html(html);

	//可休年假
	var basicDay = getOptionValue("intBasicDay", optObj);
	var increaseType1 = getOptionValue("IncreaseType1", optObj);
	var arrType1, increaseYear1, increaseDay1
	var increaseType2 = getOptionValue("IncreaseType2", optObj);
	var arrType2, increaseYear2, increaseDay2, increaseYear3, increaseDay3
	var maxVacation = getOptionValue("intMaxVacation", optObj);
	var continueNext = getOptionValue("blnContinueNext", optObj);

	if(increaseType1 == undefined || increaseType1 == "" || increaseType1 == null ||
		increaseType2 == undefined || increaseType2 == "" || increaseType2 == null){
		increaseType1 = "1";
	}
	else{
		arrType1 = (increaseType1 ? increaseType1 : "").split(",");
		increaseType1 = arrType1.length > 0 ? arrType1[0] : "";
		increaseYear1 = arrType1.length > 1 ? arrType1[1] : "";
		increaseDay1 = arrType1.length > 2 ? arrType1[2] : "";

		arrType2 = (increaseType2 ? increaseType2 : "").split(",");
		increaseType2 = arrType1.length > 0 ? arrType1[0] : "";
		increaseYear2 = arrType1.length > 1 ? arrType1[1] : "";
		increaseDay2 = arrType1.length > 2 ? arrType1[2] : "";
		increaseYear3 = arrType1.length > 3 ? arrType1[3] : "";
		increaseDay3 = arrType1.length > 4 ? arrType1[4] : "";
	}


	html = getlbl("tool.StrAnnalDetail");
	html = html.replace(/{{textbox}}/, "<input type='text' id='BasicAnnualDay' name='BasicAnnualDay' value='" + (basicDay && !isNaN(basicDay) ? basicDay : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' " + (increaseType1 == "1" ? "checked" : "") + " id='IncreaseType1' name='IncreaseType' role='radiobox' class='FormElement'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseYear1' value='" + (increaseYear1 && !isNaN(increaseYear1) ? increaseYear1 : "") + "' name='IncreaseYear1' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseDay1' value='" + (increaseDay1 && !isNaN(increaseDay1) ? increaseDay1 : "") + "' name='IncreaseDay1' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{radiobox}}/, "<input type='radio' id='IncreaseType2' " + (increaseType2 == "1" ? "checked" : "") + " ame='IncreaseType' role='radiobox' class='FormElement'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseYear2' value='" + (increaseYear2 && !isNaN(increaseYear2) ? increaseYear2 : "") + "' name='IncreaseYear2' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseDay2' value='" + (increaseDay2 && !isNaN(increaseDay2) ? increaseDay2 : "") + "' name='IncreaseDay2' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseYear3' value='" + (increaseYear3 && !isNaN(increaseYear3) ? increaseYear3 : "") + "' name='IncreaseYear3' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='IncreaseDay3' value='" + (increaseDay3 && !isNaN(increaseDay3) ? increaseDay3 : "") + "' name='IncreaseDay3' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='ContinueNext' name='ContinueNext' " + (continueNext == "1" ? "checked" : "") + "' role='checkbox' class='FormElement' checked='checked'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='MaxAnnualNum' name='MaxAnnualNum' value='" + (maxVacation && !isNaN(maxVacation) ? maxVacation : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	$("#tr_StrAnnal").children(".CaptionTD").text(getlbl("tool.StrAnnal"));
	$("#tr_StrAnnal").children(".DataTD").html(html);

	$("#IncreaseType1").change(function(){
		if($(this).is(":checked")){
			$("#IncreaseYear2, #IncreaseDay2, #IncreaseYear3, #IncreaseDay3").attr("disabled",true).val("");
			$("#IncreaseYear1, #IncreaseDay1").removeAttr("disabled");
		}
	});

	$("#IncreaseType2").change(function(){
		if($(this).is(":checked")){
			$("#IncreaseYear1, #IncreaseDay1").attr("disabled",true).val("");
			$("#IncreaseYear2, #IncreaseDay2, #IncreaseYear3, #IncreaseDay3").removeAttr("disabled");
		}
	});

	if(increaseType1 == "1"){
		$("#IncreaseType2").change();
	}
	else{
		$("#IncreaseType1").change();
	}

	//假期类型
	var skipHoliday = getOptionValue("strSkipHoliday", optObj);
	var workTime = getOptionValue("intWorkTime", optObj);
	var arrHoliday = (skipHoliday ? skipHoliday : "").split(",");
	html = getlbl("tool.StrSkipHolidayDetail");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsPrivate' name='IsPrivate' " + (arrHoliday.length > 0 && arrHoliday[0] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsSick' name='IsSick' " + (arrHoliday.length > 1 && arrHoliday[1] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsCompensatory' name='IsCompensatory' " + (arrHoliday.length > 2 && arrHoliday[2] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsMaternity' name='IsMaternity' " + (arrHoliday.length > 3 && arrHoliday[3] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsMatrimony' name='IsMatrimony' " + (arrHoliday.length > 4 && arrHoliday[4] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsLactation' name='IsLactation' " + (arrHoliday.length > 5 && arrHoliday[5] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsOther' name='IsOther' " + (arrHoliday.length > 6 && arrHoliday[6] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsTrip' name='IsTrip' " + (arrHoliday.length > 7 && arrHoliday[7] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsAnnual' name='IsAnnual' " + (arrHoliday.length > 8 && arrHoliday[8] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsHolidy' name='IsHolidy' " + (arrHoliday.length > 9 && arrHoliday[9] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsInjury' name='IsInjury' " + (arrHoliday.length > 10 && arrHoliday[10] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsFuneral' name='IsFuneral' " + (arrHoliday.length > 11 && arrHoliday[11] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{checkbox}}/, "<input type='checkbox' id='IsVisit' name='IsVisit' " + (arrHoliday.length > 12 && arrHoliday[12] == "1" ? "checked" : "") + " role='checkbox' class='FormElement'>");
	html = html.replace(/{{textbox}}/, "<input type='text' id='WorkTime' name='WorkTime' value='" + (workTime && !isNaN(workTime) ? workTime : "") + "' role='textbox' class='FormElement ui-widget-content ui-corner-all' style='width: 15px;'>");
	$("#tr_StrLeaveType").children(".CaptionTD").html(getlbl("tool.StrSkipHoliday"));
	$("#tr_StrLeaveType").children(".DataTD").html(html);

	$("#sData").html(getlbl("comm.Save") + "<span class='ui-icon ui-icon-disk'>");
	$("#sData").click(function(){		
		var strUrl = "LeaveOptionEdit.asp?nd=" + getRandom() + "&userId=" + userId;
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

	//可休年假职员
	data.AnnalDeptEmps = GetSelDepts().Ids;

	//年假规则
	data.BasicAnnualDay = $("#BasicAnnualDay").val();
	data.IncreaseType1 = $("#IncreaseType1").is(":checked") ? "1" : "0";
	data.IncreaseYear1 = $("#IncreaseYear1").val();
	data.IncreaseDay1 = $("#IncreaseDay1").val();
	data.IncreaseType2 = $("#IncreaseType2").is(":checked") ? "1" : "0";
	data.IncreaseYear2 = $("#IncreaseYear2").val();
	data.IncreaseDay2 = $("#IncreaseDay2").val();
	data.IncreaseYear3 = $("#IncreaseYear3").val();
	data.IncreaseDay3 = $("#IncreaseDay3").val();
	data.ContinueNext = $("#ContinueNext").is(":checked") ? "1" : "0";
	data.MaxAnnualDay = $("#MaxAnnualDay").val();

	//请假期间的[休息日、法定假]仍计为[休息日、法定假]
	data.IsPrivate = $("#IsPrivate").is(":checked") ? "1" : "0";
	data.IsSick = $("#IsSick").is(":checked") ? "1" : "0";
	data.IsCompensatory = $("#IsCompensatory").is(":checked") ? "1" : "0";
	data.IsMaternity = $("#IsMaternity").is(":checked") ? "1" : "0";
	data.IsMatrimony = $("#IsMatrimony").is(":checked") ? "1" : "0";
	data.IsLactation = $("#IsLactation").is(":checked") ? "1" : "0";
	data.IsOther = $("#IsOther").is(":checked") ? "1" : "0";
	data.IsTrip = $("#IsTrip").is(":checked") ? "1" : "0";
	data.IsAnnual = $("#IsAnnual").is(":checked") ? "1" : "0";
	data.IsHolidy = $("#IsHolidy").is(":checked") ? "1" : "0";
	data.IsInjury = $("#IsInjury").is(":checked") ? "1" : "0";
	data.IsFuneral = $("#IsFuneral").is(":checked") ? "1" : "0";
	data.IsVisit = $("#IsVisit").is(":checked") ? "1" : "0";
	data.WorkTime = $("#WorkTime").val();

	return data;
}

function GetSelDepts() {
    return $("#depframe")[0].contentWindow.GetCheckDepts(); //{Ids: Ids, Names: Names}
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
