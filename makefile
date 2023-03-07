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
	$(info "Adding extra pages")
	pdftk A=${out_dir}/${main_file_name}.pdf B=img/ficha_catalografica.pdf cat A1 B1 A3-end output ${out_dir}/${main_file_name}_1.pdf
	pdftk A=${out_dir}/${main_file_name}_1.pdf B=img/formulario_revisao.pdf cat A1-2 B1 A3-end output ${out_dir}/${main_file_name}_2.pdf
	pdftk A=${out_dir}/${main_file_name}_2.pdf B=img/ata_defesa.pdf cat A1-3 B1 A4-end output ${out_dir}/${outputname}.pdf
	rm ${out_dir}/${main_file_name}.pdf ${out_dir}/${main_file_name}_1.pdf ${out_dir}/${main_file_name}_2.pdf

clean:
	rm -f ${out_dir}/${main_file_name}.{aux,bbl,blg,dvi,log,out,ps,toc,pdf}

labels:
	grep -rho "\\\label{[^}]*}" src | uniq -dc | sort
