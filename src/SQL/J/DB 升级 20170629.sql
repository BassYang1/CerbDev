USE CerbDb
GO
/*==============================================================*/
/* Table: FlowStepDetail                                          */
/* Desc: ���̾�����ϸ                                              */
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

--�޸�LabelText�ֶ�����
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelEnText')
	ALTER TABLE LabelText ALTER COLUMN LabelEnText NVARCHAR(1000) NULL --�޸��ֶ�LabelEnText����	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelZhtwText')
	ALTER TABLE LabelText ALTER COLUMN LabelZhtwText NVARCHAR(500) NULL --�޸��ֶ�LabelZhtwText����	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'LabelText') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'LabelText') AND name = N'LabelZhcnText')
	ALTER TABLE LabelText ALTER COLUMN LabelZhcnText NVARCHAR(500) NULL --�޸��ֶ�LabelZhcnText����

--��ε���TempShifts�������ֶ�
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'AcalculateLate')
	ALTER TABLE TempShifts ADD AcalculateLate SMALLINT NULL --����ٵ�ʱ��	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'AcalculateEarly')
	ALTER TABLE TempShifts ADD AcalculateEarly SMALLINT NULL --�����絽ʱ��	
	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'BcalculateLate')
	ALTER TABLE TempShifts ADD BcalculateLate SMALLINT NULL --����ٵ�ʱ��	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'BcalculateEarly')
	ALTER TABLE TempShifts ADD BcalculateEarly SMALLINT NULL --�����絽ʱ��	
	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'CcalculateLate')
	ALTER TABLE TempShifts ADD CcalculateLate SMALLINT NULL --����ٵ�ʱ��	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'CcalculateEarly')
	ALTER TABLE TempShifts ADD CcalculateEarly SMALLINT NULL --�����絽ʱ��	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'EmployeeExpress')
	ALTER TABLE TempShifts ADD EmployeeExpress NTEXT NULL --Ա������

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'DepartmentCode')
	ALTER TABLE TempShifts ADD DepartmentCode NTEXT NULL --���沿���б�����	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'EmployeeCode')
	ALTER TABLE TempShifts ADD EmployeeCode NTEXT NULL --����ְԱ�б�����	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'Relationship')
	ALTER TABLE TempShifts ADD Relationship NVARCHAR(10) NULL --Ԥ��,������������ϵ

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'OtherCode')
	ALTER TABLE TempShifts ADD OtherCode NTEXT NULL --Ԥ��,�������������ӵ�����

--��ε���AttendanceOndutyRule�������ֶ�
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRule') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRule') AND name = N'DepartmentCode')
	ALTER TABLE AttendanceOndutyRule ADD DepartmentCode NTEXT NULL --���沿���б�����	
	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRule') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRule') AND name = N'Relationship')
	ALTER TABLE AttendanceOndutyRule ADD Relationship NVARCHAR(10) NULL --Ԥ��,������������ϵ

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRule') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRule') AND name = N'OtherCode')
	ALTER TABLE AttendanceOndutyRule ADD OtherCode NTEXT NULL --Ԥ��,�������������ӵ�����
	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRule') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRule') AND name = N'EmployeeExpress')
	ALTER TABLE AttendanceOndutyRule ADD EmployeeExpress NTEXT NULL --Ա������

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND name = N'DepartmentCode')
	ALTER TABLE AttendanceOndutyRuleChange ADD DepartmentCode NTEXT NULL --���沿���б�����	
	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND name = N'Relationship')
	ALTER TABLE AttendanceOndutyRuleChange ADD Relationship NVARCHAR(10) NULL --Ԥ��,������������ϵ

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND name = N'OtherCode')
	ALTER TABLE AttendanceOndutyRuleChange ADD OtherCode NTEXT NULL --Ԥ��,�������������ӵ�����		

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND name = N'EmployeeExpress')
	ALTER TABLE AttendanceOndutyRuleChange ADD EmployeeExpress NTEXT NULL --Ա������

--���LabelText
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'Yes', '��', '��', 'Yes', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'Yes');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'No', '��', '��', 'No', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'No');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Equipment', NULL, 'RegEmpCondition', 'δ����ע��Ա������', 'δ�O���]�ԆT���l��', 'Not set the staff conditions', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Equipment' AND LabelId = 'RegEmpCondition');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AdjustShiftCondition', 'δ���ð�ε���Ա������', 'δ�O�ð���{���T���l��', 'Not set the staff conditions', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AdjustShiftCondition');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftRulesCondition', 'δ�����ϰ����Ա������', 'δ�O���ϰ�Ҏ�t�T���l��', 'Not set the staff conditions', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftRulesCondition');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AdjustShiftDate_Invalid', '��ε���ʱ����Ч', '����{���r�g�oЧ', 'Invalid the date of the Shift Adjustment', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AdjustShiftDate_Invalid');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftRule_Invalid', 'δ�����ϰ����', 'δ�O���ϰ�Ҏ�t', 'Not set the shift rules', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftRule_Invalid');
								
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllDept', '���в���', '���в��T', 'All Departments', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'AllEmp', '����ְԱ', '�����T', 'All Employees', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'AllDept');

--���
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftNameUsed', '���������ʹ��', '������Q��ʹ��', 'Shift Name already used', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftNameUsed');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'ExportDataExec.asp', 'shift', '���', '���', 'Shifts', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'shift');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'ExportDataExec.asp', 'shiftadjustment', '��ε���', '����{��', 'Shifts Adjustment', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'shiftadjustment');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ShiftRules', '�ϰ����', '�ϰ�Ҏ�t', 'Shift Rules', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ShiftRules');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'Holiday', '��������', '��������', 'Legal Holidays', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Holiday');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftsAdjustment', '��ε���', '����{��', 'Shifts Adjustment', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftsAdjustment');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'ShiftRules', '�ϰ����', '�ϰ�Ҏ�t', 'Shift Rules', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'ShiftRules');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday', '��������', '��������', 'Legal Holidays', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportShiftTitle', N'���Id,�����,������ʱ,�Ƿ��ҹ,��һ���ϰ�ˢ��,�ϰ����,���԰��,�ϰ��׼ʱ��1,�ϰ࿪ʼʱ��1,�ϰ��ֹʱ��1,�°࿪ʼʱ��1,�°��׼ʱ��1,�°��ֹʱ��1,����ٵ�ʱ��1,��������ʱ��1,�м���Ϣ1,�ϰ��׼ʱ��2,�ϰ࿪ʼʱ��2,�ϰ��ֹʱ��2,�°࿪ʼʱ��2,�°��׼ʱ��2,�°��ֹʱ��2,����ٵ�ʱ��2,��������ʱ��2,�м���Ϣ2,�ϰ��׼ʱ��3,�ϰ࿪ʼʱ��3,�ϰ��ֹʱ��3,�°࿪ʼʱ��3,�°��׼ʱ��3,�°��ֹʱ��3,����ٵ�ʱ��3,��������ʱ��3,�м���Ϣ3', N'���Id,�����,�������r,�Ƿ��^ҹ,��Ҽ���ϰ�ˢ��,�ϰ�Δ�,���԰��,�ϰ��˜ʕr�g1,�ϰ��_ʼ�r�g1,�ϰ��ֹ�r�g1,�°��_ʼ�r�g1,�°��˜ʕr�g1,�°��ֹ�r�g1,���S�t���r�g1,���S���˕r�g1,���g��Ϣ1,�ϰ��˜ʕr�g2,�ϰ��_ʼ�r�g2,�ϰ��ֹ�r�g2,�°��_ʼ�r�g2,�°��˜ʕr�g2,�°��ֹ�r�g2,���S�t���r�g2,���S���˕r�g2,���g��Ϣ2,�ϰ��˜ʕr�g3,�ϰ��_ʼ�r�g3,�ϰ��ֹ�r�g3,�°��_ʼ�r�g3,�°��˜ʕr�g3,�°��ֹ�r�g3,���S�t���r�g3,���S���˕r�g3,���g��Ϣ3', 'Shift Id,Shift Name,Working Hour,Overnight,First Clock In,Time Period,Flexible Shifts,Standard Time 1 of On Duty,Start Time 1 of On Duty,End Time 1 of On Duty,Start Time 1 of Off Duty,Standard Time 1 of Off Duty,End Time 1 of Off Duty,Allow Late Time 1 (min),Allow Early Leave Time 1 (min),Rest 1 (min),Standard Time 2 of On Duty,Start Time 2 of On Duty,End Time 2 of On Duty,Start Time 2 of Off Duty,Standard Time 2 of Off Duty,End Time 2 of Off Duty,Allow Late Time 2 (min),Allow Early Leave Time 2 (min),Rest 2 (min),Standard Time 3 of On Duty,Start Time 3 of On Duty,End Time 3 of On Duty,Start Time 3 of Off Duty,Standard Time 3 of Off Duty,End Time 3 of Off Duty,Allow Late Time 3 (min),Allow Early Leave Time 3 (min),Rest 3 (min)', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportShiftTitle');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportShiftAdjustmentTitle', N'Id,�������,����ʱ��,�����,������ʱ,�Ƿ��ҹ,��һ���ϰ�ˢ��,�ϰ����,���԰��,����Ա��,�ϰ��׼ʱ��1,�ϰ࿪ʼʱ��1,�ϰ��ֹʱ��1,�°࿪ʼʱ��1,�°��׼ʱ��1,�°��ֹʱ��1,����ٵ�ʱ��1,��������ʱ��1,�м���Ϣ1,�ϰ��׼ʱ��2,�ϰ࿪ʼʱ��2,�ϰ��ֹʱ��2,�°࿪ʼʱ��2,�°��׼ʱ��2,�°��ֹʱ��2,����ٵ�ʱ��2,��������ʱ��2,�м���Ϣ2,�ϰ��׼ʱ��3,�ϰ࿪ʼʱ��3,�ϰ��ֹʱ��3,�°࿪ʼʱ��3,�°��׼ʱ��3,�°��ֹʱ��3,����ٵ�ʱ��3,��������ʱ��3,�м���Ϣ3', N'Id,������,�{���r�g,�����,�������r,�Ƿ��^ҹ,��Ҽ���ϰ�ˢ��,�ϰ�Δ�,���԰��,�{���T��,�ϰ��˜ʕr�g1,�ϰ��_ʼ�r�g1,�ϰ��ֹ�r�g1,�°��_ʼ�r�g1,�°��˜ʕr�g1,�°��ֹ�r�g1,���S�t���r�g1,���S���˕r�g1,���g��Ϣ1,�ϰ��˜ʕr�g2,�ϰ��_ʼ�r�g2,�ϰ��ֹ�r�g2,�°��_ʼ�r�g2,�°��˜ʕr�g2,�°��ֹ�r�g2,���S�t���r�g2,���S���˕r�g2,���g��Ϣ2,�ϰ��˜ʕr�g3,�ϰ��_ʼ�r�g3,�ϰ��ֹ�r�g3,�°��_ʼ�r�g3,�°��˜ʕr�g3,�°��ֹ�r�g3,���S�t���r�g3,���S���˕r�g3,���g��Ϣ3', 'Temp Shift Id,Shift Type,Adjustment Date,Shift Name,Working Hour,Overnight,First Clock In,Time Period,Flexible Shifts,Employee Desciption,Standard Time 1 of On Duty,Start Time 1 of On Duty,End Time 1 of On Duty,Start Time 1 of Off Duty,Standard Time 1 of Off Duty,End Time 1 of Off Duty,Allow Late Time 1 (min),Allow Early Leave Time 1 (min),Rest 1 (min),Standard Time 2 of On Duty,Start Time 2 of On Duty,End Time 2 of On Duty,Start Time 2 of Off Duty,Standard Time 2 of Off Duty,End Time 2 of Off Duty,Allow Late Time 2 (min),Allow Early Leave Time 2 (min),Rest 2 (min),Standard Time 3 of On Duty,Start Time 3 of On Duty,End Time 3 of On Duty,Start Time 3 of Off Duty,Standard Time 3 of Off Duty,End Time 3 of Off Duty,Allow Late Time 3 (min),Allow Early Leave Time 3 (min),Rest 3 (min)', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportShiftAdjustmentTitle');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportShiftRulesTitle', N'����Id,Ա��˵��,�ϰ෽ʽ,��ˢ��,��һ�ܿ�ʼ��,��ϸ����,��Ч����', N'Ҏ�tId,�T���f��,�ϰ෽ʽ,��ˢ��,��Ҽ���_ʼ��,Ԕ��Ҏ�t,��Ч����', 'Rule Id,Employee Desciption,On Duty Mode,Start Date,Rule Detail,Effective Date', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportShiftRulesTitle');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportHolidayTitle', N'����Id,��������,��������,����˵��,ģ��', N'����Id,��������,�{�Q����,�����f��,ģ��', 'Holiday Id,Holiday Date,Adjusted Date,Remark,Template', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportHolidayTitle');

--�ϰ෽ʽ
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Sng_Week_1', N'1-����ѭ��',N'1-����ޒȦ',N'1-Single-week Cycle',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Sng_Week_1');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Dbl_Week_2', N'2-˫��ѭ��',N'2-�p��ޒȦ',N'2-Double-week Cycle',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Dbl_Week_2');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Custom_3', N'3-�Զ���ѭ��',N'3-�Զ��xޒȦ',N'3-Custom Cycle',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Custom_3');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Dbl_St_Dt_Null', N'˫��ʱ��һ�ܿ�ʼ�ղ���Ϊ�գ�',N'�p�ܕr��һ���_ʼ�ղ��ܞ�գ�',N'The start day in the first week for a double-week cycle Not empty��',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Dbl_St_Dt_Null');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Dbl_St_Dt_Invalid', N'��һ�ܿ�ʼ�ո�ʽ��Ч��',N'��һ���_ʼ�ո�ʽ�oЧ��',N'Invalid format for the start day in the week��',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Dbl_St_Dt_Invalid');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Loop_Count_Invalid', N'ѭ��������Ч��',N'��һ���_ʼ�ո�ʽ�oЧ��',N'Invalid format for the start day in the week��',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Dbl_St_Dt_Invalid');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Effec_Dt_Null', N'��Ч���ڲ���Ϊ�գ�',N'��Ч���ڲ��ܞ�գ�',N'Blank effecitve date��',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Effec_Dt_Null');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Wm_Effec_Dt_Invalid', N'��Ч���ڸ�ʽ��Ч��',N'��Ч���ڸ�ʽ�oЧ��',N'Invalid Format for Effective Date��',NULL
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Wm_Effec_Dt_Invalid');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Name_More_50_Char', '����˵��ֻ����50���ַ�', '�����f��ֻ���S50���ַ�', 'More than 50 characters', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Name_More_50_Char');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Date_Null', '�������ڲ���Ϊ�գ�', '�������ڲ��ܞ�գ�', 'Blank holiday date!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Date_Null');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Date_Invalid', '����������Ч��', '�������ڟoЧ��', 'Invalid holiday date!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Date_Invalid');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Trans_Date_Invalid', '����������Ч��', '�{�Q���ڟoЧ��', 'Invalid date exchange!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Trans_Date_Invalid');
		
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Dupl_Holi_Date', '�����������ڲ����ظ���', '�����������ڲ������}��', 'Duplicate holiday date!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Dupl_Holi_Date');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Holiday_Dupl_Date_Exch', '�������ڲ����ظ���', '�{�Q���ڲ������}��', 'Duplicate date exchange!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Holiday_Dupl_Date_Exch');


