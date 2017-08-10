SELECT AttendMonth, D.DepartmentName, E.EmployeeId, E.Name, E.Number
	, OtTime_0, (
		SELECT COUNT(1)
		FROM AttendanceDetail
		WHERE EmployeeId = E.EmployeeId
			AND AttendMonth = A.AttendMonth
			AND OtTime > 0
		) AS TotalCount, WorkTime_1, WorkTime_2
FROM AttendanceTotal A INNER JOIN Employees E ON A.EmployeeId = E.EmployeeId LEFT JOIN Departments D ON E.DepartmentId = D.DepartmentId
WHERE E.Name LIKE '%аж%'
	AND LEFT(IncumbencyStatus, 1) <> '1'
	AND AttendMonth = '2015-04'
ORDER BY E.EmployeeId DESC