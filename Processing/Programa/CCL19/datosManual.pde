void datosManual(){

//Creamos la visualización virtual de la posición de los émbolos
  if (manual == true){
    ellipse(virU,virV,3,3);
    ellipse(virX,virY,3,3);
  }
  
//Creamos zona de trabajo ejes
  if(visualTrabajo == true){
    stroke(0);
    strokeWeight(1);
    noFill();
    rectMode(CORNERS);
    rect(356,153,865,856);
    rect(1094,153,1602,817);
  }  

//Carga de los datos de entrada en manual a una palabra
  textManual[0] = textValue[0];
  textManual[1] = textValue[1];
  textManual[2] = textValue[2];
  textManual[3] = textValue[3];
  textManual[4] = textValue[4];
  textManual[5] = textValue[5];
  textManual[6] = textValue[6];
  textManual[7] = textValue[7];

//Unimos el array de palabras para poderlo enviar por serial
  textManualJoin = join(textManual,"");
  
//Carga de los datos del slider de setp en la variable Step
	cp5.getController("step").setValue(step);
}