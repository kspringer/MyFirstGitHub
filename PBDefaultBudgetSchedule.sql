SELECT X.[xGroupCode] + ' - ' + X.[xGroupCodeDesc] AS BenefitGroup
	, right('0000' + X.[xGroupCode], 6) AS BenefitGroupSort
	, CASE 
		WHEN XBS.DayID IS NULL
			THEN CASE 
					WHEN ISNULL(XBS.CycleID, 0) = 2
						THEN 'Monthly'
					WHEN ISNULL(XBS.CycleID, 0) = 3
						THEN 'Bi-Monthly'
					WHEN ISNULL(XBS.CycleID, 0) = 4
						THEN 'Quarterly'
					WHEN ISNULL(XBS.CycleID, 0) = 5
						THEN 'Semi-Annually'
					WHEN ISNULL(XBS.CycleID, 0) = 6
						THEN 'Annually'
					END
		ELSE D.DayDesc
		END AS DayDesc
	, CASE 
		WHEN XBS.DayID IS NULL
			THEN CASE 
					WHEN ISNULL(XBS.CycleID, 0) = 2
						THEN 12
					WHEN ISNULL(XBS.CycleID, 0) = 3
						THEN 24
					WHEN ISNULL(XBS.CycleID, 0) = 4
						THEN 4
					WHEN ISNULL(XBS.CycleID, 0) = 5
						THEN 2
					WHEN ISNULL(XBS.CycleID, 0) = 6
						THEN 1
					END
		ELSE 26
		END AS HoursFrequency
	, HH.[HourCode] + ' - ' + HH.[HourCodeDesc] AS HoursCode
	, ISNULL(XBS.[NumberOfHourWorked], 0) AS NumberOfHourWorked
	, F.FrequencyCode
	, F.FrequencyCodeDesc
	, XBS.[OtherPayAmount]
	, XBS.[FirstCycleMonth]
	, XBS.[CycleDay]
	, HH.[HourCode]
	, HH.[HourCodeDesc]
	, XBS.[DayID]
	, XBS.[ShiftHeaderID]
	, XBS.[FrequencyID]
	, HH.[HourCategoryID]
	, XBS.[SeparateCheckID]
	, XBS.[ChangedUserID]
	, XBS.[ChangedDate]
	, XBS.[ActiveFlag]
	, XBS.[CycleID]
	, XBS.[xGroupBudgetPositionDefaultScheduleID]
	, XBS.[xGroupHeaderID]
	, XBS.[HourHeaderID]
FROM [LogosDB].[dbo].[xGroupBudgetPositionDefaultSchedule] XBS
JOIN [LogosDB].[dbo].[HourHeader] HH ON XBS.[HourHeaderID] = HH.[HourHeaderID]
JOIN [LogosDB].[dbo].[xGroupHeader] x ON XBS.[xGroupHeaderID] = X.[xGroupHeaderID]
LEFT OUTER JOIN [dbo].[Frequency] F ON XBS.[FrequencyID] = F.[FrequencyID]
LEFT OUTER JOIN [LogosDB].[dbo].[xGroupScheduleDay] d ON XBS.[DayID] = D.xGroupScheduleDayID
ORDER BY right('00000' + X.[xGroupCode], 6)
