# Slides LGJ1
Slides pour le cours de Java en BAC1 à l'ÉSI, [HEB-ÉSI](http://www.heb.be/esi)

Contact : Marco Codutti<mcodutti@heb.be>

## Dépendances
Pour pouvoir créer les slides, vous aurez besoin des outils suivants :
- make
- rubber
- pdfnup
- classe Prosper 
- TODO : indiquer les packages LaTeX nécessaires

##  Créer les slides
Les slides sont créés via un *Makefile*

- `make clean` : Efface les fichiers temporaires et les PDF
- `make chapter` (défaut) : crée les PDF pour chaque leçon (un répertoire
  "build" doit exister, le créer si necessaire)
- `make all` : crée en plus le PDF complet en couleur et en N/B pour l'impression

## Contribuer
La structure des fichiers LaTeX est la suivante.

* Pour la version couleur :
	java1-presentation.tex
	java1-presentation-common.tex
	java.sty
	toc.tex
	chapter*.tex

* Pour la version N/B :
	java1-presentation-print.tex
	//... idem version couleur

* Les images sont dans le dossier *img*

Pour contribuer à une leçon, il vous suffit d'éditer le fichier `chapitre*.tex` correspondant

## Remarques

- Les fichiers .tex et .sty sont en latin1 car en utf8, le package listings pose des problèmes (accents non reconnus)


(TODO : vérifier si c'est toujours le cas)

