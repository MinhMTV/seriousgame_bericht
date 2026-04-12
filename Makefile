BASENAME=project
DISTNAME=project_latex
DISTFOLDER?=$(shell pwd)

# OS detection
OS=$(shell uname)

# pdf viewer
ifeq ($(OS), Darwin)
	VIEWER=open
	VIEWER_OPTIONS=
else
	VIEWER=acroread
	VIEWER_OPTIONS=/a "view=FitH"
endif


.PHONY: default
default: clean compile view

compile: 
	pdflatex $(BASENAME)
	bibtex $(BASENAME)
	pdflatex $(BASENAME)
	pdflatex $(BASENAME)

view:
	$(VIEWER) $(VIEWER_OPTIONS) $(BASENAME).pdf

zip: clean compile
	zip -9 -r --exclude=*.svn* $(BASENAME).zip imgs db.bib $(BASENAME).tex INSOproject.cls Makefile README.txt $(BASENAME).pdf

dist: zip
	cp $(BASENAME).zip $(DISTFOLDER)/$(DISTNAME).zip

.PHONY: clean
clean:
	rm -f *.aux *.bbl *.bla *.blg *.dvi *.loa *.lof *.log *.lot *.out *.pdf *.ps *.tdo *.toc *-blx.bib *run.xml comment.cut
	rm -f $(DISTNAME).zip
