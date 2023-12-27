#!/usr/bin/bash
#extract the document number from calc_number.tex file
calc_num=$(sed -n 's/.*calcnumber}{\(.*\)}/\1/p' calc_number.tex)
#Read the database and generate macro.tex
echo "Reading database..."
python3 ./read_database.py "$calc_num"
#Run the design software
echo "Running osoconn..."
./osoconn/osoconn -s ./design_files/standard.txt ./design_files/
#Summarize the results in results.tex
echo "Summarizing results..."
./summarize_results.sh
#Print the output and create attachement.tex
echo "Printing output..."
./print_output.sh
#Compile the calculation. This is required to be done twice for the
#the table of contents to be displayed properly.
echo "Compiling calculation..."
pdflatex calc.tex
pdflatex calc.tex
echo "DONE!"
