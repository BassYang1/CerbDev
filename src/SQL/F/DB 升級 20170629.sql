USE CerbDb
GO
/*==============================================================*/
/* Table: FlowStepDetail                                          */
/* Desc: 流程经办明细                                              */
/*==============================================================*/
IF NOT EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'FlowStepDetail') AND XType = N'U')
BEGIN
	CREATE TABLE [dbo].[FlowStepDetail](
		[FlowType] [nvarchar](50) NULL,
		[FlowDataId] [int] NULL,
		[StepId] [int] NULL,
		[TransactorId] [int] NULL,
		[Transactor] [nvarchar](50) NULL,
		[Operation] [nvarchar](50) NULL,
		[OperateTime] [datetime] NULL,
		[TotalTime] [nvarchar](20) NULL,
		[Postil] [nvarchar](200) NULL
	) ON [PRIMARY]
END
GO


--修改LabelText字段类型
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelEnText')
	ALTER TABLE LabelText ALTER COLUMN LabelEnText NVARCHAR(1000) NULL --修改字段LabelEnText类型	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelZhtwText')
	ALTER TABLE LabelText ALTER COLUMN LabelZhtwText NVARCHAR(500) NULL --修改字段LabelZhtwText类型	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelZhcnText')
	ALTER TABLE LabelText ALTER COLUMN LabelZhcnText NVARCHAR(500) NULL --修改字段LabelZhcnText类型

--班次调整TempShifts，增加字段
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'AcalculateLate')
	ALTER TABLE TempShifts ADD AcalculateLate SMALLINT NULL --允许迟到时间	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'AcalculateEarly')
	ALTER TABLE TempShifts ADD AcalculateEarly SMALLINT NULL --允许早到时间	
	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'BcalculateLate')
	ALTER TABLE TempShifts ADD BcalculateLate SMALLINT NULL --允许迟到时间	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'BcalculateEarly')
	ALTER TABLE TempShifts ADD BcalculateEarly SMALLINT NULL --允许早到时间	
	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'CcalculateLate')
	ALTER TABLE TempShifts ADD CcalculateLate SMALLINT NULL --允许迟到时间	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'CcalculateEarly')
	ALTER TABLE TempShifts ADD CcalculateEarly SMALLINT NULL --允许早到时间	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'EmployeeExpress')
	ALTER TABLE TempShifts DROP COLUMN EmployeeExpress --允许早到时间

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'DepartmentCode')
	ALTER TABLE TempShifts ADD DepartmentCode NTEXT NULL --保存部门列表条件	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'EmployeeCode')
	ALTER TABLE TempShifts ADD EmployeeCode NTEXT NULL --保存职员列表条件	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'OtherCode')
	ALTER TABLE TempShifts ADD OtherCode NTEXT NULL --预留,后续可能再增加的条件

--班次调整AttendanceOndutyRule，增加字段
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRule') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRule') AND name = N'DepartmentCode')
	ALTER TABLE AttendanceOndutyRule ADD DepartmentCode NTEXT NULL --保存部门列表条件	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRule') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRule') AND name = N'OtherCode')
	ALTER TABLE AttendanceOndutyRule ADD OtherCode NTEXT NULL --预留,后续可能再增加的条件

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND name = N'DepartmentCode')
	ALTER TABLE AttendanceOndutyRuleChange ADD DepartmentCode NTEXT NULL --保存部门列表条件	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND name = N'OtherCode')
	ALTER TABLE AttendanceOndutyRuleChange ADD OtherCode NTEXT NULL --预留,后续可能再增加的条件		

--添加LabelText
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'Yes', '是', '是', 'Yes', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'Yes');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'No', '否', '否', 'No', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'No');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'RegEmpCondition', '未设置注册员工条件', '未設置註冊員工條件', 'Not set the staff conditions', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'RegEmpCondition');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AdjustShiftCondition', '未设置班次调整员工条件', '未設置班次調整員工條件', 'Not set the staff conditions', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AdjustShiftCondition');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftRulesCondition', '未设置上班规则员工条件', '未設置上班規則員工條件', 'Not set the staff conditions', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftRulesCondition');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AdjustShiftDate_Invalid', '班次调整时间无效', '班次調整時間無效', 'Invalid the date of the Shift Adjustment', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AdjustShiftDate_Invalid');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftRule_Invalid', '未设置上班规则', '未設置上班規則', 'Not set the shift rules', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftRule_Invalid');
								
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllDept', '所有部门', '所有部門', 'All Departments', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllEmp', '所有职员', '所有職員', 'All Employees', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');