--���	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Emp_Annu_Leave', '���', '���', 'Annual', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Emp_Annu_Leave');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'HolidayName', '����˵��', '�����f��', 'Remarks on Holidays', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'HolidayName');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'EmpDescription', 'Ա��˵��', '�T���f��', 'Employees Description', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'EmpDescription');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Re_Ask_For_Leave_On_Date', 'ʱ������ѱ��������ٻ����,���������룡', '�r�g�΃��ѱ���Ո�^Ո�ٻ����,��������Ո��', 'The time period has been asked for leave or trip, can not apply again!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Re_Ask_For_Leave_On_Date');	
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Re_Ask_For_OT_On_Date', 'ʱ������ѱ�������Ӱ�,���������룡', '�r�g�΃��ѱ���Ո�Ӱ�,��������Ո��', 'The time period has been asked for OT, can not apply again!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Re_Ask_For_OT_On_Date');	
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Leave_Start_Date_Not_Null', '��ʼʱ�䲻��Ϊ�գ�', '�_ʼ�r�g���ܞ�գ�', 'The start time cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_Start_Date_Not_Null');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Leave_End_Date_Not_Null', '����ʱ�䲻��Ϊ�գ�', '�Y���r�g���ܞ�գ�', 'The end time cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_End_Date_Not_Null');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Leave_Time_Over_24_Hour', '��������ٲ��ܳ���24Сʱ��', '������Ո�ٲ��ܳ��^24С�r��', 'You cannot take more than 24 hours of leave!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_Time_Over_24_Hour');
		
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Workflow', 'Leave_Time_Invalid', '�Ƿ�ʱ�䣡', '�Ƿ��r�g24С�r��', 'Invalid Time!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_Time_Invalid');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Workflow', 'Leave_Time_Interval_5_Minute ', '��ʼʱ�䲻�ܴ��ڵ��ڽ�ֹʱ��,�Ҽ������ڵ���5���ӣ�', '�_ʼ�r�g���ܴ�춵�춽�ֹ�r�g,���g�����춵��5��犣�', 'The start time cannot be greater than or equal to the deadline, and the interval should be greater than or equal to 5 minutes!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Leave_Time_Interval_5_Minute');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_All_A', 'A - ȫ��', 'A - ȫ��', 'A - All', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_All_A');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Apply_0', '0 - ����', '0 - ��Ո', '0 - Application', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Apply_0');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Review_1', '1 - ���', '1 - ����', '1 - Review', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Review_1');	

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Approval_2', '2 - ��׼', '2 - ����', '2 - Approval', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Approval_2');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Refusal_3', '3 - �ܾ�', '3 - �ܽ^', '3 - Refusal', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Refusal_3');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Review_With_Pend_4', '4 - ������', '4 - ������', '4 - Review withdrawal pending', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Review_With_Pend_4');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Approve_With_Pend_5', '5 - ������', '5 - ������', '5 - Approval withdrawal pending', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Approve_With_Pend_5');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowOper', 'FlowOper_Ceased_C', 'C - ��ֹ', 'C - ��ֹ', 'C - Ceased', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Ceased_C');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Workflow', 'FlowOper_Not_Exist_Approver', '�����˲����ڣ�', '�����˲����ڣ�', 'The approver does not exist!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowOper_Not_Exist_Approver');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowType', 'FlowType_Leave_0', '0 - ���', '0 - Ո��', '0 - Leave', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowType_Leave_0');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowType', 'FlowType_Trip_1', '1 - ����', '1 - ����', '1 - Trip', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowType_Trip_1');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowType', 'FlowType_Overtime_2', '2 - �Ӱ�', '2 - �Ӱ�', '2 - Overtime', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowType_Overtime_2');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowType', 'FlowType_Signcard_3', '3 - ����', '3 - �a��', '3 - Signcard', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowType_Signcard_3');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'FlowApprove_Desc_Length_50', '��ע˵����೤��Ϊ50���ַ���', '���]�f������L�Ȟ�50���ַ���', 'The maximum length of Description is 50 characters', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowApprove_Desc_Length_50');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Attend_Leave', '���', 'Ո��', 'Leave', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Attend_Leave');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Attend_Trip', '����', '����', 'Trip', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Attend_Trip');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Attend_SignCard', '����', '�a��', 'Signcard', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Attend_SignCard');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Attend_Overtime', '�Ӱ�', '�Ӱ�', 'Overtime', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Attend_Overtime');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Cerb', NULL, 'strLogApply', '����', '��Ո', 'Application', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Cerb' AND LabelId = 'strLogApply');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Cerb', NULL, 'strLogApproval', '��׼', '��׼', 'Approval', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Cerb' AND LabelId = 'strLogApproval');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Cerb', NULL, 'strLogRefuse', '�ܾ�', '�ܽ^', 'Refuse', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Cerb' AND LabelId = 'strLogRefuse');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Cerb', NULL, 'strLogCease', '��ֹ', '��ֹ', 'Cease', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Cerb' AND LabelId = 'strLogCease');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_All_A', 'A - ȫ��', 'A - ȫ��', 'A - All', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_All_A');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Applied_0', '0 - ����', '0 - ��Ո', '0 - Application', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Applied_0');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Reviewed_1', '1 - ����', '1 - �ь�', '1 - Reviewed', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Reviewed_1');		
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Approved_2', '2 - ����', '2 - ����', '2 - Approved', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Approved_2');		

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Refused_3', '3 - �ܾ�', '3 - �ܽ^', '3 - Refused', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Refused_3');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Review_Pending', '4 - ������', '4 - ������', '4 - Review withdrawal pending', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Review_Pending');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Approve_Pending', '5 - ������', '5 - ������', '5 - Approval withdrawal pending', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Approve_Pending');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'WorkflowStatus', 'FlowStatus_Ceased_C', 'C - ��ֹ', 'C - ��ֹ', 'C - Ceased', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'FlowStatus_Ceased_C');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'SignCard', 'SignCard_Reason_Not_Null', '����ԭ����Ϊ�գ�', '�a��ԭ���ܞ�գ�', 'The reason cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'SignCard_Reason_Not_Null');
			
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'SignCard', 'Reason_More_50_Char', '����ԭ��ֻ����50���ַ���', '�a��ԭ��ֻ���S50���ַ���', 'More than 50 characters!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Reason_More_50_Char');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'SignCard', 'Brush_Date_Not_Null', '����ʱ�䲻��Ϊ�գ�', '�a���r�g���ܞ�գ�', 'The brush time cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Brush_Date_Not_Null');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'SignCard', 'Not_ReSign_On_Same_Time', 'һ����ͬһ�˲������ظ�������', 'Ҽ����ͬҼ�˲������؏��a����', 'One person must not have a duplicate card in one day!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Not_ReSign_On_Same_Time');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Overtime', 'Time_Over_24_Hour', '�Ӱ�ʱ�䲻�ܳ���24Сʱ��', '�Ӱ��r�g���ܳ��^24С�r��', 'You cannot take more than 24 hours!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Time_Over_24_Hour');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Overtime', 'Not_Reapply_Same_Period', 'ʱ����ڲ����ظ����룡', '�r�g�΃Ȳ����؏���Ո��', 'The application cannot be repeated for a period of time!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Not_Reapply_Same_Period');	

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Overtime', 'OT_Reason_More_50_Char', '�Ӱ�ԭ��ֻ����50���ַ���', '�Ӱ�ԭ��ֻ���S50���ַ���', 'More than 50 characters!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'OT_Reason_More_50_Char');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', 'Overtime', 'OT_Reason_Not_Null', '�Ӱ�ԭ����Ϊ�գ�', '�Ӱ�ԭ���ܞ�գ�', 'The reason cannot be empty!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'OT_Reason_Not_Null');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportLeaveTitle', N'��¼Id,����,����,�������,�Ƿ�����,��ʼʱ��,����ʱ��,״̬,˵��', N'ӛ�Id,���T,����,Ո�����,�Ƿ�����,�_ʼ�r�g,�Y���r�g,��B,�f��', 'Record Id,Department,Name,Leave Type,Whole Day,Start Time,End Time,Status,Remark', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportLeaveTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportTripTitle', N'��¼Id,����,����,����ص�,�������,��ʼʱ��,����ʱ��,״̬', N'ӛ�Id,���T,����,������c,�M�k���,�_ʼ�r�g,�Y���r�g,��B', 'Record Id,Department,Name,Trip Destination,Transact Thing,Start Time,End Time,Status', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportTripTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportSignCardTitle', N'��¼Id,����,����,ʱ��,ԭ��,״̬', N'ӛ�Id,���T,����,�r�g,ԭ��,��B', 'Record Id,Department,Name,Time,Reason,Status', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportSignCardTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'ExportOvertimeTitle', N'��¼Id,����,����,ԭ��,��ʼʱ��,����ʱ��,״̬', N'ӛ�Id,���T,����,ԭ��,�_ʼ�r�g,�Y���r�g,��B', 'Record Id,Department,Name,Reason,Start Time,End Time,Status', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'ExportOvertimeTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'AskForLeave', '���', 'Ո��', 'Ask for Leave', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'AskForLeave');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'OnTrip', '����', '����', 'On Trip', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'OnTrip');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'SignCard', '����', '�a��', 'Sign Card', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'SignCard');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'OverTime', '�Ӱ�', '�Ӱ�', 'Over Time', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'OverTime');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Late_Min_Not_Numeric', '�ٵ�����ʱ������д��ֵ��', '�t��Ҏ�t�r�g�����ֵ��', 'The late minute is not a numeric!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Late_Min_Not_Numeric');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Early_Min_Not_Numeric', '���˹���ʱ������д��ֵ��', '�t��Ҏ�t�r�g�����ֵ��', 'The early minute is not a numeric!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Early_Min_Not_Numeric');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Ot_Over_Min_Not_Numeric', '�Ӱ೬ʱʱ������д��ֵ��', '�Ӱ೬�r�r�g�����ֵ��', 'The OT over time is not a numeric!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Ot_Over_Min_Not_Numeric');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Auto_Total_Time_Not_Valid', '�Զ�ͳ��ʱ����Ч��', '�ԄӽyӋ�r�g�oЧ��', 'The total time is invalid!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Auto_Total_Time_Not_Valid');
		
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Workflow_Approver_Empty', 'δ��д���������˹��ţ�', 'δ����̌����˹�̖��', 'The total time is invalid!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Workflow_Approver_Empty');
		
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Workflow_Approver_Invalid', '������������Ч', '���̌����˟oЧ��', 'The workflow approver is invalid!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Workflow_Approver_Invalid');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Annual_Day_Not_Numeric', '�����������д��ֵ��', '����씵�����ֵ��', 'The annual day is not a numeric!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Annual_Day_Not_Numeric');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Annual_Year_Not_Numeric', '������������д��ֵ��', '�������������ֵ��', 'The annual year is not a numeric!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Annual_Year_Not_Numeric');
		
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'AttendOption', 'Holiday_Work_Time_Not_Numeric', '��Ϣ�����ƹ�ʱ����д��ֵ��', '��Ϣ����Ӌ���r�����ֵ��', 'The work time is not a numeric!', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Holiday_Work_Time_Not_Numeric');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'OverTimeTotal', '�Ӱ����', '�Ӱ��R��', 'OT Summary', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'OverTimeTotal');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'AttendOTTitle', N'�·�,����,����,����,��ʱ�Ӱ�(M),�Ӱ����,��Ϣ�ռӰ�(M),�ڼ��ռӰ�(M)', N'�·�,���T,����,��̖,���r�Ӱ�(M),�Ӱ�Δ�,��Ϣ�ռӰ�(M),�����ռӰ�(M)', 'Month,Department,Name,Number,OT WorkDay,OT Count,OT RestDay,OT', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'AttendOTTitle');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'AttendTodayOnduty', '�����ϰ�', '�����ϰ�', 'Today', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'AttendTodayOnduty');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'AttendTodayOndutyTitle', N'����,��ְ����,����ʵ��,�ٵ�,�¼�,����,����,����,����', N'���T,�����˔�,���Ռ���,�t��,�¼�,����,����,����,��', 'Department,Regimented Employees,Current Day on Duty,Late,Private Leave,Sick Leave,Trip,Other Leaves,Absence', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'AttendTodayOndutyTitle');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report', 'AttendTodayDetail', 'AttTodayDetail_Emp', 'ʵ�ϰ���Ա', '���ϰ��ˆT', 'Employees on Duty', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'AttTodayDetail_Emp');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report', 'AttendTodayDetail', 'AttTodayDetail_Leave_Emp', '�����Ա', 'Ո���ˆT', 'Employees on Leave', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'AttTodayDetail_Leave_Emp');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report', 'AttendTodayDetail', 'AttTodayDetail_Abs_Emp', 'δ�ϰ���Ա', 'δ�ϰ��ˆT', 'Employees on Absence', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'AttTodayDetail_Abs_Emp');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report', 'AttendTodayDetail', 'AttTodayDetail_Late_Emp', '�ٵ���Ա', '	', 'Employees on Late Attendance', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'AttTodayDetail_Late_Emp');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','AttendTodayDetail','AttTodayDetail_Leave_Type','���,�¼�,����,����,���,����,����,ɥ��,����,������,������,�����,̽�׼�','���,�¼�,����,����,���,�a��,����,�ʼ�,�a��,������,������,�����,̽�H��','Annual Leave,Private Leave,Sick Leave,Injury for Job,Matrimony Leave,Maternity Leave,Trip,Funeral Leave,Compensatory Leave,Legal Holiday,Other Leave,Lactation Leave,Family Visit Leave', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'AttTodayDetail_Leave_Type');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Name','����','����','Name', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Name');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_First_Brush','��һ��ˢ��ʱ��','��һ��ˢ���r�g','Brush card first time', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_First_Brush');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Gender','�Ա�','�Ԅe','Gender', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Gender');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Number','���','��̖','Serial No.', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Number');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Card','����','��̖','Card No.', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Card');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Duty','ְ��','��','Duty', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Duty');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Join_Date','��ְ����','������','Joining Date', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Join_Date');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Leave_Categ','�ٱ�','�لe','Leave Category', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Leave_Categ');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_NoData','��������ʾ','�]��ӛ�','No records to view', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_NoData');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Io','��,��','�M,��','In,Out', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Io');
	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Report','','R_P_Not_Supp_CSV','��֧��CSV��ʽ','��֧��CSV��ʽ','Do not support the CSV format', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Report' AND LabelId = 'R_P_Not_Supp_CSV');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'AttendMonthTotal', '�·ݳ��ڱ���', '�·ݳ��ڈ��', 'Month', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'AttendMonthTotal');

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', NULL, 'AttendMonthTotalTitle', N'����,���°�,01$��,02$��,03$��,04$��,05$��,06$��,07$һ,08$��,09$��,10$��,11$��,12$��,13$��,14$һ,15$��,16$��,17$��,18$��,19$��,20$��,21$һ,22$��,23$��,24$��,25$��,26$��,27$��,28$һ,29$��,30$��,31$��,��������,Ӧ������', N'����,���°�,01$��,02$��,03$��,04$��,05$��,06$��,07$Ҽ,08$��,09$��,10$��,11$��,12$��,13$��,14$Ҽ,15$��,16$��,17$��,18$��,19$��,20$��,21$Ҽ,22$��,23$��,24$��,25$��,26$��,27$��,28$Ҽ,29$��,30$��,31$��,�����씵,�����씵', 'Name,OnDuty,01$Tue,02$Wed,03$Thu,04$Fri,05$Sat,06$Sun,07\n\Mon,08$Tue,09$Wed,10$Thu,11$Fri,12$Sat,13$Sun,14\n\Mon,15$Tue,16$Wed,17$Thu,18$Fri,19$Sat,20$Sun,21\n\Mon,22$Tue,23$Wed,24$Thu,25$Fri,26$Sat,27$Sun,28\n\Mon,29$Tue,30$Wed,31$Thu,Attendance Days,Actual Attendance Days', NULL 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'AttendMonthTotalTitle');

--delete from labeltext where labelid = 'R_P_Not_Supp_CSV'
GO


--�޸�Options.VariableValue�ֶγ���
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'Options') AND XType = N'U')
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'Options') AND name = N'VariableValue')
	ALTER TABLE Options ALTER COLUMN VariableValue NVARCHAR(MAX) NULL

--���������������
INSERT INTO [dbo].[Options]([VariableName],[VariableDesc],[VariableType],[VariableValue]) 
SELECT 'strWorkflowApproval', N'����������������������������', 'str', '0,0,,0'
	WHERE NOT EXISTS(SELECT 1 FROM Options WHERE VariableName = 'strWorkflowApproval')

INSERT INTO [dbo].[Options]([VariableName],[VariableDesc],[VariableType],[VariableValue]) 
SELECT 'strAnnalDeptEmps', N'���������ÿ������Ա��', 'str', '0 - All'
	WHERE NOT EXISTS(SELECT 1 FROM Options WHERE VariableName = 'strAnnalDeptEmps')

INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Tool', 'Options', 'Options', 'ѡ��', '�x�', 'Options', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Tool' AND LabelId = 'Options');
		
GO


USE [CerbDb]
GO
/****** Object:  StoredProcedure [dbo].[pAttendTotal]    Script Date: 2017/8/13 11:04:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Procedure [dbo].[pAttendTotal](@StartDate datetime,@EndDate datetime,@strmonth nvarchar(7),@strTotalType varchar(1),@blnDimission bit)
As
--@strTotalType ȡֵΪ1��ʾ�ֶ�ͳ�ƣ�ȡֵ2Ϊ�Զ�ͳ�ƣ�ȡֵ3Ϊͳ�Ƶ���
--@blnDimission=1�Ƿ��ͳ�Ʊ�����ְԱ����

--ͳ��ʱ���ɵ��������룡
--ÿ��ͳ�ƶ���ͳ�����е�Ա����
/*
declare @startdate datetime,@enddate datetime,@strmonth nvarchar(10),@strtotaltype varchar(1),@blndimission bit
set @Startdate='2015-04-01'
set @Enddate='2015-04-12'
set @strmonth='2015-04'
select @strtotaltype='1',@blndimission=0
*/
SET NoCount On
SET DateFirst 7

Declare @Tempdate datetime
Declare @RecordNum int

Declare @Day varchar(2),@month varchar(2),@year varchar(4)
Declare @maxday int

Declare @Sdate datetime
Declare	@Edate Datetime
Declare @totalcycle nvarchar(50)
Declare @sum int
Declare @TotalYear varchar(20)
Declare @Tempmonth varchar(20)
Declare @blnAnalyseWorkDay bit
Declare @strOnduty varchar(10)
Declare @blnOnduty bit
Declare @blnOffduty bit

select @stronduty=variablevalue from options where variablename='strOnduty'
set @stronduty=isnull(@stronduty,'0,0')
set @blnonduty=cast(left(@stronduty,1) as bit)
set @blnOffduty=stuff(@stronduty,1,charindex(',',@stronduty),'')

select @startdate=datename(yy,@startdate)+'-'+datename(mm,@startdate)+'-'+datename(dd,@startdate),@enddate=datename(yy,@enddate)+'-'+datename(mm,@enddate)+'-'+datename(dd,@enddate)

if @strtotaltype='2' or @strtotaltype='3'	--ȡ���Զ�ͳ���뵱��ͳ�Ƶ�@strmonthֵ��
	begin
		select @totalcycle=variablevalue from Options where variablename='StrTotalCycle'
		select @sum=dbo.fsumcharnum(@totalcycle,',')
		if @sum=3
			begin
				if left(@totalcycle,1)='0'
					begin
						set @maxday=day(dateadd(dd,-1,(cast(year(dateadd(mm,1,getdate())) as varchar(4))+'-'+cast(month(dateadd(mm,1,getdate())) as varchar(2))+'-01')))
