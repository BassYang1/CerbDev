$(document).ready(function () {
    //$("#progressbar").hide();
    CheckLoginStatus();
    initHolidayTemplates(); //初使化假期

    function CardCheck(value, colname) {
        if (value < 0)
            return [false, getlbl("hr.CardNoLt0")];//"卡号不能小于0"
        else
            return [true, ""];
    }

    jQuery("#DataGrid").jqGrid({
        url: 'HolidayList.asp',
        editurl: "HolidayEdit.asp",
        datatype: "json",
        //colNames:['RuleId',假期日期','调换日期','假期说明','TempLateId'],
        colNames: ['HolidayId', getlbl("hr.HolidayDate"), getlbl("hr.TransposalDate"), getlbl("hr.HolidayDesc"),'TempLateId'],
        colModel: [
            { name: 'HolidayId', index: 'HolidayId', align: 'center', width: 10, hidden: true, viewable: false, search: false },
            {
                name: 'HolidayDate', index: 'HolidayDate', align: 'center', hidden: false, editable: true, editrules: { required: true, date: false, edithidden: true },
                width: 150, search: false, formatter: 'date', sorttype: 'date',
                formatoptions: { srcformat: 'Y-m-d', newformat: 'Y-m-d' }, datefmt: 'Y-m-d',                
                editoptions: {
                    size:20,maxlengh:20,
                    dataInit:function(element){
                        $(element).bind('focus', function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'});});
                    },                    
                },
                formoptions: { rowpos: 1, colpos: 1, elmsuffix:"<font color=#FF0000>*</font>" }
            },
            {
                name: 'TransposalDate', index: 'TransposalDate', align: 'center', hidden: false, editable: true, editrules: { required: false, date: false, edithidden: true },
                width: 150, search: false, formatter: 'date', sorttype: 'date',
                formatoptions: { srcformat: 'Y-m-d', newformat: 'Y-m-d' }, datefmt: 'Y-m-d',                
                editoptions: {
                    size:20,maxlengh:20,
                    dataInit:function(element){
                        $(element).bind('focus', function(){WdatePicker({isShowClear:false,dateFmt:'yyyy-MM-dd'});});
                    }
                },
                formoptions: { rowpos: 2, colpos: 1 }
            },
            { 
                name: 'HolidayName', index: 'HolidayName',edittype: 'textarea', editable: true, editrules:{required:true},
                editoptions: { rows: 3, cols: 65 },
                width: 250, align: 'center', viewable: true, search: true,
                stype: 'text', searchoptions: { sopt: ["eq","ne",'cn','nc']},
                formoptions: { rowpos: 3, colpos: 1, elmsuffix:"<font color=#FF0000>*</font>" }
            },
            { name: 'TempLateId', index: 'TempLateId', align: 'center', width: 10, hidden: true, viewable: false, search: false },
         ],
        caption: getlbl("hr.Holiday"),//"法定假日"
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
            templateId: function() { return $("#selHolidayTemp").val(); },
        },
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
            top: 0, width: 450, labelswidth: '70px', height: "auto",
            beforeShowForm: function () {
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

//初使化假期模板
function initHolidayTemplates(){
    var result = $.ajax({type:'post',url:'../Common/GetTemplateJSON.asp?nd='+getRandom(),data:{templateType:'1'},async:false});
    var data = result.responseText;
    var arrTemps = data ? ($.parseJSON(data) || []) : [];
    var id, name;

    var tempListHtml = "<option value=''>" + getlbl("hr.ChooseTemp") + "</option>";

    for(var i in arrTemps){
        id = arrTemps[i].id;
        name = arrTemps[i].name;
        tempListHtml += "<option value='" + id + "'>" + name + "</option>";
    }

    $("#selHolidayTemp").html(tempListHtml);
    $("#selHolidayTemp").css('width','140');
    $("#selHolidayTemp").css('font-size','12px');
    $("#selHolidayTemp").change(function(){
        gridReload();
    });
}

function fGetFormData() {
    var data = {};

    //假期模板
    data.TemplateId = $("#selHolidayTemp").val();

    return data;
}

function gridReload() {
    $("#DataGrid").jqGrid('setGridParam', { url: "HolidayList.asp", page: 1, }).trigger("reloadGrid");
}

function GetTime() {
    WdatePicker({ isShowClear: true, dateFmt: 'HH:mm', isShowToday: false, qsEnabled: false });
};

function ExportData() {
    $("#divExport").load("../Tools/ExportDataUI.asp?nd=" + getRandom() + "&exportType=legalholiday");
    $("#divExport").show();
}