USE master
DROP DATABASE IF EXISTS udistrict_food_bank_db
CREATE DATABASE udistrict_food_bank_db
GO

USE udistrict_food_bank_db
GO

-- TABLES:

--Roles
DROP TABLE IF EXISTS Roles;
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    RoleName VARCHAR(100) NOT NULL 
);

BULK INSERT Roles
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Roles.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Roles


--Events
DROP TABLE IF EXISTS Events;
CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Location VARCHAR(255) NOT NULL, 
    Date DATE NOT NULL,
    StartTime TIME NOT NULL
);

BULK INSERT Events
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Events.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Events


--Volunteers
DROP TABLE IF EXISTS Volunteers;
CREATE TABLE Volunteers (
    VolunteerID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    VolunteerFirstName VARCHAR(150) NOT NULL,  
    VolunteerLastName VARCHAR(150) NOT NULL   
);

BULK INSERT Volunteers
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Volunteers.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Volunteers


--Volunteer_Role
DROP TABLE IF EXISTS Volunteer_Role;
CREATE TABLE Volunteer_Role (
    VolunteerRoleID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    VolunteerID INT NOT NULL,
    RoleID INT NOT NULL,
    EventID INT NOT NULL,
    ShiftStart TIME NOT NULL,
    ShiftEnd TIME NOT NULL
);

BULK INSERT Volunteer_Role
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Volunteer_Role.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Volunteer_Role


--Inventory
DROP TABLE IF EXISTS Inventory;
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    ItemID INT NOT NULL,
    QuantityOnHand INT NOT NULL,
    ExpirationDate DATE NOT NULL
);

BULK INSERT Inventory
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Inventory.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Inventory


--Items
DROP TABLE IF EXISTS Items;
CREATE TABLE Items (
    ItemID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CategoryID INT NOT NULL,
    ItemName VARCHAR(255) NOT NULL, 
    ShelfLife VARCHAR(100) NOT NULL
);

BULK INSERT Items
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Items.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Items


--Categories
DROP TABLE IF EXISTS Categories;
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CategoryName VARCHAR(150) NOT NULL  
);

BULK INSERT Categories
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Categories.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Categories


--Donors
DROP TABLE IF EXISTS Donors;
CREATE TABLE Donors (
    DonorID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    DonorName VARCHAR(255) NOT NULL  
);

BULK INSERT Donors
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Donors.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Donors


--Donor_Item
DROP TABLE IF EXISTS Donor_Item;
CREATE TABLE Donor_Item (
    DonorItemID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    DonorID INT NOT NULL,
    ItemID INT NOT NULL,
    DonationDate DATE NOT NULL,
    QuantityDonated INT NOT NULL
);

BULK INSERT Donor_Item
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Donor_Item.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Donor_Item


--Recipients
DROP TABLE IF EXISTS Recipients;
CREATE TABLE Recipients (
    RecipientID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    RecipientName VARCHAR(255) NOT NULL 
);

BULK INSERT Recipients
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Recipients.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Recipients


--Distributions
DROP TABLE IF EXISTS Distributions;
CREATE TABLE Distributions (
    DistributionID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    RecipientID INT NOT NULL,
    ItemID INT NOT NULL,
    VolunteerID INT NOT NULL,
    QuantityDistributed INT NOT NULL,
    DistributionDate DATE NOT NULL
);

BULK INSERT Distributions
FROM 'C:\Users\xyadw\Documents\College\INFO 330\Project\Project Datasets\Distributions.csv'
WITH (
    FORMAT = 'csv',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

SELECT * FROM Distributions


-- FOREIGN KEYS:
ALTER TABLE Volunteer_Role
ADD CONSTRAINT FK_Volunteer_Role_Volunteers
FOREIGN KEY (VolunteerID) REFERENCES Volunteers(VolunteerID);

ALTER TABLE Volunteer_Role
ADD CONSTRAINT FK_Volunteer_Role_Roles
FOREIGN KEY (RoleID) REFERENCES Roles(RoleID);

ALTER TABLE Volunteer_Role
ADD CONSTRAINT FK_Volunteer_Role_Events
FOREIGN KEY (EventID) REFERENCES Events(EventID);

ALTER TABLE Inventory
ADD CONSTRAINT FK_Inventory_Items
FOREIGN KEY (ItemID) REFERENCES Items(ItemID);

ALTER TABLE Items
ADD CONSTRAINT FK_Items_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID); 

