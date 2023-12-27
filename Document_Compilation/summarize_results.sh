#!/usr/bin/bash
echo "\newcommand{\cellwidth}{1.75cm}">result.tex
echo "\begin{table}[h]" >> result.tex
echo "\centering">> result.tex
echo "\ttfamily">>result.tex
echo "\begin{tabular}{m{\cellwidth}m{\cellwidth}m{\cellwidth}m{\cellwidth}m{\cellwidth}m{\cellwidth}m{\cellwidth}m{\cellwidth}}">> result.tex
echo "ID &Transfer force (N) & Shear force(N) &Support type &Beam &Support &Max Ratio  &Result\\\\">> result.tex
echo "\hline">> result.tex
for input_file in ./design_files/*.cin
do
    #get connection ID
    conn_id=$(sed -n 's/CONNECTION_ID \(.*\)/\1/p' $input_file)
    #get connection forces
    tf=$(sed -n 's/TRANSFER_FORCE \(.*\)/\1/p' $input_file)
    #get connection details
    sf=$(sed -n 's/SHEAR_FORCE \(.*\)/\1/p' $input_file)
    #get support type
    supp_type=$(sed -n 's/SUPPORT_TYPE \(.*\)/\1/p' $input_file)    
    supp_type=${supp_type/_/ }
    #get beam section 
    beam_section=$(sed -n 's/BEAM_SECTION \(.*\)/\1/p' $input_file)
    #get support section
    supp_section=$(sed -n 's/SUPPORT_SECTION \(.*\)/\1/p' $input_file)
    #get the corresponding output file name
    o_ext=".cou"
    output_file=${input_file/.cin/}${o_ext}
    if [ -e $output_file ]
    then
        #get maximum interation ratio
        ic=$(sed -n 's/Maximum utility ratio for connection \(.*\)| \(.*\)/\2/p' $output_file)
        #get design result
        res=$(sed -n 's/Connection is \(.*\)|.*/\1/p' $output_file)
    fi
    echo "$conn_id" >> result.tex
    echo "&$tf" >> result.tex
    echo "&$sf" >> result.tex
    echo "&$supp_type" >> result.tex
    echo "&$beam_section" >> result.tex
    echo "&$supp_section" >> result.tex
    echo "&$ic" >> result.tex
    echo "&$res\\\\" >> result.tex
done
echo "\hline">> result.tex
echo "\end{tabular}" >> result.tex
echo "\caption{Design Results}">> result.tex
echo "\label{tab:res_tab}" >> result.tex
echo "\end{table}">>result.tex
