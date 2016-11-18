/*---------------------------------------------------------------------------------------------
                       Construcción Cinemático-Lineal           
                                             
 http://cesar-etopia.bifi.es/index.php/2016/10/18/construccion-cinematico-lineal/  
    
  Proyecto CeSAr en etopia        
   Participantes:
    Javier Roche  (lider)   javier.roche.m@gmail.com
    Daniel Ferrer           daniel10_es@yahoo.es
    Jose Miguel Cuartero    crispincuarter@gmail.com
    María Blasco            blascocubas.maria@gmail.com
    ....      

  Agradecimientos a los creadores de la biblioteca TimerOne por su aportación.

  Definición del programa:
    Se basa en la creación de un sistema de 7 ejes coordinados realizado con motores
    paso a paso NEMA17.
    A través de un programa realizado en processing y conectado al ARDUINO MEGA con
    los motores, se coordinarán los 7 ejes con imagenes.
    Para ello, se enviarán los datos de las coordenadas T, U, V, W, X, Y, Z desde un
    programa realizado con processing al arduino para que los motores se posicionen. 
    Una vez que llega a la posición deseada, se informará al programa de processing que ha
    llegado para recibir la siguiente instrucción.
    Durante el trayecto de los ejes, arduino enviará los datos de la posición actual para que
    el programa de processing pueda coordinar con la imagen correspondiente.
    Los ejes tendrán una rutina de inicialización para posicionarse en el (0,0,0,0,0,0,0) la
    cual será llamada desde Processing cuando comience el ciclo.

    Versión: V0.1  Fecha: 20161116

    Velocidad: 9600 baudios.
    Comandos:
      - Modificar posición:
          Tnnn Unnn Vnnn Wnnn Xnnn Ynnn Znnn Fnnn
        Donde:
        T, U, V ... Z son los ejes
        nnn: Es el número del pixel o cota de cada eje donde queremos ir (desde -32768 a 32767
        F: Velocidad del movimiento (desde 0 a 1000)
      - Realizar el origen:
          ORIGEN
        Devuelve un "Origen realizado con exito" cuando lo termina
      - Poner en marcha los motores:
          ON
        Devuelve un "Motores on" cuando termina
      - Apagar los motores:
          OFF
        Devuelve un "Motores off" cuando termina 

    Pendientes de realizar:
      - Rutina origen.
      - Rutina de aceleraciones trapezoidales.
      - Introducir perro guardián de seguridad.
      - Limitar los valores de entrada.
      - Renombrar los ejes correctamente.
      - Comentar el programa.
      - Realizar organigramas explicativos.
      - Terminar biblioteca de textos.
------------------------------------------------------------------------------------------------*/

/* LIBRERIAS */
#include "pins.h"
#include "inicializacion.h"
#include "TimerOne.h"

/*VARIABLES GLOBALES*/
char COMANDOS[80];  /*Cadena de caracteres que processing envia en forma de comandos*/
byte indice = 0;    /*Indice de la cadena de datos que se envia desde processing*/

char arg[8] = {'T','U','V','W','X','Y','Z','F'};      /*Ejes y velocidad*/

int destino[8];           // T, U, V, W, X, Y, Z, F   Donde queremos ir (comando de processing) en pixeles
int origen[8];            // T, U, V, W, X, Y, Z, F   De donde venimos en pixeles
int posicion[8];          // T, U, V, W, X, Y, Z, F   Donde estamos actualmente (para enviar a processing)
int posicion_anterior[8]; // T, U, V, W, X, Y, Z, F   Auxiliar para saber si se ha cambiado la posición
int velocidad_anterior;   // Auxiliar

float K[8] = {10,10,10,10,10,10,10,1};  //Factor que relaciona los pixeles con los pasos (pixeles x pasos)
float DESTINO[8];                       // T, U, V, W, X, Y, Z, F Donde queremos ir (comando de processing) en pasos
float ORIGEN[8];                        // T, U, V, W, X, Y, Z, F Auxiliar para saber que vamos a cambiar de cota en pasos
float POSICION[8];                      // T, U, V, W, X, Y, Z, F Donde estamos actualmente (para enviar a processing) en pasos
float FAC[7];                           // T, U, V, W, X, Y, Z, Factores de linealización de los pasos cuando se sincronizan

long REC[7];                            // Auxiliar

int STEPS[7] = {X1_STEP_PIN,Y1_STEP_PIN,Z1_STEP_PIN,E1_STEP_PIN,-1,-1,-1};
int ENABLE[7] = {X1_ENABLE_PIN,Y1_ENABLE_PIN,Z1_ENABLE_PIN,E1_ENABLE_PIN,-1,-1,-1};
int DIR_PIN[7] = {X1_DIR_PIN,Y1_DIR_PIN,Z1_DIR_PIN,E1_DIR_PIN,-1,-1,-1};

float DIF[8];  // Diferencia en pasos de los ejes 
bool DIRR[8];  // Dirección de los motores

float mayor = 0;  //Mayor diferencia de pasos del eje que más pasos tiene que dar para llegar a la cota establecida

bool busy = LOW;

