
select * from AttendanceDetail where OnDutyDate = '2015-04-01'
select * from AttendanceDetail where Employeeid = 43 and OnDutyDate = '2015-04-01'
select * from AttendanceDetail where Employeeid = 25 and OnDutyDate = '2015-04-01'
select * from employees where name = '何世坛';
select * from employees where Employeeid = 25;
select * from departments where departmentId = 19;
select DISTINCT ShiftName from AttendanceShifts;
select DISTINCT ShiftName from AttendanceDetail;
select * from AttendanceShifts;
--update AttendanceShifts set ShiftName = '正常班' where ShiftName = 'aaa';

SELECT Dept.DepartmentId, Dept.DepartmentName, (
		SELECT COUNT(1)
		FROM Employees
		WHERE DepartmentId IN (SELECT DepartmentId
				FROM Departments
				WHERE 1 > 0
					AND DepartmentCode LIKE Dept.DepartmentCode + '%')
			AND IncumbencyStatus <> '1'
		) AS 'EmpCount', (
		SELECT COUNT(1)
		FROM (SELECT EmployeeId, OnDutyDate
			FROM AttendanceDetail
			WHERE ShiftName IN (SELECT ShiftName
					FROM AttendanceShifts
					WHERE Degree = 1)
				AND (OnDuty1 <> ''
					OR OffDuty1 <> '')
			UNION ALL
			SELECT EmployeeId, OnDutyDate
			FROM AttendanceDetail
			WHERE ShiftName IN (SELECT ShiftName
					FROM AttendanceShifts
					WHERE Degree = 2)
				AND (OnDuty1 <> ''
					OR OffDuty1 <> ''
					OR OnDuty2 <> ''
					OR OffDuty2 <> '')
			UNION ALL
			SELECT EmployeeId, OnDutyDate
			FROM AttendanceDetail
			WHERE ShiftName IN (SELECT ShiftName
					FROM AttendanceShifts
					WHERE Degree = 3)
				AND (OnDuty1 <> ''
					OR OffDuty1 <> ''
					OR OnDuty2 <> ''
					OR OffDuty2 <> ''
					OR OnDuty3 <> ''
					OR OffDuty3 <> '')
			) A
		WHERE A.OnDutyDate = '2015-04-01'
			AND A.EmployeeId IN (SELECT EmployeeId
				FROM Employees
				WHERE DepartmentId IN (SELECT DepartmentId
						FROM Departments
						WHERE 1 > 0
							AND DepartmentCode LIKE Dept.DepartmentCode + '%')
					AND IncumbencyStatus <> '1')
		) AS 'EmpTodayCount', (
		SELECT COUNT(1)
		FROM (SELECT EmployeeId, OnDutyDate
			FROM AttendanceDetail
			WHERE ShiftName IN (SELECT ShiftName
					FROM AttendanceShifts
					WHERE Degree = 1)
				AND LateTime1 > 0
			UNION ALL
			SELECT EmployeeId, OnDutyDate
			FROM AttendanceDetail
			WHERE ShiftName IN (SELECT ShiftName
					FROM AttendanceShifts
					WHERE Degree = 2)
				AND (LateTime1 > 0
					OR LateTime2 > 0)
			UNION ALL
			SELECT EmployeeId, OnDutyDate
			FROM AttendanceDetail
			WHERE ShiftName IN (SELECT ShiftName
					FROM AttendanceShifts
					WHERE Degree = 3)
				AND (LateTime1 > 0
					OR LateTime2 > 0
					OR LateTime3 > 0)
			) A
		WHERE A.OnDutyDate = '2015-04-01'
			AND A.EmployeeId IN (SELECT EmployeeId
				FROM Employees
				WHERE DepartmentId IN (SELECT DepartmentId
						FROM Departments
						WHERE 1 > 0
							AND DepartmentCode LIKE Dept.DepartmentCode + '%')
					AND IncumbencyStatus <> '1')
		) AS 'LateCount'
	, (
		SELECT COUNT(1)
		FROM AttendanceDetail
		WHERE PersonalLeave > 0
			AND EmployeeId IN (SELECT EmployeeId
				FROM Employees
				WHERE DepartmentId IN (SELECT DepartmentId
						FROM Departments
						WHERE 1 > 0
							AND DepartmentCode LIKE Dept.DepartmentCode + '%')
					AND IncumbencyStatus <> '1')
			AND OnDutyDate = '2015-04-01'
		) AS 'PrivateCount', (
		SELECT COUNT(1)
		FROM AttendanceDetail
		WHERE SickLeave > 0
			AND EmployeeId IN (SELECT EmployeeId
				FROM Employees
				WHERE DepartmentId IN (SELECT DepartmentId
						FROM Departments
						WHERE 1 > 0
							AND DepartmentCode LIKE Dept.DepartmentCode + '%')
					AND IncumbencyStatus <> '1')
			AND OnDutyDate = '2015-04-01'
		) AS 'SickCount', (
		SELECT COUNT(1)
		FROM AttendanceDetail
		WHERE OnTrip > 0
			AND EmployeeId IN (SELECT EmployeeId
				FROM Employees
				WHERE DepartmentId IN (SELECT DepartmentId
						FROM Departments
						WHERE 1 > 0
							AND DepartmentCode LIKE Dept.DepartmentCode + '%')
					AND IncumbencyStatus <> '1')
			AND OnDutyDate = '2015-04-01'
		) AS 'TripCount', (
		SELECT COUNT(1)
		FROM AttendanceDetail
		WHERE (AnnualVacation > 0
				OR InjuryLeave > 0
				OR WeddingLeave > 0
				OR MaternityLeave > 0
				OR FuneralLeave > 0
				OR CompensatoryLeave > 0
				OR PublicHoliday > 0
				OR OtherLeave > 0
				OR VisitLeave > 0
				OR LactationLeave > 0)
			AND EmployeeId IN (SELECT EmployeeId
				FROM Employees
				WHERE DepartmentId IN (SELECT DepartmentId
						FROM Departments
						WHERE 1 > 0
							AND DepartmentCode LIKE Dept.DepartmentCode + '%')
					AND IncumbencyStatus <> '1')
			AND OnDutyDate = '2015-04-01'
		) AS 'OtherCount', (
		SELECT COUNT(1)
		FROM AttendanceDetail
		WHERE Absent > 0
			AND nobrushcard != 1
			AND EmployeeId IN (SELECT EmployeeId
				FROM Employees
				WHERE DepartmentId IN (SELECT DepartmentId
						FROM Departments
						WHERE 1 > 0
							AND DepartmentCode LIKE Dept.DepartmentCode + '%')
					AND IncumbencyStatus <> '1')
			AND OnDutyDate = '2015-04-01'
		) AS 'AbsCount'
FROM (SELECT DepartmentId, DepartmentCode, DepartmentName
	FROM Departments
	WHERE DepartmentId IN (1)
		AND DepartmentId IN (SELECT DepartmentId
			FROM Departments
			WHERE 1 > 0)
	) Dept
ORDER BY DepartmentID DESC