--print cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) 
						--set @sdate= cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) 
						if cast(substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) as int)>@maxday
							set @sdate=cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+cast(@maxday as varchar(2))
						else
							set @sdate= cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) 

					end
				if left(@totalcycle,1)='1'
					begin
						set @maxday=day(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01')))
						if cast(substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) as int)>@maxday
							set @sdate=cast(year(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(4)) +'-'+cast(month(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(2))+'-'+cast(@maxday as varchar(2))
						else
							set @sdate=cast(year(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(4)) +'-'+cast(month(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,charindex(',',stuff(@totalcycle,1,charindex(',',@totalcycle),''))-1) 
					end				
-- 				print @sdate
-- 				end end
				set @totalcycle=stuff(@totalcycle,1,charindex(',',@totalcycle),'')
				set @totalcycle=stuff(@totalcycle,1,charindex(',',@totalcycle),'')
				if left(@totalcycle,1)='0'
					begin
						set @maxday=day(dateadd(dd,-1,(cast(year(dateadd(mm,1,getdate())) as varchar(4))+'-'+cast(month(dateadd(mm,1,getdate())) as varchar(2))+'-01')))

						if cast(substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,len(@totalcycle)-charindex(',',@totalcycle)) as int)>@maxday
							set @edate=cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+cast(@maxday as varchar(2))
						else
							set @edate= cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,len(@totalcycle)-charindex(',',@totalcycle))
					end
				if left(@totalcycle,1)='1'
					begin
						set @maxday=day(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01')))
						if cast(substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,len(@totalcycle)-charindex(',',@totalcycle)) as int)>@maxday
							set @edate=cast(year(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(4)) +'-'+cast(month(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(2))+'-'+cast(@maxday as varchar(2))
						else
							set @edate=cast(year(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(4)) +'-'+cast(month(dateadd(dd,-1,(cast(year(getdate()) as varchar(4))+'-'+cast(month(getdate()) as varchar(2))+'-01'))) as varchar(2))+'-'+substring(stuff(@totalcycle,1,charindex(',',@totalcycle),''),1,len(@totalcycle)-charindex(',',@totalcycle))
					end				
-- 				print @sdate
-- 				print @edate
-- 				end end 
				if @sdate>@edate
					return

				if cast(convert(char,getdate(),112) as datetime) >cast(convert(char,@edate,112) as datetime)
					begin

						set @strmonth=right('20'+cast(year(dateadd(mm,1,getdate())) as varchar(4)),4)+'-'+right('00'+cast(month(dateadd(mm,1,getdate())) as varchar(2)),2)
						select @sdate=dateadd(mm,1,@sdate),@edate=dateadd(mm,1,@edate)
					end
				else
					begin
						if cast(convert(char,getdate(),112) as datetime) <cast(convert(char,@sdate,112) as datetime)
							begin
								set @strmonth=right('20'+cast(year(dateadd(mm,-1,getdate())) as varchar(4)),4)+'-'+right('00'+cast(month(dateadd(mm,-1,getdate())) as varchar(2)),2)
								select @sdate=dateadd(mm,-1,@sdate),@edate=dateadd(mm,-1,@edate)
							end
						else
							begin
								set @strmonth=right('20'+cast(year(getdate()) as varchar(4)),4)+'-'+right('00'+cast(month(getdate()) as varchar(2)),2)
							end
					end
			end
		else
			return 

		if @strTotalType='2' --�Զ�ͳ��
			begin
				select @startdate=@sdate,@enddate=@edate
				if @enddate>getdate()
					set @enddate=convert(varchar(20),getdate(),120)
			end	
	end


select @startdate=cast( convert(varchar(10),@Startdate,120)as datetime),@EndDate=cast(convert(varchar(10),@EndDate,120) as datetime)--��ʼ��ͳ������
--select @startdate,@enddate
select @blnAnalyseWorkDay=variablevalue from options where variablename='blnAnalyseWorkDay'

IF OBJECT_ID('tempdb..#Tempdatetable') IS NOT NULL DROP TABLE #Tempdatetable
CREATE TABLE #Tempdatetable (Adate DATETIME)
Set @Tempdate=@StartDate
While DateDiff(dd, @TempDate, @EndDate) >= 0
	Begin
		INSERT INTO #Tempdatetable (Adate) values (@Tempdate)
		Set @TempDate=Dateadd(dd,1,@Tempdate)
	End
IF OBJECT_ID('Tempdb..#TbrushempShifts') is not null drop table #TbrushempShifts
Select * into #TbrushempShifts from attendanceshifts where 1=2
exec ('Alter table #TbrushempShifts drop column shiftname')

IF OBJECT_ID('tempdb..#AttendanceDetail') IS NOT NULL DROP TABLE #Attendancedetail
SELECT * INTO #AttendanceDetail FROM AttendanceDetail,#TbrushempShifts WHERE 1=2

--Exec ('ALTER TABLE #AttendanceDetail ADD TemplateId int null, noBrushCard bit,RuleId int,Leave1 int,leave2 int,leave3 int,LateCount int,LeaveEarlyCount int,abnormitycount int,Standardtime int default 0')
Exec ('ALTER TABLE #AttendanceDetail ADD TemplateId int null,RuleId int,LateCount int,LeaveEarlyCount int,abnormitycount int,workTimeholiday int default 0,aottime1 int default 0,aottime2 int default 0,bottime1 int default 0,bottime2 int default 0,cottime1 int default 0,cottime2 int default 0')

Alter Table #attendanceDetail  alter Column Shiftid int null
Alter Table #attendanceDetail  alter Column Degree int null
Alter Table #attendanceDetail  alter Column  Night Bit null
Alter Table #attendanceDetail  alter Column AonDutyStart Datetime null
Alter Table #attendanceDetail  alter Column AoffDuty datetime null
Alter Table #attendanceDetail  alter Column AonDuty datetime null
Drop table #TbrushempShifts

If left(@strTotalType,1)='1' and @blnDimission=1
	Begin
	--20150412 mike Templateid��ֵΪ0
	--INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,Employees.Templateid FROM  Employees,#Tempdatetable a,EmployeeDimission b WHERE Employees.IncumbencyStatus='1' and employees.employeeid=b.employeeid and b.dimissiondate between @startdate and @enddate
		INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,0 FROM  Employees,#Tempdatetable a WHERE Employees.IncumbencyStatus='1' and employees.dimissiondate between @startdate and @enddate
	End
Else
	Begin
	--INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,Employees.Templateid FROM  Employees,#Tempdatetable a
		INSERT INTO #AttendanceDetail (Employeeid,OndutyDate,Templateid) SELECT Employees.Employeeid,a.Adate,0 FROM  Employees,#Tempdatetable a
	End
IF OBJECT_ID('tempdb..#Tempdatetable') IS NOT NULL DROP TABLE #Tempdatetable


--�Զ��Ű�
exec pAutoShifts @Startdate,@EndDate
-- select * from #attendancedetail where nobrushcard=1 and employeeid=2
-- select * from brushcardattend where employeeid=2
--����ˢ��
exec pAnalyseBrushAndSign @startdate,@enddate
--select * from #AttendanceDetail order by EmployeeId,OnDutyDate
--�������
--exec pAnalyseAskforleave @startdate,@enddate

/*
	    '���ʱ������ƣ�
	    'strSkipHoliday���ݸ�ʽΪ����������+�ж�λ��������+�ж�λ��������+�ж�λ��������������
	    
	'    LactationLeave  Holiday     �����
	'    PublicHoliday   Holiday     ������
	'    PeriodLeave Holiday     Ů�Լ�
	'    CompensatoryLeave   Holiday     ����
	'    VisitLeave  Holiday     ̽�׼�
	'    OnTrip  NULL        ����
	'    FuneralLeave    Holiday     ɥ��
	'    PersonalLeave   Holiday     �¼�
	'    MaternityLeave  Holiday     ����
	'    AnnualVacation  Holiday     ���
	'    InjuryLeave Holiday     ����
	'    SickLeave   Holiday     ����
	'    WeddingLeave    Holiday     ���
*/
-- 	    Dim rsAskForLeave
-- 	    Dim rsOptions
Declare @strSkipHoliday nvarchar(4000)

select @strSkipHoliday= case when variablevalue is null or variablevalue='' then '' else variablevalue end  from options where variablename='strSkipHoliday'
Set @strSkipHoliday=isnull(@strSkipHoliday,'')
-- '�������
-- '�������ʱ��StartTime��EndTime��ֻ������û��ʱ��ġ� ������2015-04-01 00:00:00
Update #Attendancedetail Set onduty1=null,offduty1=null,Result1= b.AskForLeaveType ,Result2=b.AskForLeaveType
         From AttendanceAskforLeave b 
         where #Attendancedetail.employeeid=b.employeeid and b.allday=1 and #Attendancedetail.Ondutydate between  b.StartTime  and  EndTime and #Attendancedetail.Degree>=1 and left(b.status,1)='2'  and left(b.nextstep,1)='E' 
-- Onduty1 = OndutyDate+AOnduty ,Offduty1=  OndutyDate+AOffduty 
Update #Attendancedetail Set onduty2=null,offduty2=null,Result3= b.AskForLeaveType ,Result4= b.AskForLeaveType
         From AttendanceAskforLeave b 
         where #Attendancedetail.employeeid=b.employeeid and b.allday=1 and #Attendancedetail.Ondutydate between b.StartTime and EndTime  and #Attendancedetail.Degree>=2 and left(b.status,1)='2'  and left(b.nextstep,1)='E'
Update #Attendancedetail Set onduty3=null,offduty3=null,Result5= b.AskForLeaveType  ,Result6= b.AskForLeaveType
         From AttendanceAskforLeave b 
         where #Attendancedetail.employeeid=b.employeeid and b.allday=1 and #Attendancedetail.Ondutydate between b.StartTime  and  EndTime  and #Attendancedetail.Degree>=3 and left(b.status,1)='2'  and left(b.nextstep,1)='E'


-- '���������
-- '����ٿ��ʱ���ı�׼ʱ�䡣
--select * from #attendancedetail where employeeid=104
Update #Attendancedetail Set Onduty1 =  OndutyDate+AOnduty ,
			signinflag=  stuff(signinflag,1,1,'1') 
             From attendanceaskforleave  b 
             Where b.AllDay<>1 and #Attendancedetail.Degree>=1 and #Attendancedetail.Employeeid=b.Employeeid and 
                      left(b.status,1)='2'  and left(b.nextstep,1)='E' and OndutyDate+AOnduty>=b.StartTime and OndutyDate+AOnduty<=b.EndTime
--select * from #attendancedetail where employeeid=19
-- 
-- Update #Attendancedetail Set Offduty1 =  Convert(char,a.OndutyDate+a.AOffDuty,120),
-- 			signinflag= stuff(signinflag,2,1,'1')
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=1 and a.Employeeid=b.Employeeid and 
--                  a.AOffDuty is Not Null and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.AOffduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.AOffDuty,120)<=b.EndTime
--                 
-- Update #Attendancedetail Set Onduty2 = Convert(char,a.OndutyDate+a.BOnduty,120) ,
-- 			signinflag=  stuff(signinflag,3,1,'1')
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=2 and a.Employeeid=b.Employeeid and 
--                  a.BOnduty is Not Null and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.BOnduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.BOnduty,120)<=b.EndTime
-- Update #Attendancedetail Set OffDuty2 =  Convert(char,a.OndutyDate+a.BOffDuty,120) ,
-- 			signinflag= stuff(signinflag,4,1,'1') 
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=2 and a.Employeeid=b.Employeeid and 
--                  a.BOffDuty is Not Null  and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.BOffDuty,120)=b.StartTime and Convert(char,a.OndutyDate+a.BOffDuty,120)<=b.EndTime 
-- Update #Attendancedetail Set Onduty3 = Convert(char,a.OndutyDate+a.COnduty,120) ,
-- 			signinflag= stuff(signinflag,5,1,'1')
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=3 and a.Employeeid=b.Employeeid and 
--                  a.COnduty is Not Null  and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.COnduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.COnduty,120)<=b.EndTime
-- Update #Attendancedetail Set OffDuty3 =  Convert(char,a.OndutyDate+a.COffDuty,120),
-- 			signinflag= stuff(signinflag,6,1,'1')
--          From #Attendancedetail a,AttendanceAskforleave b 
--          Where b.AllDay<>1 and a.Degree>=3 and a.Employeeid=b.Employeeid and 
--                  a.COffDuty is Not Null and left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.COffDuty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.COffDuty,120)<=b.EndTime

Update #Attendancedetail Set Offduty1 =  Convert(char,a.OndutyDate+a.AOffDuty,120),
			signinflag= stuff(signinflag,2,1,'1')
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=1 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.AOffduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.AOffDuty,120)<=b.EndTime
                
Update #Attendancedetail Set Onduty2 = Convert(char,a.OndutyDate+a.BOnduty,120) ,
			signinflag=  stuff(signinflag,3,1,'1')
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=2 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.BOnduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.BOnduty,120)<=b.EndTime
Update #Attendancedetail Set OffDuty2 =  Convert(char,a.OndutyDate+a.BOffDuty,120) ,
			signinflag= stuff(signinflag,4,1,'1') 
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=2 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.BOffDuty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.BOffDuty,120)<=b.EndTime 
Update #Attendancedetail Set Onduty3 = Convert(char,a.OndutyDate+a.COnduty,120) ,
			signinflag= stuff(signinflag,5,1,'1')
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=3 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.COnduty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.COnduty,120)<=b.EndTime
Update #Attendancedetail Set OffDuty3 =  Convert(char,a.OndutyDate+a.COffDuty,120),
			signinflag= stuff(signinflag,6,1,'1')
         From #Attendancedetail a,AttendanceAskforleave b 
         Where b.AllDay<>1 and a.Degree>=3 and a.Employeeid=b.Employeeid and 
                 left(b.status,1)='2'  and left(b.nextstep,1)='E' and Convert(char,a.OndutyDate+a.COffDuty,120)>=b.StartTime and Convert(char,a.OndutyDate+a.COffDuty,120)<=b.EndTime


--'��������ʱ����٣���������ٵ�ˢ����Ϊ��Ӧ�ļ���
Update #AttendanceDetail Set  onduty1=null,offduty1=null,Result1= b.AskForLeaveType,Result2= b.AskForLeaveType
         From AttendanceAskforleave b 
         Where b.Allday<>1 and #AttendanceDetail.employeeid=b.employeeid and left(b.status,1)='2'  and left(b.nextstep,1)='E' and 
                 #AttendanceDetail.Ondutydate+#AttendanceDetail.AOnduty>=b.StartTime and 
                 #AttendanceDetail.Ondutydate+#AttendanceDetail.AOffDuty<=b.EndTime 
Update #AttendanceDetail Set onduty2=null,offduty2=null,Result3= b.AskForLeaveType ,Result4=b.AskForLeaveType 
         From AttendanceAskForLeave b
         Where b.Allday<>1 and #Attendancedetail.employeeid=b.employeeid and left(b.status,1)='2'  and left(b.nextstep,1)='E' and 
                #Attendancedetail.Ondutydate+#Attendancedetail.BOnduty>=b.StartTime and 
                #Attendancedetail.Ondutydate+#Attendancedetail.BOffduty<=b.EndTime 
    
Update #AttendanceDetail Set onduty3=null,offduty3=null,Result5=b.AskForLeaveType ,Result6=b.AskForLeaveType 
         From AttendanceAskForLeave b
         Where b.Allday<>1 and #Attendancedetail.employeeid=b.employeeid and left(b.status,1)='2'  and left(b.nextstep,1)='E' and
                 #Attendancedetail.Ondutydate+#Attendancedetail.COnduty>=b.StartTime and 
                 #Attendancedetail.Ondutydate+#Attendancedetail.COffduty<=b.EndTime 


-- '��ʱ�Ӱ������
-- Dim AheadOnDuty
-- Dim delayOffDuty
-- Dim AllTime
-- Dim BaseNumber
-- Dim i
Declare @NowDate datetime
Declare @SmallDate datetime,
	@LargeDate datetime

-- '�����Ӱദ��
-- 
-- '������Ӱࡣ����0-��Ϣ�Ӱ�
-- 'ȡˢ������Ϊ��ʼ�����ʱ��ǰ��30���ӵ���ʼ�����ʱ���м�㡣
-- '�����Ӱ࣬��Ϊ��ʼʱ�����ڵ�����ļӰ�ʱ�䡣

IF OBJECT_ID('tempdb..#t') IS NOT NULL DROP TABLE #t
CREATE TABLE #t(EmployeeID INT,BrushTime DATETIME)

--'�üӰ�����һ��������Ӱ���ʱ�������ϰ�ˢ�����°�ˢ�����Ӱ�ʱ�����ֶΡ�
IF OBJECT_ID('tempdb..#OverTime') IS NOT NULL DROP TABLE #OverTime

--Select employeeid, starttime,endtime into #OverTime from AttendanceOT Where allday =0 and left(status,1)='2' and left(nextstep,1)='E' and Endtime between @Startdate and dateadd(dd,1,@Enddate)

--Exec ('alter table #OverTime add StartBrush datetime,EndBrush datetime,OtTime int default 0')

