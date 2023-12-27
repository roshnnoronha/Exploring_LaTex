    SELECT Revision_Number, Revision_Date, Purpose, Prepared_By, Reviewed_By, Approved_By 
    FROM Calculations INNER JOIN Revisions ON Calculations.Calculation_Number = Revisions.Calculation_Number 
    WHERE Calculations.Calculation_Number = '540001-CAL-STR-0002' AND Status = 'ISSUED';


SELECT Revision_Number, Revision_Date, Purpose, Prepared_By, Reviewed_By, Approved_By 
FROM Calculations INNER JOIN Revisions ON Calculations.Calculation_Number = Revisions.Calculation_Number 
WHERE Calculations.Calculation_Number = '540001-CAL-STR-0002' AND Status = 'WIP';

SELECT Calculation_Title, Project_Name 
FROM Calculations INNER JOIN Projects ON Calculations.Project_Id = Projects.Project_Id 
WHERE Calculation_Number = '540001-CAL-STR-0002';