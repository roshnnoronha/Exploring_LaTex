CREATE TABLE Projects (
    Project_Id INT NOT NULL AUTO_INCREMENT,
    Project_Name VARCHAR (100) NOT NULL,
    PRIMARY KEY (Project_Id)
);

CREATE TABLE Calculations (
    Calculation_Number VARCHAR(50) NOT NULL,
    Calculation_Title VARCHAR(250) NOT NULL,
    Project_Id INT NOT NULL,
    PRIMARY KEY (Calculation_Number),
    FOREIGN KEY (Project_Id) REFERENCES Projects(Project_Id)
); 
CREATE TABLE Revisions (
    Revision_Id INT NOT NULL AUTO_INCREMENT,
    Calculation_Number VARCHAR(50) NOT NULL,
    Revision_Date DATE NOT NULL, 
    Revision_Number INT NOT NULL,
    Purpose VARCHAR(50) NOT NULL,
    Prepared_By VARCHAR(50) NOT NULL,
    Reviewed_By VARCHAR(50) NOT NULL,
    Approved_By VARCHAR(50) NOT NULL,
    Status VARCHAR(6) NOT NULL, 
    PRIMARY KEY (Revision_Id),
    FOREIGN KEY (Calculation_Number) REFERENCES Calculations(Calculation_Number)
);

INSERT INTO Projects (Project_Name) VALUES ('Big Steel Plant');

INSERT INTO Calculations (Calculation_Number,Calculation_Title,Project_Id)
VALUES ('540001-CAL-STR-0001','Steel Design for Piprack PR-01',1),
    ('540001-CAL-STR-0002', 'Connection Design for Piperack PR-01',1),
    ('540001-CAL-CIV-0001', 'Foundation Design for Piperack PR-01',1);

INSERT INTO Revisions (Calculation_Number, Revision_Date, Revision_Number, Purpose,Prepared_By,Reviewed_By,Approved_By,Status)
VALUES 
    ('540001-CAL-STR-0001','2023-07-14',0,'Issued for Review','Roshn','Aravind','Samir','ISSUED'),
    ('540001-CAL-STR-0001','2023-08-21',1,'Issued for Construction', 'Roshn','Aravind','Samir','ISSUED'),
    ('540001-CAL-STR-0002','2023-07-25',0,'Issued for Review','Jim','Aravind','Samir','ISSUED'),
    ('540001-CAL-STR-0002','2023-08-13',1,'Re-issued for Review','Jim','Aravind','Samir','ISSUED'),
    ('540001-CAL-STR-0002','2023-09-01',2,'Issued for Construction','Jim','Aravind','Samir','WIP'),
    ('540001-CAL-CIV-0001','2023-06-04',0,'Issued for Review','Prasad','Kevin','Samir', 'ISSUED'),
    ('540001-CAL-CIV-0001','2023-07-10',1,'Issued for Construction','Ravi','Kevin','Samir','ISSUED');
