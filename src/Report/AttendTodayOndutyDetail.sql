SELECT e.EmployeeId, Name, Sex, Number, e.Card
	, Headship, (
		SELECT TOP 1 AS BrushTime
		FROM BrushCardAttend
		WHERE Employeeid = E.employeeid
			AND Convert(varchar(10), BrushTime, 121) = '2015-01-01'
		) AS BrushTime
FROM Employees E
WHERE EmployeeId IN (SELECT EmployeeId
		FROM AttendanceDetail
		WHERE ShiftName IN (SELECT ShiftName
				FROM AttendanceShifts
				WHERE Degree = 1)
			AND OnDutyDate = '2015-01-01'
			AND (OnDuty1 <> ''
				OR OffDuty1 <> '')
		UNION ALL
		SELECT EmployeeId
		FROM AttendanceDetail
		WHERE ShiftName IN (SELECT ShiftName
				FROM AttendanceShifts
				WHERE Degree = 2)
			AND OnDutyDate = '2015-01-01'
			AND (OnDuty1 <> ''
				OR OffDuty1 <> ''
				OR OnDuty2 <> ''
				OR OffDuty2 <> '')
		UNION ALL
		SELECT EmployeeId
		FROM AttendanceDetail
		WHERE ShiftName IN (SELECT ShiftName
				FROM AttendanceShifts
				WHERE Degree = 3)
			AND OnDutyDate = '2015-01-01'
			AND (OnDuty1 <> ''
				OR OffDuty1 <> ''
				OR OnDuty2 <> ''
				OR OffDuty2 <> ''
				OR OnDuty3 <> ''
				OR OffDuty3 <> ''))
	AND DepartmentId IN (SELECT D1.DepartmentId
		FROM Departments D1, Departments D2
		WHERE D1.DepartmentCode LIKE D2.DepartmentCode + '%'
			AND D2.DepartmentId = 26)
	AND IncumbencyStatus <> '1'


SELECT Employees.EmployeeId, Employees.Name, Employees.Sex, Employees.Number, Employees.Card
	, Employees.Headship, Employees.JoinDate, CASE WHEN isnull(A.AnnualVacation, 0) > 0 THEN 'Äê¼Ù' WHEN isnull(A.PersonalLeave, 0) > 0 THEN 'ÊÂ¼Ù' WHEN isnull(A.SickLeave, 0) > 0 THEN '²¡¼Ù' WHEN isnull(A.InjuryLeave, 0) > 0 THEN '¹¤‚û' WHEN isnull(A.WeddingLeave, 0) > 0 THEN '»é¼Ù ' WHEN isnull(A.MaternityLeave, 0) > 0 THEN '®a¼Ù' WHEN isnull(A.OnTrip, 0) > 0 THEN '³ö²î' WHEN isnull(A.OnTrip, 0) > 0 THEN '³ö²î' WHEN isnull(A.FuneralLeave, 0) > 0 THEN '†Ê¼Ù' WHEN isnull(A.CompensatoryLeave, 0) > 0 THEN 'Ña¼Ù' WHEN isnull(A.PublicHoliday, 0) > 0 THEN '·¨¶¨¼Ù' WHEN isnull(A.OtherLeave, 0) > 0 THEN 'ÆäËû¼Ù' WHEN isnull(A.LactationLeave, 0) > 0 THEN '²¸Èé¼Ù' WHEN isnull(A.VisitLeave, 0) > 0 THEN 'Ì½ÓH¼Ù' ELSE NULL END AS LeaveType
FROM Employees, AttendanceDetail A
WHERE Employees.EmployeeId = A.EmployeeId
	AND A.OnDutyDate = '2015-01-01'
	AND Employees.DepartmentId IN (SELECT D1.DepartmentId
		FROM Departments D1, Departments D2
		WHERE D1.DepartmentCode LIKE D2.DepartmentCode + '%'
			AND D2.DepartmentId = 26)
	AND Employees.IncumbencyStatus <> '1'
ORDER BY Employees.EmployeeId


SELECT EmployeeId, Name, Sex, Number, Card
	, Headship, JoinDate
FROM Employees
WHERE EmployeeId IN (SELECT EmployeeId
		FROM AttendanceDetail
		WHERE Absent > 0
			AND OnDutyDate = '2015-01-01')
	AND DepartmentId IN (SELECT D1.DepartmentId
		FROM Departments D1, Departments D2
		WHERE D1.DepartmentCode LIKE D2.DepartmentCode + '%'
			AND D2.DepartmentId = 26)
	AND IncumbencyStatus <> '1'

SELECT E.EmployeeId, Name, Sex, Number, E.Card
	, Headship, JoinDate, (
		SELECT TOP 1 AS BrushTime
		FROM BrushCardAttend
		WHERE Employeeid = E.employeeid
			AND Convert(varchar(10), BrushTime, 121) = '2015-01-01'
		) AS BrushTime
FROM Employees E
WHERE E.EmployeeId IN (SELECT EmployeeId
		FROM AttendanceDetail
		WHERE ShiftName IN (SELECT ShiftName
				FROM AttendanceShifts
				WHERE Degree = 1)
			AND OnDutyDate = '2015-01-01'
			AND LateTime1 > 0
		UNION ALL
		SELECT EmployeeId
		FROM AttendanceDetail
		WHERE ShiftName IN (SELECT ShiftName
				FROM AttendanceShifts
				WHERE Degree = 2)
			AND OnDutyDate = '2015-01-01'
			AND (LateTime1 > 0
				OR LateTime2 > 0)
		UNION ALL
		SELECT EmployeeId
		FROM AttendanceDetail
		WHERE ShiftName IN (SELECT ShiftName
				FROM AttendanceShifts
				WHERE Degree = 3)
			AND OnDutyDate = '2015-01-01'
			AND (LateTime1 > 0
				OR LateTime2 > 0
				OR LateTime3 > 0))
	AND DepartmentId IN (SELECT D1.DepartmentId
		FROM Departments D1, Departments D2
		WHERE D1.DepartmentCode LIKE D2.DepartmentCode + '%'
			AND D2.DepartmentId = 26)
	AND IncumbencyStatus <> '1'