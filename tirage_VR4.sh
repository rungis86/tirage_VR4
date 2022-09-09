#! /bin/bash

liste_figures=/home/remi/liste_figures_VR4.txt

melange_figures(){
	sort -R -o $liste_figures $liste_figures
}

init_valeurs_sauts(){
	for i in $(seq 60); do
		figure[$i]=0
	done
}

boucle(){
	k=1 # Incrément figures
	l=1 # Incrément dans la liste des figures du fichier $liste_figures
	for i in $(seq 10); do
		saut[$i]=0
		for j in $(seq 6); do
			if (( ${saut[$i]} < 5)); then
				figure[$k]=$(sed -n "$l p" $liste_figures)
				if let ${figure[$k]} 2>/dev/nul; then
					(( saut[$i]++ ))
					(( saut[$i]++ ))
				else
					(( saut[$i]++ ))
				fi

				let "l+=1"
			else
				figure[$k]=""
			fi
			let "k+=1"
		done
	done
}

sortie(){
cat <<EOF
Saut 1	Saut 2	Saut 3	Saut 4	Saut 5	Saut 6	Saut 7	Saut 8	Saut 9	Saut 10
${figure[1]}	${figure[7]}	${figure[13]}	${figure[19]}	${figure[25]}	${figure[31]}	${figure[37]}	${figure[43]}	${figure[49]}	${figure[55]}
${figure[2]}	${figure[8]}	${figure[14]}	${figure[20]}	${figure[26]}	${figure[32]}	${figure[38]}	${figure[44]}	${figure[50]}	${figure[56]}
${figure[3]}	${figure[9]}	${figure[15]}	${figure[21]}	${figure[27]}	${figure[33]}	${figure[39]}	${figure[45]}	${figure[51]}	${figure[57]}
${figure[4]}	${figure[10]}	${figure[16]}	${figure[22]}	${figure[28]}	${figure[34]}	${figure[40]}	${figure[46]}	${figure[52]}	${figure[58]}
${figure[5]}	${figure[11]}	${figure[17]}	${figure[23]}	${figure[29]}	${figure[35]}	${figure[41]}	${figure[47]}	${figure[53]}	${figure[59]}
${figure[6]}	${figure[12]}	${figure[18]}	${figure[24]}	${figure[30]}	${figure[36]}	${figure[42]}	${figure[48]}	${figure[54]}	${figure[60]}
EOF
}

main(){
	melange_figures
	init_valeurs_sauts
	boucle
	sortie
}

main
