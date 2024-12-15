<html>

<head>
	<meta charset="utf-8" />
	<link rel="stylesheet" href="style.css" />
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
	<link rel="icon" href="vr4.ico" type="image/x-icon">
	<title>Tirage au sort VR4</title>
  	<script>
        document.addEventListener("DOMContentLoaded", function() {
			if (window.location.hash === "#result") {
				document.getElementById("result").scrollIntoView({
					behavior: 'smooth'
				});
			}
		});
    </script>
 </head>

<body>
	<header class="header">
		<h1>Tirage au sort de manches de VR4</h1>
	</header>

	<div class="introduction">
		<p class="intro-title">Bienvenue sur cette page web "Tirage aléatoire manches de VR4"</p>
		<p>
			Cette page permet de simuler le tirage au sort d'une compétition de VR4, composée de 1 à 11 manches.<br />
			Vous avez à sélectionner ci-dessous le nombre de manches ainsi que la catégorie N1 ou N2 :<br />
		<ul>
			<li>Catégorie N1 : tous les blocs sont présents dans le tirage, chaque manche compte 5 ou 6 points</li>
			<li>Catégorie N2 : les blocs spécifiques de N1 (3, 5, 10, 12, 16, 17) ne sont pas présents, chaque manche compte 4 ou 5 points</li>
		</ul>
	</div>
	
	<form class="form" method="post" action="#result">
		<p class="N1_N2_select">
			<label class="category-label">Sélectionner la catégorie :</label>
			<input type="radio" name="categorie" value="1" id="N1" <?php echo (isset($_POST['categorie']) && $_POST['categorie'] == '1') ? 'checked' : ''; ?> /> <label for="N1">Nationale 1 (N1)</label><br />
			<input type="radio" name="categorie" value="2" id="N2" <?php echo (isset($_POST['categorie']) && $_POST['categorie'] == '2') ? 'checked' : ''; ?> /> <label for="N2">Nationale 2 (N2)</label><br />
		</p>
		<p class="number_of_rounds_select">
			Choisir le nombre de manches à tirer au sort&nbsp:<br />
			<select class="number_of_rounds_list" name="number_of_rounds" id="number_of_rounds"/><br />
				<?php
				for ($i = 1; $i <= 11; $i++) {
					$selected = (isset($_POST['number_of_rounds']) && $_POST['number_of_rounds'] == $i) ? 'selected' : '';
					echo "<option value='$i' $selected>$i</option>";
				}
				?>
 			</select>
		</p>
		<input id="tirageBtn" class="validate_button" type="submit" name="exec" value="Lancer le tirage au sort !"/>
	</form>
</body>

<html>


<?php

if(!empty($_POST["exec"]))
{
	$categorie=$_POST["categorie"];
	$number_of_rounds=$_POST["number_of_rounds"];
	$output = shell_exec("bash tirage_VR4.sh $categorie $number_of_rounds");
	echo "<pre id='result' class='script_output'>";
	echo $output;
	echo "<pre>";

}

?>
