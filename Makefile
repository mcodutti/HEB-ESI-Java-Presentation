# =============
# Configuration
# =============

# Noms des dossiers utilisés
# --------------------------
# Tous les sources sont dans SRC
# Tout se construit dans BUILD
# Les PDF finaux sont dans DIST

SRC   = sources
BUILD = build
DIST  = dist

# Noms utilisés pour les fichiers
# -------------------------------
# Le document maitre pour la version normale est  : NOM-COMPLET.tex
# Le document maitre pour la version N/B est      : NOM-PRINT.tex
# Le document maitre commun est                   : NOM-COMMON.tex
# Les différentes leçons sont dans les fichiers   : NOM-CHAPITRE-*.tex
# On donne également tous les fichiers de support dont dépendent les .tex

NOM-COMPLET  = java1-presentation
NOM-PRINT    = $(NOM-COMPLET)-print
NOM-CHAPITRE = chapitre
NOM-COMMON   = $(NOM-COMPLET)-master
SUPPORT      = $(SRC)/java.sty $(SRC)/toc.tex

# Options pour Rubber
# -------------------
# -v : verbeux
# -f : force au moins une compilation (je ne sais plus pourquoi c'est utile)
# --pdf : génère du PDF via pdflatex
# --into : Indique où générer les fichiers de la compilation

RUBBEROPT = -v -f --pdf --into $(BUILD) 

# =========================================
# Notes de syntaxe pour comprendre la suite
# =========================================

# wildcard : permet d'avoir une liste où les wildcard sont utilés
# basename : enlève l'extension
# notdir   : enlève les dossiers devant
# Dans une cible : '%' est l'équivalent du '*'
# Dans les dépendances et les règles, '$@' signifie la cible
# Dans les dépendances, $* signifie ce qui a été choisi pour le % dans la cible

# ====================================================
# On génère quelques noms à partir de la configuration
# ====================================================

TEX-COMPLET   = $(SRC)/$(NOM-COMPLET).tex
TEX-PRINT     = $(SRC)/$(NOM-PRINT).tex
TEX-COMMON    = $(SRC)/$(NOM-COMMON).tex

PDF-COMPLET   = $(DIST)/$(NOM-COMPLET).pdf
PDF-PRINT     = $(DIST)/$(NOM-PRINT).pdf

TEX-CHAPITRES   = $(wildcard $(SRC)/$(NOM-CHAPITRE)*.tex)
LISTE-CHAPITRES = $(basename $(notdir $(TEX-CHAPITRES)))
PDF-CHAPITRES   = $(addprefix $(DIST)/$(NOM-COMPLET)-, $(addsuffix .pdf, $(LISTE-CHAPITRES)))

# ==========================================
# Identifie les étapes à demander à Makefile
# ==========================================
# clean   : nettoye les dossiers DIST et BUILD
# chapter : crée les PDF pour les chapitres (les n° peuvent être mauvais)
# all     : les versions complètes + chapitres
#
# debug   : affiche le contenu des variables pour comprendre quand ça va pas
# par défaut : chapter 
# ==========================================

.PHONY: default
.PHONY: clean
.PHONY: chapter
.PHONY: all

default: chapter

# Nettoye tout
clean:
	@echo "On vide $(BUILD) et $(DIST)"
	@rm -rf $(BUILD) $(DIST)
	@mkdir $(BUILD)
	@mkdir $(DIST)

debug:
	@echo "*** SRC-BUILD-DIST : $(SRC)-$(BUILD)-$(DIST)"
	@echo "*** NOM-COMPLET    : $(NOM-COMPLET)"
	@echo "*** NOM-PRINT      : $(NOM-PRINT)"
	@echo "*** NOM-COMMON     : $(NOM-COMMON)"
	@echo "*** NOM-CHAPITRE   : $(NOM-CHAPITRE)"
	@echo "*** TEX-COMPLET    : $(TEX-COMPLET)"
	@echo "*** TEX-PRINT      : $(TEX-PRINT)"
	@echo "*** TEX-COMMON     : $(TEX-COMMON)"
	@echo "*** PDF-COMPLET    : $(PDF-COMPLET)"
	@echo "*** PDF-PRINT      : $(PDF-PRINT)"
	@echo "*** SUPPORT        : $(SUPPORT)"
	@echo "*** LISTE-CHAPITRES: $(LISTE-CHAPITRES)"
	@echo "*** TEX-CHAPITRES  : $(TEX-CHAPITRES)" 
	@echo "*** PDF-CHAPITRES  : $(PDF-CHAPITRES)" 

# Les PDF des chapitres sont :
chapter: $(PDF-CHAPITRES)

# Comment créer un pdf du chapitre
# Dépend du source du chapitre + des 2 documents englobants + des supports
# Option rubber : On n'inclut que le chapiter voulu
$(DIST)/$(NOM-COMPLET)-$(NOM-CHAPITRE)-%.pdf : $(SRC)/$(NOM-CHAPITRE)-%.tex $(SUPPORT) $(TEX-COMPLET) $(TEX-COMMON)
	@echo "=====  Création du chapitre : $*"
	rubber --only $(NOM-CHAPITRE)-$* $(RUBBEROPT) $(TEX-COMPLET)
	mv $(BUILD)/$(NOM-COMPLET).pdf $@

all : $(PDF-COMPLET) $(PDF-PRINT)

$(PDF-COMPLET) : $(SUPPORT) $(TEX-CHAPITRES) $(TEX-COMPLET) $(TEX-COMMON)
	@echo "====== Tout en couleur"
	rubber $(RUBBEROPT) $(TEX-COMPLET)
	mv $(BUILD)/$(NOM-COMPLET).pdf $@
	# Il faut reconstruire les chapitres pour être sûr qu'ils aient le bon numéro.
	rm -f $(PDF-CHAPITRES)
	make chapter

$(PDF-PRINT) : $(SUPPORT) $(TEX-CHAPITRES) $(TEX-PRINT) $(TEX-COMMON)
	@echo "====== Tout en N/B"
	rubber $(RUBBEROPT) $(TEX-PRINT)
	pdfnup -q --nup 2x4 --no-landscape --frame true --outfile $@ $(BUILD)/$(NOM-PRINT).pdf

# En "mode travail", c'est bien de g�n�rer le doc complet sans les chapitres
pbt : $(SUPPORT) $(TEX-CHAPITRES) $(TEX-COMPLET) $(TEX-COMMON)
	@echo "====M�j du document couleur complet"
	rubber $(RUBBEROPT) $(TEX-COMPLET)
	mv $(BUILD)/$(NOM-COMPLET).pdf $@
