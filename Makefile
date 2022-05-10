TEX = pdflatex
BIB = bibtex8 --wolfgang
HT = make4ht

BIBFILE = fox.bib
CATEGORIES = nonref

all: cite-by-section.pdf

cite-by-section.html: cite-by-section.tex $(BIBFILE)
	@$(HT) cite-by-section
	@$(BIB) cite-by-section
	@$(HT) cite-by-section
	@sed 1,3d $@ | sed '1s/^/<!DOCTYPE html>/' > /tmp/cite-by-section.html
	mv /tmp/cite-by-section.html .

targ:
	@sed "1,3c\\\n<!DOCTYPE html>" cite-by-section.html | more

clean:
	rm -f *.{aux,pdf,dvi,log,out,bbl,blg,bcf,run.xml}
	rm -f databib.bst
	rm -f custom_bib_categories.tex

show_entry_types:
	perl -ne 'print "$&\n" if /^@\w+/' $(BIBFILE)| tr 'A-Z' 'a-z'|sort|uniq


custom_bib_categories.tex: $(BIBFILE)
	./create_bib_categories.pl $(BIBFILE) $(CATEGORIES)

cite-by-section.pdf: cite-by-section.tex $(BIBFILE)
	@$(TEX) cite-by-section
	@$(BIB) cite-by-section
	@$(TEX) cite-by-section
	@$(TEX) cite-by-section

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
