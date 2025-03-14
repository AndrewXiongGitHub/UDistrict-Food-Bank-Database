USE udistrict_food_bank_db
GO

--Query to get the most active volunteers (with 3 or more events attended):
/*
Purpose: This query can be used to find the top 5 most active volunteers based on the number of events they've
participated in. 

Results: After running this query, we can see the top 5 volunteers with the most events attended. These volunteers are
Joni Elcok (4 events), Tessie Dwelley (with 3 events), Barbara-anne Baythrop (with 3 events), Geraldine Nesbeth (with 3 events), 
and Teriann Krahl (with 3 events). 

Managerial Implications: The query can help foodbank managers commend highly active and generous volunteers. Additionally,
the query can also help identify volunteers who may be good fits or deserving of leadership roles and responsibilities due
to their shown high committment.
*/

WITH VolunteerEventCount AS (
    SELECT vr.VolunteerID, VolunteerFirstName, VolunteerLastName, 
           COUNT(DISTINCT EventID) AS TotalEvents
    FROM Volunteer_Role AS vr
		JOIN Volunteers AS v ON vr.VolunteerID = v.VolunteerID
    GROUP BY vr.VolunteerID, VolunteerFirstName, VolunteerLastName
    HAVING COUNT(DISTINCT EventID) >= 3 
)
SELECT TOP 5 VolunteerFirstName, VolunteerLastName, TotalEvents
FROM VolunteerEventCount
ORDER BY TotalEvents DESC;

GO


--Query with a stored procedure to get event participation details of a specific volunteer
/*
Purpose: This SELECT query stored procedure gets all events that a specific volunteer participated in. On top of this,
it also gets the role, date, shift start and end times, and the location. 

Results: From the example result (using Volunteer Joni Elcock as the example), we can see that Joni has participated in 4 
different events. We can see the location of the event, the date, Joni's shift start and end times, as well as Joni's role
during the event. 

Managerial Implications: This query can help track volunteer history and analyze workload trends. Additionally, the query
can be used to match volunteers with suitable future events based on past engagement. Lastly, the query can also be used to
gain a general sense of volunteers' activity (like a personalized report so to speak). 
*/
CREATE OR ALTER PROCEDURE GetVolunteerEventParticipation 
(
    @FirstName VARCHAR(150),
    @LastName VARCHAR(150) 
)
AS
BEGIN

    SELECT VolunteerFirstName, VolunteerLastName, e.EventID, Location, Date, ShiftStart, 
           ShiftEnd, RoleName
    FROM Volunteer_Role AS vr
		JOIN Volunteers AS v ON vr.VolunteerID = v.VolunteerID
		JOIN Events AS e ON vr.EventID = e.EventID
		JOIN Roles AS r ON vr.RoleID = r.RoleID
    WHERE VolunteerFirstName = @FirstName AND VolunteerLastName = @LastName
    ORDER BY Date DESC;
END;


EXEC GetVolunteerEventParticipation 'Joni', 'Elcock';

GO

-- Query to find the top 5 donors based on total quantity donated
/*
Purpose: This query retrieves the top 5 donors who have contributed the highest quantity of donated items.

Results: The query will return the donor's ID, name, and the total quantity of items they have donated.

Managerial Implications: This query helps food bank managers identify and recognize the most significant contributors.
It can also aid in donor appreciation efforts and targeting potential high-impact donors for future contributions.
*/
SELECT TOP 5 Donors.DonorID, Donors.DonorName, SUM(Donor_Item.QuantityDonated) AS TotalQuantityDonated
FROM Donors
JOIN Donor_Item ON Donors.DonorID = Donor_Item.DonorID
GROUP BY Donors.DonorID, Donors.DonorName
ORDER BY TotalQuantityDonated DESC;
GO


-- Stored Procedure to Retrieve Donations within a Specific Date Range
/*
Purpose: This stored procedure retrieves all donations made within a user-defined date range.

Results: The query returns a list of donations including DonorID, ItemID, DonationDate, and QuantityDonated.

Managerial Implications: This query enables food bank managers to track donation trends over time.
It helps in identifying high-donation periods and can be useful for planning outreach efforts.
*/
CREATE OR ALTER PROCEDURE GetDonationsByDateRange
(
    @StartDate DATE,
    @EndDate DATE
)
AS
BEGIN
    SELECT DonorID, ItemID, DonationDate, QuantityDonated
    FROM Donor_Item
    WHERE DonationDate BETWEEN @StartDate AND @EndDate
    ORDER BY DonationDate ASC;
END;
GO

-- Execute the stored procedure
EXEC GetDonationsByDateRange '2024-05-01', '2024-07-31';
GO
--Your Queries here... 
