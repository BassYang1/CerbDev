﻿var strloadtext= "正在獲取，請稍後...";
var stredittext = "修改";
var straddtext = "增加";
var strviewtext = "查看";
var strdeltext = "刪除";
var strsearchtext="查找";
var strrefreshtext="刷新";
var stralerttext = "請選擇需要操作的資料行!";
var strsearchcaption ="查找";

var login={
	Title : "Cerberus iSCS 用戶登錄",
	LoginUserName : "用戶名： ",
	LoginPwd : "密 碼： ",
	BrowseMsg1 : "&nbsp;&nbsp;&nbsp;&nbsp;您的流覽器版本過低，建議使用<a href='http://www.firefox.com.cn/download/'>Firefox</a>、<a href='https://www.google.com.hk/chrome/'>Google Chrome</a>、IE９或以上",
	BrowseMsg2 : "&nbsp;&nbsp;&nbsp;&nbsp;您的流覽器為IE，也可使用<a href='http://www.firefox.com.cn/download/'>Firefox</a>或<a href='https://www.google.com.hk/chrome/'>Google Chrome</a> ",
	EnterUserName : "請輸入用戶名",
	PwdIllegal : "密碼中含有非法字元",
	LoginEx : "登錄異常",
	UserTopImg : "url(Images/user_top_f.gif)",
	SubmitImg : "url(Images/submit_f.png)",
	imgBottom : "images/user_bottom3_f.gif",
	logopic : "images/logo_f.gif",
	photo : "images/photo_f.gif",
	picture : "images/picture_f.gif",
	Hello : "您好：",
	Employees : "人&nbsp;&nbsp;事",
	Equipment : "設備管理",
	Report : "報&nbsp;&nbsp;表",
	Tool : "工&nbsp;&nbsp;具",
	LogOut : "注&nbsp;&nbsp;銷",
	Help : "幫&nbsp;&nbsp;助",
	Monitor : "即時監控"
}

var hr={
	CardNoLt0 : "卡號不能小於0",
	SuperiorDept : "上級部門",
	DeptName : "部門名稱",
	DeptLevel : "部門級別",
	DeptList : "部門列表",
	DelByOnlyOne : "刪除部門僅能逐條刪除.",
	DelAllDept : "刪除父部門時，該部門下所有子部門將全部刪除.",
	Export : "匯出",
	ExportToLocal : "匯出至本地",
	Refresh: "刷新",
	View : "查看",
	Search : "查找",
	Del : "刪除",
	DeptMaxLevel : "部門最大支持10級，不能選擇第10級部門當上級部門",
	Dept : "部門",
	Name : "姓名",
	Num : "工號",
	Card : "卡號",
	IdentityCard : "身份證",
	Sex : "性別",
	Position : "職務",
	Headship : "職位",
	Telephone : "電話",
	BirthDate : "出生日期",
	JoinDate : "入職日期",
	Marry : "婚否",
	Knowledge : "學歷",
	Country : "國籍",
	NativePlace : "籍貫",
	Address : "通信地址",
	IncumbencyStatus : "在職狀態",
	CollectFP : "採集指紋",
	DimissionDate : "離職日期",
	DimissionReason : "離職原因",
	Male : "男",
	Female : "女",
	Married : "已婚",
	Unmarried : "未婚",
	Incumbent0 : "0-在職",
	Incumbent1 : "1-離職",
	PersonnelList : "人事列表",
	UpPhotoFail : "照片上傳失敗",
	AllDept : "所有部門",
	MyRecord : "我的記錄",
	Browse : "流覽...",
	Delete : "刪除",
	SupportPhotoFormat : "僅支援png|jpg|jpeg|gif|bmp格式圖片！",
	UpPhotoEx : "上傳照片異常",
	UpPhotoFail : "上傳照片失敗，可能原因：照片超過10K. 錯誤資訊：",
	divEmp : "人事",
	spanNavEmp : "人事資料",
	hrefDept : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;部門列表",
	hrefEmp : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;人事列表",
	spanNavAtt : "考勤",
	hrefAttShift : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;班次"
}


