import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Serial myPort; 

//Variables creación de las líneas
PImage img1;
PVector start;
PVector end;
PVector start1;
PVector end1;
float m= 0;
float m1= 0;
int intenLinea = 0;

//Variables manual
String[] textManual = new String[8];
String textManualJoin;
String textValue0;
String textValue1;
String textValue2;
String textValue3;
String textValue4;
String textValue5;
String textValue6;
String textValue7;

Textarea myTextarea0;
Textarea myTextarea1;
Textarea myTextarea2;
Textarea myTextarea3;
Textarea myTextarea4;
Textarea myTextarea5;
Textarea myTextarea6;
Textarea myTextarea7;

//Variables comunicacion
char COMANDOS[] = new char[80]; /*Cadena de caracteres que arduino envia en forma de comandos*/
String trama;
String datSerial = "T0 U0 V0 W0 X0 Y0 Z0 F0 ";
String actual;
int datActual[] = {0,0,0,0,0,0,0,0};
int indice;    /*Indice de la cadena de datos que se envia desde arduino*/

//Variables proceso
int step = 0;

boolean home = false;
boolean homeFin = false;
boolean motoresOn = false;
boolean arranqueOk = false;
boolean destAlcanzado = false;
boolean okCoordenadas = false;

int realU = 0;
int realV = 0;
int realW = 0;
int realX = 0;
int realY = 0;
int realZ = 0;
int disT = 0;

int virU = 0;
int virV = 0;
int virW = 0;
int virX = 0;
int virY = 0;
int virZ = 0;
int virT = 0;


void setup(){
  
//Iniciamos comunicación con Arduino
  myPort = new Serial(this, "COM4", 57600);

//Abrimos visualización a pantalla completa en la pantalla número 1
  fullScreen(2);

//Creamos oculto controlP5
  cp5 = new ControlP5(this);
  cp5.hide();

//Carga de elementos de manejo manuales
  pantallaManual();
  
  smooth(4);
  noCursor(); 
}

void keyPressed() {
// Activamos menu manual con letra 'm'
  if (key == 'm'|| key == 'M') {
    if (cp5.isVisible()) {
     cp5.hide();
     noCursor();
    } 
    else {
     cp5.show();
     cursor();
    }  
  }

//Cambio de step con el teclado
  if (key == '+') {
    step = step +1;
  }
  if (key == '-') {
    step = step -1;
  }  
} 

void draw(){
  noStroke();
// Secuencia de pasos del programa
    if (step == 0) {
      step0(); 
     } 
    if (step == 1) {
      step1(); 
     }     
    if (step == 2) {
      step2(); 
     }     
    if (step == 3){
      step3(); 
    }
    if (step == 4) {
      step4(); 
     }     
    if (step == 5) {
      step6(); 
     }
    if (step == 6) {
      step6(); 
     }
    if (step == 7) {
      step7(); 
     }
    if (step == 8) {
      step8(); 
     }

//Leer los comandos de processing
  while (myPort.available() > 0) {  
    char caracter = myPort.readChar();
  
//Lectura de los códigos de mensaje enviados por arduino  
  switch(caracter) {
    case 'a': 
      println("Origen realizado con exito");
      homeFin = true;
      break;
    case 'b': 
      println("Motores on");
      motoresOn = true;
      break;
    case 'd':   
      println("Arranque ok");  
      arranqueOk = true;
      break;
    case 'e':   
      println("Destino alcanzado");
      destAlcanzado = true;
      break;
    case 'h':   
      println("Ok recepción coordenadas");
      okCoordenadas = true;
      break;
    default:
      break;
}

//Lectura de las coordenadas enviadas por arduino

//Si ha llegado al final de la cadena de carácteres entra al parseo
    if(caracter == '\r') {
      /* El comando ha sido leido. Es hora de analizarlo */
      datSerial = String.valueOf(COMANDOS);  //Convertimos el array de carácteres a String
      println (datSerial);       
      parseo();       
      indice = 0; //preparamos el índice para la siguiente cadena de carácteres
      for (int i = 0; i < COMANDOS.length; i++){ 
        COMANDOS[i] = '\0'; //Ponemos a 0 todos los caráctares para la siguiente cadena
      }
    } 
    
//Si no ha llegado al final aumenta el índice y carga otro carácter
    else {
      COMANDOS[indice] = caracter;
      indice++;
      COMANDOS[indice] = '\0'; //Mantiene el caracter NULL al final de la cadena
    }     
  }
  
//Cargamos parseo en variables    
    disT  = datActual[0];
    realU = datActual[1];
    realV = datActual[2];
    realW = datActual[3];
    realX = datActual[4];
    realY = datActual[5];
    realZ = datActual[6];
  
//Desplazamiento de coordenada X para hacer la simetría entre los dos ejes
    virU = realU;
    virV = realV;
    virW = realW;
    virX = realX+960;
    virY = realY;
    virZ = realZ;
    
//Carga de datos en pantalla Manual
  datosManual();

}

//Captura de datos de entrada en manual
void cuerda_T(String theText0) {
  textValue0 = "T"+theText0;
  myTextarea0.setText(theText0);
}

void eje_U(String theText1) {
  textValue1 = "U"+theText1;
  myTextarea1.setText(theText1);
}

void eje_V(String theText2) {
  textValue2 = "V"+theText2;
  myTextarea2.setText(theText2);
}

void eje_W(String theText3) {
  textValue3 = "W"+theText3;
  myTextarea3.setText(theText3);
}

void eje_X(String theText4) {
  textValue4 = "X"+theText4;
  myTextarea4.setText(theText4);
}

void eje_Y(String theText5) {
  textValue5 = "Y"+theText5;
  myTextarea5.setText(theText5);
}

void eje_Z(String theText6) {
  textValue6 = "Z"+theText6;
  myTextarea6.setText(theText6);
}

void velocidad_F(String theText7) {
  textValue7 = "F"+theText7;
  myTextarea7.setText(theText7);
  println("F"+theText7);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName().equals("Carga_datos")) {
     println(textManualJoin);
     myPort.write(textManualJoin);
     myPort.write("\r");     
    }
}