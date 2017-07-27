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
    var iapply = false, iapprove = false, irevoke = false, ipend = false, iedit = false, iadd = false, idel = false, iview = false, irefresh = false, isearch = false, iexport = false;
    try {
        iapply = role.apply;
        iapprove = role.approve;
        irevoke = role.approve;
        ipend = role.apply;
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

    initList(iapprove); //初使化列表数据

    //登录员工考勤数据
    var empId = getCookie(cookieEmId); 

    jQuery("#DataGrid").jqGrid({
        url: 'TripList.asp',
        editurl: "TripEdit.asp",
        datatype: "json",
        //colNames:['AskForLeaveId','部门','员工姓名',DepartmentCode,EmployeeCode,OtherCode,'出差地点','拟办事项','开始时间','结束时间','状态'],
        colNames: ['AskForLeaveId', getlbl("hr.Dept"), getlbl("hr.Name"),getlbl("hr.DeptList"), getlbl("hr.EmpList"),'OtherCode', getlbl("hr.TripDes"), getlbl("hr.TripThing"), getlbl("hr.IsAllDay"), getlbl("hr.StartTime"), getlbl("hr.EndTime"), getlbl("hr.Status")],
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
                name: 'Note', index: 'Note', align: 'center', width: 250, editable: true, hidden: false, editrules: { required: false, edithidden: true }, viewable: false, search: false,
                formoptions: { rowpos: 1, colpos: 1 },
            },
            {
                name: 'TransactThing', index: 'TransactThing', edittype: 'textarea', width: 220, editable: true, editrules: { required: false }, 
                search: false, sortable: false, formoptions: { rowpos: 2, colpos: 1 },
                editoptions: { rows: 3, cols: 65, dataInit: null },
                formoptions: { rowpos: 2, colpos: 1 },
            },         
            {
                name: 'AllDay', index: 'AllDay', align: 'center', width: 80, editable: true, edittype: 'checkbox', hidden: true, editrules: { required: false, edithidden: true }, viewable: false, search: false,
                formoptions: { rowpos: 3, colpos: 1 },
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
                formatoptions: { srcformat: 'Y-m-d', newformat: 'Y-m-d' }, datefmt: 'Y-m-d',
                editoptions: {
                    size:20,maxlengh:20,
                    dataInit:function(element){
                        $(element).bind('focus', function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'});});
                    }
                },
                formoptions: { rowpos: 4, colpos: 1, elmsuffix:"<font color=#FF0000>*</font>" }
            },
            { name: 'EndTime', index: 'EndTime', align: 'center', editable: true, editrules: { required: true, date: false, edithidden: true },
                width: 150, search: false, formatter: 'date', sorttype: 'date',
                formatoptions: { srcformat: 'Y-m-d', newformat: 'Y-m-d' }, datefmt: 'Y-m-d',
                editoptions: {
                    size:20,maxlengh:20,
                    dataInit:function(element){
                        $(element).bind('focus', function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'});});
                    }
                },
                formoptions: { rowpos: 5, colpos: 1, elmsuffix:"<font color=#FF0000>*</font>" }
            },
            { name: 'Status', index: 'Status', width: 100, align: 'center', viewable: true, search: false, hidden: !iapprove, 
                editable: false, edittype: 'none', 
            },
        ],
        caption: getlbl("hr.TripList"),//"出差"
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
            edit: iapprove, add: iapply, del: irevoke, view: iview, refresh: irefresh, search: false, edittext: strapprovetext, addtext: iapprove ? strapplytext : straddtext, deltext: strrevoketext, searchtext: strsearchtext, refreshtext: strrefreshtext, viewtext: strviewtext,
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
                initEditForm(ret); //绑定事件处理方法
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
                initEditForm(); //绑定事件处理方法
                CloseLoadingByDept();
            },
            onclickSubmit: function (params) {
                return fGetFormData();
            },
        },  //  default settings for add
        {
            top: 0,            
            caption: strrevoketext,
            msg: strrevokemsg,
            bSubmit: strrevoketext,
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
});

function initEditForm(rowObject) {
    var id = rowObject && rowObject.AskForLeaveId ? rowObject.AskForLeaveId : "";

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

    if(rowObject && rowObject.AskforleaveId){
        $("#FrmGrid_DataGrid").find("input").attr("disabled", true);
        getDuration();

        $("#sData").html(strapprovetext + "<span class='ui-icon ui-icon-disk'>");
        $("#sData").after("<a id='fData' class='fm-button ui-state-default ui-corner-all fm-button-icon-left'>" + strrefusetext + "<span class='ui-icon ui-icon-disk'></span></a>");
        $("#tr_Note").after("<tr rowpos='9' class='FormData' id='tr_Description'><td class='CaptionTD'>" + getlbl('hr.ApproveDesc') + "</td><td class='DataTD'>&nbsp;<textarea rows='3' cols='65' id='Description' name='Description' role='textbox' multiline='true' class='FormElement ui-widget-content ui-corner-all'></textarea></td></tr>");
    }
    else{
        $("#sData").html(strapplytext + "<span class='ui-icon ui-icon-disk'>");
    }

    //加载部门
    //initDepartments(id); 
    //加载员工
    //initEmployees(); 
}

function fGetFormData() {
    var data = {};

    //是否整天
    data.AllDay = $("#AllDay").is(":checked") ? "1" : "0";

    //开始时间
    data.StartTime = $("#StartTime").val();

    //结束时间
    data.EndTime = $("#EndTime").val();

    //拟办事项
    data.TransactThing = $("#TransactThing").val();

    //出差地点
    data.Note = $("#Note").val();

    //员工Id
    data.EmpId = getCookie(cookieEmId);

    return data;
}

function gridReload() {
    $("#DataGrid").jqGrid('setGridParam', { url: "TripList.asp", page: 1, }).trigger("reloadGrid");
}

function GetTime() {
    WdatePicker({ isShowClear: true, dateFmt: 'HH:mm', isShowToday: false, qsEnabled: false });
};

function ExportData() {
    $("#divExport").load("../Tools/ExportDataUI.asp?nd=" + getRandom() + "&exportType=ontrip");
    $("#divExport").show();
}