var con={
	ControllerId : '設備ID',
	ControllerIdNum : '設備編號',
	ControllerIdName : '設備名稱',
	Location : '位置',
	IP : '設備IP',
	MASK : '子網路遮罩',
	GateWay : '閘道',
	DNS : 'DNS',
	DNS2 : 'DNS2',
	DHCP : '啟用DHCP',
	AntiPassBackType : '防遣返',
	WorkType : '工作類型',
	ServerIP : '伺服器',
	ServerIP2 : '伺服器(域名)',
	StorageMode : '存儲方式',
	IsFingerprint : '指紋模組',
	DoorType : '門類型',
	CardReader1 : '讀卡器1（彩屏機）',
	CardReader2 : '讀卡器2',
	SystemPassword : '設備密碼',
	DataUpdateTime : '數據上傳間隔',
	WaitTime : '屏保等待時間',
	CloseLightTime : '螢幕關閉時間',
	DownPhoto : '下載相片',
	DownFingerprint : '下載指紋',
	Sound : '音量',
	ScreenFile1 : '屏保圖片1',
	ScreenFile2 : '屏保圖片2',
	SyncStatus : '同步狀態',
	WorkType0 : '0 - 上下班',
	WorkType1 : '1 - 進出入',
	WorkType2 : '2 - 上下班+進出入',
	StorageMode0 : '0 - 所有刷卡',
	StorageMode1 : '1 - 僅註冊卡',
	DoorType0 : '0 - 單門',
	DoorType1 : '1 - 雙門',
	CardReaderVal0 : '0 - 進',
	CardReaderVal1 : '1 - 出',
	Minute : '分鐘',
	Second : '秒',
	SoundVal : '檔',
	ConBasicData : '設備基本資料',
	IPNull : '設備IP: 此欄位必需',
	MASKNull : '子網路遮罩: 此欄位必需',
	IPIllegal : 'IP地址非法',
	MASKIllegal : '子網路遮罩非法',
	GateWayIllegal : '閘道非法',
	DNSIllegal : 'DNS非法',
	DNS2Illegal : 'DNS2非法',
	Yes : '是',
	No : '否',
	Have : '有',
	NotHave : '無',
	SyncToCon : '同步到設備',
	SyncTitle : '將全部資料(基本資料、時間表、假期表、輸入輸出表及註冊卡號)同步到設備',
	DHCPMsg : '啟用DHCP，您可能無法得知設備IP', 
	ConHoliday : "設備假期表",
	ConSchedule : "設備時間表",
	SelRowNull : '請選擇需要操作的資料行!',
	SyncEx : '同步異常',
	Edit : "修改",
	EditTitle : "修改儲存格，顏色改變的儲存格為可編輯，點擊可進入編輯狀態",
	Submit : "保存",
	SubmitTitle : "保存資料，且自動同步到設備",
	Cancel : "取消",
	CancelTitle : "取消保存",
	SaveEx : "保存資料異常",
	SyncHolidayTitle : "將假期表資料同步到設備",
	HolidayName : "假期表名稱",
	HolidayTemp : "假期表範本",
	SN : "序號",
	HoliName : "假期名稱",
	HolidayDate : "日期",
	Del : "刪除",
	DelTitle : "刪除所選記錄",
	Add : "增加",
	AddTitle : "添加新記錄",
	DateNull : "日期為空",
	UpScreenFail : "上傳照片失敗，可能原因：圖片超過200K. 錯誤資訊：",
	OutputMin : "輸出值不能小於0",
	OutputMax : "輸出值不能大於99999999毫秒",
	ConInout : "設備輸入輸出表",
	Explain : "說明",
	ScheduleName : "時間表名稱",
	ScheduleTemp : "時間表範本",
	Ouput1 : "一",
	Ouput2 : "二",
	Ouput3 : "三",
	Ouput4 : "四",
	Ouput5 : "五",
	SelTemp : "選擇範本",
	InputFont : "輸入",
	OutputFont : "輸出(毫秒)",
	MustSelSchedule : "必須選擇時間表",
	SyncInoutTitle : "將輸入輸出表資料同步到設備",
	SyncScheduleTitle : "將時間表資料同步到設備",
	InoutName : "輸入/輸出表名稱",
	InoutTemp : "輸入/輸出表範本",
	SaveData : "保存資料",
	ConManager : "設備管理",
	spanNavBasicData : "基本資料",
	aBasicData : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;基本資料",
	spanNavHoliday : "假期表",
	spanNavSchedule : "時間表",
	spanNavInOut : "輸入輸出表",
	spanNavRegCard : "註冊卡號表",
	aHolidayController : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;設備方式",
	aHolidayTemplate : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;範本方式",
	RegCardTitle : "註冊卡號",
	SyncDataTitle : "同步資料",
	spanLoad : "正在載入，請稍後...",
	SyncButtonExplain : "<B>[同步變更]</B>表示僅同步變更的資料,<br /><br /><B>[同步所有]</B>表示同步所有的資料  ",
	SyncedUnsync : "已同步/未同步",
	Synced : "已同步",
	Unsync : "未同步",
	ClickDetail : "點擊查看明細",
	ViewTitle : "查看設備註冊卡號明細",
	Reg : "註冊",
	RegTitle : "註冊人員",
	SyncRegCardTitle : "將註冊卡號數據同步到設備",
	Moment : "請稍後...",
	SyncChange : "同步變更",
	SyncAll : "同步所有",
	spanDelAll : "刪除所選記錄？",
	ValidateMode : "驗證方式",
	Schedule : "時間表",
	InOutDoor : "進出門",
	HavePhoto : "有照片",
	HaveFP : "有指紋",
	RegCardDetail : "註冊卡號明細",
	TempRegToCon : "範本註冊到設備",
	RegTempExplan : "<br /><B>[覆蓋註冊]</B>表示用範本資料覆蓋原註冊卡號，即先全部清空原註冊卡號，再註冊（注意：清空僅清空伺服器設備資料，不清空硬體上的資料）；<br /><br />&nbsp;&nbsp;&nbsp;<B>[追加註冊]</B>表示將範本資料追加到設備上（注意：不會產生重復資料，已註冊的卡號，不做任何修改）",
	TempID : "範本ID",
	TempName : "範本名稱",
	Emp : "職員",
	Controller : "設備",
	SelController : "選擇設備",
	Sel : "選擇",
	InOutDoorVal1 : "1 - 門1",
	InOutDoorVal2 : "2 - 門2",
	InOutDoorVal3 : "3 - 雙門",
	ValidateModeVal0 : "0 - 卡",
	ValidateModeVal1 : "1 - 指紋",
	ValidateModeVal2 : "2 - 卡＋指紋",
	ValidateModeVal3 : "3 - 卡＋密碼",
	RegCardTemp : "註冊卡號範本",
	AllEmp0 : "0 - 所有職員",
	RegToCon : "註冊到設備",
	RegToConTitle : "將範本註冊到設備",
	AllCon : "所有設備",
	PartCon : "部分設備",
	CoverReg : "覆蓋註冊",
	AdditionalReg : "追加註冊",
	Week : "星期",
	Start : "開始",
	End : "截止",
	Monday : "週一",
	Tuesday : "週二",
	Wednesday : "週三",
	Thursday : "週四",
	Friday : "週五",
	Saturday : "週六",
	Sunday : "週日",
	NotHoliSchedule : "無假期時間表",
	HoliSchedule : "假期時間表",
	Times1 : "時段1",
	Times2 : "時段2",
	Times3 : "時段3",
	Times4 : "時段4",
	Times5 : "時段5",
	StartTimeNull : "[開始時間]不能為空！",
	StartTimeIllegal : "[開始時間]非法！",
	EndTimeNull : "[截止時間]不能為空！",
	EndTimeIllegal : "[截止時間]非法！",
	EndTimeLtStartTime : "[截止時間]不能小於等於[開始時間]！",
	Schedule024 : "0 - 24H進出",
	ConnStatus : '連接狀態',
	IN_button : '0-按鈕',
	IN_MenCi : '1-門磁',
	ByDept: '按部門'
	DeptList: '部門列表',
	ByEmp: '按職員',
	EmpList: '職員列表',
	OnlyByCond:'僅按此條件', 
	OnlyByCondDesc:'勾選後設備只主冊上述條件人園，不符合上述條件的人園將刪除；否則追主冊'
}

