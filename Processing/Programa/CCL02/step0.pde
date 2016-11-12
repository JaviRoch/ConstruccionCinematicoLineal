void step0(){

	int intermitencia = 0;
	int intermitenciaTemp = 0;

//Activamos el Homing
	home = true;

//Simulación temporal
	
	
	
 	background(125);
 	textAlign(CENTER);
	textSize(82);
	text("home", width/2, 300); 
	fill(0, 102, 153);
	text("homing", width/2, 600);
	fill(0, 102, 153, 51);
	text("home", width/2, 900);
		

	if (intermitenciaTemp == 1) {
	 	println("intermitencia 1");
	 	background(125);	
	 	delay(200);
	 	intermitencia = 0;

	 } 	
	 	
	

//Reseteamos el Homing
	if (homeFin == true){
		home = false;
		step = 1;
		homeFin = false;
	}
}