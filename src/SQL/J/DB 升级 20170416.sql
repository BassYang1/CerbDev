USE CerbDb
GO

--�������ֶ�ControllerTemplates
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'DepartmentCode')
	ALTER TABLE ControllerTemplates ADD DepartmentCode NTEXT NULL --���沿���б�����	


IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'EmployeeCode')
	ALTER TABLE ControllerTemplates ADD EmployeeCode NTEXT NULL --����ְԱ�б�����	

	
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'OtherCode')
	ALTER TABLE ControllerTemplates ADD OtherCode NTEXT NULL --Ԥ��,�������������ӵ�����	


IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'ControllerTemplates') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'ControllerTemplates') AND name = N'OnlyByCondition')
	ALTER TABLE ControllerTemplates ADD OnlyByCondition BIT NOT NULL DEFAULT(0) --����������, 1Ϊ���湴ѡ��,0��null ��ʾû��ѡ

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
	AND EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'EmployeeExpress')
	ALTER TABLE TempShifts DROP COLUMN EmployeeExpress --�����絽ʱ��

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'DepartmentCode')
	ALTER TABLE TempShifts ADD DepartmentCode NTEXT NULL --���沿���б�����	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'EmployeeCode')
	ALTER TABLE TempShifts ADD EmployeeCode NTEXT NULL --����ְԱ�б�����	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'TempShifts') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'TempShifts') AND name = N'OtherCode')
	ALTER TABLE TempShifts ADD OtherCode NTEXT NULL --Ԥ��,�������������ӵ�����

--��ε���AttendanceOndutyRule�������ֶ�
IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRule') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRule') AND name = N'DepartmentCode')
	ALTER TABLE AttendanceOndutyRule ADD DepartmentCode NTEXT NULL --���沿���б�����	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRule') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRule') AND name = N'OtherCode')
	ALTER TABLE AttendanceOndutyRule ADD OtherCode NTEXT NULL --Ԥ��,�������������ӵ�����

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND name = N'DepartmentCode')
	ALTER TABLE AttendanceOndutyRuleChange ADD DepartmentCode NTEXT NULL --���沿���б�����	

IF EXISTS(SElECT 1 FROM dbo.SYSOBJECTS WHERE Id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND XType = N'U')
	AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID(N'AttendanceOndutyRuleChange') AND name = N'OtherCode')
	ALTER TABLE AttendanceOndutyRuleChange ADD OtherCode NTEXT NULL --Ԥ��,�������������ӵ�����		

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

--���	
INSERT INTO LabelText(PageFolder, PageName, LabelId, LabelZhcnText, LabelZhtwText, LabelEnText, LabelCustomText)
SELECT 'Employees', NULL, 'Emp_Trip', '����', '����', 'Trip', '' 
	WHERE NOT EXISTS(SELECT 1 FROM LabelText WHERE PageFolder = 'Employees' AND LabelId = 'Emp_Trip');

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
	
