#! /bin/bash

accueil_programme(){

if [ ! "$1" ]; then

	cat <<EOF


############################ Tirage au sort VR4 ############################

Ce script permet de réaliser un tirage au sort aléatoire de 10 sauts de VR4.
Vous aurez la possibilité de choisir les règles N1 ou N2.

N1 >> tous les blocs sont présents dans le tirage, chaque manche compte
5 ou 6 points.
N2 >> les blocs N1 ne sont pas présents, chaque manche compte 4 ou 5 points.

############################################################################


EOF

fi

}

choix_N1_N2(){

if [ ! "$1" ]; then

	cat <<EOF
Veuillez choisir la catégorie N1 ou N2 :
	1) N1
	2) N2

EOF

	read categorie

	if ! [[ $categorie =~ ^[1-2]$ ]]; then
		echo "$(tput setaf 1)Erreur ! Veuillez taper 1 ou 2$(tput setaf 7)"
		echo ""
		echo ""
		sleep 1
		choix_N1_N2
	fi
else
	categorie="$1"
fi

}

choix_nombre_manches(){

if [ ! "$1" ]; then

	cat <<EOF
Veuillez choisir le nombre de manches (Entre 1 et 11) :

EOF

	read nb_manches

	if ! [[ $nb_manches =~ ^([1-9]|1[0-1])$ ]]; then
		echo "$(tput setaf 1)Erreur ! Veuillez taper une valeur entre 1 et 11$(tput setaf 7)"
		echo ""
		echo ""
		sleep 1
		choix_nombre_manches
	fi
else
	nb_manches="$1"
fi

}

selection_liste_figures(){
	if [[ categorie -eq 1 ]]; then
		liste_figures=liste_figures_VR4_N1.txt
		nb_points=5
	else
		liste_figures=liste_figures_VR4_N2.txt
		nb_points=4
	fi

	nbfigures_programme=$(grep -c "" $liste_figures)
}

melange_figures(){
	sort -R -o $liste_figures $liste_figures
}

init_valeurs_sauts(){
	for x in $(seq 60); do
		figure[$x]=""
	done
}

init_tetes_colonnes(){
	for y in $(seq 11); do
		tete_colonne[$y]=""
	done
}

boucle(){
	k=1 # Incrément figures
	l=1 # Incrément dans la liste des figures du fichier $liste_figures
	for i in $(seq $nb_manches); do
		saut[$i]=0 # Nombre de points dans le saut
		tete_colonne[$i]="Saut $i"	
		for j in $(seq 6); do
			if (( ${saut[$i]} < $nb_points)); then
				figure[$k]=$(sed -n "$l p" $liste_figures)
				if [[ ${figure[$k]} =~ ^[0-9]+$ ]]; then
					(( saut[$i]++ ))
					(( saut[$i]++ ))
				else
					(( saut[$i]++ ))
				fi
				
				if [[ $l -eq $nbfigures_programme ]]; then
					melange_figures
					l=1
				else
					let "l+=1"
				fi
			else
				figure[$k]=""
			fi
			let "k+=1"
		done
	done
}

tri_fichier_liste_figures(){
	sort -n -o $liste_figures $liste_figures
}

sortie(){

if [ ! "$1" ]; then

	cat <<EOF

###### Tirage au sort VR4 N$categorie ######
EOF

fi

cat <<EOF

${tete_colonne[1]}	${tete_colonne[2]}	${tete_colonne[3]}	${tete_colonne[4]}	${tete_colonne[5]}	${tete_colonne[6]}	${tete_colonne[7]}	${tete_colonne[8]}	${tete_colonne[9]}	${tete_colonne[10]}	${tete_colonne[11]}
${figure[1]}	${figure[7]}	${figure[13]}	${figure[19]}	${figure[25]}	${figure[31]}	${figure[37]}	${figure[43]}	${figure[49]}	${figure[55]}	${figure[61]}
${figure[2]}	${figure[8]}	${figure[14]}	${figure[20]}	${figure[26]}	${figure[32]}	${figure[38]}	${figure[44]}	${figure[50]}	${figure[56]}	${figure[62]}
${figure[3]}	${figure[9]}	${figure[15]}	${figure[21]}	${figure[27]}	${figure[33]}	${figure[39]}	${figure[45]}	${figure[51]}	${figure[57]}	${figure[63]}
${figure[4]}	${figure[10]}	${figure[16]}	${figure[22]}	${figure[28]}	${figure[34]}	${figure[40]}	${figure[46]}	${figure[52]}	${figure[58]}	${figure[64]}
${figure[5]}	${figure[11]}	${figure[17]}	${figure[23]}	${figure[29]}	${figure[35]}	${figure[41]}	${figure[47]}	${figure[53]}	${figure[59]}	${figure[65]}
${figure[6]}	${figure[12]}	${figure[18]}	${figure[24]}	${figure[30]}	${figure[36]}	${figure[42]}	${figure[48]}	${figure[54]}	${figure[60]}	${figure[66]}
EOF
}

main(){
	accueil_programme "$1"
	choix_N1_N2 "$1"
	choix_nombre_manches "$2"
	selection_liste_figures
	melange_figures
	init_valeurs_sauts
	init_tetes_colonnes
	boucle
	tri_fichier_liste_figures
	sortie "$1"
}

main "$1" "$2"
