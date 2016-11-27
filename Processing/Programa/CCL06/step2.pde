void step2(){
  
  background(0);  

//Grosor de la línea
  strokeWeight (2);
  
  stroke(intenLinea);

  line (200,800,900,500);

//Aumentamos la intensidad de la línea
//Modificacndo este valor regulamos la velocidad de aparición de la línea
  intenLinea+= 5;

//Instrucción de seguridad para que no desborde las 255 unidades
  if(intenLinea >= 254){
    intenLinea = 255;
  }

//!!!!!Poner a 0 intenLinea al salir del step!!!!!!!!!!
}