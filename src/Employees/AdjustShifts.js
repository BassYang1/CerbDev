$(document).ready(function () {
    //$("#progressbar").hide();
    CheckLoginStatus();

    function CardCheck(value, colname) {
        if (value < 0)
            return [false, getlbl("hr.CardNoLt0")];//"卡号不能小于0"
        else
            return [true, ""];
    }

    jQuery("#DataGrid").jqGrid({
        url: 'AdjustShiftsList.asp',
        editurl: "AdjustShiftsEdit.asp",
        datatype: "json",
        //colNames:['TempShiftID','ShiftType','调整日期','ShiftId','班次名','EmployeeDesc','调整说明',弹性班次','基本工时','上班次数','是否过夜','第一次上班刷卡','DepartmentCode','EmployeeCode','OtherCode','AonDuty','AonDutyStart','AonDutyEnd','AoffDuty','AoffDutyStart','AoffDutyEnd','AcalculateLate','AcalculateEarly','ArestTime','BonDuty','BonDutyStart','BonDutyEnd','BoffDuty','BoffDutyStart','BoffDutyEnd','BcalculateLate','BcalculateEarly','BrestTime','ConDuty','ConDutyStart','ConDutyEnd','CoffDuty','CoffDutyStart','CoffDutyEnd','CcalculateLate','CcalculateEarly','CrestTime'],
        colNames: ['TempShiftID', 'ShiftType', getlbl("hr.AdjustDate"), 'ShiftId', getlbl("hr.ShiftName"), 'EmployeeDesc', getlbl("hr.Description"), getlbl("hr.StretchShift"), getlbl("hr.ShiftTime"), getlbl("hr.Degree"), getlbl("hr.Night"), getlbl("hr.FirstOnDuty"), getlbl("hr.DeptList"), getlbl("hr.EmpList"), 'OtherCode', 'AonDuty', 'AonDutyStart', 'AonDutyEnd', 'AoffDuty', 'AoffDutyStart', 'AoffDutyEnd', 'AcalculateLate', 'AcalculateEarly', 'ArestTime', 'BonDuty', 'BonDutyStart', 'BonDutyEnd', 'BoffDuty', 'BoffDutyStart', 'BoffDutyEnd', 'BcalculateLate', 'BcalculateEarly', 'BrestTime', 'ConDuty', 'ConDutyStart', 'ConDutyEnd', 'CoffDuty', 'CoffDutyStart', 'CoffDutyEnd', 'CcalculateLate', 'CcalculateEarly', 'CrestTime'],
        colModel: [
            { name: 'TempShiftID', index: 'TempShiftID', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'ShiftType', index: 'ShiftType', align: 'center', width: 10, hidden: true, editrules: { required: false, edithidden: true }, viewable: false, search: false },
            {
                name: 'AdjustDate', index: 'AdjustDate', align: 'center', editable: true, editrules: { required: true, date: false, edithidden: true },
                width: 150, search: false, formatter: 'date', sorttype: 'date',
                formatoptions: { srcformat: 'Y-m-d', newformat: 'Y-m-d' }, datefmt: 'Y-m-d',
                editoptions: {
                    size: 20, maxlengh: 20
                },
                formoptions: { elmsuffix: "<font color=#FF0000>*</font>", rowpos: 1, colpos: 1 }
            },
            { name: 'ShiftId', index: 'ShiftId', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            {
                name: 'ShiftName', index: 'ShiftName', align: 'center', edittype: 'select', editable: true, editrules: { required: true, edithidden: true },
                stype: 'select', searchoptions: { sopt: ["eq"], value:":", dataInit:initShiftsList },
                formoptions: { rowpos: 5, colpos: 1 },
                editoptions: {readonly:true,dataInit:initShiftsList}
            },
            { name: 'EmployeeDesc', index: 'EmployeeDesc', align: 'center', width: 10, hidden: true, viewable: true, search: false },
            {
                name: 'Description', index: 'Description', edittype: 'textarea', width: 250, editable: true, editrules: { required: false }, 
                search: false, sortable: false, formoptions: { rowpos: 2, colpos: 1 },
                editoptions: { rows: 3, cols: 65, dataInit: mergeFormCells },
            },
            {
                name: 'StretchShift', index: 'StretchShift', align: 'center', editable: true, editrules: { required: false, edithidden: true },
                edittype: 'checkbox', editoptions: { value: getlbl("hr.Yes") + ":" + getlbl("hr.No") }, stype: 'select', searchoptions: { sopt: ["eq"], value: "1:" + getlbl("hr.Yes") + ";" + "0:" + getlbl("hr.No") }, //"0-否:1-是"
                formatter: function (cellvalue, options, rowObject) { if (cellvalue == "True") { return getlbl("hr.Yes"); } else { return getlbl("hr.No"); } },
                formoptions: { rowpos: 7, colpos: 2 }
            },
            {
                name: 'ShiftTime', index: 'ShiftTime', width: 120, align: 'center', editable: true, sortable: false, search: false, formatter: 'number',
                editrules: { required: true, edithidden: true },
                formoptions: { rowpos: 5, colpos: 2, elmsuffix: "<font color=#FF0000>*</font>" }
            },
            {
                name: 'Degree', index: 'Degree', width: 120, align: 'center', editable: true, sortable: false, search: false,
                editrules: { required: true, edithidden: true },
                edittype: 'select', editoptions: { value: '1:1;2:2;3:3' },
                formoptions: { rowpos: 7, colpos: 1 }
            },
            {
                name: 'Night', index: 'Night', editable: true, align: 'center', editrules: { required: false, edithidden: true },
                edittype: 'checkbox', editoptions: { value: getlbl("hr.Yes") + ":" + getlbl("hr.No") }, stype: 'select', searchoptions: { sopt: ["eq"], value: "1:" + getlbl("hr.Yes") + ";" + "0:" + getlbl("hr.No") }, //"0-否:1-是"
                formatter: function (cellvalue, options, rowObject) { if (cellvalue == "True") { return getlbl("hr.Yes"); } else { return getlbl("hr.No"); } },
                formoptions: { rowpos: 6, colpos: 1 }
            },
            {
                name: 'FirstOnDuty', index: 'FirstOnDuty', editable: true, hidden: true, align: 'center', editrules: { required: false, edithidden: true },
                edittype: 'select', editoptions: { value: '0:' + getlbl("hr.OnThatDay") + ";1:" +  getlbl("hr.OnPriorDay")},
                formoptions: { rowpos: 6, colpos: 2 }
            },
            {
                name: 'DepartmentCode', index: 'DepartmentCode', align: 'center', width: 10, editable: true, edittype: 'select', hidden: true, editrules: { required: false, edithidden: true }, viewable: false, search: false,
                formoptions: { rowpos: 3, colpos: 1 },
                editoptions: { dataInit: mergeFormCells },
            },
            {
                name: 'EmployeeCode', index: 'EmployeeCode', align: 'center', width: 10, editable: true, edittype: 'select', hidden: true, editrules: { required: false, edithidden: true }, viewable: false, search: false,
                formoptions: { rowpos: 4, colpos: 1 },
                editoptions: { dataInit: mergeFormCells },
            },
            { name: 'OtherCode', index: 'OtherCode', align: 'center', width: 10, editable: true, edittype: 'none', hidden: true, viewable: false, search: false },
            { name: 'AonDuty', index: 'AonDuty', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'AonDutyStart', index: 'AonDutyStart', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'AonDutyEnd', index: 'AonDutyEnd', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'AoffDuty', index: 'AoffDuty', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'AoffDutyStart', index: 'AoffDutyStart', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'AoffDutyEnd', index: 'AoffDutyEnd', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'AcalculateLate', index: 'AcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'AcalculateEarly', index: 'AcalculateEarly', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'ArestTime', index: 'ArestTime', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BonDuty', index: 'BonDuty', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BonDutyStart', index: 'BonDutyStart', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BonDutyEnd', index: 'BonDutyEnd', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BoffDuty', index: 'BoffDuty', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BoffDutyStart', index: 'BoffDutyStart', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BoffDutyEnd', index: 'BoffDutyEnd', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BcalculateLate', index: 'BcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BcalculateEarly', index: 'BcalculateEarly', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'BrestTime', index: 'BrestTime', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'ConDuty', index: 'ConDuty', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'ConDutyStart', index: 'ConDutyStart', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'ConDutyEnd', index: 'ConDutyEnd', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'CoffDuty', index: 'CoffDuty', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'CoffDutyStart', index: 'CoffDutyStart', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'CoffDutyEnd', index: 'CoffDutyEnd', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'CcalculateLate', index: 'CcalculateLate', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'CcalculateEarly', index: 'CcalculateEarly', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            { name: 'CrestTime', index: 'CrestTime', align: 'center', width: 10, hidden: true, viewable: false, search: false },
        ],
        caption: getlbl("hr.ShiftAdjust"),//"班次调整"
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
        loadComplete: function (data) { //完成服务器请求后，回调函数 
            if (data == null || data.records == 0) {
                jQuery("#DataGrid").jqGrid('clearGridData');
            }
        },
    });

    //获取操作权限
    var role = GetOperRole("employees");
    var iedit = false, iadd = false, idel = false, iview = false, irefresh = false, isearch = false, iexport = false;
    try {
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

    jQuery("#DataGrid").jqGrid('navGrid', '#DataGrid_toppager',
        {
            edit: iedit, add: iadd, del: idel, view: iview, refresh: irefresh, search: isearch, edittext: stredittext, addtext: straddtext, deltext: strdeltext, searchtext: strsearchtext, refreshtext: strrefreshtext, viewtext: strviewtext,
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
            top: 0, width: 850, labelswidth: '70px', height: "auto",
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
            reloadAfterSubmit: true,
            afterSubmit: getDelafterSubmit
        },  // delete instead that del:false we need this
        { multipleSearch: false, multipleGroup: false, showQuery: false, closeAfterSearch: true, caption: strsearchcaption, top: 60 },// search options
        {
            top: 0, width: 850, labelswidth: '70px', height: "auto",
            beforeShowForm: function () {
                var rowid = $("#DataGrid").jqGrid('getGridParam', 'selrow');
                var ret = $("#DataGrid").jqGrid('getRowData', rowid);

                initShiftDetail4View(ret); //查看详细
                setFormStyle("view"); //查看详细

                $(".navButton").hide(); //隐藏按钮  
            }
        }   //view parameters
        );

    var topPagerDiv = $('#DataGrid_toppager')[0];         // "#list_toppager"
    $("#DataGrid_toppager_center", topPagerDiv).remove(); // "#list_toppager_center"
    $(".ui-paging-info", topPagerDiv).remove();
    $("#DataGrid_toppager_right").css('width', '30%');
    $("#DataGrid_toppager_left").css("width", "70%");
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

//合并单元格
function mergeFormCells(element, options) {
    $(element).parent().nextAll().remove();
    $(element).parent().attr("colspan", "3");
}

//加载班次列表
function initShiftsList(element){
    var result = $.ajax({type:'post',url:'../Common/GetShiftJSON.asp?nd='+getRandom(),data:null,async:false});
    var data = result.responseText;
    var arrShifts = data ? ($.parseJSON(data) || []) : [];

    var $selObj = $(element);
    $selObj.attr({"id":"ShiftName", "name":"ShiftName"});

    for(var i in arrShifts){
        $selObj.append("<option value='" + arrShifts[i].id + "'>" + arrShifts[i].name + "</option>");
    }

    $selObj.find("option:first").attr("selected","selected");
}

//degree 上班时段
//rowObject 班次数据
function initShiftDetail4Form(degree, rowObject) {
    if (degree == undefined || isNaN(degree) || parseInt(degree) < 1) {
        degree = 1;
    }

    var html = "<tr id='tr_TimePeriod' class='FormData' rowpos='4'>";
    html = html + "<td colspan='4'>";
    html = html + "<table id='tbl_TimePeriod' width='100%' border='0' cellpadding='0' cellspacing='0'>";
    html = html + "<tbody>";
    html = html + "<tr class='FormData'>";
    html = html + "<td colspan='2' rowspan='2' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.TimePeriod") + "</td>";
    html = html + "<td colspan='3' align='center' class='ui-border ui-NoneRightBorder' style='width: 25%;'>" + getlbl("hr.Clockin") + "</td>";
    html = html + "<td colspan='3' align='center' class='ui-border ui-NoneRightBorder' style='width: 25%;'>" + getlbl("hr.Clockout") + "</td>";
    html = html + "<td colspan='6' align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getlbl("hr.Other") + "</td>";
    html = html + "</tr>";
    html = html + "<tr>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Standard") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Start") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.End") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Standard") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Start") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.End") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.CanLateIn") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.CanEarlyOut") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border ui-NoneRightBorder ui-border-LB ui-border-R'>" + getlbl("hr.CanRest") + "</td>";
    html = html + "</tr>";
    html = html + "<tr id='trAOnDuty'>";
    html = html + "<td colspan='2' align='center' class='ui-border-LB'>1</td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='AonDuty' id='AonDuty' type='text' style='width:50px;'></td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='AonDutyStart' id='AonDutyStart' type='text' style='width:50px;'></td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='AonDutyEnd' id='AonDutyEnd' type='text' style='width:50px;'></td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='AoffDuty' id='AoffDuty' type='text' style='width:50px;'></td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='AoffDutyStart' id='AoffDutyStart' type='text' style='width:50px;'></td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='AoffDutyEnd' id='AoffDutyEnd' type='text' style='width:50px;'></td>";
    html = html + "<td colspan='2' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='AcalculateLate' id='AcalculateLate' type='text' style='width:50px;'></td>";
    html = html + "<td colspan='2' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='AcalculateEarly' id='AcalculateEarly' type='text' style='width:50px;'></td>";
    html = html + "<td colspan='2' align='center' class='ui-border-LB ui-border-R'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='ArestTime' id='ArestTime' type='text' style='width:50px;'></td>";
    html = html + "</tr>";

    if (parseInt(degree) > 1) {
        html = html + "<tr id='trBOnDuty'>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'>2</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BonDuty' id='BonDuty' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BonDutyStart' id='BonDutyStart' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BonDutyEnd' id='BonDutyEnd' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BoffDuty' id='BoffDuty' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BoffDutyStart' id='BoffDutyStart' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BoffDutyEnd' id='BoffDutyEnd' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BcalculateLate' id='BcalculateLate' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BcalculateEarly' id='BcalculateEarly' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB ui-border-R'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='BrestTime' id='BrestTime' type='text' style='width:50px;'></td>";
        html = html + "</tr>";
    }


    if (parseInt(degree) > 2) {
        html = html + "<tr id='trCOnDuty'>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'>3</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='ConDuty' id='ConDuty' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='ConDutyStart' id='ConDutyStart' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='ConDutyEnd' id='ConDutyEnd' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='CoffDuty' id='CoffDuty' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='CoffDutyStart' id='CoffDutyStart' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='CoffDutyEnd' id='CoffDutyEnd' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='CcalculateLate' id='CcalculateLate' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='CcalculateEarly' id='CcalculateEarly' type='text' style='width:50px;'></td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB ui-border-R'><input class='FormElement ui-widget-content ui-corner-all' role='textbox' name='CrestTime' id='CrestTime' type='text' style='width:50px;'></td>";
        html = html + "</tr>";
    }

    html = html + "</tbody>";
    html = html + "</table>";
    html = html + "</td>";
    html = html + "</tr>";

    $("#tr_TimePeriod").remove();
    $("#tr_StretchShift").after(html);
    $("#tbl_TimePeriod td:first").width($("#tr_StretchShift td:first").width() - 1);

    if (rowObject) {
        $("#AonDuty").val(rowObject.AonDuty ? rowObject.AonDuty : "");
        $("#AonDutyStart").val(rowObject.AonDutyStart ? rowObject.AonDutyStart : "");
        $("#AonDutyEnd").val(rowObject.AonDutyEnd ? rowObject.AonDutyEnd : "");
        $("#AoffDuty").val(rowObject.AoffDuty ? rowObject.AoffDuty : "");
        $("#AoffDutyStart").val(rowObject.AoffDutyStart ? rowObject.AoffDutyStart : "");
        $("#AoffDutyEnd").val(rowObject.AoffDutyEnd ? rowObject.AoffDutyEnd : "");
        $("#AcalculateLate").val(rowObject.AcalculateLate ? rowObject.AcalculateLate : "");
        $("#AcalculateEarly").val(rowObject.AcalculateEarly ? rowObject.AcalculateEarly : "");
        $("#ArestTime").val(rowObject.ArestTime ? rowObject.ArestTime : "");


        $("#BonDuty").val(rowObject.BonDuty ? rowObject.BonDuty : "");
        $("#BonDutyStart").val(rowObject.BonDutyStart ? rowObject.BonDutyStart : "");
        $("#BonDutyEnd").val(rowObject.BonDutyEnd ? rowObject.BonDutyEnd : "");
        $("#BoffDuty").val(rowObject.BoffDuty ? rowObject.BoffDuty : "");
        $("#BoffDutyStart").val(rowObject.BoffDutyStart ? rowObject.BoffDutyStart : "");
        $("#BoffDutyEnd").val(rowObject.BoffDutyEnd ? rowObject.BoffDutyEnd : "");
        $("#BcalculateLate").val(rowObject.BcalculateLate ? rowObject.BcalculateLate : "");
        $("#BcalculateEarly").val(rowObject.BcalculateEarly ? rowObject.BcalculateEarly : "");
        $("#BrestTime").val(rowObject.BrestTime ? rowObject.BrestTime : "");


        $("#ConDuty").val(rowObject.ConDuty ? rowObject.ConDuty : "");
        $("#ConDutyStart").val(rowObject.ConDutyStart ? rowObject.ConDutyStart : "");
        $("#ConDutyEnd").val(rowObject.ConDutyEnd ? rowObject.ConDutyEnd : "");
        $("#CoffDuty").val(rowObject.CoffDuty ? rowObject.CoffDuty : "");
        $("#CoffDutyStart").val(rowObject.CoffDutyStart ? rowObject.CoffDutyStart : "");
        $("#CoffDutyEnd").val(rowObject.CoffDutyEnd ? rowObject.CoffDutyEnd : "");
        $("#CcalculateLate").val(rowObject.CcalculateLate ? rowObject.CcalculateLate : "");
        $("#CcalculateEarly").val(rowObject.CcalculateEarly ? rowObject.CcalculateEarly : "");
        $("#CrestTime").val(rowObject.CrestTime ? rowObject.CrestTime : "");
    }

    $("#AonDuty").bind('focus', GetTime);
    $("#AonDutyStart").bind('focus', GetTime);
    $("#AonDutyEnd").bind('focus', GetTime);
    $("#AoffDuty").bind('focus', GetTime);
    $("#AoffDutyStart").bind('focus', GetTime);
    $("#AoffDutyEnd").bind('focus', GetTime);

    $("#BonDuty").bind('focus', GetTime);
    $("#BonDutyStart").bind('focus', GetTime);
    $("#BonDutyEnd").bind('focus', GetTime);
    $("#BoffDuty").bind('focus', GetTime);
    $("#BoffDutyStart").bind('focus', GetTime);
    $("#BoffDutyEnd").bind('focus', GetTime);

    $("#ConDuty").bind('focus', GetTime);
    $("#ConDutyStart").bind('focus', GetTime);
    $("#ConDutyEnd").bind('focus', GetTime);
    $("#CoffDuty").bind('focus', GetTime);
    $("#CoffDutyStart").bind('focus', GetTime);
    $("#CoffDutyEnd").bind('focus', GetTime);

    checkStretchShift($("#StretchShift").is(":checked")); //检查弹性班次
}

