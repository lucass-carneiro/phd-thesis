main_file_name = main
outputname = thesis

source_dir = ./src
out_dir = ./out

pdf:
	mkdir -p out
	lualatex -shell-escape -halt-on-error -aux-directory=${out_dir} -output-directory=${out_dir} ${source_dir}/${main_file_name}
	bibtex ${out_dir}/${main_file_name}||true
	lualatex -shell-escape -halt-on-error -aux-directory=${out_dir} -output-directory=${out_dir} ${source_dir}/${main_file_name}
	lualatex -shell-escape -halt-on-error -aux-directory=${out_dir} -output-directory=${out_dir} ${source_dir}/${main_file_name}
	mv ${out_dir}/${main_file_name}.pdf ${out_dir}/${outputname}.pdf

clean:
	rm -f ${out_dir}/${main_file_name}.{aux,bbl,blg,dvi,log,out,ps,toc,pdf}

labels:
	grep -rho "\\\label{[^}]*}" src | uniq -dc | sort