void setup() {
  inicializacion();
  Timer1.initialize(2000); 
  Timer1.attachInterrupt(trazar); 
  destino[7] = 800;
}

void trazar() {   /* Función crítica, lo más rápida posible*/
  if (busy == HIGH) {
    if (mayor > 0) {
      for (int q = 0; q < 7; q++) {
        long a = ceil(mayor*FAC[q]);
        if (a != REC[q]) {
          digitalWrite(STEPS[q], HIGH); 
          digitalWrite(STEPS[q], LOW);  
          if (DIRR[q] == HIGH) {
            POSICION[q]++;
          } else {
            POSICION[q]--;
          }
          REC[q] = a;   
        }     
      }
      mayor--; 
    } else {
      busy = LOW;
    }
  }
}

void marcha() { /* Activa los motores */
  for (int q = 0; q < 7; q++) { 
    digitalWrite(ENABLE[q], LOW);
  }
}

void paro() {  /* Desactiva los motores */
  for (int q = 0; q < 7; q++) { 
    digitalWrite(ENABLE[q], HIGH);
  }  
}

void origen_coordenadas() {  /* Realiza el origen de coordenadas */
  
}

void calcular() {    /* Calculo de pasos */
  
  for (int q = 0; q < 7; q++) { 
    DESTINO[q] = destino[q] * K[q];  /*Calculo del destino en pasos*/
    DIF[q] = DESTINO[q] - ORIGEN[q]; /*Calculo del diferencial en pasos*/
  }

  /*Calculo del mayor*/
  mayor = 0;
  for (int q = 0; q < 7; q++) {
    if (abs(DIF[q])>mayor){
      mayor = abs(DIF[q]);
    }
  }

  /*Calculo de la dirección*/
  for (int q = 0; q < 7; q++) {
    if (DIF[q]>0.0){
      DIRR[q] = HIGH;
    } else {
      DIRR[q] = LOW;
    }
  }

  for (int q = 0; q < 7; q++) {
    digitalWrite(DIR_PIN[q],DIRR[q]);
  }

  /*Calculo de los factores*/
  for (int q = 0; q < 7; q++) {
    FAC[q] = abs(DIF[q])/mayor;
  }
}

void parsear (String trama){
  int i = 0;
  int fin = 0;
  for (int q = 0; q < 8; q++) {                       //Interrogamos los 7 ejes
    if (trama.indexOf(arg[q],0) >= 0) {               //Si existe la letra como argumento
      i = trama.indexOf(arg[q],0);                    //Nos posicionamos en ella
      fin = trama.indexOf(' ',i);                     //Calculamos el tamaño del numero
      destino[q] = trama.substring(i+1,fin).toInt();  //Creamos la cadena de texto y la pasamos a entero
    }
  }
  if (trama == "ORIGEN") {
    origen_coordenadas();
    Serial.println("Origen realizado con exito");
  }

  if (trama == "ON") {
    marcha();
    Serial.println("Motores on");
  }

  if (trama == "OFF") {
    paro();
    Serial.println("Motores off");
  }
}

void loop() {
  /* Leer los comandos de processing */
  while (Serial.available() > 0) {
    char caracter = Serial.read();
    if(caracter == '\r') {
      /* El comando ha sido leido. Es hora de analizarlo */
      parsear(COMANDOS);
      indice = 0;
      COMANDOS[indice] = NULL;
    } else {
      COMANDOS[indice] = caracter;
      indice++;
      COMANDOS[indice] = '\0'; //Mantiene el caracter NULL al final de la cadena
    }
  }

/* Ajustamos la velocidad */
  if ((destino[7]==velocidad_anterior)==LOW) {
    Timer1.initialize(map(destino[7],0,1000,30000,1000)); 
    velocidad_anterior=destino[7];
    POSICION[7] = destino[7];
  }

/* Controla si ha cambiado el valor de algún eje*/
  if ((destino[0]==origen[0] && destino[1]==origen[1] && destino[2]==origen[2] && destino[3]==origen[3] && destino[4]==origen[4] && destino[5]==origen[5] && destino[6]==origen[6]) == LOW) {
    busy = LOW;
    for (int q = 0; q < 7; q++) {
      origen[q] = destino[q];
      ORIGEN[q] = POSICION[q];
    }  
    calcular(); 
    busy = HIGH; //Llamamos a la función que recalcula los datos
  }

/* Refrescamos la posición actual */
  for (int q = 0; q < 8; q++) {
    posicion[q] = long(ceil(POSICION[q]/K[q]));  //Recalculamos la posición actual
  } 

/* Respuesta de Arduino a processing*/
  if ((posicion[0]==posicion_anterior[0] && posicion[1]==posicion_anterior[1] && posicion[2]==posicion_anterior[2] && posicion[3]==posicion_anterior[3] && posicion[4]==posicion_anterior[4] && posicion[5]==posicion_anterior[5] && posicion[6]==posicion_anterior[6]) == LOW) {
    for (int q = 0; q < 8; q++) {
      Serial.print(arg[q]);
      Serial.print(posicion[q]);
      Serial.print(" ");
      posicion_anterior[q] = posicion[q];
    }
    Serial.println(" "); 
  }
}
