void step0(){
  


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
	



//Arrancamos motores si ya ha arrancado arduino
if(motoresOn == false & arranqueOk == true){
  myPort.write("ON\r");
}

//Reseteamos el Homing
	if (homeFin == true){
		home = false;
		step = 1;
		homeFin = false;
	}
}