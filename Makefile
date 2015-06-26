all: cite.pdf

clean:
	rm -f cite.{aux,pdf,dvi,log,out,bbl,blg}

cite.pdf: cite.tex
	pdflatex cite
	bibtex cite
	pdflatex cite
	pdflatex cite
