all: presentation.pdf

# Run twice for table of contents
presentation.pdf: $(wildcard *.tex)
	xelatex presentation.tex
	xelatex presentation.tex

.PHONY: clean
clean:
	rm -f *.aux *.dvi *.nav *.out *.snm *.toc *.pdf
