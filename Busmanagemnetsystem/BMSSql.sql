-- Create the database and switch to it
CREATE DATABASE BusManagementSystem;
USE BusManagementSystem;

-- Create and insert into Bus table
CREATE TABLE Bus (
    BusID INT PRIMARY KEY IDENTITY(1,1),
    BusNumber VARCHAR(50) NOT NULL,
    BusName VARCHAR(30),
    Capacity INT NOT NULL,
    Type VARCHAR(50),
    Source VARCHAR(100) NOT NULL,
    Destination VARCHAR(100) NOT NULL,
    Distance INT NOT NULL,
    DepartureTime TIME NOT NULL,
    ArrivalTime TIME NOT NULL,
    Date DATE
);

INSERT INTO Bus (BusNumber, BusName, Capacity, Type, Source, Destination, Distance, DepartureTime, ArrivalTime, Date)
VALUES 
    ('KA0101', 'Voyager', 100, 'AC', 'Bangalore', 'Chennai', 1500, '10:00', '13:00', '2024-06-07'),
    ('KA0202', 'Star Travels', 120, 'AC', 'Chennai', 'Bangalore', 1500, '11:00', '14:00', '2024-06-06'),
    ('KA0303', 'BMTC', 80, 'Non-AC', 'Mumbai', 'Pune', 200, '12:00', '15:00', '2024-06-07');

SELECT * FROM Bus;

-- Create and insert into Driver table
CREATE TABLE Driver (
    DriverID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    BusID INT FOREIGN KEY REFERENCES Bus(BusID),
    BusNumber VARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(15)
);

INSERT INTO Driver (Name, BusID, BusNumber, ContactNumber)
VALUES 
    ('Rajesh Kumar', 1, 'KA0101', '9876543210'),
    ('Suresh Reddy', 2, 'KA0202', '9876543211'),
    ('Anil Patel', 3, 'KA0303', '9876543212');

-- Create and insert into Maintenance table
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1),
    BusID INT FOREIGN KEY REFERENCES Bus(BusID),
    Date DATE NOT NULL,
    Description VARCHAR(1000)
);

INSERT INTO Maintenance (BusID, Date, Description)
VALUES 
    (1, '2024-06-08', 'Engine oil change and brake check');

-- Create and insert into User table
CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(15)
);

INSERT INTO [User] (Username, Password, Email, ContactNumber)
VALUES 
    ('Lavanya', 'lav123', 'lav@gmail.com', '9000000001'),
    ('Hema', 'hem123', 'hem@gmail.com', '9000000002');

-- Create and insert into Ticket table
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES [User](UserID),
    PassengerName VARCHAR(100) NOT NULL,
    SeatNumber VARCHAR(10) NOT NULL,
    NumberOfSeats INT NOT NULL,
    BusID INT FOREIGN KEY REFERENCES Bus(BusID),
    BusName VARCHAR(30),
    BookingDate DATE NOT NULL,
    Fare DECIMAL(10,2) NOT NULL
);

INSERT INTO Ticket (UserID, PassengerName, SeatNumber, NumberOfSeats, BusID, BusName, BookingDate, Fare)
VALUES 
    (1, 'Lavanya', 'A1', 2, 1, 'Voyager', '2024-06-01', 100.00),
    (2, 'Hema', 'A2', 1, 2, 'Star Travels', '2024-06-02', 200.00);

-- Create and insert into Payment table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    TicketID INT FOREIGN KEY REFERENCES Ticket(TicketID),
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50)
);
ALTER TABLE Payment
ADD UserID INT FOREIGN KEY REFERENCES [User](UserID);
select * from payment
drop table Payment
INSERT INTO Payment (TicketID, PaymentDate, Amount, PaymentMethod,userid)
VALUES 
    (1, '2024-06-01', 300.00, 'Credit Card',1),
    (2, '2024-06-01', 600.00, 'Debit Card',2);

-- Create and insert into Feedback table
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES [User](UserID),
    Comments VARCHAR(1000),
    Rating INT CHECK (Rating >= 1 AND Rating <= 5)
);

INSERT INTO Feedback (UserID, Comments, Rating)
VALUES 
    (1, 'Great service!', 5);