var rep={
	selstartTime : "選擇起始日期",
	selendTime : "選擇截止日期",
	Input : "輸入",
	BCDate : "日期",
	BCTime : "時間",
	BCTime2 : "刷卡時間",
	ButtonReport : "按鈕事件報表",
	ConfirmStr : "確定",
	ConfirmSearch : "確定查找",
	AllCon0 : "0 - 所有設備",
	AllDept1 : "1 - 所有部門",
	MyRecord0 : "0 - 我的記錄",
	Status : "狀態",
	AcsDetailRport : "進出明細報表",
	StatusVal99 : "99 - 所有狀態",
	StatusVal0 : "0 - 合法卡",
	StatusVal1 : "1 - 非法卡",
	StatusVal2 : "2 - 非法時段",
	StatusVal3 : "3 - 非法門",
	StatusVal4 : "4 - 防遣返",
	StatusVal5 : "5 - 非法指紋",
	StatusVal6 : "6 - 密碼錯誤",
	StatusVal7 : "7 - 未採集指紋",
	StatusVal8 : "8 - 驗證方式錯",
	StatusVal9 : "9 - 指紋模組故障",
	StatusShow0 : "合法卡",
	StatusShow1 : "非法卡",
	StatusShow2 : "非法時段",
	StatusShow3 : "非法門",
	StatusShow4 : "防遣返",
	StatusShow5 : "非法指紋",
	StatusShow6 : "密碼錯誤",
	StatusShow7 : "未採集指紋",
	StatusShow8 : "驗證方式錯",
	StatusShow9 : "指紋模組故障",
	AcsIllegalReport : "非法進出報表",
	StatusValAllIllegal : "0 - 所有非法狀態",
	AttendDetailReport : "考勤明細報表",
	selMonth : "選擇月份",
	AttendOriginalCard : "考勤刷卡報表",
	Shift : "班次",
	OnDuty : "上班",
	OffDuty : "下班",
	WorkTime : "工時(M)",
	LateTime : "遲到(M)",
	LeaveEarly : "早退(M)",
	First : "第一次",
	Second : "第二次",
	Third : "第三次",
	selshowAllRowVal0 : "0 - 僅顯示有刷卡資料的行",
	selshowAllRowVal1 : "1 - 顯示日期範圍內所有行",
	AttendOriginalReport : "考勤原始刷卡報表",
	RedColor : " 注：<font color=#FF0000>(紅色)</font>表示非法卡",
	Month : "月份",
	WorkDay_0 : "出勤天數",
	WorkTime_0 : "總工時",
	LateCount_0 : "遲到次數",
	LateTime_0 : "遲到時間",
	LeaveEarlyCount_0 : "早退次數",
	LeaveEarlyTime_0 : "早退時間",
	AbnormityCount_0 : "異常次數",
	AttendTotalReport : "考勤匯總報表",
	Report : "報表",
	spanNavAttend : "考勤",
	aAttendTotal : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;考勤匯總",
	aAttendOriginalCard : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;考勤卡",
	aAttendOriginalReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;原始刷卡",
	aAttendDetailReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;刷卡明細",
	spanNavACS : "門禁",
	aAcsDetailReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;進出明細",
	aAcsIllegalReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;非法進出",
	aAcsButtonReport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;按鈕事件"
}

