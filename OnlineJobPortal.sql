CREATE TABLE User (
    UserId INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Password VARCHAR(100),
    Phone VARCHAR(15),
    Address TEXT,
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Education VARCHAR(255),
    Experience TEXT,
    Resume VARCHAR(255),
    Role VARCHAR(20), -- 'Job Seeker' or 'Job Provider'
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);
Select*from user;

CREATE TABLE Jobs (
    JobId INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    CompanyName VARCHAR(255),
    State VARCHAR(100),
    Country VARCHAR(100),
    Salary VARCHAR(100),
    Description TEXT,
    Specialization TEXT,
    Qualification TEXT,
    Experience TEXT,
    CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    NoofPost INT,
    JobType VARCHAR(50),
    LastDatetoApply DATE,
    CompanyImage Varchar(255),
    Website VARCHAR(255),
    Email VARCHAR(255)
);
select*from jobs;

CREATE TABLE Contact (
    ContactId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Subject VARCHAR(255),
    Message TEXT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);
select*from Contact;

CREATE TABLE Country (
    CountryId INT AUTO_INCREMENT PRIMARY KEY,
    CountryName VARCHAR(100)
);
select*from country;

CREATE TABLE AppliedCandidates (
    ApplicationId INT AUTO_INCREMENT PRIMARY KEY,
    JobId INT,
    UserId INT,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    Resume VARCHAR(255),
    ApplyDate DATETIME DEFAULT CURRENT_TIMESTAMP
);
select*from AppliedCandidates;

CREATE VIEW ViewAppliedCandidates AS
SELECT 
    appliedcandidates.ApplicationId, 
    jobs.CompanyName, 
    jobs.Title, 
    user.Name, 
    user.Email, 
    user.Mobile, 
    user.UserId,
    appliedcandidates.ApplyDate, 
    appliedcandidates.Resume
FROM 
    AppliedCandidates
INNER JOIN jobs on appliedcandidates.JobId = jobs.JobId
INNER JOIN User ON appliedcandidates.UserId = user.UserId;

select * from viewappliedcandidates;



