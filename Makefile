TEX = pdflatex
BIB = bibtex8 --wolfgang

all: cite.pdf

clean:
	rm -f *.{aux,pdf,dvi,log,out,bbl,blg,bcf,run.xml}
	rm -f databib.bst

cite-by-section.pdf: cite-by-section.tex fox.bib
	$(TEX) cite-by-section
	$(BIB) cite-by-section
	$(TEX) cite-by-section

cite.pdf: cite.tex
	$(TEX) cite
	bibtex cite
	$(TEX) cite
	$(TEX) cite
cite2.pdf: cite2.tex
	$(TEX) cite2
	bibtex cite2
	$(TEX) cite2
	$(TEX) cite2

# #!/bin/bash
# for file in *.aux ; do
#  bibtex `basename $file .aux`
# done