var tool={
	SelectAll : "全選",
	LoginName : "用戶名",
	LoginIP : "登錄機器",
	OperateTime : "日期",
	Modules : "模組",
	Actions : "操作方式",
	Objects : "對象",
	LogEvent : "日誌流覽",
	tool : "工具",
	spanNavUser : "用戶",
	aUsers : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用戶",
	spanNavImport : "導入人事",
	aImport : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;導入人事",
	spanNavLogEvent : "日誌",
	aLogEvent : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日誌",
	spanNavSetCode : "設置代碼",
	aSetCode : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;設置代碼",
	spanNavTotal : "考勤統計",
	aTotal : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;統計",
	selCodeTypeVal1 : "1 - 國籍",
	selCodeTypeVal2 : "2 - 籍貫",
	selCodeTypeVal3 : "3 - 職務",
	selCodeTypeVal4 : "4 - 職位",
	CodeName : "名稱",
	SetCode : "設置代碼",
	TotalMonth : "統計月份",
	TotalDimission : "僅統計離職人員",
	TotalDialogPrompt : "<B>[立即執行統計]</B>立即執行統計，執行過程中不能離開頁面，適用於資料量較小、統計能在短時間內完成（約2分鐘內）；<br /><br />&nbsp;&nbsp;&nbsp;&nbsp;<B>[服務執行統計]</B>通過服務執行統計，執行過程中可以離開頁面，適用於資料量較大或需花較多時間完成統計。",
	ExecTotal : "執行統計",
	CancelTotal : "取消統計",
	ImmediatelyTotal : "立即執行統計",
	ServiceTotal : "服務執行統計",
	TotalingNotLeave : "正在統計，請稍後......請不要離開頁面",
	Totaling : "正在統計，請稍後...",
	LoginName : "登錄名",
	Pwd : "密碼",
	Role : "角色",
	VisitDept : "訪問部門",
	VisitCon : "訪問設備",
	OperPermDescVal1 : "系統管理員",
	OperPermDescVal2 : "一般職員",
	UserList : "用戶列表",
	OperPermDescVal1Msg : "[系統管理員]擁有增加、修改、刪除等操作許可權",
	OperPermDescVal2Msg : "[一般職員]僅能查看資料，不能操作"
}

