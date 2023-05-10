-- Insert Tables
-- Hilton Wong 100385078 (MS SQL Server Expert)
--USE [GroupProject]

-- Insert data into ParkingLot table
INSERT INTO ParkingLot (LotNum) VALUES (1), (2), (3);

-- Insert data into ParkingLotBlock table
INSERT INTO ParkingLotBlock (LotNum, BlockNum) VALUES (1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (3, 1);

-- Insert data into ParkingLotBlockStall table
INSERT INTO ParkingLotBlockStall (LotNum, BlockNum, StallNum, Size, Type) VALUES 
  (1, 1, 1, 'Compact', 'Standard'),
  (1, 1, 2, 'Compact', 'Standard'),
  (1, 2, 1, 'Regular', 'Handicapped'),
  (1, 2, 2, 'Regular', 'Handicapped'),
  (1, 3, 1, 'Large', 'Electric'),
  (2, 1, 1, 'Regular', 'Standard'),
  (2, 1, 2, 'Regular', 'Standard'),
  (2, 2, 1, 'Regular', 'Handicapped'),
  (2, 2, 2, 'Regular', 'Handicapped'),
  (3, 1, 1, 'Compact', 'Electric');

-- Insert data into Vehicle table
INSERT INTO Vehicle (LicensePlate, VehicleType) VALUES 
  ('ABC123', 'Car'),
  ('DEF456', 'Truck'),
  ('GHI789', 'SUV'),
  ('PPP123', 'Car'),
  ('OOO123', 'Motorbike'),
  ('LLL123', 'Car'),
  ('KKK123', 'SUV'),
  ('AAA123', 'Car'),
  ('BBB123', 'Truck'),
  ('CCC213', 'MotorBike');


-- Insert data into Employee table
INSERT INTO Employee (EmployeeID) VALUES (1), (2), (3);

-- Insert data into Ticket table
INSERT INTO Ticket (TicketNum, FineAmount, DateIssued, TimeIssued, LotNum, BlockNum, StallNum, EmployeeID) VALUES 
  (1, 15.00, '2016-01-01', '10:01:00', 1, 1, 1, 1),
  (2, 20.00, '2017-12-10', '22:30:00', 1, 1, 1, 2),
  (3, 9.00, '2017-12-16', '15:45:00', 2, 2, 2, 1),
  (4, 25.00, '2023-03-18', '09:15:00', 1, 2, 1, 1),
  (5, 32.00, '2023-03-17', '10:30:00', 1, 3, 1, 2),
  (6, 40.00, '2023-03-15', '11:45:00', 2, 2, 2, 3);

-- Insert data into Pass table
INSERT INTO Pass (PassNum, ExpiryDate, Cost, PassType) VALUES 
  (1, '2017-12-06', 100.00, 'Monthly'),
  (2, '2023-03-31', 50.00, 'Weekly'),
  (3, '2023-03-10', 100.00, 'Monthly'),
  (4, '2023-04-15', 50.00, 'Weekly'),
  (5, '2023-01-31', 10.00, 'Daily'),
  (6, '2023-05-31', 10.00, 'Daily'),
  (7, '2023-08-14', 50.00, 'Weekly'),
  (8, '2023-02-27', 50.00, 'Weekly'),
  (9, '2023-02-15', 100.00, 'Monthly'),
  (10, '2023-04-29', 100.00, 'Monthly');

-- Insert data into VehiclePassStall table
INSERT INTO VehiclePassStall (ParkingDate, LicensePlate, PassNum, LotNum, BlockNum, StallNum) VALUES 
  ('2023-03-01', 'ABC123', 10, 1, 1, 1),
  ('2023-03-02', 'DEF456', 2, 1, 1, 2),
  ('2023-03-03', 'GHI789', 3, 1, 2, 1),
  ('2023-03-01', 'PPP123', 4, 1, 2, 2),
  ('2023-01-29', 'OOO123', 5, 1, 3, 1),
  ('2023-03-01', 'LLL123', 6, 2, 1, 1),
  ('2023-03-01', 'KKK123', 7, 2, 1, 2),
  ('2023-02-22', 'AAA123', 8, 2, 2, 1),
  ('2023-01-14', 'BBB123', 9, 2, 2, 2),
  ('2017-12-05', 'CCC213', 1, 1, 1, 1);