-- Create and insert into UserProfile table
CREATE TABLE UserProfile (
    UserProfileID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES [User](UserID),
    FullName VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10)
);

INSERT INTO UserProfile (UserID, FullName, Address, City, State, ZipCode)
VALUES 
    (1, 'Lavanya', '123 Main Street', 'Bangalore', 'Karnataka', '560001'),
    (2, 'Hema', '456 High Street', 'Mysore', 'Karnataka', '570002');

-- Create and insert into BookingHistory table
CREATE TABLE BookingHistory (
    BookingHistoryID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES [User](UserID),
    TicketID INT FOREIGN KEY REFERENCES Ticket(TicketID),
    BookingDate DATE NOT NULL,
    Status VARCHAR(50)
);

INSERT INTO BookingHistory (UserID, TicketID, BookingDate, Status)
VALUES 
    (1, 1, '2024-06-01', 'Confirmed'),
    (2, 2, '2024-06-02', 'Cancelled');

-- Create and insert into AvailableSeats table
CREATE TABLE AvailableSeats (
    BusID INT PRIMARY KEY,
    TotalSeats INT,
    AvailableSeats INT,
    FOREIGN KEY (BusID) REFERENCES Bus(BusID)
);
drop table availableseats

INSERT INTO AvailableSeats (BusID, TotalSeats, AvailableSeats)
VALUES
    (1, 10, 9),
    (2, 12, 11),
    (3, 8, 8);
drop table booking
-- Create and insert into Booking table
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES [User](UserID),
    From_Station VARCHAR(20),
    To_Station VARCHAR(20),
    Date DATE,
    BusID INT FOREIGN KEY REFERENCES Bus(BusID)
);
ALTER TABLE Booking ADD SeatNumber varchar(10);

INSERT INTO Booking (UserID, From_Station, To_Station, Date, BusID,seatnumber)
VALUES 
    (1, 'Bangalore', 'Chennai', '2024-06-07', 1,'A1,A2,A3'),
    (2, 'Chennai', 'Bangalore', '2024-06-06', 2,'B1');
CREATE TABLE Seat (
    SeatID INT PRIMARY KEY IDENTITY(1,1),
    BusID INT FOREIGN KEY REFERENCES Bus(BusID),
    SeatNumber VARCHAR(10) NOT NULL,
    IsAvailable BIT NOT NULL
);

-- Insert sample data into Seat table
-- Insert seats for BusID 1
INSERT INTO Seat (BusID, SeatNumber, IsAvailable)
VALUES 
    (1, 'A1', 1),
    (1, 'A2', 1),
    (1, 'A3', 1),
    (1, 'A4', 1),
    (1, 'A5', 1),
    (1, 'A6', 1),
    (1, 'A7', 1),
    (1, 'A8', 1),
    (1, 'A9', 1),
    (1, 'A10', 0); -- One seat already booked

-- Insert seats for BusID 2
INSERT INTO Seat (BusID, SeatNumber, IsAvailable)
VALUES 
    (2, 'B1', 1),
    (2, 'B2', 1),
    (2, 'B3', 1),
    (2, 'B4', 1),
    (2, 'B5', 1),
    (2, 'B6', 1),
    (2, 'B7', 1),
    (2, 'B8', 1),
    (2, 'B9', 1),
    (2, 'B10', 1),
    (2, 'B11', 1),
    (2, 'B12', 0); -- One seat already booked

-- Insert seats for BusID 3
INSERT INTO Seat (BusID, SeatNumber, IsAvailable)
VALUES 
    (3, 'C1', 1),
    (3, 'C2', 1),
    (3, 'C3', 1),
    (3, 'C4', 1),
    (3, 'C5', 1),
    (3, 'C6', 1),
    (3, 'C7', 1),
    (3, 'C8', 1); -- All seats available

-- Select all records from Seat table to verify insertion
SELECT * FROM Seat;

drop table seat
-- Select all records from each table
SELECT * FROM Bus;
SELECT * FROM Driver;
SELECT * FROM Maintenance;
SELECT * FROM [User];
SELECT * FROM Ticket;
SELECT * FROM Payment;
SELECT * FROM Feedback;
SELECT * FROM UserProfile;
SELECT * FROM BookingHistory;
SELECT * FROM AvailableSeats;
SELECT * FROM Booking;
drop table booking