var mon={
	AllCon : "所有設備",
	MonitorTitle : "即時監控",
	Name : "姓名",
	Card : "卡號",
	Num : "工號",
	Dept : "部門",
	Time : "時間",
	Controller : "設備",
	Property : "屬性",
	Monitor : "監控",
	MonitorAll : "監控所有設備",
	StopMonitor : "停止監控",
	FullScreen : "全屏顯示",
	PSelectCon : "請先選擇設備",
	MonitorIsEmpty : "監控位址為空，請重新登錄再試！",
	MonitorPartIng : "正在監控部分設備:",
	MonitorAllIng : "正在監控所有設備...",
	StopMonitored : "已停止監控",
	ExitFullScreen : "退出全屏",
	OpenDoor : "遠程開門",
	SyncData : "立即同步",
	SyncTime : "立即校時",
	ConfirmOpenDoor : "確定遠程開門?",
	SelectOutput : "選擇輸出點",
	OutputMsg : "輸出點",
	PleSelCon : "請先選擇設備！",
	ExecSuccess : "執行成功",
	MonitorBrushCard : "監控進出明細",
	MonitorDoorStatus : "監控門狀態",
	DoorConnSta : "已連接網路，但門狀態未知",
	DoorDisConnSta : "已斷開",
	DoorCloseSta : "門已關閉",
	DoorOpenSta : "門已打開",
	DoorAlarmSta : "非法開門"

}
