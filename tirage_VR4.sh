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

for i in $(seq $nb_manches); do
	if (( i < 10 )); then
		cat <<EOF
${tete_colonne[i]}   -->  ${figure[6*i-5]} ${figure[6*i-4]} ${figure[6*i-3]} ${figure[6*i-2]} ${figure[6*i-1]} ${figure[6*i]}
EOF
	else
		cat <<EOF
${tete_colonne[i]}  -->  ${figure[6*i-5]} ${figure[6*i-4]} ${figure[6*i-3]} ${figure[6*i-2]} ${figure[6*i-1]} ${figure[6*i]}
EOF
	fi
done

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