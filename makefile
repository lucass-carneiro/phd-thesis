main_file_name = main
outputname = thesis

source_dir = ./src
out_dir = ./out

pdf:
	mkdir -p out
	bibtex ${source_dir}/${main_file_name}||true
	lualatex -halt-on-error -aux-directory=${out_dir} -output-directory=${out_dir} ${source_dir}/${main_file_name}
	lualatex -halt-on-error -aux-directory=${out_dir} -output-directory=${out_dir} ${source_dir}/${main_file_name}
	mv ${out_dir}/${main_file_name}.pdf ${out_dir}/${outputname}.pdf

clean:
	rm -f ${out_dir}/${main_file_name}.{aux,bbl,blg,dvi,log,out,ps,toc,pdf}
