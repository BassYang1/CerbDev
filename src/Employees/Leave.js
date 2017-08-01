$(document).ready(function () {
    //$("#progressbar").hide();
    CheckLoginStatus();

    function CardCheck(value, colname) {
        if (value < 0)
            return [false, getlbl("hr.CardNoLt0")];//"卡号不能小于0"
        else
            return [true, ""];
    }

    //获取操作权限
    var role = GetOperRole("employees");    
    var iapply = false, iapprove = false, irevoke = false;
    var iedit = false, iadd = false, idel = false, iview = false, irefresh = false, isearch = false, iexport = false;
    try {
        iapply = role.apply; //是否流程处理
        iapprove = role.approve; //登录用户是否用审批权限
        irevoke = role.apply;
        iedit = role.edit;
        iadd = role.add;
        idel = role.del;
        iview = role.view;
        irefresh = role.refresh;
        isearch = role.search;
        iexport = role.exportdata;
    }
    catch (exception) {
        alert(exception);
    }

    initListPage(iapprove); //初使化列表页面

    //登录员工考勤数据
    var empId = getCookie(cookieEmId); 
    var attendData = getEmpAttendJSON(empId, (new Date()).getFullYear());

    jQuery("#DataGrid").jqGrid({
        url: 'LeaveList.asp',
        editurl: "LeaveEdit.asp",
        datatype: "json",
        //colNames:['AskForLeaveId','部门','员工姓名',DepartmentCode,EmployeeCode,OtherCode,'假期类型','是否整天','开始时间','结束时间','状态','说明'],
        colNames: ['AskForLeaveId', getlbl("hr.Dept"), getlbl("hr.Name"),getlbl("hr.DeptList"), getlbl("hr.EmpList"),'OtherCode', getlbl("hr.LeaveType"), getlbl("hr.IsAllDay"),getlbl("hr.StartTime"), getlbl("hr.EndTime"), getlbl("hr.Status"),getlbl("hr.Note")],
        colModel: [
            { name: 'AskForLeaveId', index: 'AskForLeaveId', align: 'center', width: 10, hidden: true, viewable: false, search: false }, 
            { name: 'DepartmentName', index: 'DepartmentName', width: 150, align: 'center', viewable: true, search: false },      
            { name: 'Name', index: 'Name', width: 80, align: 'center', viewable: true, search: false },                
            {
                name: 'DepartmentCode', index: 'DepartmentCode', align: 'center', width: 10, editable: false, edittype: 'select', hidden: true, editrules: { required: false, edithidden: false }, viewable: false, search: false,
                editoptions: { },
            },
            {
                name: 'EmployeeCode', index: 'EmployeeCode', align: 'center', width: 10, editable: false, edittype: 'select', hidden: true, editrules: { required: false, edithidden: false }, viewable: false, search: false,
                editoptions: { },
            },
            { name: 'OtherCode', index: 'OtherCode', align: 'center', width: 40, editable: false, edittype: 'none', hidden: true, viewable: false, search: false },
            {
                name: 'AskForLeaveType', index: 'AskForLeaveType', align: 'center', width: 100, editable: true, editrules: { required: false, edithidden: true },
                edittype: 'none',
                stype: 'select', searchoptions: { sopt: ["eq","ne"], value: ":;1-" + getlbl("hr.Private") + ":" + getlbl("hr.Private") + ";2-" + getlbl("hr.Sick") + ":" + getlbl("hr.Sick") + ";3-" + getlbl("hr.Annual") + ":" + getlbl("hr.Annual")+ ";4-" + getlbl("hr.Compensatory") + ":" + getlbl("hr.Compensatory")+ ";5-" + getlbl("hr.Maternity") + ":" + getlbl("hr.Maternity")+ ";6-" + getlbl("hr.Matrimony") + ":" + getlbl("hr.Matrimony")+ ";7-" + getlbl("hr.Visit") + ":" + getlbl("hr.Visit")+ ";8-" + getlbl("hr.Lactation") + ":" + getlbl("hr.Lactation")+ ";9-" + getlbl("hr.Funeral") + ":" + getlbl("hr.Funeral")+ ";10-" + getlbl("hr.OtherLeave") + ":" + getlbl("hr.OtherLeave") }, 
                formatter: function (cellvalue, options, rowObject) { 
                    if (cellvalue && cellvalue.indexOf("-") >= 0) { 
                        return cellvalue.substr(cellvalue.indexOf("-") + 1); 
                    } 
                    else { 
                        return cellvalue; 
                    } 
                },
                formoptions: { rowpos: 3, colpos: 1 }
            },            
            {
                name: 'AllDay', index: 'AllDay', align: 'center', width: 80, editable: true, edittype: 'checkbox', hidden: false, editrules: { required: false, edithidden: true }, viewable: false, search: false,
                formoptions: { rowpos: 4, colpos: 1 },
                formatter: function (cellvalue, options, rowObject) { if (cellvalue == "True") { return getlbl("hr.Yes"); } else { return getlbl("hr.No"); } },
                editoptions: { 
                    dataInit:function(element){
                        $(element).attr("checked", true);
                        $(element).bind("change", function(){
                            if($(element).is(":checked")){
                                $("#StartTime, #EndTime").unbind('focus').bind('focus', function(){
                                    WdatePicker({isShowClear:true,dateFmt:'yyyy-MM-dd'});
                                    getDuration();
                                });
                            }
                            else{
                                $("#StartTime, #EndTime").unbind('focus').bind('focus', function(){
                                    WdatePicker({isShowClear:true,dateFmt:'yyyy-MM-dd HH:mm:ss'});
                                    getDuration();
                                });
                            }
                        });
                    }
                },
            },
            { name: 'StartTime', index: 'StartTime', align: 'center', editable: true, editrules: { required: true, date: false, edithidden: true },
                width: 150, search: false, formatter: 'date', sorttype: 'date',
                formatoptions: { srcformat: 'Y-m-d H:m:s', newformat: 'Y-m-d H:m:s' }, datefmt: 'Y-m-d H:m:s',
                editoptions: {
                    size:20,maxlengh:20,
                    dataInit:function(element){
                        $(element).bind('focus', function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'});});
                    }
                },
                formoptions: { rowpos: 5, colpos: 1, elmsuffix:"<font color=#FF0000>*</font>" }
            },
            { name: 'EndTime', index: 'EndTime', align: 'center', editable: true, editrules: { required: true, date: false, edithidden: true },
                width: 150, search: false, formatter: 'date', sorttype: 'date',
                formatoptions: { srcformat: 'Y-m-d H:m:s', newformat: 'Y-m-d H:m:s' }, datefmt: 'Y-m-d H:m:s',
                editoptions: {
                    size:20,maxlengh:20,
                    dataInit:function(element){
                        $(element).bind('focus', function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'});});
                    }
                },
                formoptions: { rowpos: 6, colpos: 1, elmsuffix:"<font color=#FF0000>*</font>" }
            },
            { name: 'Status', index: 'Status', width: 100, align: 'center', viewable: true, search: false, hidden: !iapply,
                editable: true, edittype: 'none', 
                editrules: { edithidden: true },
                formoptions: { rowpos: 7, colpos: 1 },
                formatter: function (cellvalue, options, rowObject) { 
                    if (cellvalue && cellvalue.indexOf("-") >= 0) { 
                        return cellvalue.substr(cellvalue.indexOf("-") + 2); 
                    } 
                    else { 
                        return cellvalue; 
                    } 
                },
            },
            {
                name: 'Note', index: 'Note', edittype: 'textarea', width: 350, editable: true, editrules: { required: false }, 
                search: false, sortable: false, formoptions: { rowpos: 2, colpos: 1 },
                editoptions: { rows: 3, cols: 65, dataInit: null },
                formoptions: { rowpos: 8, colpos: 1 },
            },
        ],
        caption: getlbl("hr.LeaveList"),//"请假"
        imgpath: '/images',
        multiselect: false,
        rowNum: irowNum,
        rowList: [10, 16, 20, 30],
        prmNames: { search: "_search" },
        //jsonReader: { repeatitems: false },
        pager: '#pager',
        //sortname: 'RecordID',
        multiselect: true,
        multiboxonly: true,
        viewrecords: true,
        sortorder: "desc",
        height: 'auto',
        width: 'auto',
        forceFit: true, //调整列宽度不会改变表格的宽度
        hidegrid: false,//禁用控制表格显示、隐藏的按钮
        loadtext: strloadtext,
        toppager: true,
        postData:{
            selYear: function() { return $("#selYear").val(); },
            selMonth: function() { return $("#selMonth").val(); },
            selStatus: function() { return $("#selStatus").val(); },
            selHead: function() { return $("#selHead").val(); },
            selDept: function() { return $("#selDept").val(); },
        },
        loadComplete: function (data) { //完成服务器请求后，回调函数 
            if (data == null || data.records == 0) {
                jQuery("#DataGrid").jqGrid('clearGridData');
            }
        },
    });

    jQuery("#DataGrid").jqGrid('navGrid', '#DataGrid_toppager',
        {
            edit: iapprove || iedit, add: iapply || iadd, del: irevoke || idel, view: iview, refresh: irefresh, search: isearch, 
            edittext: iapprove ? strchecktext : stredittext, addtext: iapply ? strapplytext : straddtext, deltext: iapply ? strrevoketext : strdeltext, searchtext: strsearchtext, refreshtext: strrefreshtext, viewtext: strviewtext,
            alerttext: stralerttext,
        },
        {
            top: 0, width: 850, labelswidth: '70px', height: "auto",
            dataheight: "auto",
            reloadAfterSubmit: true,
            closeAfterEdit: document.all ? false : true,    //IE下修改后，对话框不关闭。主要是上传照片Ajax无法同步执行
            jqModal: true,
            closeOnEscape: false,
            beforeInitData: function (formid) {},
            beforeShowForm: function (form) {
            },
            beforeSubmit: function (postdata, formid) {
                var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow'); //获取选择行ID
                return [true, ''];
            },
            afterSubmit: getEditafterSubmit,
            afterShowForm: function (formid) {
                var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow');
                var ret = $("#DataGrid").jqGrid('getRowData', rowid);

                $(".navButton").hide(); //隐藏按钮

                ShowLoading();
                initEditForm(attendData, ret); //绑定事件处理方法
                CloseLoadingByDept();
            },
            onclickSubmit: function (params) {
                return fGetFormData();
            },
            //selarrrow
        },  //  default settings for edit
        {
            top: 0, width: 850,
            dataheight: "auto",
            //url: addUrl,
            jqModal: true,
            reloadAfterSubmit: true,
            closeAfterAdd: document.all ? false : true, //IE下修改后，对话框不关闭。主要是上传照片Ajax无法同步执行
            //bottominfo : "<div class=&#39test'>有*号的为必填项  </div>",,
            afterSubmit: getAddafterSubmit,
            afterShowForm: function (formid) {
                ShowLoading();
                initEditForm(attendData); //绑定事件处理方法
                CloseLoadingByDept();
            },
            onclickSubmit: function (params) {
                return fGetFormData();
            },
        },  //  default settings for add
        {
            top: 0,            
            caption: iapply ? strrevoketext : strdeltext,
            msg: iapply ? strrevokemsg : strdelmsg,
            bSubmit: iapply ? strrevoketext : strdeltext,
            bCancel: getlbl("comm.Cancel"),
            reloadAfterSubmit: true,
            afterSubmit: getDelafterSubmit
        },  // delete instead that del:false we need this
        { multipleSearch: false, multipleGroup: false, showQuery: false, closeAfterSearch: true, caption: strsearchcaption, top: 60 },// search options
        {
            top: 0, width: 850, labelswidth: '70px', height: "auto",
            beforeShowForm: function () {
                var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow');
                var ret = $("#DataGrid").jqGrid('getRowData', rowid);

                $(".navButton").hide(); //隐藏按钮  
            }
        }   //view parameters
        );

    var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
    $("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
    $(".ui-paging-info", topPagerDiv).remove();
    $("#DataGrid_toppager_right").css('width', '48%');
    $("#DataGrid_toppager_left").css("width", "52%");
    $('#table_DataGrid_top_right').appendTo('#DataGrid_toppager_right');

    //导出列表数据
    if (iexport) {
        $("#DataGrid").jqGrid('navGrid', "#DataGrid_toppager_left").jqGrid('navButtonAdd', "#DataGrid_toppager_left", {
            caption: getlbl("hr.Export"),//"导出"
            buttonicon: "ui-icon-bookmark",
            title: getlbl("hr.ExportToLocal"),//"导出至本地"
            id: "DataGrid_btnSubmit",
            onClickButton: ExportData,
            //position:"first"
        });
    }

    changeNavEx();
});

function initEditForm(attendData, rowObject) {
    var id = rowObject && rowObject.AskForLeaveId ? rowObject.AskForLeaveId : "";

    //请假类型
    var htmlLeaveType = "&nbsp;";
    htmlLeaveType += "<input type='radio' checked value='1-" + getlbl("hr.Private") + "' id='Private' name='AskForLeaveType' role='radio' class='FormElement' /><label for='Private'>" + getlbl("hr.Private") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='2-" + getlbl("hr.Sick") + "' id='Sick' name='AskForLeaveType' role='radio' class='FormElement' /><label for='Sick'>" + getlbl("hr.Sick") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='3-" + getlbl("hr.Annual") + "' id='Annual' name='AskForLeaveType' role='radio' class='Annual' /><label for='Annual'>" + getlbl("hr.Annual") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='4-" + getlbl("hr.Compensatory") + "' id='Compensatory' name='AskForLeaveType' role='radio' class='FormElement' /><label for='Compensatory'>" + getlbl("hr.Compensatory") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='5-" + getlbl("hr.Maternity") + "' id='Maternity' name='AskForLeaveType' role='radio' class='FormElement' /><label for='Maternity'>" + getlbl("hr.Maternity") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='6-" + getlbl("hr.Matrimony") + "' id='Matrimony' name='AskForLeaveType' role='radio' class='FormElement' /><label for='Matrimony'>" + getlbl("hr.Matrimony") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='7-" + getlbl("hr.Visit") + "' id='Visit' name='AskForLeaveType' role='radio' class='FormElement' /><label for='Visit'>" + getlbl("hr.Visit") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='8-" + getlbl("hr.Lactation") + "' id='Lactation' name='AskForLeaveType' role='radio' class='FormElement' /><label for='Lactation'>" + getlbl("hr.Lactation") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='9-" + getlbl("hr.Funeral") + "' id='Funeral' name='AskForLeaveType' role='radio' class='FormElement' /><label for='Funeral'>" + getlbl("hr.Funeral") + "</label>&nbsp;";
    htmlLeaveType += "<input type='radio' value='10-" + getlbl("hr.OtherLeave") + "' id='OtherLeave' name='AskForLeaveType' role='radio' class='FormElement' /><label for='OtherLeave'>" + getlbl("hr.OtherLeave") + "</label>";
    
    $("#tr_AskForLeaveType").children("td.DataTD").html(htmlLeaveType);
    $("#tr_AskForLeaveType").children("td.DataTD").children().css("vertical-align", "middle");
    $("#tr_AskForLeaveType").children("td.DataTD").children("label").css("margin-left", "2px");
    
    $("#tr_AskForLeaveType").children("td.DataTD").children("input").bind("change", function(){
        changeLeaveStatus(attendData, $(this).val().substr(0, $(this).val().indexOf("-")));
    });

    if(rowObject && rowObject.AskForLeaveType){
        var lType = rowObject.AskForLeaveType;
        lType = lType.substr(0, lType.indexOf("-"));

        $("#tr_AskForLeaveType").children("td.DataTD").children("input[value^='" + lType + "']").attr("checked", "checked");
    }

    changeLeaveStatus(attendData);

    //绑定事件
    $("#StartTime, #EndTime").bind("focus", getDuration);


    if(rowObject && rowObject.StartTime && rowObject.EndTime){
        $("#StartTime").val(rowObject.StartTime);
        $("#EndTime").val(rowObject.EndTime);
    }

    if(rowObject && rowObject.AllDay && rowObject.AllDay == "True"){
        $("#AllDay").attr("checked", "checked");
    }

    if(rowObject && rowObject.Note){
        $("#Note").val(rowObject.Note);
    }

    if(rowObject && rowObject.AskForLeaveId){
        getDuration();

        $("#FrmGrid_DataGrid").find("input,textarea").attr("disabled", true);
        $("#sData").html(strapprovetext + "<span class='ui-icon ui-icon-disk'>");
        $("#sData").after("<input type='hidden' id='hdRefuse' /><a id='fData' class='fm-button ui-state-default ui-corner-all fm-button-icon-left'>" + strrefusetext + "<span class='ui-icon ui-icon-disk'></span></a>");
        $("#tr_Note").after("<tr rowpos='9' class='FormData' id='tr_Description'><td class='CaptionTD'>" + getlbl('hr.ApproveDesc') + "</td><td class='DataTD'>&nbsp;<textarea rows='3' cols='65' id='Description' name='Description' role='textbox' multiline='true' class='FormElement ui-widget-content ui-corner-all'></textarea></td></tr>");
        $("#fData").click(function(){
            $("#hdRefuse").val("1");
            $("#sData").click();
        });
    }
    else{
        $("#sData").html(strapplytext + "<span class='ui-icon ui-icon-disk'>");
    }

    //加载部门
    //initDepartments(id); 
    //加载员工
    //initEmployees(); 
}

function changeLeaveStatus(){
    var attendData;
    if(arguments.length > 0){
        attendData = arguments[0]; 
    }

    var lType = "1";
    if(arguments.length > 1){
        lType = arguments[1]; 
    }

    var statusHtml = "<table id='tbl_LeaveStatus' class='FormElement' style='margin-left:13px;' width='90%' border='0' cellpadding='0' cellspacing='0'><tbody>";

    if(lType == "3"){
        statusHtml += "<tr class='FormData'><td>" + getlbl("hr.YearLeave") + "</td>" + "<td>" + (attendData.Annual0 ? attendData.Annual0 : 0) + getlbl("hr.Day") + "</td></tr>" + 
                "<tr class='FormData'><td>" + getlbl("hr.AppliedLeave") + "</td>" + "<td>" + (attendData.Annual2 ? attendData.Annual2 : 0) + getlbl("hr.Day") + "</td></tr>" + 
                "<tr class='FormData'><td>" + getlbl("hr.RemainLeave") + "</td>" + "<td>" + (attendData.Annual1 ? attendData.Annual1 : 0) + getlbl("hr.Day") + "</td></tr>";
    }
    else{
        var leaveNum = 0;
        if(iType = "1") leaveNum = attendData.Personal ? attendData.Personal : 0;
        else if(iType = "2") leaveNum = attendData.Sick ? attendData.Sick : 0;
        else if(iType = "4") leaveNum = attendData.Compensatory ? attendData.Compensatory : 0;
        else if(iType = "5") leaveNum = attendData.Maternity ? attendData.Maternity : 0;
        else if(iType = "6") leaveNum = attendData.Wedding ? attendData.Wedding : 0;
        else if(iType = "7") leaveNum = attendData.Visit ? attendData.Visit : 0;
        else if(iType = "8") leaveNum = attendData.Lactation ? attendData.Lactation : 0;
        else if(iType = "9") leaveNum = attendData.Funeral ? attendData.Funeral : 0;
        else if(iType = "10") leaveNum = attendData.Other ? attendData.Other : 0;

        statusHtml += "<tr class='FormData'><td>" + getlbl("hr.AppliedLeave") + "</td>" + "<td>" + leaveNum + getlbl("hr.Day") + "</td></tr>";
    }

    statusHtml += "<tr class='FormData'><td>" + getlbl("hr.ApplingLeave") + "</td>" + "<td><span id='leaveNum'>" + "" + " </span></td></tr>";
    statusHtml += "</TBODY></TABLE>";

    $("#tr_Status").children("td.DataTD").html("&nbsp;" + statusHtml);
    $("#tbl_LeaveStatus").find("td:even").css({"width":"15%" });
    $("#tbl_LeaveStatus").find("td:odd").css({"text-align": "left" });
    $("#tbl_LeaveStatus").find("tr").css({"line-height": "25px" });
    getDuration(); //获取请假数
}

function fGetFormData() {
    var data = {};

    //是否执行拒绝
    var irefuse = $("#hdRefuse").val();
    data.Refuse = irefuse && irefuse == "1" ? "1" : "0";

    //假期类型
    data.LeaveType = $("#tr_AskForLeaveType").find("input[name='AskForLeaveType']").filter(":checked").val();
    //data.LeaveType = data.LeaveType.substr(data.LeaveType.indexOf("-") + 1);

    //是否整天
    data.AllDay = $("#AllDay").is(":checked") ? "1" : "0";

    //开始时间
    data.StartTime = $("#StartTime").val();

    //结束时间
    data.EndTime = $("#EndTime").val();

    //请假时间
    data.LeaveNum = $("#LeaveNum").html();

    //备注
    data.Note = $("#Note").val();

    //员工Id
    data.EmpId = getCookie(cookieEmId);

    return data;
}

function gridReload() {
    $("#DataGrid").jqGrid('setGridParam', { url: "LeaveList.asp", page: 1, }).trigger("reloadGrid");
}

function GetTime() {
    WdatePicker({ isShowClear: true, dateFmt: 'HH:mm', isShowToday: false, qsEnabled: false });
};

function ExportData() {
    $("#divExport").load("../Tools/ExportDataUI.asp?nd=" + getRandom() + "&exportType=askforleave");
    $("#divExport").show();
}