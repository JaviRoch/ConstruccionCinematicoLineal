      //Parseo de la cadena de carácteres enviada por arduino a variables 
void parseo(){
    int i = 0;
    int fin = 0;
    int q = 0;
    int t =0;
    char arg[] = {'T','U','V','W','X','Y','Z','F'}; /*Ejes y velocidad*/
   
 
      for (q = 0; q < 8; q++) {   //Interrogamos los 7 ejes
      if (datSerial.indexOf(arg[q],0) >= 0) {           //Si existe la letra como argumento
        i = datSerial.indexOf(arg[q],0);                //Nos posicionamos en ella
        fin = datSerial.indexOf(' ',i);        //Calculamos el tamaño del numero
        actual = datSerial.substring(i+1,fin);          //Creamos la cadena de texto
        datActual[q] =  int (actual);      //Lo pasamos a entero 
      } 
      }

 }