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