CREATE TABLE #overtime (Employeeid int,Starttime datetime,endtime datetime,StartBrush datetime null,EndBrush datetime null,OtTime int default 0)
insert into #overtime (employeeid ,starttime,endtime) select employeeid ,starttime,endtime from attendanceot  Where allday =0 and left(status,1)='2' and left(nextstep,1)='E' and Endtime between @Startdate and dateadd(dd,1,@Enddate)
insert into #overtime (employeeid ,starttime,endtime) select a.employeeid,b.ondutydate,dateadd(mi,-1,(dateadd(dd,1,b.ondutydate))) from attendanceot a ,#attendancedetail b where a.allday=1 and a.employeeid=b.employeeid and b.ondutydate between a.starttime and a.endtime and left(b.ondutytype,1)='1' and left(nextstep,1)='E'
--select * from #overtime where employeeid=103
--select * from brushcardattend where employeeid=15 or employeeid=17
-- insert into brushcardattend (controllernumber,card,employeeid,brushtime)
-- 	values (1,0,15,'2015-04-10 18:00:00')
Set @NowDate=@StartDate
While @NowDate<=@EndDate
	Begin
		--'��ҹ���ȡֵ��ǰ����͢��һ�졣
		Select @SmallDate=Dateadd(ss,-86399,@NowDate),@LargeDate=Dateadd(ss,86399,@NowDate)
		--'�Ӱ�ˢ��
		IF OBJECT_ID('tempdb..#BrushCardAttend') IS NOT NULL DROP TABLE #BrushCardAttend
		SELECT EmployeeID,BrushTime INTO #BrushCardAttend 
			FROM BrushcardAttend WHERE  EmployeeID IN(SELECT DISTINCT EmployeeID FROM #OverTime) AND BrushTime BETWEEN @SmallDate AND @LargeDate
		CREATE CLUSTERED INDEX BrushTime_ind ON #BrushCardAttend(EmployeeID,BrushTime)
		if @blnonduty=0
			insert into #brushcardattend (employeeid,brushtime)
				select employeeid,starttime from attendanceot 
				where allday=0 and left(status,1)='2' and left(nextstep,1)='E' and starttime between  @SmallDate AND @LargeDate 
		if @blnoffduty=0
			insert into #brushcardattend (employeeid,brushtime)
				select employeeid,endtime from attendanceot 
				where allday=0 and left(status,1)='2' and left(nextstep,1)='E' and endtime between  @SmallDate AND @LargeDate 

		INSERT INTO #t
		         SELECT b.EmployeeID,MIN(BrushTime) AS BrushTime
		         FROM #OverTime a,#BrushCardAttend b
		         WHERE  a.EmployeeID=b.EmployeeID And DATEDIFF(d,a.StartTime,@NowDate)=0  
		         AND (b.BrushTime BETWEEN Dateadd(mi,-30,a.Starttime)  AND dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime))
		         GROUP BY b.EmployeeID,a.starttime
		
		UPDATE #OverTime SET StartBrush = b.BrushTime
		         FROM  #t b
		         WHERE DATEDIFF(d,#OverTime.StartTime,@NowDate)=0  
		         AND #OverTime.EmployeeID=b.EmployeeID
		         AND b.BrushTime BETWEEN Dateadd(mi,-30,#OverTime.Starttime)  AND dateadd(mi,datediff(mi,#OverTime.Starttime,#OverTime.Endtime)/2,#OverTime.starttime)
		TRUNCATE TABLE #t

		INSERT INTO #t 
		         SELECT b.EmployeeId,Max(Brushtime) as Brushtime
		         FROM #Overtime a,#BrushCardAttend b
		         WHERE a.Employeeid=b.employeeid and DateDiff(d,a.StartTime,@NowDate)=0 
		         And b.BrushTime Between dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime) and dateadd(mi,30,a.Endtime)
		         Group By b.employeeid,a.starttime
		UpDate #OverTime Set EndBrush =b.Brushtime
		         From #OverTime a,#t b
		         WHERE DATEDIFF(d,a.StartTime,@NowDate)=0  
		         AND a.EmployeeID=b.EmployeeID
		         And b.BrushTime Between dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime) and dateadd(mi,30,a.Endtime)
		TRUNCATE TABLE #t
		TRUNCATE TABLE #BrushCardAttend
		
		--'�Ӱಹ��
		IF OBJECT_ID('tempdb..#SigninCard') IS NOT NULL DROP TABLE #SigninCard
		SELECT EmployeeID,BrushTime INTO #SigninCard FROM AttendanceSignin WHERE EmployeeID IN(SELECT DISTINCT EmployeeID FROM #OverTime) AND left(status,1)='2' and left(nextstep,1)='E'  AND BrushTime BETWEEN @SmallDate AND @LargeDate
		 CREATE CLUSTERED INDEX BrushTime_ind ON #SigninCard(EmployeeID,BrushTime)
		                  			
		INSERT INTO #t
		         SELECT b.Employeeid,Min(Brushtime) as BrushTime
		         FROM #OverTime a,#SigninCard b
		         WHERE a.employeeid=b.employeeid and datediff(d,a.StartTime,@NowDate)=0 
		         AND b.BrushTime BETWEEN Dateadd(mi,-30,a.Starttime)  AND dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime)
		         GROUP BY b.employeeid,a.starttime
		UPDATE #OverTime SET StartBrush = b.BrushTime
		         FROM #OverTime a,#t b
		         WHERE DATEDIFF(d,a.StartTime,@NowDate)=0  
		         AND a.EmployeeID=b.EmployeeID
		         AND b.BrushTime BETWEEN Dateadd(mi,-30,a.Starttime)  AND dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime)
		TRUNCATE TABLE #t
--		select * from #t where employeeid=103
		INSERT INTO #t 
		         SELECT b.EmployeeId,Max(Brushtime) as Brushtime
		         FROM #Overtime a,#SigninCard b
		         WHERE a.Employeeid=b.employeeid and DateDiff(d,a.StartTime,@NowDate)=0 
		         And b.BrushTime Between dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime) and dateadd(mi,30,a.Endtime)
		         Group By b.employeeid,a.starttime
		UpDate #OverTime Set EndBrush =b.Brushtime
		         From #OverTime a,#t b
		         WHERE DATEDIFF(d,a.StartTime,@NowDate)=0  
		         AND a.EmployeeID=b.EmployeeID
		         And b.BrushTime Between dateadd(mi,datediff(mi,a.Starttime,a.Endtime)/2,a.starttime) and dateadd(mi,30,a.Endtime)
		TRUNCATE TABLE #t
		TRUNCATE TABLE #SigninCard
		Set @NowDate=Dateadd(dd,1,@NowDate)
	End


Update #OverTime set StartBrush= case when startbrush<=StartTime then starttime else startbrush end where StartBrush is not null
Update #OverTime Set EndBrush=case When endbrush>=endtime then endtime else endbrush end where endbrush is not null
Update #OverTime Set OtTime=datediff(mi,startbrush,endbrush) where startbrush is not null and endbrush is not null