ALTER TABLE Donor_Item
ADD CONSTRAINT FK_Donor_Item_Donors
FOREIGN KEY (DonorID) REFERENCES Donors(DonorID);

ALTER TABLE Donor_Item
ADD CONSTRAINT FK_Donor_Item_Items
FOREIGN KEY (ItemID) REFERENCES Items(ItemID);

ALTER TABLE Distributions
ADD CONSTRAINT FK_Distributions_Recipients
FOREIGN KEY (RecipientID) REFERENCES Recipients(RecipientID);

ALTER TABLE Distributions
ADD CONSTRAINT FK_Distributions_Items
FOREIGN KEY (ItemID) REFERENCES Items(ItemID);

ALTER TABLE Distributions
ADD CONSTRAINT FK_Distributions_Volunteers
FOREIGN KEY (VolunteerID) REFERENCES Volunteers(VolunteerID);


-- CHECK CONSTRAINTS
ALTER TABLE Inventory
ADD CONSTRAINT CHK_Inventory_QuantityOnHand_NonNegative CHECK (QuantityOnHand >= 0);

ALTER TABLE Volunteer_Role
ADD CONSTRAINT CHK_Volunteer_Role_ShiftEnd_GreaterThan_ShiftStart CHECK (ShiftEnd > ShiftStart);

ALTER TABLE Distributions 
ADD CONSTRAINT CHK_QuantityDistributed CHECK (QuantityDistributed >= 0);

-- DEFAULT CONSTRAINTS
ALTER TABLE Distributions
ADD CONSTRAINT DF_Distributions_DistributionDate_Default DEFAULT GETDATE() FOR DistributionDate;

ALTER TABLE Donor_Item
ADD CONSTRAINT DF_Donor_Item_DonationDate_Default DEFAULT GETDATE() FOR DonationDate;

ALTER TABLE Events
ADD CONSTRAINT DF_Events_StartTime_Default DEFAULT '06:00:00' FOR StartTime;

GO

--USER-DEFINED FUNCTIONS (UDF):
--UDF1: Calculate the duration of a shift
CREATE FUNCTION CalculateShiftDuration (@ShiftStart TIME, @ShiftEnd TIME)
	RETURNS DECIMAL(4,2)
	AS
	BEGIN
		DECLARE @Duration DECIMAL(4,2);
		SET @Duration = DATEDIFF(MINUTE, @ShiftStart, @ShiftEnd) / 60.0;
		RETURN @Duration;
	END;

GO

--UDF2: Calculate the total quantity donated
CREATE FUNCTION CalculateTotalQuantityDonated (@DonorID INT)
	RETURNS INT
	AS
	BEGIN
		DECLARE @TotalQuantity INT;
		SELECT @TotalQuantity = SUM(QuantityDonated) 
		FROM Donor_Item 
		WHERE DonorID = @DonorID;
		RETURN ISNULL(@TotalQuantity, 0); 
	END;

GO

--UDF3: Calculate the number of volunteers at an event
CREATE FUNCTION CalculateEventVolunteerCount (@EventID INT)
	RETURNS INT
	AS
	BEGIN
		DECLARE @VolunteerCount INT;
		SELECT @VolunteerCount = COUNT(DISTINCT VolunteerID) 
		FROM Volunteer_Role 
		WHERE EventID = @EventID;
		RETURN ISNULL(@VolunteerCount, 0);
	END;

GO

--UDF4: Get the total number of items distributed to a recipient
CREATE FUNCTION dbo.GetTotalDistributed(@RecipientID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;
    
    SELECT @Total = SUM(QuantityDistributed)
    FROM Distributions
    WHERE RecipientID = @RecipientID;

    RETURN COALESCE(@Total, 0);
END;

GO

-- COMPUTED COLUMNS
--Computed column (contains UDF): ShiftDuration
ALTER TABLE Volunteer_Role
ADD ShiftDuration AS dbo.CalculateShiftDuration(ShiftStart, ShiftEnd);
GO

--Computed column (contains UDF): TotalQuantityDonated
ALTER TABLE Donors
ADD TotalQuantityDonated AS dbo.CalculateTotalQuantityDonated(DonorID);
GO

--Computed column (contains UDF): VolunteerCount
ALTER TABLE Events
ADD VolunteerCount AS dbo.CalculateEventVolunteerCount(EventID);
GO



GO