--班次
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftNameUsed', '班次名称已使用', '班次名稱已使用', 'Shift Name already used', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftNameUsed');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'ExportDataExec.asp', 'shift', '班次', '班次', 'Shifts', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'shift');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'ExportDataExec.asp', 'shiftadjustment', '班次调整', '班次調整', 'Shifts Adjustment', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'shiftadjustment');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ShiftRules', '上班规则', '上班規則', 'Shift Rules', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ShiftRules');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'Holiday', '法定假期', '法定假期', 'Legal Holidays', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Holiday');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftsAdjustment', '班次调整', '班次調整', 'Shifts Adjustment', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftsAdjustment');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftRules', '上班规则', '上班規則', 'Shift Rules', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftRules');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday', '法定假期', '法定假期', 'Legal Holidays', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportShiftTitle', N'班次Id,班次名,基本工时,是否过夜,第一次上班刷卡,上班次数,弹性班次,上班标准时间1,上班开始时间1,上班截止时间1,下班开始时间1,下班标准时间1,下班截止时间1,允许迟到时间1,允许早退时间1,中间休息1,上班标准时间2,上班开始时间2,上班截止时间2,下班开始时间2,下班标准时间2,下班截止时间2,允许迟到时间2,允许早退时间2,中间休息2,上班标准时间3,上班开始时间3,上班截止时间3,下班开始时间3,下班标准时间3,下班截止时间3,允许迟到时间3,允许早退时间3,中间休息3', N'班次Id,班次名,基本工時,是否過夜,第壹次上班刷卡,上班次數,彈性班次,上班標準時間1,上班開始時間1,上班截止時間1,下班開始時間1,下班標準時間1,下班截止時間1,允許遲到時間1,允許早退時間1,中間休息1,上班標準時間2,上班開始時間2,上班截止時間2,下班開始時間2,下班標準時間2,下班截止時間2,允許遲到時間2,允許早退時間2,中間休息2,上班標準時間3,上班開始時間3,上班截止時間3,下班開始時間3,下班標準時間3,下班截止時間3,允許遲到時間3,允許早退時間3,中間休息3', 'Shift Id,Shift Name,Working Hour,Overnight,First Clock In,Time Period,Flexible Shifts,Standard Time 1 of On Duty,Start Time 1 of On Duty,End Time 1 of On Duty,Start Time 1 of Off Duty,Standard Time 1 of Off Duty,End Time 1 of Off Duty,Allow Late Time 1 (min),Allow Early Leave Time 1 (min),Rest 1 (min),Standard Time 2 of On Duty,Start Time 2 of On Duty,End Time 2 of On Duty,Start Time 2 of Off Duty,Standard Time 2 of Off Duty,End Time 2 of Off Duty,Allow Late Time 2 (min),Allow Early Leave Time 2 (min),Rest 2 (min),Standard Time 3 of On Duty,Start Time 3 of On Duty,End Time 3 of On Duty,Start Time 3 of Off Duty,Standard Time 3 of Off Duty,End Time 3 of Off Duty,Allow Late Time 3 (min),Allow Early Leave Time 3 (min),Rest 3 (min)', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportShiftTitle');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportShiftAdjustmentTitle', N'Id,班次类型,调整时间,班次名,基本工时,是否过夜,第一次上班刷卡,上班次数,弹性班次,调整员工,上班标准时间1,上班开始时间1,上班截止时间1,下班开始时间1,下班标准时间1,下班截止时间1,允许迟到时间1,允许早退时间1,中间休息1,上班标准时间2,上班开始时间2,上班截止时间2,下班开始时间2,下班标准时间2,下班截止时间2,允许迟到时间2,允许早退时间2,中间休息2,上班标准时间3,上班开始时间3,上班截止时间3,下班开始时间3,下班标准时间3,下班截止时间3,允许迟到时间3,允许早退时间3,中间休息3', N'Id,班次類型,調整時間,班次名,基本工時,是否過夜,第壹次上班刷卡,上班次數,彈性班次,調整員工,上班標準時間1,上班開始時間1,上班截止時間1,下班開始時間1,下班標準時間1,下班截止時間1,允許遲到時間1,允許早退時間1,中間休息1,上班標準時間2,上班開始時間2,上班截止時間2,下班開始時間2,下班標準時間2,下班截止時間2,允許遲到時間2,允許早退時間2,中間休息2,上班標準時間3,上班開始時間3,上班截止時間3,下班開始時間3,下班標準時間3,下班截止時間3,允許遲到時間3,允許早退時間3,中間休息3', 'Temp Shift Id,Shift Type,Adjustment Date,Shift Name,Working Hour,Overnight,First Clock In,Time Period,Flexible Shifts,Employee Desciption,Standard Time 1 of On Duty,Start Time 1 of On Duty,End Time 1 of On Duty,Start Time 1 of Off Duty,Standard Time 1 of Off Duty,End Time 1 of Off Duty,Allow Late Time 1 (min),Allow Early Leave Time 1 (min),Rest 1 (min),Standard Time 2 of On Duty,Start Time 2 of On Duty,End Time 2 of On Duty,Start Time 2 of Off Duty,Standard Time 2 of Off Duty,End Time 2 of Off Duty,Allow Late Time 2 (min),Allow Early Leave Time 2 (min),Rest 2 (min),Standard Time 3 of On Duty,Start Time 3 of On Duty,End Time 3 of On Duty,Start Time 3 of Off Duty,Standard Time 3 of Off Duty,End Time 3 of Off Duty,Allow Late Time 3 (min),Allow Early Leave Time 3 (min),Rest 3 (min)', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportShiftAdjustmentTitle');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportShiftRulesTitle', N'规则Id,员工说明,上班方式,免刷卡,第一周开始日,详细规则,生效日期', N'規則Id,員工說明,上班方式,免刷卡,第壹周開始日,詳細規則,生效日期', 'Rule Id,Employee Desciption,On Duty Mode,Start Date,Rule Detail,Effective Date', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportShiftRulesTitle');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportHolidayTitle', N'假期Id,假期日期,调换日期,假期说明,模板', N'假期Id,假期日期,調換日期,假期說明,模板', 'Holiday Id,Holiday Date,Adjusted Date,Remark,Template', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportHolidayTitle');