--������ģ��ע�ᵽ�豸
if exists (select name from sysObjects where name = 'pRegCardTemplateRegister' and type = 'p')
	drop Procedure pRegCardTemplateRegister
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[pRegCardTemplateRegister]
( --ģ��Id
  @TemplateId VARCHAR(50),
  --ע�᷽ʽ��0Ϊ׷��ע�ᣨ��������ظ����ݣ���ע��Ŀ��ţ������κ��޸ģ�
  --1Ϊ����ע�ᣨ����ȫ�����ԭע�Ῠ�ţ���ע�ᣨע�⣺��ս���շ������豸���ݣ������Ӳ���ϵ����ݣ���
  @RegMode		bit = 0,  
  --��ģ���������ɸѡע����Ա������Ϊ�ձ�ʾ��ģ�������ȫ��ע��. ��ʽ��EmployeeIDֵ. �磺select EmployeeId from Employes where Employeeid In (1,2,3)
  @WhereEmployee VARCHAR(2000) = '',     
 --��ģ���������ɸѡ�豸��Ϊ�ձ�ʾ��ģ�������ȫ��ע��	. ��ʽ��ͬ��
  @WhereControllerid VARCHAR(2000) = ''
)
AS
BEGIN	
	--DECLARE @TemplateId VARCHAR(50) = 51,	DECLARE @TemplateId VARCHAR(50) = 73,
			--@RegMode		bit = 1,  
			--@WhereEmployee VARCHAR(2000) = 'Select Employeeid from Employees where DepartmentID in (select DepartmentID from RoleDepartment where UserId in (5) and Permission=1) and Left(IncumbencyStatus,1)<>''1''',     
			--@WhereControllerid VARCHAR(2000) = 'select ControllerID from RoleController where UserId in (5) and Permission=1'

	DECLARE @strSQL nvarchar(max)
	DECLARE @strEmController VARCHAR(1000)
	DECLARE @strEmCode VARCHAR(4000) --Ա��Id
	DECLARE @strDeptCode VARCHAR(4000) --����Id
	DECLARE @strOtherCode VARCHAR(4000) --��������
	DECLARE @strEmployeeScheID VARCHAR(100)
	DECLARE @strEmployeeDoor VARCHAR(100)
	DECLARE @strValidateMode VARCHAR(100)
	DECLARE @OnlyByCondition bit

	SET NOCOUNT ON
	--��ģ����ȡ����ֶ�
	SELECT @strEmCode=EmployeeCode,@strDeptCode=DepartmentCode,@strOtherCode=OtherCode,@strEmController=ISNULL(EmployeeController,''),
			@strEmployeeScheID=ISNULL(EmployeeScheID,''),@strEmployeeDoor=ISNULL(EmployeeDoor,''),@strValidateMode=ValidateMode,@OnlyByCondition=isnull(OnlyByCondition,0)
			FROM ControllerTemplates where TemplateType=4 and TemplateId=+@TemplateId
				
	if ISNULL(@strEmCode,'') != '' and left(rtrim(ltrim(@strEmCode)), 1) <> '0'
	begin
		Set @strEmCode = '( EmployeeId in ('+ @strEmCode + '))'

		if ISNULL(@strDeptCode,'') != '' and left(rtrim(ltrim(@strDeptCode)), 1) <> '0'
			Set @strEmCode = '(' + @strEmCode + ' or (Departmentid In(' + @strDeptCode + ')))'	
	end
	else
	begin
		if ISNULL(@strDeptCode,'') != '' and left(rtrim(ltrim(@strDeptCode)), 1) <> '0'
			Set @strEmCode = '(Departmentid In(' + @strDeptCode + '))'	
	end		
	
	if ISNULL(@strEmCode,'') != '' 
		Set @strEmCode = 'select EmployeeId from Employees where Left(IncumbencyStatus,1) != ''1'' and '+ @strEmCode
	else 
	Begin
		Set @strEmCode = 'select EmployeeId from Employees where Left(IncumbencyStatus,1) != ''1'''		
	End
	
	--WhereEmployee ��������ֱ�Ӳ��뵽strEmCode�У���Ϊ���ѡ�񡾽���������ע�᡿Ҫɾ���������е���Ա��  WhereEmployeeһ�����ڽӿ�ͬ��ʱ�������б䶯����Ա��Ϣ
	--IF @WhereEmployee <> '' 
	--	Set @strEmCode = @strEmCode + ' and EmployeeId IN (' + @WhereEmployee+')'	
		
	--��ȡ��Ҫע����豸�������豸ID������#TempConId��
	IF object_id('tempdb.dbo.#TempConId') IS not null
		DROP TABLE #TempConId

	Create Table #TempConId(ControllerId int null)
	Set @strSQL = 'INSERT #TempConId SELECT ControllerId  From Controllers '
	IF left(@strEmController,1)='0'
		 Set @strSQL = @strSQL + ' where ControllerId > 0 '
	Else
		Set @strSQL = @strSQL + ' where ControllerId in ('+@strEmController+') '

	--@WhereControllerid ��������ֱ�Ӳ��뵽@strEmController�У�ͬ@WhereEmployee
	--IF @WhereControllerid <> '' 
	--	Set @strSQL = @strSQL + ' and ControllerId in ('+@WhereControllerid+') '

	Exec(@strSQL)

	----ע��ʱ�����ǰʱ���IDû���豸ʱ����У�����һ��ScheduleCode��С��û��δע���ʱ���ļ�¼�����浱ǰʱ���ID
	IF @strEmployeeScheID <> ''
	BEGIN
		Set @strSQL = 'update CS set TemplateId='+@strEmployeeScheID+',TemplateName=(select top 1 TemplateName from ControllerTemplates where TemplateId='+@strEmployeeScheID+' ),Status=0 
						From ControllerSchedule CS 
						where CS.ScheduleCode=(select MIN(ScheduleCode) From ControllerSchedule CS2 
									where CS.Controllerid=CS2.Controllerid and (ISNULL(CS2.TemplateId,0)=0 or ISNULL(CS2.TemplateId,'''')='''')  ) 
							and CS.Controllerid in (Select Controllerid from #TempConId ) 
							and CS.ControllerId NOT IN(select Controllerid from ControllerSchedule where TemplateId='+@strEmployeeScheID+' ) ' 
	End
	EXEC(@strSQL)

	--set @RegMode = 0
	
	if @RegMode=1 
	Begin
		--����ע�ᣬ��ɾ������ע��
		Set @strSQL = 'delete from ControllerEmployee where ControllerId in (select ControllerId from #TempConId) 
						and EmployeeId in (select EmployeeId from ('+@strEmCode+') A ); ' --ɾ��������ע��
						
		Set @strSQL = @strSQL+'insert into ControllerEmployee(ControllerId,Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag,Status, ValidateMode) 
						select C.ControllerId, Emp.Employeeid, U.Userpassword,'''+@strEmployeeScheID+''','''+@strEmployeeDoor+''',0,0, '''+@strValidateMode+''' 
						from Controllers C,Employees Emp left join Users U on  Emp.Employeeid=U.Employeeid 
						where  Emp.EmployeeId in (select EmployeeId from ('+@strEmCode+') A ) and Left(Emp.IncumbencyStatus,1)!=''1'' and Emp.Card>0 
						and C.ControllerID in (select ControllerId from #TempConId) 
						and NOT EXISTS(SELECT 1 FROM ControllerEmployee AS CE 
							WHERE CE.Employeeid=Emp.Employeeid and CE.Controllerid = C.Controllerid 
							and CE.ControllerID in (select ControllerId from #TempConId) 
							and ISNULL(CE.deleteflag, 0) = 0 ) '
		Exec(@strSQL)	
	End
	Else
	Begin
		Set @strSQL = @strSQL+'insert into ControllerEmployee(ControllerId,Employeeid,UserPassword,ScheduleCode,EmployeeDoor,DeleteFlag,Status, ValidateMode) 
						select C.ControllerId, Emp.Employeeid, U.Userpassword,'''+@strEmployeeScheID+''','''+@strEmployeeDoor+''',0,0, '''+@strValidateMode+''' 
						from Controllers C,Employees Emp left join Users U on  Emp.Employeeid=U.Employeeid 
						where  Emp.EmployeeId in (select EmployeeId from ('+@strEmCode+') A ) '
		IF @WhereEmployee <> '' 
			Set @strSQL = @strSQL+' and Emp.EmployeeId IN (' + @WhereEmployee+')'
			
		Set @strSQL = @strSQL+'and Left(Emp.IncumbencyStatus,1)!=''1'' and Emp.Card>0 
						and C.ControllerID in (select ControllerId from #TempConId) '
		IF @WhereControllerid <> '' 
			Set @strSQL = @strSQL+' and C.ControllerID IN (' + @WhereControllerid+')'
			
		Set @strSQL = @strSQL+' and NOT EXISTS(SELECT 1 FROM ControllerEmployee AS CE 
							WHERE CE.Employeeid=Emp.Employeeid and CE.Controllerid = C.Controllerid 
							and CE.ControllerID in (select ControllerId from #TempConId) 
							and ISNULL(CE.deleteflag, 0) = 0 ) '
		--����������ע�ᡣɾ���������е�����
		if	@OnlyByCondition = 1
		begin
			set @strSQL = @strSQL+';update ControllerEmployee set deleteflag = 1, status = 0 where ControllerId in (select ControllerId from #TempConId) 
							and EmployeeId not in (select EmployeeId from ('+@strEmCode+') A ); ' --���ɾ����ǰδע���ڸ��豸�ϵ�Ա������
		end
		
		Exec(@strSQL)	
	End	
	
	
	
	UPDATE ControllerDataSync set SyncStatus=0 where Controllerid in (select ControllerId from #TempConId) and SyncType='register'
		
	IF object_id('tempdb.dbo.#TempConId') IS not null
		DROP TABLE #TempConId

	SET NOCOUNT OFF
END
GO


--����ģ��ע�ᵽ�豸
if exists (select name from sysObjects where name = 'pRegCardTemplateRegisterAll' and type = 'p')
	drop Procedure pRegCardTemplateRegisterAll
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROC [dbo].[pRegCardTemplateRegisterAll]
( 
 /*ע�⣺ִ��ע��ʱ��ģ��ID�Ӵ�С���򣬼���ע�����IDģ�塡*/

  --ע�᷽ʽ��0Ϊ׷��ע�ᣨ��������ظ����ݣ���ע��Ŀ��ţ������κ��޸ģ�
  --1Ϊ����ע�ᣨ����ȫ�����ԭע�Ῠ�ţ���ע�ᣨע�⣺��ս���շ������豸���ݣ������Ӳ���ϵ����ݣ���
  @RegMode		bit = 0,  
  --��ģ���������ɸѡע����Ա������Ϊ�ձ�ʾ��ģ�������ȫ��ע��. ��ʽ��EmployeeIDֵ. �磺select EmployeeId from Employes where Employeeid In (1,2,3)
  @WhereEmployee VARCHAR(2000) = '',     
 --��ģ���������ɸѡ�豸��Ϊ�ձ�ʾ��ģ�������ȫ��ע��	. ��ʽ��ͬ��
  @WhereControllerid VARCHAR(2000) = ''
)
AS
BEGIN	
	--DECLARE @RegMode		bit = 0,  
	--		@WhereEmployee VARCHAR(2000) = '',     
	--		@WhereControllerid VARCHAR(2000) = ''

	DECLARE @StrSQL NVARCHAR(2000)
	DECLARE @TemplateId VARCHAR(50)

	SET NOCOUNT ON

		if exists( select * from master.dbo.syscursors where cursor_name='RegCursor')
			DEALLOCATE  RegCursor 
	     
		set @strSQL='declare RegCursor cursor for select TemplateId from ControllerTemplates where TemplateType=4 order by TemplateId Desc '
		exec sp_executesql  @strSQL
	   
		OPEN RegCursor; --���α�
		FETCH NEXT FROM RegCursor INTO @TemplateId; --��ȡ��һ������,����ֵ�����ڱ�����
		WHILE @@FETCH_STATUS = 0
			BEGIN
				exec pRegCardTemplateRegister @TemplateId,@RegMode,@WhereEmployee,@WhereControllerid

				FETCH NEXT FROM RegCursor INTO @TemplateId; --��ȡ��һ������
			END
		CLOSE RegCursor; --�ر��α�
		DEALLOCATE RegCursor; --�ͷ��α�
	
	SET NOCOUNT OFF
END

GO