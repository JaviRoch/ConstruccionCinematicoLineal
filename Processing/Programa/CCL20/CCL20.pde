import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Serial myPort; 

//Variables de imágenes
PImage img[] = new PImage[40];      //Imagenes

//Variables creación de las líneas
PVector start[] = new PVector[20];   //Inicio vectores
PVector end[] = new PVector[20];     //Fin vectores
float m[] = new float[20];      //Velocidad de creación vector
int intenLinea = 0;  //Velocidad de aparición de línea

float Xver1 = 965;
float Yver1 = 604;
float Xver2 = 965;
float Yver2 = 762;

//Variables manual
boolean manual = false;

String textManual[] = new String[8]; //Variable temporal almacenamiento valores manual
String textManualJoin;               //Variable con datos de manual preparardos para enviar por serie
String textValue[] = new String[8];  //Variable temporal almacenamiento valores manual
boolean visualTrabajo  = false;

Textarea myTextarea0;    //Campo visualización datos manual 
Textarea myTextarea1;    //Campo visualización datos manual
Textarea myTextarea2;    //Campo visualización datos manual
Textarea myTextarea3;    //Campo visualización datos manual
Textarea myTextarea4;    //Campo visualización datos manual
Textarea myTextarea5;    //Campo visualización datos manual
Textarea myTextarea6;    //Campo visualización datos manual
Textarea myTextarea7;    //Campo visualización datos manual

//Variables comunicacion
char COMANDOS[] = new char[80]; //Cadena de caracteres que arduino envia en forma de comandos
String trama;
String datSerial = "T0 U0 V0 W0 X0 Y0 Z0 F0 ";
String actual;
int datActual[] = {0,0,0,0,0,0,0,0};
int indice;    //Indice de la cadena de datos que se envia desde arduino

//Variables proceso
int step = 0;                    //Variable de control de pasos del programa

boolean homeFin = false;         //Home finalizado
boolean motoresOn = false;       //Motores conectados
boolean arranqueOk = false;      //Arranque arduino completado
boolean destAlcanzado = false;   //Destino movimiento motores alcanzado
boolean okCoordenadas = false;   //Coordenadas enviadas correctamente a arduino

int realU = 0;
int realV = 0;
int realW = 0;
int realX = 0;
int realY = 0;
int realZ = 0;
int disT = 0;

int virU = 0;
int virV = 0;
int virX = 0;
int virY = 0;

boolean distanciaOn;   //Conexión envío de distancia a arduino
float tempDistancia  = 0;   //Variable temporal de distanacia para comparación 
int savedTime;         //Temporización referesco de envío de distancia
int totalTime = 200;   //Temporización referesco de envío de distancia 0.2 segundos
int time2;                 //Temporización movimiento vertice 1 posición 2
int wait2 = 4000;          //Temporización movimiento vertice 1 posición 2
boolean tempTime2 = false; //Temporización movimiento vertice 1 posición 2
boolean ver1temp2 = false; //Temporización movimiento vertice 1 posición 2


void setup(){
  
//Iniciamos comunicación con Arduino
  myPort = new Serial(this, "COM4", 57600);

//Abrimos visualización a pantalla completa en la pantalla número 1
  fullScreen(2);

//Creamos oculto el control de manual
  cp5 = new ControlP5(this);
  cp5.hide();

//Carga de elementos de manejo manuales
  pantallaManual();

  savedTime = millis();

  smooth(4);
  noCursor();
  strokeJoin(BEVEL);
  strokeCap(ROUND);
  background(0);
}

void keyPressed() {
// Activamos menú manual
  if (key == 'm'|| key == 'M') {
    if (cp5.isVisible()) {
     cp5.hide();
     noCursor();
     manual = false;
    } 
    else {
     cp5.show();
     cursor();
     manual = true;
    }  
  }

//Cambio de step con el teclado
  if (key == '+') {
    step = step +1;
  }
  if (key == '-') {
    step = step -1;
  }
  
//Visualización zona trabajo ejes
  if (key == 't'|| key == 'T'){
    if (visualTrabajo == false) {
     visualTrabajo = true;
    } 
    else {
     visualTrabajo = false;
    } 
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

//Desplazamiento de coordenadas para hacer correcciones en la visualización
    virU = realU+356;
    virV = realV+153;
    virX = realX+1094;
    virY = realY+153;

//Enviaremos los datos cada 0.2 segundos para descargar el puerto serie
    int passedTime = millis() - savedTime;  //Calculamos cuanto tiempo ha pasado
    
//Si ha pasado el tiempo (0.2 segundos) y está activada (distanciaOn) calculamos y enviamos la variable de distancia
    if (passedTime > totalTime & distanciaOn == true) {

//Cálculo y envío de la distancia entre émbolo 1 y 2

      float distanVir = dist(virU,virV,virX,virY); //Calculamos la distancia entre émbolos 
      float distW = realW *1.57; //Variable sumatoria de la distania del eje w
      float distZ = realZ *1.57; //Variable sumatoria de la distania del eje Z
      float distancia = sqrt(sq(abs(distW-distZ))+sq(distanVir))-738;    //Le restamos la distancia real una vez hecho el Home y le sumamos las variables de altura de los ejes W y Z  
      String distData = "T"+distancia;    //Adaptamos el valor a string para envío a arduino 
   
      println (distData);
      myPort.write(distData);
      myPort.write("\r");
      savedTime = millis(); // Save the current time to restart the timer!
    }
    
   
//---------Lectura de datos enviados por arduino-----------

//Leer los comandos de arduino
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
    
//----------Manual---------------------------

//Carga de datos en pantalla Manual
  datosManual();

} //--------------Termina draw-----------------

//Captura de datos de entrada en manual
void cuerda_T(String theText0) {
  textValue[0] = "T"+theText0;
  myTextarea0.setText(theText0);
}

void eje_U(String theText1) {
  textValue[1] = "U"+theText1;
  myTextarea1.setText(theText1);
}

void eje_V(String theText2) {
  textValue[2] = "V"+theText2;
  myTextarea2.setText(theText2);
}

void eje_W(String theText3) {
  textValue[3] = "W"+theText3;
  myTextarea3.setText(theText3);
}

void eje_X(String theText4) {
  textValue[4] = "X"+theText4;
  myTextarea4.setText(theText4);
}

void eje_Y(String theText5) {
  textValue[5] = "Y"+theText5;
  myTextarea5.setText(theText5);
}

void eje_Z(String theText6) {
  textValue[6] = "Z"+theText6;
  myTextarea6.setText(theText6);
}

void velocidad_F(String theText7) {
  textValue[7] = "F"+theText7;
  myTextarea7.setText(theText7);
}

//Enviamos los datos de manual a arduino
void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName().equals("Carga_datos")) {
     println("manual"+textManualJoin);
     myPort.write(textManualJoin);
     myPort.write("\r");     
    }
}