--上班方式
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Sng_Week_1', N'1-单周循环',N'1-單周迴圈',N'1-Single-week Cycle',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Sng_Week_1');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Dbl_Week_2', N'2-双周循环',N'2-雙周迴圈',N'2-Double-week Cycle',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Dbl_Week_2');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Custom_3', N'3-自定义循环',N'3-自定義迴圈',N'3-Custom Cycle',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Custom_3');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Dbl_St_Dt_Null', N'双周时第一周开始日不能为空！',N'雙周時第一周開始日不能為空！',N'The start day in the first week for a double-week cycle Not empty！',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Dbl_St_Dt_Null');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Dbl_St_Dt_Invalid', N'第一周开始日格式无效！',N'第一周開始日格式無效！',N'Invalid format for the start day in the week！',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Dbl_St_Dt_Invalid');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Loop_Count_Invalid', N'循环天数无效！',N'第一周開始日格式無效！',N'Invalid format for the start day in the week！',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Dbl_St_Dt_Invalid');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Effec_Dt_Null', N'生效日期不能为空！',N'生效日期不能為空！',N'Blank effecitve date！',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Effec_Dt_Null');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Effec_Dt_Invalid', N'生效日期格式无效！',N'生效日期格式無效！',N'Invalid Format for Effective Date！',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Effec_Dt_Invalid');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Name_More_50_Char', '假期说明只允许50个字符', '假期說明只允許50個字符', 'More than 50 characters', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Name_More_50_Char');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Date_Null', '假期日期不能为空！', '假期日期不能為空！', 'Blank holiday date!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Date_Null');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Date_Invalid', '假期日期无效！', '假期日期無效！', 'Invalid holiday date!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Date_Invalid');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Trans_Date_Invalid', '调换日期无效！', '調換日期無效！', 'Invalid date exchange!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Trans_Date_Invalid');
		
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Dupl_Holi_Date', '法定假期日期不可重复！', '法定假期日期不可重複！', 'Duplicate holiday date!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Dupl_Holi_Date');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Dupl_Date_Exch', '调换日期不可重复！', '調換日期不可重複！', 'Duplicate date exchange!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Dupl_Date_Exch');


