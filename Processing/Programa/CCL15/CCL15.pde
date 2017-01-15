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
float man_U = 0;
float man_V = 0;
float man_W = 0;
float man_X = 0;
float man_Y = 0;
float man_Z = 0;
float man_T = 0;

//Variables comunicacion
char COMANDOS[] = new char[40]; /*Cadena de caracteres que arduino envia en forma de comandos*/
String trama;
String datSerial = "T0 U0 V0 W0 X0 Y0 Z0 F0 ";
String actual;
int datActual[] = {0,0,0,0,0,0,0,0};
int indice;    /*Indice de la cadena de datos que se envia desde arduino*/

//Variables proceso
int step = 0;

boolean home = false;
boolean homeFin = false;

int realU = 0;
int realV = 0;
int realW = 0;

int realX = 0;
int realY = 0;
int realZ = 0;

int disT = 0;


void setup(){
  
//Iniciamos comunicación con Arduino
  myPort = new Serial(this, "COM4", 57600);


//Abrimos visualización a pantalla completa en la pantalla número 1
  fullScreen(1);

//Creamos oculto controlP5
  cp5 = new ControlP5(this);
  cp5.hide();
  
//Carga de elementos de manejo manuales
  pantallaManual();

//Carga de imágenes
  img1 = loadImage("lanzarote1.jpg");
  
//Arrancamos motores
  myPort.write("ON\r");
  
  smooth(4);
  
}

void keyPressed() {
// Activamos menu manual con letra 'm'
  if (key == 'm') {
    if (cp5.isVisible()) {
     cp5.hide();     
    } 
    else {
     cp5.show();
    }  
  }

//Cambio de step con el teclado
  if (key == '+') {
    step = step +1;
  }
  if (key == '-') {
    step = step -1;
  }
  if (key == 'e'){
    myPort.write("T50U200V1000F5\r");   
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

/* Leer los comandos de processing */
while (myPort.available() > 0) {  
  char caracter = myPort.readChar();
    if(caracter == '\r') {
      /* El comando ha sido leido. Es hora de analizarlo */
      datSerial = String.valueOf(COMANDOS);  //Convertimos el array de carácteres a String ¿Problema código ASCI?
//      print(COMANDOS);
//      println (" dat1 "+datSerial);
      println (datSerial);
      parseo();     
      indice = 0; //preparamos el índice para la siguiente cadena de carácteres
      for (int i = 0; i < COMANDOS.length; i++){ 
        COMANDOS[i] = '\0'; //Ponemos a 0 todos los caráctares para la siguiente cadena
   }
      }     
    else {
      COMANDOS[indice] = caracter;
      indice++;
      COMANDOS[indice] = '\0'; //Mantiene el caracter NULL al final de la cadena
//      println(COMANDOS);
//      println (" dat2 "+datSerial);
    }    
//      println ("datActual"+ actual);
//      println(datActual);    
  }

//Carga de datos en pantalla Manual
  datosManual();
  


//Visualización de datos
  //println("man_U: "+man_U);
  //println("step: "+step);


}




  