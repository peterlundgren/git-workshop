all: presentation.pdf

# Run twice for table of contents
presentation.pdf: $(wildcard *.tex)
	latexmk -xelatex --shell-escape presentation.tex

.PHONY: clean
clean:
	rm -f *.aux *.dvi *.nav *.out *.snm *.toc *.pdf