--请假	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Emp_Annu_Leave', '年假', '年假', 'Annual', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Emp_Annu_Leave');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'HolidayName', '假期说明', '假期說明', 'Remarks on Holidays', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'HolidayName');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'EmpDescription', '员工说明', '員工說明', 'Employees Description', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'EmpDescription');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Re_Ask_For_Leave_On_Date', '时间段内已被申请过请假,不能再申请！', '時間段內已被申請過請假,不能再申請！', 'The time period has been asked for leave, can not apply again!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Re_Ask_For_Leave_On_Date');	
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Leave_Start_Date_Not_Null', '开始时间不能为空！', '開始時間不能為空！', 'The start time cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_Start_Date_Not_Null');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Leave_End_Date_Not_Null', '结束时间不能为空！', '結束時間不能為空！', 'The end time cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_End_Date_Not_Null');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Leave_Time_Over_24_Hour', '非整天请假不能超过24小时！', '非整天請假不能超過24小時！', 'You cannot take more than 24 hours of leave!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_Time_Over_24_Hour');
		
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Workflow', 'Leave_Time_Invalid', '非法时间！', '非法時間24小時！', 'Invalid Time!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_Time_Invalid');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Workflow', 'Leave_Time_Interval_5_Minute ', '开始时间不能大于等于截止时间,且间隔需大于等于5分钟！', '開始時間不能大於等於截止時間,且間隔需大於等於5分鐘！', 'The start time cannot be greater than or equal to the deadline, and the interval should be greater than or equal to 5 minutes!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_Time_Interval_5_Minute');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_All_A', 'A - 全部', 'A - 全部', 'A - All', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_All_A');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Apply_0', '0 - 申请', '0 - 申請', '0 - Application', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Apply_0');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Review_1', '1 - 审核', '1 - 審核', '1 - Review', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Review_1');	

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Approval_2', '2 - 批准', '2 - 批準', '2 - Approval', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Approval_2');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Refusal_3', '3 - 拒绝', '3 - 拒絕', '3 - Refusal', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Refusal_3');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Review_With_Pend_4', '4 - 待撤审', '4 - 待撤審', '4 - Review withdrawal pending', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Review_With_Pend_4');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Approve_With_Pend_5', '5 - 待撤批', '5 - 待撤批', '5 - Approval withdrawal pending', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Approve_With_Pend_5');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Ceased_C', 'C - 中止', 'C - 中止', 'C - Ceased', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Ceased_C');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Workflow', 'FlowOper_Not_Exist_Approver', '审批人不存在！', '審批人不存在！', 'The approver does not exist!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Not_Exist_Approver');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowType', 'FlowType_Leave_0', '0 - 请假', '0 - 請假', '0 - Leave', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowType_Leave_0');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowType', 'FlowType_Trip_1', '1 - 出差', '1 - 出差', '1 - Trip', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowType_Trip_1');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowType', 'FlowType_Overtime_2', '2 - 加班', '2 - 加班', '2 - Overtime', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowType_Overtime_2');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowType', 'FlowType_Signcard_3', '3 - 补卡', '3 - 補卡', '3 - Signcard', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowType_Signcard_3');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'FlowApprove_Desc_Length_50', '批注说明最多长度为50个字符！', '批註說明最多長度為50個字符！', 'The maximum length of Description is 50 characters', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowApprove_Desc_Length_50');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Attend_Leave', '请假', '請假', 'Leave', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Attend_Leave');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Attend_Trip', '出差', '出差', 'Trip', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Attend_Trip');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Attend_SignCard', '补卡', '補卡', 'Signcard', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Attend_SignCard');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Attend_Overtime', '加班', '加班', 'Overtime', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Attend_Overtime');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Cerb', NULL, 'strLogApply', '申请', '申請', 'Application', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Cerb' AND LabelId = 'strLogApply');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Cerb', NULL, 'strLogApproval', '批准', '批准', 'Approval', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Cerb' AND LabelId = 'strLogApproval');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Cerb', NULL, 'strLogRefuse', '拒绝', '拒絕', 'Refuse', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Cerb' AND LabelId = 'strLogRefuse');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Cerb', NULL, 'strLogCease', '中止', '中止', 'Cease', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Cerb' AND LabelId = 'strLogCease');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_All_A', 'A - 全部', 'A - 全部', 'A - All', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_All_A');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Applied_0', '0 - 申请', '0 - 申請', '0 - Application', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Applied_0');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Reviewed_1', '1 - 已审', '1 - 已審', '1 - Reviewed', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Reviewed_1');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Approved_2', '2 - 已批', '2 - 已批', '2 - Approved', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Approved_2');		

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Refused_3', '3 - 拒绝', '3 - 拒絕', '3 - Refused', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Refused_3');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Ceased_C', 'C - 中止', 'C - 中止', 'C - Ceased', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Ceased_C');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'SignCard', 'SignCard_Reason_Not_Null', '补卡原因不能为空！', '補卡原因不能為空！', 'The reason cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'SignCard_Reason_Not_Null');
			
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'SignCard', 'Reason_More_50_Char', '补卡原因只允许50个字符！', '補卡原因只允許50個字符！', 'More than 50 characters!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Reason_More_50_Char');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'SignCard', 'Brush_Date_Not_Null', '补卡时间不能为空！', '補卡時間不能為空！', 'The brush time cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Brush_Date_Not_Null');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'SignCard', 'Not_ReSign_On_Same_Time', '一天中同一人不可有重复补卡！', '壹天中同壹人不可有重復補卡！', 'One person must not have a duplicate card in one day!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Not_ReSign_On_Same_Time');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Overtime', 'Time_Over_24_Hour', '加班时间不能超过24小时！', '加班時間不能超過24小時！', 'You cannot take more than 24 hours!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Time_Over_24_Hour');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Overtime', 'Not_Reapply_Same_Period', '时间段内不能重复申请！', '時間段內不能重復申請！', 'The application cannot be repeated for a period of time!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Not_Reapply_Same_Period');	

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Overtime', 'OT_Reason_More_50_Char', '加班原因只允许50个字符！', '加班原因只允許50個字符！', 'More than 50 characters!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'OT_Reason_More_50_Char');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Overtime', 'OT_Reason_Not_Null', '加班原因不能为空！', '加班原因不能為空！', 'The reason cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'OT_Reason_Not_Null');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportLeaveTitle', N'记录Id,部门,姓名,请假类型,是否整天,开始时间,结束时间,状态,说明', N'記錄Id,部門,姓名,請假類型,是否整天,開始時間,結束時間,狀態,說明', 'Record Id,Department,Name,Leave Type,Whole Day,Start Time,End Time,Status,Remark', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportLeaveTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportTripTitle', N'记录Id,部门,姓名,出差地点,拟办事项,开始时间,结束时间,状态', N'記錄Id,部門,姓名,出差地點,擬辦事項,開始時間,結束時間,狀態', 'Record Id,Department,Name,Trip Destination,Transact Thing,Start Time,End Time,Status', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportTripTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportSignCardTitle', N'记录Id,部门,姓名,时间,原因,状态', N'記錄Id,部門,姓名,時間,原因,狀態', 'Record Id,Department,Name,Time,Reason,Status', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportSignCardTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportOvertimeTitle', N'记录Id,部门,姓名,原因,开始时间,结束时间,状态', N'記錄Id,部門,姓名,原因,開始時間,結束時間,狀態', 'Record Id,Department,Name,Reason,Start Time,End Time,Status', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportOvertimeTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'AskForLeave', '请假', '請假', 'Ask for Leave', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'AskForLeave');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'OnTrip', '出差', '出差', 'On Trip', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'OnTrip');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'SignCard', '补卡', '補卡', 'Sign Card', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'SignCard');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'OverTime', '加班', '加班', 'Over Time', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'OverTime');
					
GO