all: cite.pdf

clean:
	rm -f cite.{aux,pdf,dvi,log,out,bbl,blg}
	rm -f databib.bst

cite.pdf: cite.tex
	pdflatex cite
	bibtex cite
	pdflatex cite
	pdflatex cite
cite2.pdf: cite2.tex
	pdflatex cite2
	bibtex cite2
	pdflatex cite2
	pdflatex cite2

# #!/bin/bash
# for file in *.aux ; do
#  bibtex `basename $file .aux`
# done
