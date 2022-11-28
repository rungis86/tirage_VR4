<html>

<head>
	<meta charset="utf-8" />
	<link rel="stylesheet" href="style.css" />
	<title>Tirage au sort VR4</title>
</head>

<body>
	<header class="header">
		<h1>Tirage au sort de manches de VR 4</h1>
	</header>

	<div class="introduction">
		<p class="intro-title">Bienvenue sur cette page web "Tirage aléatoire manches de VR4"</p>
		<p>
			Cette page permet de simuler le tirage au sort d'une compétition de VR4, composée de 1 à 11 manches.<br />
			Vous avez à sélectionner ci-dessous le nombre de manches ainsi que la catégorie N1 ou N2 :<br />
		<ul>
			<li>Catégorie N1 : tous les blocas sont présents dans le tirage, chaque manche compte 5 ou 6 points</li>
			<li>Catégorie N2 : les blocs spécifiques de N1 (3, 5, 10, 12, 16, 17) ne sont pas présents, chaque manche compte 4 ou 5 points</li>
		</ul>
	</div>
	
	<div class="form">
		<form method="post" action="">
			<p class="N1_N2_select">
				Sélectionner la catégorie N1 ou N2 :<br />
				<input type="radio" name="categorie" value="1" id="N1" checked /> <label for="N1">N1</label><br />
				<input type="radio" name="categorie" value="2" id="N2" /> <label for="N2">N2</label><br />
			</p>
			<p class="number_of_rounds_select">
				Choisir le nombre de manches à tirer au sort :<br />
				<select name="number_of_rounds" id="number_of_rounds"/><br />
					<option value=1>1</option>
					<option value=2>2</option>
					<option value=3>3</option>
					<option value=4>4</option>
					<option value=5>5</option>
					<option value=6>6</option>
					<option value=7>7</option>
					<option value=8>8</option>
					<option value=9>9</option>
					<option value=10>10</option>
					<option value=11>11</option>
				</select>
			</p>
			
			<input class="validate_button" type="submit" name="exec" value="Lancer le tirage au sort !"/>
		</form>
	</div>
</body>

<html>


<?php

if(!empty($_POST["exec"]))
{
	$categorie=$_POST["categorie"];
	$number_of_rounds=$_POST["number_of_rounds"];
	$output = shell_exec("bash tirage_VR4.sh $categorie $number_of_rounds");
	echo "<pre class='script_output'>";
	echo $output;
	echo "<pre>";
}

?>