--�޸����ݣ�1���ڼ��գ���Ϣ���ϰ࣬�����ڼӰദ���롣
--	   2����Ϣ�գ��ڼ��յļӰ࣬��attendancetotal�������֣��һ���Ϊworktime_1,worktime_2���Է���,��attendancedetail �л�����worktime
--         3����Ϣ�գ��ڼ�������ļӰ಻��Ҫ�򿨣�������ټ���Ϊ���١�
--	   4�����ٴ���Ӧ���ݼ١�
--	   5�����ܱ��У���������Ϣ�ճٵ�����ʱ�䣬�ٵ������쳣���������ڣ���ʱ�Ӱࡣ
Update #Attendancedetail set ottime=b.ottime
                 From (select employeeid,convert(char,starttime,110) as starttime,sum(ottime) as ottime from #OverTime b group by employeeid,convert(char,starttime,110)) b where b.employeeid=#attendancedetail.employeeid and datediff(dd,#attendancedetail.ondutydate,b.starttime)=0 and left(#attendancedetail.ondutytype,1)='0'

-- update #overtime set ottime=datediff(mi,starttime,endtime) from #attendancedetail a 
-- 	where a.employeeid=#overtime.employeeid and (left(a.ondutytype,1)='1' or left(a.ondutytype,1)='2') and datediff(dd,a.ondutydate,#overtime.starttime)=0
Update #Attendancedetail set worktimeholiday=c.ottime
                 From (select employeeid,convert(char,starttime,110) as starttime,sum(ottime) as ottime from #OverTime b group by employeeid,convert(char,starttime,110)) c where c.employeeid=#attendancedetail.employeeid and datediff(dd,#attendancedetail.ondutydate,c.starttime)=0 and (left(#attendancedetail.ondutytype,1)='1' or left(#attendancedetail.ondutytype,1)='2')

-- '����Ӱ�ļ�����ڼ�����ں�������
-- '���ռӰ�������У�������'1-��Ϣ'�Ĺ����գ����Զ�Ϊ�ϲ���ҹ�ĵ��԰��:�ӵ��գ�00��00��01��23:29:59ֹ��
-- '��ʱ�Ӱദ��!
-- '��ʱ��Ӱ࣬����Ե�һ��ʱ����ϰ࣬�����һ����
Declare @strLate varchar(100)
Declare @blnLate bit                --'����ٵ�������ʱ�䣿
Declare @intLate int                --'�ٵ���Χ
Declare @strLeaveEarly varchar(100)
Declare @blnLeaveEarly int           --'�������˰�����ʱ�䣿
Declare @intLeaveEarly int           --'���˷�Χ

Declare @strAbnormity varchar(100)			--'�쳣�Ƿ�ǿ���,1��ʾ��Ϊ����,0��ʾ����
--Declare @strSkipHoliday nvarchar(4000)


Declare @strOverTime varchar(100)
Declare @blnBefor bit                --'��ǰ�ƼӰ��
Declare @blnAfter bit                --'�Ӻ�ƼӰ��
Declare @blnFull bit                 --'��ǰ���Ӻ�����ʱ��ƼӰ�
Declare @intBase int                 --'�Ӱ�ʱ�����


Select @strLate=variablevalue from options where variablename='strlate'
If len(@strlate)>=3
	select @intlate=cast(substring(@strLate,1,patindex('%,%',@strlate)-1) as int),@blnlate=cast(substring(@strlate,patindex('%,%',@strlate)+1,1) as bit)


Select @intlate=isnull(@intlate,0),@blnlate=isnull(@blnlate,0)

Select @strLeaveEarly=variablevalue from options where variablename='strleaveearly'
If len(@strleaveEarly)>3
	select @intLeaveEarly=cast(substring(@strleaveEarly,1, patindex('%,%',@strleaveEarly)-1) as int),@blnLeaveEarly=cast(substring(@strleaveEarly,patindex('%,%',@strleaveEarly)+1,1) as bit)
Select @intLeaveEarly=isnull(@intLeaveEarly,0),@blnLeaveEarly=isnull(@blnLeaveEarly,0)

Select @strAbnormity=variablevalue from options where variablename='strAbnormity'
Set @strAbnormity=isnull(@strAbnormity,'0')
	
select @strSkipHoliday= case when variablevalue is null or variablevalue='' then '' else variablevalue end  from options where variablename='strSkipHoliday'
Set @strSkipHoliday=isnull(@strSkipHoliday,'')

select @strOverTime=variablevalue from options where variablename='strOTType'
if len(@strOverTime)>=9
	Begin
		select @blnBefor=cast(substring(@strOvertime,1,charindex(',',@strovertime,1)-1) as bit)
		set @strovertime=stuff(@strovertime,1,charindex(',',@strovertime,1),'')
		select @blnafter=cast(substring(@strOvertime,1,charindex(',',@strovertime,1)-1) as bit)
		set @strovertime=stuff(@strovertime,1,charindex(',',@strovertime,1),'')
		select @blnfull=cast(substring(@strOvertime,1,charindex(',',@strovertime,1)-1) as bit)
		set @strovertime=stuff(@strovertime,1,charindex(',',@strovertime,1),'')
		set @intbase =cast(substring(@strOvertime,1,charindex(',',@strovertime,1)-1) as int)

	end
Select @blnBefor=isnull(@blnBefor,0),@blnafter=isnull(@blnafter,0),@blnfull=isnull(@blnfull,0),@intbase=isnull(@intbase,0)

--'����ǵ��԰���еĳٵ�����.
--20150412  by mike 
	
Update #Attendancedetail 
                 set LateTime1= Case when @blnLate  =1 then datediff(mi,ondutydate+Aonduty,onduty1)
                                 Else Datediff(mi,dateadd(mi,AcalculateLate ,Ondutydate+Aonduty),onduty1) end 
                 Where stretchshift=0 and noBrushcard <> 1 and degree >=1 and datediff(mi,dateadd(mi,AcalculateLate ,ondutydate+aonduty),onduty1)>0 
Update #AttendanceDetail 
                Set LateTime2= Case When @blnLate  =1 then Datediff(mi,Ondutydate+Bonduty,Onduty2)
                                 Else Datediff(mi,dateadd(mi,BcalculateLate ,Ondutydate+Bonduty),Onduty2) end 
                 Where Stretchshift=0 and noBrushcard <> 1  and degree >=2 and datediff(mi,dateadd(mi,BcalculateLate ,ondutydate+Bonduty),onduty2)>0
Update #AttendanceDetail 
                Set LateTime3= Case When @blnLate =1 then Datediff(mi,Ondutydate+Conduty,Onduty3)
                                 Else Datediff(mi,dateadd(mi,CcalculateLate ,Ondutydate+Conduty),Onduty3) end 
                 Where Stretchshift=0 and noBrushcard <> 1  and degree >=3 and datediff(mi,dateadd(mi,CcalculateLate ,ondutydate+Conduty),onduty3)>0

Update #Attendancedetail 
                Set LeaveEarlyTime1 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty1,Ondutydate+AOffduty) 
                                 Else Datediff(mi,Offduty1,Dateadd(mi,0-AcalculateEarly ,Ondutydate+AOffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=1 and datediff(mi,Offduty1,dateadd(mi,0-AcalculateEarly ,ondutydate+AOffduty))>0

Update #Attendancedetail 
                Set LeaveEarlyTime2 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty2,Ondutydate+BOffduty) 
                                 Else Datediff(mi,Offduty2,Dateadd(mi,0-BcalculateEarly ,Ondutydate+BOffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=2 and datediff(mi,Offduty2,dateadd(mi,0-BcalculateEarly ,ondutydate+BOffduty))>0
Update #Attendancedetail 
                Set LeaveEarlyTime3 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty3,Ondutydate+COffduty) 
                                 Else Datediff(mi,Offduty3,Dateadd(mi,0-CcalculateEarly ,Ondutydate+COffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=3 and datediff(mi,Offduty3,dateadd(mi,0-CcalculateEarly ,ondutydate+COffduty))>0
						
-------------------------------------------------
/*
Update #Attendancedetail 
                 set LateTime1= Case when @blnLate  =1 then datediff(mi,ondutydate+Aonduty,onduty1)
                                 Else Datediff(mi,dateadd(mi,@intLate ,Ondutydate+Aonduty),onduty1) end 
                 Where stretchshift=0 and noBrushcard <> 1 and degree >=1 and datediff(mi,dateadd(mi,@intLate ,ondutydate+aonduty),onduty1)>0 
Update #AttendanceDetail 
                Set LateTime2= Case When @blnLate  =1 then Datediff(mi,Ondutydate+Bonduty,Onduty2)
                                 Else Datediff(mi,dateadd(mi,@intLate ,Ondutydate+Bonduty),Onduty2) end 
                 Where Stretchshift=0 and noBrushcard <> 1  and degree >=2 and datediff(mi,dateadd(mi,@intLate ,ondutydate+Bonduty),onduty2)>0
Update #AttendanceDetail 
                Set LateTime3= Case When @blnLate =1 then Datediff(mi,Ondutydate+Conduty,Onduty3)
                                 Else Datediff(mi,dateadd(mi,@intLate ,Ondutydate+Conduty),Onduty3) end 
                 Where Stretchshift=0 and noBrushcard <> 1  and degree >=3 and datediff(mi,dateadd(mi,@intLate ,ondutydate+Conduty),onduty3)>0

Update #Attendancedetail 
                Set LeaveEarlyTime1 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty1,Ondutydate+AOffduty) 
                                 Else Datediff(mi,Offduty1,Dateadd(mi,-@intLeaveEarly ,Ondutydate+AOffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=1 and datediff(mi,Offduty1,dateadd(mi,-@intLeaveEarly ,ondutydate+AOffduty))>0

Update #Attendancedetail 
                Set LeaveEarlyTime2 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty2,Ondutydate+BOffduty) 
                                 Else Datediff(mi,Offduty2,Dateadd(mi,-@intLeaveEarly ,Ondutydate+BOffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=2 and datediff(mi,Offduty2,dateadd(mi,-@intLeaveEarly ,ondutydate+BOffduty))>0
Update #Attendancedetail 
                Set LeaveEarlyTime3 = Case When @blnLeaveEarly =1 Then Datediff(mi,Offduty3,Ondutydate+COffduty) 
                                 Else Datediff(mi,Offduty3,Dateadd(mi,-@intLeaveEarly ,Ondutydate+COffduty)) End 
                Where Stretchshift=0 and noBrushcard <> 1  and Degree>=3 and datediff(mi,Offduty3,dateadd(mi,-@intLeaveEarly ,ondutydate+COffduty))>0
*/
/*	
'    strOTType   ��ʱ�Ӱ�    �磺1,1,1,0,30  ��ʾ��ǰ����ʱ��������Ӱ࣬�Ӱ෽ʽΪ������ǰ���Ӻ�����й�ʱ��Ϊ�Ӱ�
'    ��ʱ�Ӱ๦�ܣ����Ը��ݳ�ʱ�Ӱ���趨����"��ʼˢ������׼"��"��׼���ؿ�ˢ��"֮����ϰ�ʱ���Ϊ�Ӱ�ʱ��
*/
--**********
UPdate #Attendancedetail set overtime=case when overtime is null then 0 else overtime end 
Update #Attendancedetail Set aOttime1= 
         Case When @blnBefor  =1 and @blnFull =1 then datediff(mi,onduty1,ondutydate+Aonduty)-overtime
              When @blnBefor  =1 and @blnFull =0 Then (datediff(mi,onduty1,ondutydate+Aonduty)-overtime)/@intBase *@intBase 
              Else aottime1 end 
         Where Stretchshift=0 and degree>=1 and datediff(mi,onduty1,ondutydate+Aonduty)>0

Update #Attendancedetail Set bOttime1= 
         Case When @blnBefor  =1 and @blnFull =1 then datediff(mi,onduty2,ondutydate+Bonduty) -overtime
              When @blnBefor  =1 and @blnFull =0 Then (datediff(mi,onduty2,ondutydate+Bonduty)-overtime)/@intBase *@intBase 
              Else bottime1 end 
         Where Stretchshift=0 and degree>=2 and datediff(mi,onduty2,ondutydate+Bonduty)>0
Update #Attendancedetail Set cOttime1= 
         Case When @blnBefor  =1 and @blnFull =1 then datediff(mi,onduty3,ondutydate+Conduty) -overtime
              When @blnBefor  =1 and @blnFull =0 Then (datediff(mi,onduty3,ondutydate+Conduty)-overtime)/@intBase*@intBase 
              Else cottime1 end 
         Where Stretchshift=0 and degree>=3 and datediff(mi,onduty3,ondutydate+Conduty)>0
        
Update #Attendancedetail Set aOttime2= 
         Case When @blnAfter  =1 and @blnFull =1 then datediff(mi,ondutydate+AOffduty,Offduty1) -overtime
              When @blnAfter  =1 and @blnFull =0 Then (datediff(mi,ondutydate+AOffduty,Offduty1)-overtime)/@intBase *@intBase 
              Else aottime2 end 
         Where Stretchshift=0 and degree>=1 and datediff(mi,ondutydate+AOffduty,Offduty1)>0
Update #Attendancedetail Set bOttime2= 
         Case When @blnAfter  =1 and @blnFull =1 then datediff(mi,ondutydate+BOffduty,Offduty2) -overtime
              When @blnAfter  =1 and @blnFull =0 Then (datediff(mi,ondutydate+BOffduty,Offduty2)-overtime)/@intBase*@intBase 
              Else bottime2 end 
         Where Stretchshift=0 and degree>=2 and datediff(mi,ondutydate+BOffduty,Offduty2)>0
Update #Attendancedetail Set cOttime2= 
         Case When @blnAfter  =1 and @blnFull =1 then datediff(mi,ondutydate+COffduty,Offduty3) -overtime
              When @blnAfter  =1 and @blnFull =0 Then (datediff(mi,ondutydate+COffduty,Offduty3)-overtime)/@intBase *@intBase 
              Else cottime2 end 
         Where Stretchshift=0 and degree>=3 and datediff(mi,ondutydate+COffduty,Offduty3)>0
Update #Attendancedetail set aottime1 =case when aottime1<0 then 0 else aottime1 end,
							bottime1=case when bottime1<0 then 0 else bottime1 end ,
							cottime1=case when cottime1<0 then 0 else cottime1 end,
							aottime2=case when aottime2<0 then 0 else aottime2 end ,
							bottime2=case when bottime2<0 then 0 else bottime2 end,
							cottime2=case when cottime2<0 then 0 else cottime2 end 
							
--������ʱ�Ӱ�������Ӱ�֮�����޳�ͻ(����ʱ�Ӱ��ˢ���Ƿ������Ӱ࣬����ǳ�ͻ��)�г�ͻ�����������Ϊ׼���������߶��㡣

UpDate #Attendancedetail set aottime1=0 
	from attendanceot a
	where #attendancedetail.employeeid=a.employeeid and ((onduty1>=a.starttime and onduty1<=a.endtime) or (onduty1<a.starttime and a.starttime<=Aonduty+ondutydate))

UpDate #Attendancedetail set bottime1=0 
	from attendanceot a
	where #attendancedetail.employeeid=a.employeeid and ((onduty2>=a.starttime and onduty2<=a.endtime) or (onduty2<a.starttime and a.starttime<=Bonduty+ondutydate))

UpDate #Attendancedetail set Cottime1=0 
	from attendanceot a
	where #attendancedetail.employeeid=a.employeeid and ((onduty3>=a.starttime and onduty3<=a.endtime) or (onduty3<a.starttime and a.starttime<=Conduty+ondutydate))

Update #attendancedetail set aottime2=0
	from attendanceot a
	where #attendancedetail.employeeid =a.employeeid and ((offduty1>=a.starttime and offduty1<=a.endtime) or (offduty1>a.endtime and a.starttime>=Aoffduty+ondutydate))

Update #attendancedetail set bottime2=0
	from attendanceot a
	where #attendancedetail.employeeid =a.employeeid and ((offduty2>=a.starttime and offduty2<=a.endtime) or (offduty2>a.endtime and a.starttime>=boffduty+ondutydate))
Update #attendancedetail set cottime2=0
	from attendanceot a
	where #attendancedetail.employeeid =a.employeeid and ((offduty3>=a.starttime and offduty3<=a.endtime) or (offduty3>a.endtime and a.starttime>=coffduty+ondutydate))

update #attendancedetail set ottime=isnull(ottime,0)+aottime1+aottime2+bottime1+bottime2+cottime1+cottime2
update #attendancedetail set worktime=worktimeholiday where (worktime is null or worktime=0)and left(ondutytype,1) in ('1','2')
--select * from #attendancedetail where employeeid=103
--lect * from brushcardattend

--**********
--   '��������ڼ�����ʱ��
--'�������,���Ϊ1�����������㣩
--'�������ʱ��StartTime��EndTime��ֻ������û��ʱ��ġ� ������2015-04-01 00:00:00

Declare @Fieldname varchar(100),
	@AskforleaveName nvarchar(200)
Declare @intworktime numeric(18,2)
select @intworktime=isnull(variablevalue,8) from options where variablename='intworktime'
set @intworktime=isnull(@intworktime,8)

--���㹤ʱ����׼ʱ������׼ʱ��-���ʱ��-�ٵ�ʱ��-����ʱ��
--�޸�����: ��ʱ�ļ��㣬ԭ��һʱ�������������͵����ʱ����ʱ����ȥ������һ�����͵�ʱ�䡣
--	    ����ʱ�ļ����еļ��ٵ������м���Ϣ���ᵽ��ٴ����������δ�������������ٴ�������ڣ���ʲô��ټ���ʲô��١�
Update #Attendancedetail Set workTime1= datediff(mi,Ondutydate+AOnduty,Ondutydate+AOffduty)-Isnull(Latetime1,0)-Isnull(LeaveearlyTime1,0)-isnull(ArestTime,0) 
             Where degree>=1 and Onduty1 is not null and Offduty1 is not null 
            
Update #Attendancedetail Set WorkTime2=  Datediff(mi,Ondutydate+Bonduty,Ondutydate+BOffduty)-IsNull(LateTime2,0)-IsNull(LeaveEarlytime2,0) -isnull(brestTime,0) 
             Where Degree>=2 and Onduty2 is Not null and OffDuty2 is Not null 
            
Update #Attendancedetail Set WorkTime3= Datediff(mi,Ondutydate+cOnduty,Ondutydate+COffduty)-Isnull(LateTime3,0)-Isnull(LeaveEarlytime3,0)-isnull(crestTime,0)  
             Where Degree>=3 and Onduty3 is not null and offduty3 is not null 

--�⿨ʱ�����밴��εı�׼ʱ����㹤ʱ
update #attendancedetail set worktime1=datediff(mi,(ondutydate+aonduty),(ondutydate+aoffduty))-isnull(Aresttime,0) where nobrushcard=1 and degree>=1 
update #attendancedetail set worktime2=datediff(mi,(ondutydate+bonduty),(ondutydate+boffduty))-isnull(Bresttime,0) where nobrushcard=1 and degree>=2
update #attendancedetail set worktime3=datediff(mi,(ondutydate+conduty),(ondutydate+coffduty))-isnull(Cresttime,0) where nobrushcard=1 and degree>=3 

Declare AskForleave cursor
	for select fieldname,fielddesc from tablestructure where (fieldname='OnTrip' or fieldproperty1='Holiday') and tableid in (select tableid from tables where tablename='attendancedetail')
Open Askforleave
Fetch Askforleave into @Fieldname,@AskforleaveName
while @@fetch_status=0
	begin
		Exec ('Update #Attendancedetail Set '+@Fieldname+ '=1 ,worktime1=null,worktime2=null,worktime3=null
				From AttendanceAskforLeave b ,#Attendancedetail a 
				where a.employeeid=b.employeeid and b.allday=1 and b.AskForLeaveType='''+@AskforleaveName+''' and 
					a.Ondutydate between b.StartTime  and  b.EndTime  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
 
	--         '���������.
	--         '������٣�������������Ϣ�����ʱ��Ӧ��ȥ��Ϣ�������β�����Ϣʱ�䡣
	-- '������ע�⣬����������ڼ����ϰ�ʱ��ʱҪ��ȥ��

	--	�޸����ݣ�����ʱ������ͬһʱ����������٣�ֻ�ܼ��������һ�����ʱ�������
		if object_id('tempdb..#askforleave') is not null drop table #askforleave
		create table #askforleave (employeeid int,ondutydate datetime,leave1 int default 0,leave2 int default 0,leave3 int default 0)
--		�ֲ�sql��䣬���Ч��
-- 	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1,leave2,leave3) select #attendancedetail.employeeid,ondutydate, 
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+AOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,AOnduty,AOffDuty)-isnull(ArestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,OndutyDate+Aonduty,b.EndTime) 
-- 	                              When b.StartTime>Cast(conVert(char,Ondutydate+Aonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+AOffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime>Cast(ConVert(char,Ondutydate+AonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)  and b.StartTime< Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+AOffduty) End ,
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+BOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,BOnduty,BOffDuty)-isnull(BrestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime)
-- 	                                     Then Datediff(mi,OndutyDate+Bonduty,b.EndTime) 
-- 	                              When b.StartTime>Cast(conVert(char,Ondutydate+Bonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+BOffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime>Cast(ConVert(char,Ondutydate+BonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+BOffduty) End ,
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+COnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,COnduty,COffDuty)-isnull(CrestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime)
-- 	                                     Then Datediff(mi,OndutyDate+Conduty,b.EndTime) 
-- 	                              When b.StartTime > Cast(conVert(char,Ondutydate+Conduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+COffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime > Cast(ConVert(char,Ondutydate+ConDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+COffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+COffduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+COffduty) End 
-- 	                     From AttendanceAskforleave b,#Attendancedetail
-- 	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+'''  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')


	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1) 
				select #attendancedetail.employeeid,ondutydate,datediff(mi,AOnduty,AOffDuty)-isnull(ArestTime,0) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=1 and  b.Starttime<=Cast(ConVert(char,OndutyDate+AOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime)  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,OndutyDate+Aonduty,b.EndTime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=1 and b.Starttime<=Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,b.endtime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=1 and b.StartTime>Cast(conVert(char,Ondutydate+Aonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+AOffduty,120) as DAtetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave1) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,Ondutydate+AOffduty)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=1 and b.Starttime>Cast(ConVert(char,Ondutydate+AonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)  and b.StartTime< Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
		--*
	        Exec ('insert into #askforleave (employeeid,ondutydate,leave2) 
				select #attendancedetail.employeeid,ondutydate,datediff(mi,BOnduty,BOffDuty)-isnull(BrestTime,0)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=2 and b.Starttime<=Cast(ConVert(char,OndutyDate+BOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave2) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,OndutyDate+Bonduty,b.EndTime)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=2 and b.Starttime<=Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave2) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,b.endtime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=2 and b.StartTime>Cast(conVert(char,Ondutydate+Bonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+BOffduty,120) as DAtetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave2) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,Ondutydate+BOffduty)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=2 and b.Starttime>Cast(ConVert(char,Ondutydate+BonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime) and b.StartTime< Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
		--*

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave3) 
				select #attendancedetail.employeeid,ondutydate,datediff(mi,COnduty,COffDuty)-isnull(CrestTime,0) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=3 and b.Starttime<=Cast(ConVert(char,OndutyDate+COnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave3) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,OndutyDate+Conduty,b.EndTime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=3 and b.Starttime<=Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave3) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,b.endtime) 
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=3 and b.StartTime > Cast(conVert(char,Ondutydate+Conduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+COffduty,120) as DAtetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')

	        Exec ('insert into #askforleave (employeeid,ondutydate,leave3) 
				select #attendancedetail.employeeid,ondutydate,Datediff(mi,b.starttime,Ondutydate+COffduty)
	                     From  #Attendancedetail,AttendanceAskforleave b
	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
	                         #Attendancedetail.degree>=3 and b.Starttime > Cast(ConVert(char,Ondutydate+ConDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+COffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+COffduty,120) as Datetime) and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')


		--�޸�����: ��ʱ�ļ��㣬ԭ��һʱ�������������͵����ʱ����ʱ����ȥ������һ�����͵�ʱ�䡣
		--	    ����ʱ�ļ����еļ��ٵ������м���Ϣ���ᵽ��ٴ����������δ�������������ٴ�������ڣ���ʲô��ټ���ʲô��١�		
	         Exec ('Update #Attendancedetail set '+@Fieldname+'= (isnull(t.leave1,0)+isnull(t.leave2,0)+isnull(t.leave3,0)) / 60.0/shifttime ,
				worktime1=worktime1-t.leave1,worktime2=worktime2-t.leave2,worktime3=worktime3-t.leave3
			     From (select employeeid,ondutydate,sum(isnull(leave1,0)) as Leave1,sum(isnull(leave2,0)) as Leave2,sum(isnull(leave3,0)) as Leave3 from #askforleave group by employeeid,ondutydate) t
	                     Where #attendancedetail.employeeid=t.employeeid and #attendancedetail.ondutydate=t.ondutydate')
		
		--�޸����ݣ�1����Ϣ�գ��ڼ��ղ������Ű࣬��������������������Լ����
		--	   2������û�а�Σ�һ��Ļ�����ʱ��ѡ�������á�
		--  	   3�������������٣�������������뿪ʼʱ�����������ٻ���
		--         4,��������ٳ���ܿ�24Сʱ��
		if object_id('tempdb..#attendaskforleave') is not null drop table #attendaskforleave
		Create table #attendaskforleave (employeeid int,ondutydate datetime,starttime datetime,endtime datetime,askforleavetype nvarchar(50),leavetime int default 0)
		exec ('insert into #attendaskforleave (employeeid,ondutydate,starttime,endtime,askforleavetype,leavetime)
			select a.employeeid ,a.ondutydate,b.starttime,b.endtime,b.askforleavetype,datediff(mi,b.starttime,b.endtime) from #attendancedetail a,attendanceaskforleave b
				where a.employeeid=b.employeeid and datediff(dd,a.ondutydate,b.starttime)=0 and b.allday=0 and (left(a.ondutytype,1) =''1'' or left(a.ondutytype,1)=''2'') and b.askforleavetype='''+@AskforleaveName+'''')
		Exec ('Update #attendancedetail set '+@Fieldname+'=a.leavetime/60.0/'+@intworktime+' 
				from (select employeeid,ondutydate,sum(isnull(leavetime,0)) as leavetime from  #attendaskforleave  group by employeeid,ondutydate)a 
				where #attendancedetail.employeeid=a.employeeid and #attendancedetail.ondutydate=a.ondutydate and (left(#attendancedetail.ondutytype,1)=''1'' or left(#attendancedetail.ondutytype,1)=''2'')'
			)

		
-- 		if @Askforleavename='�¼�'
-- 			begin
-- 			select * from #attendancedetail where employeeid=1875
-- 			select * from #attendaskforleave
-- 			select employeeid,ondutydate,sum(isnull(leavetime,0)) as leavetime from  #attendaskforleave  group by employeeid,ondutydate
-- 			end
-- 
-- 	        Exec ('Update #Attendancedetail set Leave1= 
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+AOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,AOnduty,AOffDuty)-isnull(ArestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+AOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+AOnduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,OndutyDate+Aonduty,b.EndTime) 
-- 	                              When b.StartTime>Cast(conVert(char,Ondutydate+Aonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+AOffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime>Cast(ConVert(char,Ondutydate+AonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)  and b.StartTime< Cast(Convert(char,Ondutydate+AOffduty,120) as Datetime)
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+AOffduty) End 
-- 	                     From AttendanceAskforleave b
-- 	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
-- 	                         #Attendancedetail.degree>=1  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
--             
-- 	         Exec ('Update #Attendancedetail set Leave2= 
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+BOnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,BOnduty,BOffDuty)-isnull(BrestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+BOffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+BOnduty,120) as Datetime)
-- 	                                     Then Datediff(mi,OndutyDate+Bonduty,b.EndTime) 
-- 	                              When b.StartTime>Cast(conVert(char,Ondutydate+Bonduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+BOffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime>Cast(ConVert(char,Ondutydate+BonDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+BOffduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+BOffduty) End 
-- 	                     From AttendanceAskforleave b
-- 	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
-- 	                         #Attendancedetail.degree>=2  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
	                       
-- 	        Exec ('Update #Attendancedetail set Leave3= 
-- 	                         Case When b.Starttime<=Cast(ConVert(char,OndutyDate+COnduty,120) as Datetime) and b.endtime>=Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) 
-- 	                                     Then datediff(mi,COnduty,COffDuty)-isnull(CrestTime,0) 
-- 	                              When b.Starttime<=Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime) and b.Endtime < Cast(ConVert(char,Ondutydate+COffduty,120) as Datetime) and b.EndTime > Cast(ConVert(char,Ondutydate+COnduty,120) as Datetime)
-- 	                                     Then Datediff(mi,OndutyDate+Conduty,b.EndTime) 
-- 	                              When b.StartTime > Cast(conVert(char,Ondutydate+Conduty,120) as Datetime) and b.EndTime < Cast(ConVert(char,Ondutydate+COffduty,120) as DAtetime) 
-- 	                                     Then Datediff(mi,b.starttime,b.endtime) 
-- 	                              When b.Starttime > Cast(ConVert(char,Ondutydate+ConDuty,120) as Datetime) and b.EndTime>=Cast(Convert(char,Ondutydate+COffduty,120) as Datetime)  and b.StartTime < Cast(Convert(char,Ondutydate+COffduty,120) as Datetime) 
-- 	                                     Then Datediff(mi,b.starttime,Ondutydate+COffduty) End 
-- 	                     From AttendanceAskforleave b
-- 	                     Where b.allday<>1 and b.employeeid=#Attendancedetail.employeeid and b.AskForLeaveType='''+@Askforleavename+''' and 
-- 	                         #Attendancedetail.degree>=3  and left(b.status,1)=''2''  and left(b.nextstep,1)=''E''')
-- 	--             '���㹤ʱ����׼ʱ������׼ʱ��-���ʱ��-�ٵ�ʱ��-����ʱ��
-- 	--             '���ͬһʱ�δ���������٣��ݲ����ǣ�WokeTime1>0
-- 
-- 	        Update #Attendancedetail Set workTime1= datediff(mi,Ondutydate+AOnduty,Ondutydate+AOffduty)-isnull(Leave1,0)-Isnull(Latetime1,0)-Isnull(LeaveearlyTime1,0)-isnull(ArestTime,0) 
-- 	                     Where degree>=1 and Onduty1 is not null and Offduty1 is not null and Leave1 is not null 
-- 	                    
-- 	        Update #Attendancedetail Set WorkTime2=  Datediff(mi,Ondutydate+Bonduty,Ondutydate+BOffduty)-Isnull(Leave2,0)-IsNull(LateTime2,0)-IsNull(LeaveEarlytime2,0) -isnull(brestTime,0) 
-- 	                     Where Degree>=2 and Onduty2 is Not null and OffDuty2 is Not null and Leave2 is not null 
-- 	                    
-- 	        Update #Attendancedetail Set WorkTime3= Datediff(mi,Ondutydate+cOnduty,Ondutydate+COffduty)-isNull(Leave3,0)-Isnull(LateTime3,0)-Isnull(LeaveEarlytime3,0)-isnull(crestTime,0)  
-- 	                     Where Degree>=3 and Onduty3 is not null and offduty3 is not null and Leave3 is not null

-- 
-- 	         Exec ('Update #Attendancedetail set '+@Fieldname+'= (IsNull(Leave1, 0) + IsNull(Leave2, 0) + IsNull(Leave3, 0)) / 60.0/shifttime 
-- 	                     Where '+@Fieldname+' is null')

-- 	        --����׼��ʱ��һ�첻�԰���еĹ�ʱΪ׼�������Ա�׼ʱ��֮�ͼ��м���ϢΪ׼��
-- 		if @blnanalyseworkday=1
-- 			begin
-- 			         Exec ('Update #Attendancedetail set '+@Fieldname+'= (IsNull(Leave1, 0) + IsNull(Leave2, 0) + IsNull(Leave3, 0)) / 60.0/shifttime 
-- 			                     Where '+@Fieldname+' is null')
-- 
-- 			end
-- 		else
-- 			begin
-- 
-- 			         Exec ('Update #Attendancedetail set '+@Fieldname+'= (IsNull(Leave1, 0) + IsNull(Leave2, 0) + IsNull(Leave3, 0)) / standardtime 
-- 			                     Where '+@Fieldname+' is null and standardtime>0')
-- 
-- 			end
	                              
	
--	        Update #Attendancedetail set Leave1=null,Leave2=null,Leave3=Null
	
	        If Charindex(@Fieldname, @strSkipHoliday, 1) > 0 
			Begin
				If substring(@strSkipHoliday, Charindex(@Fieldname, @strSkipHoliday, 1) + Len(@Fieldname), 1) = '1'
					begin
					--print @fieldname
					--print substring(@strSkipHoliday, Charindex(@Fieldname, @strSkipHoliday, 1) + Len(@Fieldname), 1)

					 Exec ('Update #Attendancedetail set '+@Fieldname+'=0
					                ,Result1= case when Result1='''+@Askforleavename+''' then null else Result1 end 
					                ,Result2= case when Result2='''+@Askforleavename+''' then null else Result2 end 
					                ,Result3= case when Result3='''+@Askforleavename+''' then null else Result3 end 
					                ,Result4= case when Result4='''+@Askforleavename+''' then null else Result4 end 
					                ,Result5= case when Result5='''+@Askforleavename+''' then null else Result5 end 
					                ,Result6= case when Result6='''+@Askforleavename+''' then null else Result6 end 
					                 where left(ondutytype,1) in (''1'',''2'')')
					end
			end
		Fetch Askforleave into @Fieldname,@Askforleavename
	end
Close Askforleave
DealLocate Askforleave
--select * from #attendancedetail where employeeid=1

-- '�����ʱ�Ĺ�ʱ
-- 'һ��ʱ��ʱ�����԰���ϰ����ʱ��ƶ���ʱ�䣡
Update #Attendancedetail Set workTime1=case when LEFT(stretchshift,1)=0 then Datediff(mi,Ondutydate+Aonduty,Ondutydate+AOffduty)-Isnull(ArestTime,0)-IsNull(LateTime1,0)-IsNull(LeaveEarlytime1,0) 
				else  Datediff(mi,Ondutydate+onduty1,Ondutydate+Offduty1)-Isnull(ArestTime,0)-IsNull(LateTime1,0)-IsNull(LeaveEarlytime1,0) end  
             Where degree>=1 and Onduty1 is not null and Offduty1 is not null and Worktime1 is null 
Update #Attendancedetail Set workTime2=Datediff(mi,Ondutydate+Bonduty,Ondutydate+BOffduty)-Isnull(BrestTime,0)-IsNull(LateTime2,0)-IsNull(LeaveEarlytime2,0) 
             Where degree>=2 and Onduty2 is not null and Offduty2 is not null and Worktime2 is null 
Update #Attendancedetail Set workTime3=Datediff(mi,Ondutydate+Conduty,Ondutydate+COffduty)-Isnull(CrestTime,0)-IsNull(LateTime3,0)-IsNull(LeaveEarlytime3,0) 
             Where degree>=3 and Onduty3 is not null and Offduty3 is not null and Worktime3 is null 
Update #Attendancedetail Set WorkTime= isnull(Worktime1,0)+Isnull(WorkTime2,0)+Isnull(Worktime3,0) where left(ondutytype,1)='0'

Update #Attendancedetail set OtTime = WorkTime
             From #Attendancedetail a,Attendanceot b 
             Where a.employeeid=b.employeeid and a.Ondutydate Between b.Starttime and B.Endtime and b.allday=1 and left(a.ondutytype,1)<>'1'

--��������ε���Ϊ��Ϣʱ��shifttime��Ϊ0���ᵼ�³���0����
UpDate #attendancedetail set shifttime=null where Shifttime=0

if @blnAnalyseWorkDay=1 
	Update #attendancedetail set Workday =isnull(WorkTime,0)/60.00/isnull(ShiftTime,8) --'����ĵ��԰��Ҫ�趨shifttime
else
	Update #attendancedetail set Workday =
		(isnull(WorkTime1,0)+case when isnull(worktime1,0)>0 then isnull(latetime1,0)+isnull(leaveearlytime1,0) else 0 end 
		 +isnull(Worktime2,0)+case when isnull(worktime2,0)>0 then isnull(latetime2,0)+isnull(leaveearlytime2,0) else 0 end 
		 +isnull(Worktime3,0)+case when isnull(worktime3,0)>0 then isnull(latetime3,0)+isnull(leaveearlytime3,0) else 0 end )
		/60.00/isnull(ShiftTime,8) 

--select * from #attendancedetail where nobrushcard=1 and employeeid=2

--'�����ϰ�����
Update #Attendancedetail set Result1= case when latetime1>0 then '�ٵ�' else result1 end, 
				  Result2= case when LeaveEarlytime1>0 then '����' else Result2 end, 
				  Result3= case when Latetime2>0 then '�ٵ�' else Result3 end, 
				  Result4= case when LeaveEarlyTime2>0 then '����' else Result4 end, 
				  Result5= case when latetime3>0 then '�ٵ�' else Result5 end, 
				  Result6 =case when LeaveEarlytime3>0 then '����' else Result6 end 
Update #attendancedetail set Result1= case when onduty1 is null and result1 is null then 'δ��' when Onduty1 is not null and result1 is null then '����' else Result1 end, 
				  Result2= case When offduty1 is null and result2 is null then 'δ��' when offduty1 is not null and result2 is null then '����' else Result2 end 
				 where Degree>=1 and NoBrushcard<>1 
Update #attendancedetail set Result3= case when onduty2 is null and result3 is null then 'δ��' when Onduty2 is not null and result3 is null then '����' else Result3 end, 
				  Result4= case When offduty2 is null and result4 is null then 'δ��' when offduty2 is not null and result4 is null then '����' else Result4 end 
				 where Degree>=2 and NoBrushcard<>1 
Update #attendancedetail set Result5= case when onduty3 is null and result5 is null then 'δ��' when Onduty3 is not null and result5 is null then '����' else Result5 end, 
				  Result6= case When offduty3 is null and result6 is null then 'δ��' when offduty3 is not null and result6 is null then '����' else Result6 end 
				 where Degree=3 and NoBrushcard<>1 
Update #Attendancedetail set result1=null ,result2=null
				where left(ondutytype,1)='2' and degree>=1 and (result1 ='δ��' and result2='δ��')
Update #Attendancedetail set result3=null ,result4=null
				where left(ondutytype,1)='2' and degree>=2 and (result3 ='δ��' and result4='δ��')
Update #Attendancedetail set result5=null ,result6=null
				where left(ondutytype,1)='2' and degree>=3 and (result5 ='δ��' and result6='δ��')
update #AttendanceDetail set result1= case when  degree>=1 and result1 is null then holidayname else result1 end ,
			 result2= case when  degree>=1 and result2 is null then holidayname else result2 end ,
			 result3= case when  degree>=2 and result3 is null then holidayname else result3 end ,
			 result4= case when  degree>=2 and result4 is null then holidayname else result4 end ,
			 result5= case when  degree>=3 and result5 is null then holidayname else result5 end ,
			 result6= case when  degree>=3 and result6 is null then holidayname else result6 end 
	 from attendanceholiday b where #AttendanceDetail.ondutydate=b.HolidayDate and left(#AttendanceDetail.ondutytype,1)<>'1'

if @strAbnormity='1'
	Begin
		Update #Attendancedetail Set Absent= (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8)
		         Where Degree=1  and noBrushcard <> 1 and (Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')  and Left(ondutytype,1)<>'1' 
		Update #Attendancedetail Set Absent= Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) Then ((datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty))-isnull(Aresttime,0)-isnull(Bresttime,0))/60.00/isnull(ShiftTime,8) 
		         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and Onduty2 is not null and Offduty2 is not null Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8)
		         When  (Onduty1 is not null and Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(BrestTime,0))/60.00/isnull(ShiftTime,8) end
		         Where Degree=2 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'
		Update #Attendancedetail Set Absent=Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and ((Onduty3 is null or Offduty3 is null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)+datediff(mi,ondutydate+Conduty,ondutydate+Coffduty)-isnull(ArestTime,0)-isnull(BrestTime,0)-isnull(CrestTime,0))/60.00/isnull(ShiftTime,8) 
		         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' Or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Aresttime,0)-isnull(BrestTime,0))/60.00/isnull(ShiftTime,8) 
		         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and (Onduty2 is not null and Offduty2 is not null) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8) 
		         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Bresttime,0))/60.00/isnull(ShiftTime,8) 
		         When (Onduty1 is not null and  Offduty1 is not null) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is null or Offduty3 is  null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Cresttime,0))/60.00/isnull(ShiftTime,8) 
		         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��'))  and ((Onduty3 is null or Offduty3 is null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)+datediff(mi,Ondutydate+Conduty,Ondutydate+COffduty)-isnull(Bresttime,0)-isnull(Cresttime,0))/60.00/isnull(ShiftTime,8) 
		         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is  null or Offduty3 is null) and (result5  ='δ��' Or result6  ='δ��')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Aresttime,0)-isnull(CrestTime,0))/60.00/isnull(ShiftTime,8) end 
		        Where Degree=3 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'
-- 		if @blnanalyseworkday=1
-- 
-- 			begin
-- 				Update #Attendancedetail Set Absent= (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8)
-- 				         Where Degree=1  and noBrushcard <> 1 and (Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')  and Left(ondutytype,1)<>'1' 
-- 				Update #Attendancedetail Set Absent= Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) Then ((datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty))-isnull(Aresttime,0)-isnull(Bresttime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and Onduty2 is not null and Offduty2 is not null Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8)
-- 				         When  (Onduty1 is not null and Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(BrestTime,0))/60.00/isnull(ShiftTime,8) end
-- 				         Where Degree=2 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'
-- 				Update #Attendancedetail Set Absent=Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and ((Onduty3 is null or Offduty3 is null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)+datediff(mi,ondutydate+Conduty,ondutydate+Coffduty)-isnull(ArestTime,0)-isnull(BrestTime,0)-isnull(CrestTime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' Or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Aresttime,0)-isnull(BrestTime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and (Onduty2 is not null and Offduty2 is not null) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Bresttime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is null or Offduty3 is  null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Cresttime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��'))  and ((Onduty3 is null or Offduty3 is null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)+datediff(mi,Ondutydate+Conduty,Ondutydate+COffduty)-isnull(Bresttime,0)-isnull(Cresttime,0))/60.00/isnull(ShiftTime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is  null or Offduty3 is null) and (result5  ='δ��' Or result6  ='δ��')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Aresttime,0)-isnull(CrestTime,0))/60.00/isnull(ShiftTime,8) end 
-- 				        Where Degree=3 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'
-- 
-- 			end
-- 		else		
-- 			begin
-- 				Update #Attendancedetail Set Absent= (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/isnull(standardtime,8)
-- 				         Where Degree=1  and noBrushcard <> 1 and (Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')  and Left(ondutytype,1)<>'1'  and standardtime>0
-- 				Update #Attendancedetail Set Absent= Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) Then ((datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty))-isnull(Aresttime,0)-isnull(Bresttime,0))/isnull(standardtime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and Onduty2 is not null and Offduty2 is not null Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/60.00/isnull(standardtime,8)
-- 				         When  (Onduty1 is not null and Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(BrestTime,0))/60.00/isnull(standardtime,8) end
-- 				         Where Degree=2 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'  and standardtime>0
-- 				Update #Attendancedetail Set Absent=Case when ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and ((Onduty3 is null or Offduty3 is null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)+datediff(mi,ondutydate+Conduty,ondutydate+Coffduty)-isnull(ArestTime,0)-isnull(BrestTime,0)-isnull(CrestTime,0))/isnull(standardtime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' Or result2  ='δ��')) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Aresttime,0)-isnull(BrestTime,0))/isnull(standardtime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and (Onduty2 is not null and Offduty2 is not null) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0))/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��')) and (Onduty3 is not null and Offduty3 is not null) Then (datediff(mi,Ondutydate+BOnduty,Ondutydate+BOffduty)-isnull(Bresttime,0))/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is null or Offduty3 is  null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Cresttime,0))/isnull(ShiftTime,8) 
-- 				         When (Onduty1 is not null and  Offduty1 is not null) and ((Onduty2 is null or Offduty2 is null) and (result3  ='δ��' or result4  ='δ��'))  and ((Onduty3 is null or Offduty3 is null) and (result5  ='δ��' or result6  ='δ��')) Then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)+datediff(mi,Ondutydate+Conduty,Ondutydate+COffduty)-isnull(Bresttime,0)-isnull(Cresttime,0))/isnull(standardtime,8) 
-- 				         When ((Onduty1 is null or Offduty1 is null) and (result1  ='δ��' or result2  ='δ��')) and (Onduty2 is not null and Offduty2 is not null) and ((Onduty3 is  null or Offduty3 is null) and (result5  ='δ��' Or result6  ='δ��')) Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)+datediff(mi,Ondutydate+COnduty,Ondutydate+COffduty)-isnull(Aresttime,0)-isnull(CrestTime,0))/isnull(standardtime,8) end 
-- 				        Where Degree=3 and noBrushcard <> 1  and Left(ondutytype,1)<>'1'  and standardtime>0
-- 			
-- 			end		
			--'�쳣������У������гٵ����˲��Ƴٵ����ˡ�
		Update #Attendancedetail set LateTime1=0,LeaveEarlyTime1=0 
			 Where Degree>=1  and noBrushcard <> 1 and  (result1 ='δ��' or result2 ='δ��')  and Left(ondutytype,1)<>'1' 
		Update #Attendancedetail set Latetime2=0,LeaveEarlytime2=0 
			 Where Degree>=2  and noBrushcard <> 1 and  (result3 ='δ��' or result4 ='δ��')  and Left(ondutytype,1)<>'1' 
		Update #Attendancedetail set Latetime3=0,LeaveEarlytime3=0 
			 Where Degree>=3  and noBrushcard <> 1 and  (result5 ='δ��' or result6 ='δ��')  and Left(ondutytype,1)<>'1' 
	end
else
	Update #Attendancedetail Set Absent= (Case When Degree>=1 and onduty1 is null and offduty1 is null and result1  ='δ��' and result2  ='δ��' Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0)) else 0 end +
			 Case When Degree>=2 and onduty2 is null and Offduty2 is null and result3  ='δ��' and result4  ='δ��' then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)-isnull(BrestTime,0))  else 0 end + 
			 Case When Degree>=3 and Onduty3 is null and Offduty3 is null and result5  ='δ��' and result6  ='δ��' then (datediff(mi,ondutydate+Conduty,Ondutydate+COffduty)-isnull(CrestTime,0)) else  0 end )/60.00 /isnull(ShiftTime,8)
	         Where noBrushcard <> 1  and Left(ondutytype,1)<>'1'

