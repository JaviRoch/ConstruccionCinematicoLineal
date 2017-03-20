void datosManual(){
 
//Carga de los datos de entrada en manual a una palabra
  textManual[0] = textValue0;
  textManual[1] = textValue1;
  textManual[2] = textValue2;
  textManual[3] = textValue3;
  textManual[4] = textValue4;
  textManual[5] = textValue5;
  textManual[6] = textValue6;
  textManual[7] = textValue7;

//Unimos el array de palabras para poderlo enviar por serial
  textManualJoin = join(textManual,"");
  
  
  
  
	cp5.getController("step").setValue(step);
}