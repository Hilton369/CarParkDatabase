-- Create Tables
-- Hilton Wong 100385078 (MS SQL Server Expert)

/*
This feature:
"	DateIssued DATE DEFAULT GETDATE()," 
does not work on MySQL Serve 
*/
--USE [GroupProject]

CREATE TABLE ParkingLot(
	LotNum INT NOT NULL,
	PRIMARY KEY (LotNum)
);

CREATE TABLE ParkingLotBlock(
	LotNum INT NOT NULL,
	BlockNum INT NOT NULL,
	PRIMARY KEY (LotNum, BlockNum),
	FOREIGN KEY (LotNum) REFERENCES ParkingLot(LotNum) ON DELETE CASCADE
);

CREATE TABLE ParkingLotBlockStall(
	LotNum INT NOT NULL,
	BlockNum INT NOT NULL,
	StallNum INT NOT NULL,
	Size VARCHAR(10) NOT NULL,
	Type VARCHAR(15) NOT NULL,
	PRIMARY KEY (LotNum, BlockNum, StallNum),
	FOREIGN KEY (LotNum, BlockNum) REFERENCES ParkingLotBlock(LotNum, BlockNum) ON DELETE CASCADE,
);


CREATE TABLE Vehicle(
	LicensePlate VARCHAR(10) NOT NULL,
	VehicleType VARCHAR(20) NOT NULL,
	PRIMARY KEY (LicensePlate)
);

CREATE TABLE Employee(
	EmployeeID INT NOT NULL,
	PRIMARY KEY (EmployeeID)
);

CREATE TABLE Ticket(
	TicketNum INT NOT NULL,
	FineAmount DECIMAL(10,2) NOT NULL,
	DateIssued DATE DEFAULT GETDATE(),
	TimeIssued TIME NOT NULL,
	LotNum INT NOT NULL,
	BlockNum INT NOT NULL,
	StallNum INT NOT NULL,
	EmployeeID INT NOT NULL,
	PRIMARY KEY (TicketNum),
	FOREIGN KEY (LotNum, BlockNum, StallNum) REFERENCES ParkingLotBlockStall(LotNum, BlockNum, StallNum) ON DELETE CASCADE,
	FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);

CREATE TABLE Pass(
	PassNum INT NOT NULL,
	ExpiryDate DATE NOT NULL,
	Cost DECIMAL (10,2) NOT NULL,
	PassType VARCHAR(20) NOT NULL,
	PRIMARY KEY (PassNum)
);

CREATE TABLE VehiclePassStall(
	ParkingDate DATE NOT NULL,
	LicensePlate VARCHAR(10) NOT NULL,
	PassNum INT NOT NULL,
	LotNum INT NOT NULL,
	BlockNUM INT NOT NULL,
	StallNum INT NOT NULL,
	PRIMARY KEY (ParkingDate, LicensePlate, PassNum, LotNum, BlockNum, StallNum),
	FOREIGN KEY (LicensePlate) REFERENCES Vehicle(LicensePlate) ON DELETE CASCADE,
	FOREIGN KEY (PassNum) REFERENCES Pass(PassNum) ON DELETE CASCADE,
	FOREIGN KEY (LotNum, BlockNum, StallNum) REFERENCES ParkingLotBlockStall(LotNum, BlockNum, StallNum) ON DELETE CASCADE
);