-- 	if @blnanalyseworkday=1
-- 	Update #Attendancedetail Set Absent= (Case When Degree>=1 and onduty1 is null and offduty1 is null and result1  ='δ��' and result2  ='δ��' Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0)) else 0 end +
-- 			 Case When Degree>=2 and onduty2 is null and Offduty2 is null and result3  ='δ��' and result4  ='δ��' then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)-isnull(BrestTime,0))  else 0 end + 
-- 			 Case When Degree>=3 and Onduty3 is null and Offduty3 is null and result5  ='δ��' and result6  ='δ��' then (datediff(mi,ondutydate+Conduty,Ondutydate+COffduty)-isnull(CrestTime,0)) else  0 end )/60.00 /isnull(ShiftTime,8)
-- 	         Where noBrushcard <> 1  and Left(ondutytype,1)<>'1'
-- 	else
-- 	Update #Attendancedetail Set Absent= (Case When Degree>=1 and onduty1 is null and offduty1 is null and result1  ='δ��' and result2  ='δ��' Then (datediff(mi,ondutydate+Aonduty,Ondutydate+AOffduty)-isnull(ArestTime,0)) else 0 end +
-- 			 Case When Degree>=2 and onduty2 is null and Offduty2 is null and result3  ='δ��' and result4  ='δ��' then (datediff(mi,ondutydate+Bonduty,Ondutydate+BOffduty)-isnull(BrestTime,0))  else 0 end + 
-- 			 Case When Degree>=3 and Onduty3 is null and Offduty3 is null and result5  ='δ��' and result6  ='δ��' then (datediff(mi,ondutydate+Conduty,Ondutydate+COffduty)-isnull(CrestTime,0)) else  0 end )/isnull(standardtime,8)
-- 	         Where noBrushcard <> 1  and Left(ondutytype,1)<>'1'  and standardtime>0
-- 
--select * from #Attendancedetail where employeeid=2
if @strTotalType='3'--����ͳ��
	begin
		set @tempmonth=''
		select @tempmonth=postmonth from totalmonth where @startdate between startdate and enddate
		select @tempmonth=isnull(@tempmonth,'')

		if @tempmonth=''
			select @startdate=@sdate,@enddate=@edate
		else
			select @startdate=startdate,@enddate=enddate,@strmonth=postmonth from totalmonth where postmonth=@strmonth

		insert #attendancedetail (Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,
				PublicHoliday,Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,
				CompensatoryLeave,OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,
				OnDuty1,LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,
				LeaveEarlyTime2,PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag)
				 select Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,PublicHoliday,
				Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,CompensatoryLeave,
				OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,OnDuty1,
				LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,LeaveEarlyTime2,
				PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag 
				from attendancedetail where ondutydate >=@startdate and ondutydate <=@EndDate and cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) not in 
				(select cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) as employeeonduty from #attendancedetail )
			
	end
