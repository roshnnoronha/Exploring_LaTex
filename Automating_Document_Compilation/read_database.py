import mysql.connector
import sys
calc_number = [sys.argv[1]]
print (calc_number)
out = open('macros.tex','w')
db = mysql.connector.connect(
        host = 'localhost',
        user = 'roshn',
        password = 'password',
        database = 'calculations'
        )
cur = db.cursor()
stmt= """SELECT Calculation_Title, Project_Name 
FROM Calculations INNER JOIN Projects ON Calculations.Project_Id = Projects.Project_Id 
WHERE Calculation_Number = %s ;"""
cur.execute(stmt,calc_number)
res = cur.fetchone()
out.write('\\newcommand {\\calctitle}{'+ res[0] + '}\n')
out.write('\\newcommand {\\calcproject}{' + res[1] + '}\n')
stmt = """SELECT Revision_Number, Revision_Date, Purpose, Prepared_By, Reviewed_By, Approved_By 
FROM Calculations INNER JOIN Revisions ON Calculations.Calculation_Number = Revisions.Calculation_Number 
WHERE Calculations.Calculation_Number = %s AND Status = 'WIP';"""
cur.execute(stmt,calc_number)
res = cur.fetchone()
if res:
    out.write('\\newcommand {\\calcrevisionone}{' + str(res[0]) + '}\n')
    out.write('\\newcommand {\\calcdateone}{' + res[1].strftime('%d-%m-%Y') + '}\n')
    out.write('\\newcommand {\\calcpurposeone}{' + res[2] + '}\n')
    out.write('\\newcommand {\\calcpreparedbyone}{' + res[3] + '}\n')
    out.write('\\newcommand {\\calcreviewedbyone}{' + res[4] + '}\n')
    out.write('\\newcommand {\\calcapprovedbyone}{' + res[5] + '}\n')
stmt = """SELECT Revision_Number, Revision_Date, Purpose, Prepared_By, Reviewed_By, Approved_By 
FROM Calculations INNER JOIN Revisions ON Calculations.Calculation_Number = Revisions.Calculation_Number 
WHERE Calculations.Calculation_Number = %s AND Status = 'ISSUED'
ORDER BY Revision_Number DESC
LIMIT 2;"""
cur.execute(stmt,calc_number) 
res = cur.fetchall()
if res[0]:
    out.write('\\newcommand {\\calcrevisiontwo}{' + str(res[0][0]) + '}\n')
    out.write('\\newcommand {\\calcdatetwo}{' + res[0][1].strftime('%d-%m-%Y') + '}\n')
    out.write('\\newcommand {\\calcpurposetwo}{' + res[0][2] + '}\n')
    out.write('\\newcommand {\\calcpreparedbytwo}{' + res[0][3] + '}\n')
    out.write('\\newcommand {\\calcreviewedbytwo}{' + res[0][4] + '}\n')
    out.write('\\newcommand {\\calcapprovedbytwo}{' + res[0][5] + '}\n')
else:
    out.write('\\newcommand {\\calcrevisiontwo}{-}\n')
    out.write('\\newcommand {\\calcdatetwo}{-}\n')
    out.write('\\newcommand {\\calcpurposetwo}{-}\n')
    out.write('\\newcommand {\\calcpreparedbytwo}{-}\n')
    out.write('\\newcommand {\\calcreviewedbytwo}{-}\n')
    out.write('\\newcommand {\\calcapprovedbytwo}{-}\n')
if res[1]:
    out.write('\\newcommand {\\calcrevisionthree}{' + str(res[1][0]) + '}\n')
    out.write('\\newcommand {\\calcdatethree}{' + res[1][1].strftime('%d-%m-%Y') + '}\n')
    out.write('\\newcommand {\\calcpurposethree}{' + res[1][2] + '}\n')
    out.write('\\newcommand {\\calcpreparedbythree}{' + res[1][3] + '}\n')
    out.write('\\newcommand {\\calcreviewedbythree}{' + res[1][4] + '}\n')
    out.write('\\newcommand {\\calcapprovedbythree}{' + res[1][5] + '}\n')
else:
    out.write('\\newcommand {\\calcrevisionthree}{-}\n')
    out.write('\\newcommand {\\calcdatethree}{-}\n')
    out.write('\\newcommand {\\calcpurposethree}{-}\n')
    out.write('\\newcommand {\\calcpreparedbythree}{-}\n')
    out.write('\\newcommand {\\calcreviewedbythree}{-}\n')
    out.write('\\newcommand {\\calcapprovedbythee}{-}\n')
           
out.close()
cur.close()
db.close()
