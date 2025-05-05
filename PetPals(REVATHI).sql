CREATE DATABASE PetPals;
USE PetPals;

CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(200)
);

CREATE TABLE Pets (
    PetID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Breed VARCHAR(100),
    Type VARCHAR(50),
    AvailableForAdoption BIT,
    OwnerID INT,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

CREATE TABLE Donations (
    DonationID INT PRIMARY KEY,
    DonorName VARCHAR(100),
    DonationType VARCHAR(50),
    DonationAmount DECIMAL(10,2),
    DonationItem VARCHAR(100),
    DonationDate DATETIME,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

CREATE TABLE AdoptionEvents (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(200)
);

CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY,
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

INSERT INTO Shelters (ShelterID, Name, Location) VALUES
(1, 'Pet Paradise', 'Chennai'),
(2, 'Kitty Kingdom', 'Bangalore'),
(3, 'Whisker Wonderland', 'Chennai'),
(4, 'Furry Friends', 'Villupuram');  
SELECT * FROM Shelters;

INSERT INTO Pets (PetID, Name, Age, Breed, Type, AvailableForAdoption, OwnerID, ShelterID) VALUES
(1, 'Simba', 2, 'Labrador', 'Dog', 1, 1, 1),
(2, 'Luna', 3, 'Persian', 'Cat', 1, 2, 2),
(3, 'Simba', 1, 'Orange', 'Cat', 1, NULL, 3),
(4, 'Brownie', 5, 'Beagle', 'Dog', 0, NULL, 4); 
SELECT * FROM Pets;

INSERT INTO Donations (DonationID, DonorName, DonationType, DonationAmount, DonationItem, DonationDate, ShelterID) VALUES
(1, 'Sab', 'Cash', 1000, NULL, '2024-12-01 10:00:00', 1),
(2, 'Lisa', 'Cash', 2000, 'Dog Bone', '2025-01-15 12:30:00', 1),
(3, 'Dia', 'Cash', 1500, NULL, '2025-03-20 09:15:00', 3),
(4, 'Rani', 'Item', NULL, 'Blankets', '2025-04-10 14:45:00', 4);
SELECT * FROM Donations;

INSERT INTO AdoptionEvents (EventID, EventName, EventDate, Location) VALUES
(1, 'Healthy Pups Fund', '2025-05-10 10:00:00', 'Pune'),
(2, 'Paws-itively', '2025-06-20 11:00:00', 'Bangalore'),
(3, 'Pawfest', '2025-07-25 09:00:00', 'Chennai'),
(4, 'Furry Friends Fair', '2025-08-15 10:30:00', 'Villupuram');
SELECT * FROM AdoptionEvents;

INSERT INTO Participants (ParticipantID, ParticipantName, ParticipantType, EventID) VALUES
(1, 'Indu', 'Adopter', 1),
(2, 'Kiara', 'Adopter', 3),
(3, 'Pet Paradise', 'Shelter', 1),
(4, 'Whisker Wonderland', 'Shelter', 4);

SELECT * FROM Participants;

SELECT Name, Age, Breed, Type FROM Pets
WHERE AvailableForAdoption = True;

SELECT * FROM Pets
WHERE AvailableForAdoption = TRUE;

SELECT ParticipantName, ParticipantType FROM Participants
WHERE EventID = 3;

SELECT Name, Age, Breed, Type FROM Pets
WHERE OwnerID IS NULL;

SELECT DISTINCT Breed FROM Pets
WHERE (Age BETWEEN 1 AND 3) OR (Age > 5);

SELECT DISTINCT Breed FROM Pets
WHERE Age BETWEEN 1 AND 5;

SELECT S.Name AS ShelterName, COALESCE(SUM(D.DonationAmount), 0) AS TotalDonation
FROM Shelters S
LEFT JOIN Donations D ON S.ShelterID = D.ShelterID
GROUP BY S.ShelterID, S.Name;

SELECT P.Name AS PetName, P.Breed, P.Type, S.Name AS ShelterName
FROM Pets P
JOIN Shelters S ON P.ShelterID = S.ShelterID
WHERE P.AvailableForAdoption = TRUE;

SELECT 
    DATE_FORMAT(DonationDate, '%M %Y') AS MonthYear,
    SUM(DonationAmount) AS TotalDonation
FROM Donations
GROUP BY YEAR(DonationDate), MONTH(DonationDate)
ORDER BY YEAR(DonationDate), MONTH(DonationDate);

SELECT COUNT(*) AS TotalParticipants
FROM Participants
WHERE EventID IN (
    SELECT EventID FROM AdoptionEvents WHERE Location = 'Chennai'
);

SELECT S.Name AS ShelterName, COUNT(*) AS AvailablePets
FROM Pets P
JOIN Shelters S ON P.ShelterID = S.ShelterID
WHERE P.AvailableForAdoption = TRUE
GROUP BY S.ShelterID;

SELECT S.Name AS ShelterName, E.EventName
FROM Shelters S
CROSS JOIN AdoptionEvents E;

SELECT S.Name AS ShelterName, COUNT(*) AS AdoptedPets
FROM Pets P
JOIN Shelters S ON P.ShelterID = S.ShelterID
WHERE P.AvailableForAdoption = FALSE
GROUP BY S.ShelterID
ORDER BY AdoptedPets DESC
LIMIT 1;