-- Update #Attendancedetail 
--                 Set LateCount =(Case When latetime1>0 then 1 else 0 end )+(Case When Latetime2>0 then 1 else 0 end ) +(Case When lateTime3>0 then 1 else 0 end ), 
--                     LeaveEarlyCount=(Case When LeaveEarlyTime1>0 then 1 else 0 end )+(Case When LeaveEarlyTime2>0 then 1 else 0 end )+(Case When LeaveEarlyTime3>0 then 1 else 0 end ), 
--                     abnormitycount=(Case when (onduty1 is not null and Offduty1 is null) or (Onduty1 is null and Offduty1 is not null) then 1 else 0 end ) +(Case When (Onduty2 is not null and Offduty2 is null)or (Onduty2 is null and Offduty2 is not null) then 1 else 0 end )+(Case When (onduty3 is not null and offduty3 is null) or (onduty3 is null and offduty3 is not null) then 1 else 0 end )
-- 	where nobrushcard=0
Update #Attendancedetail 
                Set LateCount =(Case When latetime1>0 then 1 else 0 end )+(Case When Latetime2>0 then 1 else 0 end ) +(Case When lateTime3>0 then 1 else 0 end ), 
                    LeaveEarlyCount=(Case When LeaveEarlyTime1>0 then 1 else 0 end )+(Case When LeaveEarlyTime2>0 then 1 else 0 end )+(Case When LeaveEarlyTime3>0 then 1 else 0 end ), 
                    abnormitycount=(Case when (result1 ='δ��'  and result2 <>'δ��') or (result1 <>'δ��'  and result2 ='δ��') then 1 else 0 end ) +(Case When (result3 ='δ��'  and result4 <>'δ��')or (result3 <>'δ��'  and result4 ='δ��') then 1 else 0 end )+(Case When (result5 ='δ��'  and result6 <>'δ��') or (result5 <>'δ��'  and result6 ='δ��') then 1 else 0 end )
	where nobrushcard=0

--select * from #attendancedetail where employeeid=1163
--����û�ϰ಻�ǿ�����
Update #attendancedetail set absent=0 where left(ondutytype,1)='2'

--	'û����ʷ��,ÿ�ε����ݵñ���,ͳ��ʱ���ظ��ľ�������ͳ�Ƶĸ���,�����ظ���������!
Update Attendancedetail set employeeid=a.employeeid,ondutydate=a.ondutydate,Result3=a.Result3,WorkTime=a.WorkTime,LactationLeave=a.LactationLeave,Result5=a.Result5,Result2=a.Result2,WorkTime2=a.WorkTime2,Absent=a.Absent,OnDuty3=a.OnDuty3,
				PublicHoliday=a.PublicHoliday,Result4=a.Result4,WorkTime3=a.WorkTime3,OtherLeave=a.OtherLeave,OtTime=a.OtTime,WorkDay=a.WorkDay,WorkTime1=a.WorkTime1,LateTime1=a.LateTime1,OffDuty3=a.OffDuty3,Result1=a.Result1,
				CompensatoryLeave=a.CompensatoryLeave,OnDutyType=a.OnDutyType,VisitLeave=a.VisitLeave,Result6=a.Result6,OffDuty2=a.OffDuty2,OnTrip=a.OnTrip,FuneralLeave=a.FuneralLeave,ShiftName=a.ShiftName,LateTime2=a.LateTime2,
					OnDuty1=a.OnDuty1,LeaveEarlyTime3=a.LeaveEarlyTime3,OnDuty2=a.OnDuty2,LeaveEarlyTime1=a.LeaveEarlyTime1,OffDuty1=a.OffDuty1,LateTime3=a.LateTime3,nobrushcard=a.nobrushcard,
				LeaveEarlyTime2=a.LeaveEarlyTime2,PersonalLeave=a.PersonalLeave,MaternityLeave=a.MaternityLeave,AnnualVacation=a.AnnualVacation,InjuryLeave=a.InjuryLeave,SickLeave=a.SickLeave,WeddingLeave=a.WeddingLeave,signinflag=a.signinflag
				 from #attendancedetail a where a.employeeid =attendancedetail.employeeid and a.ondutydate=attendancedetail.ondutydate

-- select Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,PublicHoliday,
-- 				Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,CompensatoryLeave,
-- 				OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,OnDuty1,
-- 				LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,LeaveEarlyTime2,
-- 				PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag 
-- 				from #attendancedetail where cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) not in 
-- 				(select cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) as employeeonduty from attendancedetail 
-- 				where ondutydate >=@startdate and ondutydate <=@EndDate)

Insert into Attendancedetail (Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,
				PublicHoliday,Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,
				CompensatoryLeave,OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,
				OnDuty1,LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,
				LeaveEarlyTime2,PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag,nobrushcard)
				 select Result3,WorkTime,LactationLeave,Result5,Result2,WorkTime2,Absent,OnDuty3,PublicHoliday,
				Result4,WorkTime3,OtherLeave,OtTime,WorkDay,WorkTime1,LateTime1,OffDuty3,Result1,CompensatoryLeave,
				OnDutyType,VisitLeave,Result6,OffDuty2,OnTrip,FuneralLeave,ShiftName,LateTime2,OnDuty1,
				LeaveEarlyTime3,OnDuty2,EmployeeId,OnDutyDate,LeaveEarlyTime1,OffDuty1,LateTime3,LeaveEarlyTime2,
				PersonalLeave,MaternityLeave,AnnualVacation,InjuryLeave,SickLeave,WeddingLeave,signinflag,nobrushcard 
				from #attendancedetail where cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) not in 
				(select cast(employeeid as varchar(12)) +cast(ondutydate as varchar(18)) as employeeonduty from attendancedetail 
				where ondutydate >=@startdate and ondutydate <=@EndDate)

--select * from attendancedetail where nobrushcard=1 and employeeid=2

--    '���ܿ���
if @strTotalType='3'--����ͳ��
	begin
-- 		Declare @Day varchar(2),@month varchar(2),@year varchar(4),@maxday int
-- 		Declare @Sdate datetime,@Edate Datetime
-- 		Declare @totalcycle nvarchar(50)
--		select @totalcycle=variablevalue from Options where variablename='StrTotalCycle'
		/*
		set @totalcycle='0-����,1,0-����,3'
		print charindex(',',@totalcycle,1)
		print charindex(',',@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)+1)+1
		print substring(@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)+1)+1,2)
		Declare @strmonth nvarchar(50)
		Declare @startdate datetime
		set @startdate='2015-04-08'
		*/

-- 		set @tempmonth=''
-- 		select @tempmonth=postmonth from totalmonth where @startdate between startdate and enddate
-- 		select @tempmonth=isnull(@tempmonth,'')
-- 
-- 		if @tempmonth=''
-- 			select @startdate=@sdate,@enddate=@edate
-- 		else
-- 			select @startdate=startdate,@enddate=enddate,@strmonth=postmonth from totalmonth where postmonth=@strmonth
-- 		if @strmonth=''--��������ȡ��ͳ���·�
-- 			begin
-- 				select @year=cast(year(@startdate) as varchar(4)),@month=cast(month(@startdate) as varchar(2))
-- 				if len(@month)=1
-- 					set @month='0'+@month
-- 				set @maxday=day(dateadd(dd,-1,dateadd(mm,+1,(@year+@month+'01'))))
-- 				set @day=substring(@totalcycle,charindex(',',@totalcycle,1)+1,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)-charindex(',',@totalcycle,1)-1) 
-- 				if len(@day)=1
-- 					set @day='0'+@day
-- 				if @maxday<cast(@day as int)
-- 					set @sdate= @year+'-'+@month+'-'+cast(@maxday as varchar(2))
-- 				else
-- 					set @sdate= @year+'-'+@month+'-'+@day
-- 				if substring(@totalcycle,1,1)='1'
-- 					set @sdate=dateadd(mm,-1,@sdate)
-- 
-- 				set @day=substring(@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)+1)+1,2)
-- 				if len(@day)=1
-- 					set @day='0'+@day
-- 				if @maxday<cast(@day as int)
-- 					set @edate=@year+'-'+@month+'-'+cast(@maxday as varchar(2))
-- 				else
-- 					set @edate=@year+'-'+@month+'-'+@day
-- 				if substring(@totalcycle,charindex(',',@totalcycle,charindex(',',@totalcycle,1)+1)+1,1)='1'
-- 					set @edate=dateadd(mm,-1,@sdate)
-- 				if @sdate>@edate
-- 					return
-- 				if @startdate>=@sdate and @startdate<=@edate
-- 					set @strmonth=@year+@month
-- 				if @startdate<@sdate
-- 					begin
-- 						set @month=cast(month(dateadd(mm,-1,(@year+@month+'01'))) as varchar(2))
-- 						if len(@month)<>2
-- 							set @month='0'+@month
-- 						set @strmonth=cast(year(dateadd(mm,-1,(@year+@month+'01'))) as varchar(4))+@month					
-- 					end
-- 				if @startdate>@sdate
-- 					begin
-- 						set @month=cast(month(dateadd(mm,1,(@year+@month+'01'))) as varchar(2))
-- 						if len(@month)<>2
-- 							set @month='0'+@month
-- 						set @strmonth=cast(year(dateadd(mm,1,(@year+@month+'01'))) as varchar(4))+@month					
-- 					end
-- 				select @startdate=@sdate,@enddate=@edate
-- 			end
-- 		else
-- 			begin
-- 				select @startdate=startdate,@enddate=enddate from totalmonth where postmonth=@strmonth
-- 			end
		Exec ('Update AttendanceTotal 
		                 Set InjuryLeave=t.InjuryLeave,WeddingLeave=t.WeddingLeave,OtherLeave=t.OtherLeave,
		                     LactationLeave=t.LactationLeave,VisitLeave=t.VisitLeave,OnTrip=t.OnTrip,
		                     CompensatoryLeave=t.CompensatoryLeave,FuneralLeave=t.FuneralLeave,PersonalLeave=t.PersonalLeave,
		                     Absent=t.Absent,MaternityLeave=t.MaternityLeave,SickLeave=t.SickLeave,
		                     PublicHoliday=t.PublicHoliday,AnnualVacation=t.AnnualVacation 
		                 From (Select Employeeid, Sum(isnull(InjuryLeave,0)) as InjuryLeave,Sum(IsNULL(WeddingLeave,0)) as Weddingleave,
		                       Sum(Isnull(OtherLeave,0)) as OtherLeave,Sum(isnull(LactationLeave,0)) as LactationLeave,
		                       Sum(isnull(VisitLeave,0)) as VisitLeave,Sum(isnull(OnTrip,0)) as OnTrip,
		                       Sum(isnull(CompensatoryLeave,0)) as CompensatoryLeave,Sum(isnull(FuneralLeave,0)) as FuneralLeave,
		                       Sum(isnull(PersonalLeave,0)) as PersonalLeave,Sum(isnull(Absent,0)) as Absent,
		                       sum(isnull(MaternityLeave,0)) as MaternityLeave,Sum(isnull(SickLeave,0)) as SickLeave,
		                       Sum(isnull(PublicHoliday,0)) as PublicHoliday,Sum(isnull(AnnualVacation,0)) as AnnualVacation 
		                       From attendancedetail where ondutydate between '''+@startdate+''' and ''' +@enddate+''' Group by Employeeid) t
		                 Where Attendancetotal.employeeid=t.employeeid and Attendancetotal.AttendMonth='''+@strmonth+'''')
		                
		Exec('Insert into AttendanceTotal (employeeid,attendmonth,InjuryLeave,WeddingLeave,OtherLeave,
		                             LactationLeave,VisitLeave,OnTrip,
		                             CompensatoryLeave,FuneralLeave,PersonalLeave,
		                             Absent,MaternityLeave,SickLeave,
		                             PublicHoliday,AnnualVacation )    
		                             Select Employeeid,'''+ @strmonth +''', Sum(isnull(InjuryLeave,0)) as InjuryLeave,Sum(IsNULL(WeddingLeave,0)) as Weddingleave,
		                               Sum(Isnull(OtherLeave,0)) as OtherLeave,Sum(isnull(LactationLeave,0)) as LactationLeave,
		                               Sum(isnull(VisitLeave,0)) as VisitLeave,Sum(isnull(OnTrip,0)) as OnTrip,
		                               Sum(isnull(CompensatoryLeave,0)) as CompensatoryLeave,Sum(isnull(FuneralLeave,0)) as FuneralLeave,
		                               Sum(isnull(PersonalLeave,0)) as PersonalLeave,Sum(isnull(Absent,0)) as Absent,
		                               sum(isnull(MaternityLeave,0)) as MaternityLeave,Sum(isnull(SickLeave,0)) as SickLeave,
		                               Sum(isnull(PublicHoliday,0)) as PublicHoliday,Sum(isnull(AnnualVacation,0)) as AnnualVacation 
		                               From attendancedetail 
		                               Where employeeid not in (select employeeid from 
		                               attendancetotal where AttendMonth='''+ @strmonth +''') Group by Employeeid')	
	end
else				    
	begin
		Exec ('Update AttendanceTotal 
		                 Set InjuryLeave=t.InjuryLeave,WeddingLeave=t.WeddingLeave,OtherLeave=t.OtherLeave,
		                     LactationLeave=t.LactationLeave,VisitLeave=t.VisitLeave,OnTrip=t.OnTrip,
		                     CompensatoryLeave=t.CompensatoryLeave,FuneralLeave=t.FuneralLeave,PersonalLeave=t.PersonalLeave,
		                     Absent=t.Absent,MaternityLeave=t.MaternityLeave,SickLeave=t.SickLeave,
		                     PublicHoliday=t.PublicHoliday,AnnualVacation=t.AnnualVacation 
		                 From (Select Employeeid, Sum(isnull(InjuryLeave,0)) as InjuryLeave,Sum(IsNULL(WeddingLeave,0)) as Weddingleave,
		                       Sum(Isnull(OtherLeave,0)) as OtherLeave,Sum(isnull(LactationLeave,0)) as LactationLeave,
		                       Sum(isnull(VisitLeave,0)) as VisitLeave,Sum(isnull(OnTrip,0)) as OnTrip,
		                       Sum(isnull(CompensatoryLeave,0)) as CompensatoryLeave,Sum(isnull(FuneralLeave,0)) as FuneralLeave,
		                       Sum(isnull(PersonalLeave,0)) as PersonalLeave,Sum(isnull(Absent,0)) as Absent,
		                       sum(isnull(MaternityLeave,0)) as MaternityLeave,Sum(isnull(SickLeave,0)) as SickLeave,
		                       Sum(isnull(PublicHoliday,0)) as PublicHoliday,Sum(isnull(AnnualVacation,0)) as AnnualVacation 
		                       From #attendancedetail Group by Employeeid) t
		                 Where Attendancetotal.employeeid=t.employeeid and Attendancetotal.AttendMonth='''+@strmonth+'''')
		                
		Exec('Insert into AttendanceTotal (employeeid,attendmonth,InjuryLeave,WeddingLeave,OtherLeave,
		                             LactationLeave,VisitLeave,OnTrip,
		                             CompensatoryLeave,FuneralLeave,PersonalLeave,
		                             Absent,MaternityLeave,SickLeave,
		                             PublicHoliday,AnnualVacation )    
		                             Select Employeeid,'''+ @strmonth +''', Sum(isnull(InjuryLeave,0)) as InjuryLeave,Sum(IsNULL(WeddingLeave,0)) as Weddingleave,
		                               Sum(Isnull(OtherLeave,0)) as OtherLeave,Sum(isnull(LactationLeave,0)) as LactationLeave,
		                               Sum(isnull(VisitLeave,0)) as VisitLeave,Sum(isnull(OnTrip,0)) as OnTrip,
		                               Sum(isnull(CompensatoryLeave,0)) as CompensatoryLeave,Sum(isnull(FuneralLeave,0)) as FuneralLeave,
		                               Sum(isnull(PersonalLeave,0)) as PersonalLeave,Sum(isnull(Absent,0)) as Absent,
		                               sum(isnull(MaternityLeave,0)) as MaternityLeave,Sum(isnull(SickLeave,0)) as SickLeave,
		                               Sum(isnull(PublicHoliday,0)) as PublicHoliday,Sum(isnull(AnnualVacation,0)) as AnnualVacation 
		                               From #attendancedetail 
		                               Where employeeid not in (select employeeid from 
		                               attendancetotal where AttendMonth='''+ @strmonth +''') Group by Employeeid')
 	end

--   '0-ƽ��
Update Attendancetotal 
             set Workday_0=t.Workday_0,LateTime_0=t.LateTime_0,LateCount_0=t.LateCount_0,
             abnormitycount_0=t.abnormitycount_0,ottime_0 =t.ottime_0,Worktime_0=t.WorkTime_0,
             LeaveEarlytime_0=t.leaveearlytime_0,leaveearlycount_0=t.leaveearlycount_0 
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_0,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_0,
                     Sum(isnull(LateCount,0)) as LateCount_0,Sum(isnull(abnormitycount,0)) as abnormitycount_0,
                     Sum(isnull(ottime,0)) as OtTime_0,Sum(isnull(Worktime,0)) as WorkTime_0,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_0,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_0 From #Attendancedetail 
                     Where Left(ondutytype,1)='0' Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth
--    '1-��Ϣ
Update Attendancetotal 
             set Worktime_1=t.WorkTime_1
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_1,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_1,
                     Sum(isnull(LateCount,0)) as LateCount_1,Sum(isnull(abnormitycount,0)) as abnormitycount_1,
                     Sum(isnull(ottime,0)) as OtTime_1,Sum(isnull(Worktimeholiday,0)) as WorkTime_1,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_1,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_1 From #Attendancedetail 
                     Where Left(ondutytype,1)='1' Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth
--    '2-����
Update Attendancetotal 
             set Worktime_2=t.WorkTime_2,publicholiday=t.publicholiday 
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_2,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_2,
                     Sum(isnull(LateCount,0)) as LateCount_2,Sum(isnull(abnormitycount,0)) as abnormitycount_2,
                     Sum(isnull(ottime,0)) as OtTime_2,Sum(isnull(Worktimeholiday,0)) as WorkTime_2,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_2,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_2,sum(case when worktimeholiday=0 then 1 else 0 end ) as publicholiday From #Attendancedetail 
                     Where Left(ondutytype,1)='2'  Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth

/*
--    '1-��Ϣ
Update Attendancetotal 
             set Workday_1=t.Workday_1,LateTime_1=t.LateTime_1,LateCount_1=t.LateCount_1,
             abnormitycount_1=t.abnormitycount_1,ottime_1 =t.ottime_1,Worktime_1=t.WorkTime_1,
             LeaveEarlytime_1=t.leaveearlytime_1,leaveearlycount_1=t.leaveearlycount_1 
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_1,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_1,
                     Sum(isnull(LateCount,0)) as LateCount_1,Sum(isnull(abnormitycount,0)) as abnormitycount_1,
                     Sum(isnull(ottime,0)) as OtTime_1,Sum(isnull(Worktime,0)) as WorkTime_1,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_1,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_1 From #Attendancedetail 
                     Where Left(ondutytype,1)='1' Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth
--    '2-����
Update Attendancetotal 
             set Workday_2=t.Workday_2,LateTime_2=t.LateTime_2,LateCount_2=t.LateCount_2,
             abnormitycount_2=t.abnormitycount_2,ottime_2 =t.ottime_2,Worktime_2=t.WorkTime_2,
             LeaveEarlytime_2=t.leaveearlytime_2,leaveearlycount_2=t.leaveearlycount_2,publicholiday=t.publicholiday 
             From (Select Employeeid,Sum(isnull(workday,0)) as WorkDay_2,Sum(isnull(Latetime1,0))+Sum(isnull(Latetime2,0))+Sum(isnull(latetime3,0)) as Latetime_2,
                     Sum(isnull(LateCount,0)) as LateCount_2,Sum(isnull(abnormitycount,0)) as abnormitycount_2,
                     Sum(isnull(ottime,0)) as OtTime_2,Sum(isnull(Worktime,0)) as WorkTime_2,
                     Sum(isnull(LeaveEarlyTime1,0))+Sum(isnull(leaveEarlyTime2,0))+Sum(isnull(Leaveearlytime3,0)) as LeaveEarlytime_2,
                     Sum(isnull(LeaveEarlyCount,0)) as LeaveEarlycount_2,sum(case when worktime=0 then 1 else 0 end ) as publicholiday From #Attendancedetail 
                     Where Left(ondutytype,1)='2'  Group by Employeeid)t 
             Where Attendancetotal.employeeid=t.employeeid and attendancetotal.attendmonth=@strmonth
*/
--delete from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4)
--ֱ���޸��Ѵ��ڵ������﷨�������⡣��ɾ���ٲ���ķ�ʽҲ���С�������ʱ��
-- update attendancetotalyear set WorkDay_1=a.WorkDay_1
-- 	FROM attendancetotalyear b,(select @strmonth,employeeid,WorkDay_1 from attendancetotal)a
-- 	where a.employeeid=b.employeeid


if object_id('tempdb..#totalyear') is not null drop table #totalyear
select @totalyear=right('20'+cast(year(@strmonth+'-01') as varchar(4)),4)

--select * into #totalyear from (select WorkDay_1,LateTime_0,InjuryLeave,WeddingLeave,LateCount_2,AbnormityCount_1,OtherLeave,OtTime_1,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,LeaveEarlyCount_1,OtTime_2,AbnormityCount_0,FuneralLeave,PersonalLeave,LateTime_2,LeaveEarlyCount_2,OtTime_0,Absent,WorkTime_0,LateTime_1,WorkDay_2,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,LeaveEarlyTime_1,PublicHoliday,AbnormityCount_2,AnnualVacation,LeaveEarlyTime_2,WorkTime_2,LateCount_1,WorkDay_0,AnnualVacationRemanent,CompensatoryLeaveFree from attendancetotalyear where 1=2)a
Select * into #totalyear from attendancetotalyear where 1=2
insert into #totalyear (attendmonth,employeeid,LateTime_0,InjuryLeave,WeddingLeave,OtherLeave,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,AbnormityCount_0,FuneralLeave,PersonalLeave,OtTime_0,Absent,WorkTime_0,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,PublicHoliday,AnnualVacation,WorkTime_2,WorkDay_0,AnnualVacationRemanent)
	select @totalyear,employeeid,sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(OtherLeave,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AnnualVacation,0)),sum(isnull(WorkTime_2,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0))
		 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid
--select * from #totalyear
Update attendancetotalyear set LateTime_0=a.LateTime_0,InjuryLeave=a.InjuryLeave,WeddingLeave=a.WeddingLeave,OtherLeave=a.OtherLeave,LactationLeave=a.LactationLeave,VisitLeave=a.VisitLeave,OnTrip=a.OnTrip,CompensatoryLeave=a.CompensatoryLeave,AbnormityCount_0=a.AbnormityCount_0,FuneralLeave=a.FuneralLeave,PersonalLeave=a.PersonalLeave,OtTime_0=a.OtTime_0,Absent=a.Absent,WorkTime_0=a.WorkTime_0,MaternityLeave=a.MaternityLeave,LateCount_0=a.LateCount_0,WorkTime_1=a.WorkTime_1,LeaveEarlyCount_0=a.LeaveEarlyCount_0,SickLeave=a.SickLeave,LeaveEarlyTime_0=a.LeaveEarlyTime_0,PublicHoliday=a.PublicHoliday,AnnualVacation=a.AnnualVacation,WorkTime_2=a.WorkTime_2,WorkDay_0=a.WorkDay_0,AnnualVacationRemanent=a.AnnualVacationRemanent
	from #totalyear a where a.attendmonth=attendancetotalyear.attendmonth and a.employeeid=attendancetotalyear.employeeid 
	
insert into attendancetotalyear (AttendMonth,EmployeeId,LateTime_0,InjuryLeave,WeddingLeave,OtherLeave,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,AbnormityCount_0,FuneralLeave,PersonalLeave,OtTime_0,Absent,WorkTime_0,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,PublicHoliday,AnnualVacation,WorkTime_2,WorkDay_0,AnnualVacationRemanent) 
	select @totalyear,employeeid,sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(OtherLeave,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AnnualVacation,0)),sum(isnull(WorkTime_2,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0)) 
		 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid not in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid
-- select @totalyear,employeeid,sum(isnull(WorkDay_1,0)),sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(LateCount_2,0)),sum(isnull(AbnormityCount_1,0)),sum(isnull(OtherLeave,0)),sum(isnull(OtTime_1,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(LeaveEarlyCount_1,0)),sum(isnull(OtTime_2,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(LateTime_2,0)),sum(isnull(LeaveEarlyCount_2,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(LateTime_1,0)),sum(isnull(WorkDay_2,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(LeaveEarlyTime_1,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AbnormityCount_2,0)),sum(isnull(AnnualVacation,0)),sum(isnull(LeaveEarlyTime_2,0)),sum(isnull(WorkTime_2,0)),sum(isnull(LateCount_1,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0)),sum(isnull(CompensatoryLeaveFree,0))
-- 	 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid not in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid

-- Select * into #totalyear from attendancetotalyear where 1=2
-- insert into #totalyear (attendmonth,employeeid,WorkDay_1,LateTime_0,InjuryLeave,WeddingLeave,LateCount_2,AbnormityCount_1,OtherLeave,OtTime_1,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,LeaveEarlyCount_1,OtTime_2,AbnormityCount_0,FuneralLeave,PersonalLeave,LateTime_2,LeaveEarlyCount_2,OtTime_0,Absent,WorkTime_0,LateTime_1,WorkDay_2,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,LeaveEarlyTime_1,PublicHoliday,AbnormityCount_2,AnnualVacation,LeaveEarlyTime_2,WorkTime_2,LateCount_1,WorkDay_0,AnnualVacationRemanent,CompensatoryLeaveFree)
-- 	select @totalyear,employeeid,sum(isnull(WorkDay_1,0)),sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(LateCount_2,0)),sum(isnull(AbnormityCount_1,0)),sum(isnull(OtherLeave,0)),sum(isnull(OtTime_1,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(LeaveEarlyCount_1,0)),sum(isnull(OtTime_2,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(LateTime_2,0)),sum(isnull(LeaveEarlyCount_2,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(LateTime_1,0)),sum(isnull(WorkDay_2,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(LeaveEarlyTime_1,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AbnormityCount_2,0)),sum(isnull(AnnualVacation,0)),sum(isnull(LeaveEarlyTime_2,0)),sum(isnull(WorkTime_2,0)),sum(isnull(LateCount_1,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0)),sum(isnull(CompensatoryLeaveFree,0))
-- 		 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid
-- Update attendancetotalyear set WorkDay_1=a.WorkDay_1,LateTime_0=a.LateTime_0,InjuryLeave=a.InjuryLeave,WeddingLeave=a.WeddingLeave,LateCount_2=a.LateCount_2,AbnormityCount_1=a.AbnormityCount_1,OtherLeave=a.OtherLeave,OtTime_1=a.OtTime_1,LactationLeave=a.LactationLeave,VisitLeave=a.VisitLeave,OnTrip=a.OnTrip,CompensatoryLeave=a.CompensatoryLeave,LeaveEarlyCount_1=a.LeaveEarlyCount_1,OtTime_2=a.OtTime_2,AbnormityCount_0=a.AbnormityCount_0,FuneralLeave=a.FuneralLeave,PersonalLeave=a.PersonalLeave,LateTime_2=a.LateTime_2,LeaveEarlyCount_2=a.LeaveEarlyCount_2,OtTime_0=a.OtTime_0,Absent=a.Absent,WorkTime_0=a.WorkTime_0,LateTime_1=a.LateTime_1,WorkDay_2=a.WorkDay_2,MaternityLeave=a.MaternityLeave,LateCount_0=a.LateCount_0,WorkTime_1=a.WorkTime_1,LeaveEarlyCount_0=a.LeaveEarlyCount_0,SickLeave=a.SickLeave,LeaveEarlyTime_0=a.LeaveEarlyTime_0,LeaveEarlyTime_1=a.LeaveEarlyTime_1,PublicHoliday=a.PublicHoliday,AbnormityCount_2=a.AbnormityCount_2,AnnualVacation=a.AnnualVacation,LeaveEarlyTime_2=a.LeaveEarlyTime_2,WorkTime_2=a.WorkTime_2,LateCount_1=a.LateCount_1,WorkDay_0=a.WorkDay_0,AnnualVacationRemanent=a.AnnualVacationRemanent,CompensatoryLeaveFree=a.CompensatoryLeaveFree
-- 	from #totalyear a where a.attendmonth=attendancetotalyear.attendmonth and a.employeeid=attendancetotalyear.employeeid 
-- 	
-- insert into attendancetotalyear (AttendMonth,EmployeeId,WorkDay_1,LateTime_0,InjuryLeave,WeddingLeave,LateCount_2,AbnormityCount_1,OtherLeave,OtTime_1,LactationLeave,VisitLeave,OnTrip,CompensatoryLeave,LeaveEarlyCount_1,OtTime_2,AbnormityCount_0,FuneralLeave,PersonalLeave,LateTime_2,LeaveEarlyCount_2,OtTime_0,Absent,WorkTime_0,LateTime_1,WorkDay_2,MaternityLeave,LateCount_0,WorkTime_1,LeaveEarlyCount_0,SickLeave,LeaveEarlyTime_0,LeaveEarlyTime_1,PublicHoliday,AbnormityCount_2,AnnualVacation,LeaveEarlyTime_2,WorkTime_2,LateCount_1,WorkDay_0,AnnualVacationRemanent,CompensatoryLeaveFree) 
-- 	select @totalyear,employeeid,sum(isnull(WorkDay_1,0)),sum(isnull(LateTime_0,0)),sum(isnull(InjuryLeave,0)),sum(isnull(WeddingLeave,0)),sum(isnull(LateCount_2,0)),sum(isnull(AbnormityCount_1,0)),sum(isnull(OtherLeave,0)),sum(isnull(OtTime_1,0)),sum(isnull(LactationLeave,0)),sum(isnull(VisitLeave,0)),sum(isnull(OnTrip,0)),sum(isnull(CompensatoryLeave,0)),sum(isnull(LeaveEarlyCount_1,0)),sum(isnull(OtTime_2,0)),sum(isnull(AbnormityCount_0,0)),sum(isnull(FuneralLeave,0)),sum(isnull(PersonalLeave,0)),sum(isnull(LateTime_2,0)),sum(isnull(LeaveEarlyCount_2,0)),sum(isnull(OtTime_0,0)),sum(isnull(Absent,0)),sum(isnull(WorkTime_0,0)),sum(isnull(LateTime_1,0)),sum(isnull(WorkDay_2,0)),sum(isnull(MaternityLeave,0)),sum(isnull(LateCount_0,0)),sum(isnull(WorkTime_1,0)),sum(isnull(LeaveEarlyCount_0,0)),sum(isnull(SickLeave,0)),sum(isnull(LeaveEarlyTime_0,0)),sum(isnull(LeaveEarlyTime_1,0)),sum(isnull(PublicHoliday,0)),sum(isnull(AbnormityCount_2,0)),sum(isnull(AnnualVacation,0)),sum(isnull(LeaveEarlyTime_2,0)),sum(isnull(WorkTime_2,0)),sum(isnull(LateCount_1,0)),sum(isnull(WorkDay_0,0)),sum(isnull(AnnualVacationRemanent,0)),sum(isnull(CompensatoryLeaveFree,0))
-- 		 from attendancetotal where left(attendmonth,4)=left(@strmonth,4) and employeeid not in (select distinct employeeid from attendancetotalyear where left(attendmonth,4)=left(@strmonth,4) and len(attendmonth)=4) group by employeeid

if object_id('tempdb..#totalyear') is not null drop table #totalyear

IF OBJECT_ID('tempdb..#Attendancedetail') IS NOT NULL DROP TABLE #Attendancedetail

select @Recordnum=count(*) from totalmonth where postmonth= @strmonth 
set @recordnum=isnull(@recordnum,0)

if @recordnum>0
	begin
	if @strTotalType<>'3'
		Exec ('update totalmonth set startdate='''+@StartDate+''',enddate='''+@EndDate+''' where postmonth=''' + @strmonth+'''')
	end
else
	begin
		Exec ('insert into totalmonth (postmonth,startdate,enddate) values (''' +@strmonth +''','''+@StartDate+''','''+@EndDate+''')')
-- 		if right(@strmonth,2)='01' --and (@strtotaltype='1' or @strtotaltype='2') ����һ��ͳ��Ϊһ��ĵ�һ����ʱ����������ʣ�����
-- 			begin
-- 				Declare @blnContinueNext bit
-- 				select @blnContinueNext=cast(variablevalue as bit) from options where variablename='blnContinueNext'
-- 				if @blncontinuenext=1 --��������
-- 					begin
-- 						update attendancetotalyear set AnnualVacationRemanent= employees.AnnualVacation-attendancetotalyear.AnnualVacation --+attendancetotalyear.AnnualVacationRemanent
-- 							from employees 
-- 							where attendancetotalyear.employeeid=employees.employeeid and left(attendancetotalyear.AttendMonth,4)=cast(cast(left(@strmonth,4) as int)-1 as varchar(4))
-- 						update attendancetotalyear set AnnualVacationRemanent=0 where AttendMonth=@strmonth and AnnualVacationRemanent<0
-- 					end
-- 			end
	end

	Declare @oCode int
	declare @onote varchar(100)
	--20150412 mike ȥ�����
	--exec pUpdateAnnualVacation @ocode output,@onote output
	Update Options set VariableValue='' where VariableName='strTotal'

GO