//degree 上班时段
//rowObject 班次数据
function initShiftDetail4View(rowObject) {
    if (rowObject == undefined || rowObject == null || typeof rowObject != "object") {
        return;
    }

    $("#trv_EmployeeDesc").remove();
    $("#trv_StretchShift").after("<tr rowpos='8' class='FormData' id='trv_EmployeeDesc'><td class='CaptionTD form-view-label ui-widget-content' width='30%'><b>调整员工</b></td><td colspan='3' class='DataTD form-view-data ui-helper-reset ui-widget-content' id='v_EmployeeDesc'>&nbsp;<span>" + (rowObject && rowObject.EmployeeDesc ? rowObject.EmployeeDesc : "") + "</span></td></tr>");

    var degree = rowObject.Degree && !isNaN(rowObject.Degree) ? 1 : parseInt(rowObject.Degree);

    var html = "<tr id='trv_TimePeriod' class='FormData' rowpos='4'>";
    html = html + "<td colspan='4'>";
    html = html + "<table id='tbl_TimePeriod' width='100%' border='0' cellpadding='0' cellspacing='0'>";
    html = html + "<tbody>";
    html = html + "<tr class='FormData'>";
    html = html + "<td colspan='2' rowspan='2' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.TimePeriod") + "</td>";
    html = html + "<td colspan='3' align='center' class='ui-border ui-NoneRightBorder' style='width: 25%;'>" + getlbl("hr.Clockin") + "</td>";
    html = html + "<td colspan='3' align='center' class='ui-border ui-NoneRightBorder' style='width: 25%;'>" + getlbl("hr.Clockout") + "</td>";
    html = html + "<td colspan='6' align='center' class='ui-border ui-NoneRightBorder ui-border-R'>" + getlbl("hr.Other") + "</td>";
    html = html + "</tr>";
    html = html + "<tr>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Standard") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Start") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.End") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Standard") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.Start") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.End") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.CanLateIn") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border ui-NoneRightBorder ui-border-LB'>" + getlbl("hr.CanEarlyOut") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border ui-NoneRightBorder ui-border-LB ui-border-R'>" + getlbl("hr.CanRest") + "</td>";
    html = html + "</tr>";
    html = html + "<tr id='trAOnDuty'>";
    html = html + "<td colspan='2' align='center' class='ui-border-LB'>1</td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.AonDuty ? rowObject.AonDuty : "") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.AonDutyStart ? rowObject.AonDutyStart : "") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.AonDutyEnd ? rowObject.AonDutyEnd : "") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.AoffDuty ? rowObject.AoffDuty : "") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.AoffDutyStart ? rowObject.AoffDutyStart : "") + "</td>";
    html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.AoffDutyEnd ? rowObject.AoffDutyEnd : "") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border-LB'>" + (rowObject.AcalculateLate ? rowObject.AcalculateLate : "") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border-LB'>" + (rowObject.AcalculateEarly ? rowObject.AcalculateEarly : "") + "</td>";
    html = html + "<td colspan='2' align='center' class='ui-border-LB ui-border-R'>" + (rowObject.ArestTime ? rowObject.ArestTime : "") + "</td>";
    html = html + "</tr>";

    if (parseInt(degree) > 1) {
        html = html + "<tr id='trBOnDuty'>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'>2</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.BonDuty ? rowObject.BonDuty : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.BonDutyStart ? rowObject.BonDutyStart : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.BonDutyEnd ? rowObject.BonDutyEnd : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.BoffDuty ? rowObject.BoffDuty : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.BoffDutyStart ? rowObject.BoffDutyStart : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LB'>" + (rowObject.BoffDutyEnd ? rowObject.BoffDutyEnd : "") + "</td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'>" + (rowObject.BcalculateLate ? rowObject.BcalculateLate : "") + "</td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'>" + (rowObject.BcalculateEarly ? rowObject.BcalculateEarly : "") + "</td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB ui-border-R'>" + (rowObject.BrestTime ? rowObject.BrestTime : "") + "</td>";
        html = html + "</tr>";
    }


    if (parseInt(degree) > 2) {
        html = html + "<tr id='trCOnDuty'>";
        html = html + "<td colspan='2' align='center' class='ui-border-LB'>3</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LC'>" + (rowObject.ConDuty ? rowObject.ConDuty : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LC'>" + (rowObject.ConDutyStart ? rowObject.ConDutyStart : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LC'>" + (rowObject.ConDutyEnd ? rowObject.ConDutyEnd : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LC'>" + (rowObject.CoffDuty ? rowObject.CoffDuty : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LC'>" + (rowObject.CoffDutyStart ? rowObject.CoffDutyStart : "") + "</td>";
        html = html + "<td colspan='1' align='center' class='ui-border-LC'>" + (rowObject.CoffDutyEnd ? rowObject.CoffDutyEnd : "") + "</td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LC'>" + (rowObject.CcalculateLate ? rowObject.CcalculateLate : "") + "</td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LC'>" + (rowObject.CcalculateEarly ? rowObject.CcalculateEarly : "") + "</td>";
        html = html + "<td colspan='2' align='center' class='ui-border-LC ui-border-R'>" + (rowObject.CrestTime ? rowObject.CrestTime : "") + "</td>";
        html = html + "</tr>";
    }

    html = html + "</tbody>";
    html = html + "</table>";
    html = html + "</td>";
    html = html + "</tr>";

    $("#trv_TimePeriod").remove();
    $("#trv_EmployeeDesc").after(html);
    $("#tbl_TimePeriod td:first").width($("#trv_StretchShift td:first").width() - 1);
}

//stretchShift 是否弹性上班
function checkStretchShift(stretchShift) {
    if (stretchShift) {
        $("#AonDutyEnd").attr("disabled", "disabled");
        $("#AoffDutyStart").attr("disabled", "disabled");
        $("#BonDutyEnd").attr("disabled", "disabled");
        $("#BoffDutyStart").attr("disabled", "disabled");
        $("#ConDutyEnd").attr("disabled", "disabled");
        $("#CoffDutyStart").attr("disabled", "disabled");
    }
    else {
        $("#AonDutyEnd").removeAttr("disabled");
        $("#AoffDutyStart").removeAttr("disabled");
        $("#BonDutyEnd").removeAttr("disabled");
        $("#BoffDutyStart").removeAttr("disabled");
        $("#ConDutyEnd").removeAttr("disabled");
        $("#CoffDutyStart").removeAttr("disabled");
    }
}

function setFormStyle(oper) {    
    if(oper == "view"){
        //$("#trv_ShiftName").children(":even").css("width", "15%");
    }else{
        //$("#tr_Description>td,#tr_AdjustDate>td,#tr_ShiftName>td,#tr_StretchShift>td,#tr_Night>td").addClass("ui-border ui-NoneRightBorder");
        //$("#tr_ShiftName>td:last,#tr_Night>td:last,#tr_StretchShift>td:last,#tr_AdjustDate>td:last,#tr_Description>td:last").addClass("ui-border-R");
        $("#Night").css({ "margin-top": "5px" });
        $("#StretchShift").css({ "margin-top": "5px" });
        $("#Degree").css({ "width": "120px" });

        //$("#trv_ShiftName").children(":even").css("width", "12%");
    }
}

function checkFirstOnDuty(firstOnDuty){
    if($("#Night").is(':checked')){
        if(firstOnDuty && firstOnDuty == "1"){
            $("#FirstOnDuty").html("<option value='0'>" + getlbl("hr.OnThatDay") + "</option><option selected value='1'>" + getlbl("hr.OnPriorDay") + "</option>");
        }
        else{
            $("#FirstOnDuty").html("<option selected value='0'>" + getlbl("hr.OnThatDay") + "</option><option value='1'>" + getlbl("hr.OnPriorDay") + "</option>");
        }
    }
    else{
        $("#FirstOnDuty").html("<option selected value='0'>" + getlbl("hr.OnThatDay") + "</option>");
    }
}

function initEditForm(rowObject) {
    var id = rowObject && rowObject.TempShiftID ? rowObject.TempShiftID : "";
    var degree = rowObject && rowObject.Degree ? rowObject.Degree : "";

    InitDepartments(id); //加载部门
    InitEmployees(); //加载员工
    initShiftDetail4Form(degree, rowObject); //显示上班时段详细
    setFormStyle("edit"); //设置表单样式

    if(rowObject && rowObject.EmployeeCode){ //加载已选中人员
        LoadSelEmp(rowObject.EmployeeCode);
    }

    $("#AdjustDate").bind("focus", function () { 
        WdatePicker({ isShowClear: false, dateFmt: 'yyyy-MM-dd' }); 
    }).blur();

    $("#StretchShift").bind("change", function () {
        checkStretchShift($(this).is(':checked'));
    });

    $("#Night").bind("change", function () {
        checkFirstOnDuty(rowObject && rowObject.FirstOnDuty ? rowObject.FirstOnDuty : "");
    });

    $("#Degree").bind("change", function () {
        rowObject = rowObject || {};
        rowObject.AonDuty = $("#AonDuty").size() > 0 ? $("#AonDuty").val() : "";
        rowObject.AonDutyStart = $("#AonDutyStart").size() > 0 ? $("#AonDutyStart").val() : "";
        rowObject.AonDutyEnd = $("#AonDutyEnd").size() > 0 ? $("#AonDutyEnd").val() : "";
        rowObject.AoffDuty = $("#AoffDuty").size() > 0 ? $("#AoffDuty").val() : "";
        rowObject.AoffDutyStart = $("#AoffDutyStart").size() > 0 ? $("#AoffDutyStart").val() : "";
        rowObject.AoffDutyEnd = $("#AoffDutyEnd").size() > 0 ? $("#AoffDutyEnd").val() : "";
        rowObject.AcalculateLate = $("#AcalculateLate").size() > 0 ? $("#AcalculateLate").val() : "";
        rowObject.AcalculateEarly = $("#AcalculateEarly").size() > 0 ? $("#AcalculateEarly").val() : "";
        rowObject.ArestTime = $("#ArestTime").size() > 0 ? $("#ArestTime").val() : "";
        rowObject.BonDuty = $("#BonDuty").size() > 0 ? $("#BonDuty").val() : "";
        rowObject.BonDutyStart = $("#BonDutyStart").size() > 0 ? $("#BonDutyStart").val() : "";
        rowObject.BonDutyEnd = $("#BonDutyEnd").size() > 0 ? $("#BonDutyEnd").val() : "";
        rowObject.BoffDuty = $("#BoffDuty").size() > 0 ? $("#BoffDuty").val() : "";
        rowObject.BoffDutyStart = $("#BoffDutyStart").size() > 0 ? $("#BoffDutyStart").val() : "";
        rowObject.BoffDutyEnd = $("#BoffDutyEnd").size() > 0 ? $("#BoffDutyEnd").val() : "";
        rowObject.BcalculateLate = $("#BcalculateLate").size() > 0 ? $("#BcalculateLate").val() : "";
        rowObject.BcalculateEarly = $("#BcalculateEarly").size() > 0 ? $("#BcalculateEarly").val() : "";
        rowObject.BrestTime = $("#BrestTime").size() > 0 ? $("#BrestTime").val() : "";
        rowObject.ConDuty = $("#ConDuty").size() > 0 ? $("#ConDuty").val() : "";
        rowObject.ConDutyStart = $("#ConDutyStart").size() > 0 ? $("#ConDutyStart").val() : "";
        rowObject.ConDutyEnd = $("#ConDutyEnd").size() > 0 ? $("#ConDutyEnd").val() : "";
        rowObject.CoffDuty = $("#CoffDuty").size() > 0 ? $("#CoffDuty").val() : "";
        rowObject.CoffDutyStart = $("#CoffDutyStart").size() > 0 ? $("#CoffDutyStart").val() : "";
        rowObject.CoffDutyEnd = $("#CoffDutyEnd").size() > 0 ? $("#CoffDutyEnd").val() : "";
        rowObject.CcalculateLate = $("#CcalculateLate").size() > 0 ? $("#CcalculateLate").val() : "";
        rowObject.CcalculateEarly = $("#CcalculateEarly").size() > 0 ? $("#CcalculateEarly").val() : "";
        rowObject.CrestTime = $("#CrestTime").size() > 0 ? $("#CrestTime").val() : "";

        initShiftDetail4Form($(this).val(), rowObject);
    });

    if(rowObject && rowObject.ShiftId && !isNaN(rowObject.ShiftId)){
        $("#ShiftName").find("option[value='" + rowObject.ShiftId + "']").attr("selected","selected");
    }

    checkFirstOnDuty(rowObject && rowObject.FirstOnDuty ? rowObject.FirstOnDuty : "");
    $("#WdateDiv").hide();
}

//初使化部门
function InitDepartments(templateId) {
    var $tr = $("#tr_DepartmentCode"),
        $label = $tr.children("td.CaptionTD"),
        $data = $tr.children("td.DataTD");

    if (templateId == undefined || templateId == null || templateId == "" || typeof templateId != "string") {
        templateId = "0";
    }

    var userId = getCookie(cookieUserId);
    $data.html("&nbsp;<iframe id='depframe' name='depframe' width='90%' height='180' marginheight='0' marginwidth='0' frameborder='0' align='center' src='../Tools/GetUserEditDept.html?nd=" + getRandom() + "&oper=shiftadjustment&templateId=" + templateId + "&userId=" + userId + "'></iframe>");
}

function InitEmployees() {
    var $tr = $("#tr_EmployeeCode"),
        $label = $tr.children("td.CaptionTD"),
        $data = $tr.children("td.DataTD");

    var empListHtml = "<div>&nbsp;<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='btnSearchEmployee' onclick='fSearchEmployee()'>" + getlbl("hr.Search") + "<span class='ui-icon ui-icon-search'></span></a></div>" +
            "<TABLE width='100%' border='0' cellPadding=0 cellSpacing=0>" +
            "<TBODY><TR>" +
            "<TD width='30%' valign='top'><div onDblClick='fInsertEmp()' style='padding-left:1em;' class='ui-jqdialog-content ui-widget-content'>" +
            "<select id='selEmpSrc' name='selEmpSrc' class='FormElement ui-widget-content ui-corner-all' size=8 multiple style='WIDTH: 270px'>";

    empListHtml += "</select></div></TD>" +
            "<TD width='18%'align=middle valign='middle'>" +
            "<div align='center'>" +
            "<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left ' id='empadd' onclick='fInsertEmp()'>" +
            "<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -13px;top: 8px;'></span>" +
            "<span class='ui-icon ui-icon-carat-1-e ' style='position:relative;left: -8px;top: 0px;'></span>" +
            "</a><p>" +
            "<a class='fm-button ui-state-default ui-corner-all fm-button-icon-left' id='empdel' onclick='fDelEmp()'>" +
            "<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -13px;top: 8px;'></span>" +
            "<span class='ui-icon ui-icon-carat-1-w ' style='position:relative;left: -8px;top: 0px;'></span>" +
            "</a></div></TD>" +
            "<TD width='52%' valign='top'><div onDblClick='fDelEmp()' class='ui-jqdialog-content ui-widget-content'>" +
            "<select id='selEmpDesc' name='selEmpDesc' class='FormElement ui-widget-content ui-corner-all' style='WIDTH: 270px' multiple size=8 >" +
            "</select></div></TD></TR></TBODY></TABLE>";

    $data.html(empListHtml);
}

function fInsertEmp() {
    //职员列表
    var srcValue, srcText;
    var $srcObj = $("#selEmpSrc");
    var $selOptions = $srcObj.find("option:selected"); //选中职员
    var $selOption, $allOptions; //包括子部门

    //所选职员列表
    var $selObj = $("#selEmpDesc");

    //是否选择所有职员
    if ($selObj.find("option[value='0']").length <= 0) { //未选择所有员工，则继续添加
        if ($selOptions.filter("option[value='0']").length > 0) {
            $selObj.empty();
            $selObj.append("<option value='0'>" + getlbl("con.AllEmp") + "</option>");
        }
        else {
            $selOptions.each(function (i) {
                $selOption = $(this);
                srcValue = $selOption.val();
                srcText = $selOption.text();

                if ($selObj.find("option[value='" + srcValue + "']").length <= 0) {
                    $selObj.append("<option value='" + srcValue + "'>" + srcText + "</option>");
                }
            });
        }
    }
}

function fDelEmp() {
    //所选职员列表
    var $selObj = $("#selEmpDesc");
    var $selOptions = $selObj.find("option:selected"); //待移出的选项

    $selOptions.each(function (i) {
        $(this).remove();
    });
}

function fSearchEmployee() {
    $("#divSearch").load("../Equipment/search.asp?submitfun=fSearchEmployeeSubmit()");
    $("#divSearch").show();
}

function fSearchEmployeeSubmit() {
    var strsearchField = $("#searRetColVal").html();
    var strsearchOper = $("#searRetOperVal").html();
    var strsearchString = $("#searRetDataVal").html();

    condition = strsearchField + "|," + strsearchOper + "|," + encodeURI(strsearchString);

    var arrEmps = getEmpJSON(condition);

    //所选职员列表
    var $srcObj = $("#selEmpSrc");
    $srcObj.empty();

    for (var i in arrEmps) {
        $srcObj.append("<option value='" + arrEmps[i].id + "'>" + arrEmps[i].number + "-" + arrEmps[i].name + "</option>");
    }
}

function LoadSelEmp(empIds){
    if(empIds == undefined || typeof empIds != "string" || empIds == "" || empIds.search(/[a-zA-Z]+/g) >= 0){
        return false;
    }

    var arrEmps = getEmpJSON(null, empIds); //获取员工JSON数据

    //所选职员列表
    var $selObj = $("#selEmpDesc");

    for(var i in arrEmps){
        $selObj.append("<option value='" + arrEmps[i].id + "'>" + arrEmps[i].number + "-" + arrEmps[i].name + "</option>");
    }

    return true;
}

function gridReload() {
    $("#DataGrid").jqGrid('setGridParam', { url: "AdjustShiftsList.asp", page: 1, }).trigger("reloadGrid");
}

function GetTime() {
    WdatePicker({ isShowClear: true, dateFmt: 'HH:mm', isShowToday: false, qsEnabled: false });
};

function fGetFormData() {
    var data = {
        StretchShift: "", Night: "",
        AonDuty: "", AonDutyStart: "", AonDutyEnd: "", AoffDuty: "", AoffDutyStart: "", AoffDutyEnd: "", AcalculateLate: "", AcalculateEarly: "", ArestTime: "",
        BonDuty: "", BonDutyStart: "", BonDutyEnd: "", BoffDuty: "", BoffDutyStart: "", BoffDutyEnd: "", BcalculateLate: "", BcalculateEarly: "", BrestTime: "",
        ConDuty: "", ConDutyStart: "", ConDutyEnd: "", CoffDuty: "", CoffDutyStart: "", CoffDutyEnd: "", CcalculateLate: "", CcalculateEarly: "", CrestTime: ""
    };

    //调整班次
    data.ShiftId = $("#ShiftName").find("option:selected").val();
    data.ShiftName = $("#ShiftName").find("option:selected").text();

    //选择部门
    var depts = GetSelDepts();
    if(depts && depts.Ids && depts.Names){
        data.DepartmentCode = depts.Ids;
        data.DepartmentName = depts.Names;
    }

    //选择职员
    var empIds = "", empNames = "";
    $("#selEmpDesc").find("option").each(function(){
        empIds += "," + $(this).val();
        empNames += "," + $(this).text();
    });

    data.EmployeeCode = empIds.substr(1);
    data.EmployeeName = empNames.substr(1);

    data.StretchShift = $("#StretchShift").is(":checked") ? "1" : "0";
    data.Night = $("#Night").is(":checked") ? "1" : "0";
    data.AdjustDate = $("#AdjustDate").val();

    data.AonDuty = $("#AonDuty").val();
    data.AonDutyStart = $("#AonDutyStart").val();
    data.AonDutyEnd = $("#AonDutyEnd").val();
    data.AoffDuty = $("#AoffDuty").val();
    data.AoffDutyStart = $("#AoffDutyStart").val();
    data.AoffDutyEnd = $("#AoffDutyEnd").val();
    data.AcalculateLate = $("#AcalculateLate").val();
    data.AcalculateEarly = $("#AcalculateEarly").val();
    data.ArestTime = $("#ArestTime").val();

    data.BonDuty = $("#BonDuty").val();
    data.BonDutyStart = $("#BonDutyStart").val();
    data.BonDutyEnd = $("#BonDutyEnd").val();
    data.BoffDuty = $("#BoffDuty").val();
    data.BoffDutyStart = $("#BoffDutyStart").val();
    data.BoffDutyEnd = $("#BoffDutyEnd").val();
    data.BcalculateLate = $("#BcalculateLate").val();
    data.BcalculateEarly = $("#BcalculateEarly").val();
    data.BrestTime = $("#BrestTime").val();

    data.ConDuty = $("#ConDuty").val();
    data.ConDutyStart = $("#ConDutyStart").val();
    data.ConDutyEnd = $("#ConDutyEnd").val();
    data.CoffDuty = $("#CoffDuty").val();
    data.CoffDutyStart = $("#CoffDutyStart").val();
    data.CoffDutyEnd = $("#CoffDutyEnd").val();
    data.CcalculateLate = $("#CcalculateLate").val();
    data.CcalculateEarly = $("#CcalculateEarly").val();
    data.CrestTime = $("#CrestTime").val();

    return data;
}

function GetSelDepts() {
    return $("#depframe")[0].contentWindow.GetCheckDepts(); //{Ids: Ids, Names: Names}
}

function ExportData() {
    $("#divExport").load("../Tools/ExportDataUI.asp?nd=" + getRandom() + "&exportType=shiftadjustment");
    $("#divExport").show();
}