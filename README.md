# Slides pour le cours de Java 1ère année à l'ESI 

[HEB-ÉSI](http://www.heb.be/esi)
Contact : <mcodutti@heb.be>

## Dépendances
Pour pouvoir créer les slides, il faut les outils suivants
- make
- rubber
- pdfnup
- classe Prosper 
- TODO : indiquer les packages LaTeX nécessaires

##  Créer les slides
Les slides sont créés via un *Makefile*

- make clean : Efface les fichiers temporaires et les PDF
- make chapter (défaut) : crée les PDF pour chaque leçon
- make all : crée en plus le PDF complet en couleur et en N/B pour l'impression

## Contribuer
La structure des fichiers LaTeX est la suivante.

Pour la version couleur :
	java1-presentation.tex
		java1-presentation-common.tex
			java.sty
			toc.tex
			chapter*.tex

Pour la version N/B :
	java1-presentation-print.tex
		//... idem version couleur

Les images sont dans le dossier *img*

Pour contribuer à une leçon, éditer le fichier chapitre*.tex correspondant

## Remarques

- Les fichiers .tex et .sty sont en latin1 car en utf8, le package listings pose des problèmes (accents non reconnus)
(TODO : vérifier si c'est toujours le cas)
- 

