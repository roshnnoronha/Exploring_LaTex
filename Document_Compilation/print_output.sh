#!/usr/bin/bash
#backup all existing pdf files in ~/PDF
mkdir ~/PDF/temp
mv ~/PDF/*.pdf ~/PDF/temp/
#iterate through all output files and print them
for file in ./design_files/*.cou
do
    if [ -f "$file" ]; then
        echo "Printing $file..."
        lpr -p -o media=Custom.9.5x11in $file
    fi
done
#wait till printing is done
sleep 2
#move all printed files from default folder to a folder under the current folder
if [ -d ./design_files/script_output_pdf_files ] 
then
    rm ./design_files/script_output_pdf_files/*.pdf
else
    mkdir ./design_files/script_output_pdf_files
fi
mv ~/PDF/*.pdf ./design_files/script_output_pdf_files/
#restore backup files and delete the temporary folder
mv ~/PDF/temp/* ~/PDF/
rm -d ~/PDF/temp

#crear contents and update attachement.tex
> ./attachment.tex
for file in ./design_files/script_output_pdf_files/*.pdf
do
    echo "\includepdf[pages=-]{$file}" >> ./attachment.tex
done


