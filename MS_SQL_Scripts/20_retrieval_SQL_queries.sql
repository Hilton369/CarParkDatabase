-- 20_retrieval_SQL_queries
-- Hilton Wong 100385078 (MS SQL Server Expert)
-- Zhanji Wang 100279543 (MySQL Expert)
USE [GroupProject]

--1) Display ParkingDate, LicensePlate, PassNum of each car and their corresponding Lot, block and stall number, sorted by lot, block and stall num.
SELECT * FROM VehiclePassStall
ORDER BY LotNum, BlockNum, StallNum;

--2) Count how many tickets issued by each employee
SELECT EmployeeID, COUNT(TicketNum) AS NumTickets 
FROM Ticket
GROUP BY EmployeeID;

--3) Display all license plates, lot/block/stall, ticket number of all vehicles that have a ticket
SELECT LicensePlate, T.LotNum, T.BlockNum, T.StallNum, TicketNum
FROM Ticket T, VehiclePassStall VPS
WHERE T.LotNum = VPS.LotNum AND T.BlockNum = VPS.BlockNUM AND T.StallNum = VPS.StallNUM AND VPS.ParkingDate <= T.DateIssued;

--4) Display all license plates, lot/block/stall of vehicles that have expired passes
SELECT LicensePlate, LotNum, BlockNum, StallNum
FROM VehiclePassStall VPS
JOIN Pass P ON P.PassNum = VPS.PassNum AND P.ExpiryDate < GETDATE()
ORDER BY LotNum, BlockNum, StallNum;

--5) Display the LotNum that has had the most cars parked in it.
SELECT LotNum, COUNT(LotNum) AS NoOfCars
FROM VehiclePassStall
GROUP BY LotNum
HAVING COUNT(LotNum) = (SELECT MAX(X.mycount)
						FROM (SELECT LotNum, COUNT(LotNum) mycount
						FROM VehiclePassStall
						GROUP BY LotNum) AS X);

--6) Display the average FineAmount for tickets
SELECT AVG(FineAmount) AS 'Average fine'
FROM Ticket;

--7) Display all TicketNum, FineAmount and EmployeeID of tickets that have a fine amount below the average
SELECT TicketNum, FineAmount, EmployeeID
FROM Ticket
WHERE FineAmount > (SELECT AVG(FineAmount)
					FROM Ticket);

--8) Display ParkingDate, LicensePlate, Lot/Block/StallNum of all cars that have no ticket
SELECT ParkingDate, VPS.LicensePlate, VPS.LotNum, VPS.BlockNUM, VPS.StallNum
FROM VehiclePassStall VPS
FULL JOIN TICKET T ON VPS.LotNum = T.LotNum AND VPS.BlockNum = T.BlockNum AND VPS.StallNum = T.StallNum
WHERE TicketNum IS NULL;

--9) Display the ParkingDate and LicensePlate of the first car parked in the carpark
SELECT ParkingDate, LicensePlate
FROM VehiclePassStall VPS
WHERE ParkingDate = (SELECT MIN(ParkingDate) FROM VehiclePassStall);

--10) Create a View that shows only LicensePlate, PassExpiry and ParkingDate of Trucks then using the view show the LicensePlate of Trucks with expired passes
GO
CREATE VIEW EmployeeUI AS
	SELECT VPS.LicensePlate, ParkingDate, ExpiryDate
	FROM VehiclePassStall VPS, Pass P, Vehicle V
	WHERE VPS.PassNum = P.PassNum AND VPS.LicensePlate = V.LicensePlate AND V.VehicleType = 'Truck';
GO
SELECT LicensePlate
FROM EmployeeUI
WHERE ExpiryDate < GETDATE();

--11. Which vehicles have passes that expire before June 1, 2023?
SELECT LicensePlate 
FROM VehiclePassStall 
WHERE PassNum IN (
  SELECT PassNum 
  FROM Pass 
  WHERE ExpiryDate < '2023-06-01'
);

--12. What is the total number of vehicles parked in each block of ParkingLotBlock?
SELECT VehiclePassStall.BlockNum, COUNT(DISTINCT LicensePlate) AS TotalVehicles 
FROM VehiclePassStall 
JOIN ParkingLotBlockStall ON VehiclePassStall.StallNum = ParkingLotBlockStall.StallNum 
GROUP BY VehiclePassStall.BlockNum;


--13. Display the license plate and type of vehicles parked in the lot, sorted by lot number and stall number.
SELECT v.LicensePlate, v.VehicleType 
FROM Vehicle v 
JOIN VehiclePassStall vps ON v.LicensePlate = vps.LicensePlate 
JOIN ParkingLotBlockStall pls ON vps.StallNum = pls.StallNum 
JOIN ParkingLotBlock plb ON pls.BlockNum = plb.BlockNum AND vps.LotNum = plb.LotNum 
ORDER BY vps.LotNum, vps.StallNum;

--14. Update the cost of a parking pass with PassNum 100 to $50.00.
UPDATE Pass 
SET Cost = 50.00 
WHERE PassNum = 100;

--15. Delete all VehiclePassStall entries for LicensePlate "ABC123".
DELETE FROM VehiclePassStall 
WHERE LicensePlate = 'ABC123';

--16. What is the minimum stall size for each block in the parking lot?
SELECT BlockNum, MIN(Size) AS MinSize 
FROM ParkingLotBlockStall 
GROUP BY BlockNum;

--17. Display the LicensePlate and PassType of vehicles with a pass that has the highest cost.
SELECT LicensePlate, PassType 
FROM VehiclePassStall 
WHERE PassNum IN
(SELECT PassNum FROM Pass WHERE Cost = (SELECT MAX(Cost) FROM Pass));

--18. What is the total number of tickets issued by each employee, including those who haven't issued any tickets?
SELECT Employee.EmployeeID, COUNT(Ticket.TicketNum) AS TotalTickets
FROM Employee LEFT JOIN Ticket ON Employee.EmployeeID = Ticket.EmployeeID
GROUP BY Employee.EmployeeID;

--19. Display the ParkingDate and number of vehicles parked for each day, sorted by the number of vehicles parked in descending order.
SELECT ParkingDate, COUNT(LicensePlate) AS NumVehicles
FROM VehiclePassStall GROUP BY ParkingDate ORDER BY NumVehicles DESC;

--20. Create a view that shows the StallNum, LotNum, BlockNum, and Type for each parking stall in the parking lot.
GO
CREATE VIEW ParkingStallInfo AS SELECT StallNum, ParkingLotBlockStall.LotNum, ParkingLotBlockStall.BlockNum, Type FROM ParkingLotBlockStall
INNER JOIN ParkingLotBlock ON ParkingLotBlockStall.BlockNum = ParkingLotBlock.BlockNum
INNER JOIN ParkingLot ON ParkingLotBlock.LotNum = ParkingLot.LotNum;
GO
