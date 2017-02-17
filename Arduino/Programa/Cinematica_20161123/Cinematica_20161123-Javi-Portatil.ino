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

    Versión: V0.3  Fecha: 20161123

    Velocidad: 57600 baudios.
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
          DES
        Devuelve un "Motores off" cuando termina 

    Pendientes de realizar:
      - Introducir perro guardián de seguridad.
      - Limitar los valores de entrada.
      - Comentar el programa en detalle.
      - Realizar organigramas explicativos.
------------------------------------------------------------------------------------------------*/

/* LIBRERIAS */
#include "pins.h"
#include "textos.h"
#include "inicializacion.h"
#include "TimerOne.h"

#define acc 80

/*VARIABLES GLOBALES*/
byte indice = 0;    /*Indice de la cadena de datos que se envia desde processing*/

char COMANDOS[80];  /*Cadena de caracteres que processing envia en forma de comandos*/
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
float DIF[8];                           // Diferencia en pasos de los ejes 
float mayor = 0;  //Mayor diferencia de pasos del eje que más pasos tiene que dar para llegar a la cota establecida

long REC[7];                            // Auxiliar

int STEPS[7]    = {T_STEP_PIN,   U_STEP_PIN,   V_STEP_PIN,   W_STEP_PIN,   X_STEP_PIN,   Y_STEP_PIN,   Z_STEP_PIN   };
int ENABLE[7]   = {T_ENABLE_PIN, U_ENABLE_PIN, V_ENABLE_PIN, W_ENABLE_PIN, X_ENABLE_PIN, Y_ENABLE_PIN, Z_ENABLE_PIN };
int DIR_PIN[7]  = {T_DIR_PIN,    U_DIR_PIN,    V_DIR_PIN,    W_DIR_PIN,    X_DIR_PIN,    Y_DIR_PIN,    Z_DIR_PIN    };
int MIN_PIN[7]  = {T_MIN_PIN,    U_MIN_PIN,    V_MIN_PIN,    W_MIN_PIN,    X_MIN_PIN,    Y_MIN_PIN,    Z_MIN_PIN    };

bool DIRR[8];                 // Dirección de los motores
bool PETICION_ORIGEN = LOW;   // Flag petición para realizar el origen
bool OOK[7];                  // Origen realizado de cada eje

bool busy = LOW;
bool motores_on = LOW;
bool FL1 = LOW;
bool FL2 = LOW;
bool ook;

long t_ant;
long t_ant2;
int v;
float aux;
float aux2;
 

void setup() {
  inicializacion();
  Timer1.initialize(2000); 
  Timer1.attachInterrupt(trazar); 
  destino[7] = 800;
  for (int q = 0; q < 7; q++) {
    OOK[q] = LOW;
  }  
  Serial.println(MSG_ARRANQUE);
}

void trazar() {   /* Función crítica, lo más rápida posible*/
  if (busy == HIGH) {
    if (mayor > 0) {
      for (int q = 0; q < 7; q++) {
        long a = ceil(mayor*FAC[q]);
        if (a != REC[q]) {
          digitalWrite(STEPS[q], HIGH);   /* Flanco del paso */
          digitalWrite(STEPS[q], LOW);    /* Flanco del paso */
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
  destino[7] = 800;

  /*Origen eje T*/
  if (OOK[0] == LOW) {
    destino[0] = -10000;  
    if (digitalRead(MIN_PIN[0]) == LOW) {
      destino[0] = 0;
      origen[0] = 0;
      posicion[0] = 0;
      POSICION[0] = 0;
      mayor = 0;
      posicion_anterior[0] = 0;
      OOK[0] = HIGH;
    } 
  }

  /*Origen eje U*/
  if (OOK[1] == LOW && OOK[0] == HIGH) {
    destino[1] = -10000; 
    if (digitalRead(MIN_PIN[1]) == LOW) {
      destino[1] = 0;
      origen[1] = 0;
      posicion[1] = 0;
      POSICION[1] = 0;
      mayor = 0;
      posicion_anterior[1] = 0;
      OOK[1] = HIGH;
    }  
  }

  /*Origen eje V*/
  if (OOK[2] == LOW && OOK[1] == HIGH && OOK[0] == HIGH) {
    destino[2] = -10000;  
    if (digitalRead(MIN_PIN[2]) == LOW) {
      destino[2] = 0;
      origen[2] = 0;
      posicion[2] = 0;
      POSICION[2] = 0;
      mayor = 0;
      posicion_anterior[2] = 0;
      OOK[2] = HIGH;
    }  
  }

  /*Origen eje W*/
  if (OOK[3] == LOW && OOK[2] == HIGH && OOK[1] == HIGH  && OOK[0] == HIGH) {
    destino[3] = -10000; 
    if (digitalRead(MIN_PIN[3]) == LOW) {
      destino[3] = 0;
      origen[3] = 0;
      posicion[3] = 0;
      POSICION[3] = 0;
      mayor = 0;
      posicion_anterior[3] = 0;
      OOK[3] = HIGH;
    } 
  }

  /*Origen eje X*/
  if (OOK[4] == LOW && OOK[3] == HIGH && OOK[2] == HIGH  && OOK[1] == HIGH && OOK[0] == HIGH) {
    destino[4] = -10000; 
    if (digitalRead(MIN_PIN[4]) == LOW) {
      destino[4] = 0;
      origen[4] = 0;
      posicion[4] = 0;
      POSICION[4] = 0;
      mayor = 0;
      posicion_anterior[4] = 0;
      OOK[4] = HIGH;
    }  
  }

  /*Origen eje Y*/
  if (OOK[5] == LOW && OOK[4] == HIGH && OOK[3] == HIGH  && OOK[2] == HIGH && OOK[1] == HIGH && OOK[0] == HIGH) {
    destino[5] = -10000;  
    if (digitalRead(MIN_PIN[5]) == LOW) {
      destino[5] = 0;
      origen[5] = 0;
      posicion[5] = 0;
      POSICION[5] = 0;
      mayor = 0;
      posicion_anterior[5] = 0;
      OOK[5] = HIGH;
    }
  }

  /*Origen eje Z*/
  if (OOK[6] == LOW && OOK[5] == HIGH && OOK[4] == HIGH  && OOK[3] == HIGH && OOK[2] == HIGH && OOK[1] == HIGH  && OOK[0] == HIGH) {
    destino[6] = -100; 
    if (digitalRead(MIN_PIN[6]) == LOW) {
      destino[6] = 0;
      origen[6] = 0;
      posicion[6] = 0;
      POSICION[6] = 0;
      mayor = 0;
      posicion_anterior[6] = 0;
      OOK[6] = HIGH;
    } 
  }
  
  /*Reset petición de origen*/
  if (OOK[6] == HIGH && OOK[5] == HIGH && OOK[4] == HIGH  && OOK[3] == HIGH && OOK[2] == HIGH && OOK[1] == HIGH  && OOK[0] == HIGH) {
    PETICION_ORIGEN = LOW;
  }
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

  /*Establece la dirección de los motores*/
  for (int q = 0; q < 7; q++) {
    digitalWrite(DIR_PIN[q],DIRR[q]);
  }

  /*Calculo de los factores*/
  for (int q = 0; q < 7; q++) {
    FAC[q] = abs(DIF[q])/mayor;
  }
}

/* Analizar los comandos enviados desde processing */
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

  /* Realizar origen */
  if (trama == "ORIGEN") {
    PETICION_ORIGEN = HIGH;
    for (int q = 0; q < 7; q++) {
      OOK[q] = LOW;
    }  
  }

/* Encender motores */
  if (trama == "ON") {
    marcha();
    Serial.println(MSG_MOTORES_ON);
    motores_on = HIGH;
  }

/* Apagar motores */
  if (trama == "DES") {
    paro();
    Serial.println(MSG_MOTORES_OFF);
    motores_on = LOW;
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

/* Realizar origen */
  if (PETICION_ORIGEN == HIGH) {
    origen_coordenadas();
  }

/* Mensaje de destino alcanzado*/
  if (busy == HIGH && FL1 == LOW) {
    FL1 = HIGH;
    aux = mayor;
  }

  if (busy == LOW) {
    FL1 = LOW;
  }

/* Mensaje de destino alcanzado*/
  if (busy == LOW && FL2 == LOW) {
    FL2 = HIGH;
    Serial.println(MSG_TARGET);
  }

  if (busy == HIGH) {
    FL2 = LOW;
  }

/*-----------------------------------------------------------------------------------------------------*/
/* Aceleración */
  if((busy == HIGH) && (millis() > (t_ant + 50)) && (mayor > aux2)) {
    if (v < destino[7]) {
      if ((v + acc) < destino[7]) {v = v + acc;} else {v = destino[7]; aux2 = aux - mayor; }
    } 
    
    t_ant = millis();
    int a = map(v,0,1000,30000,1000);
    Timer1.initialize(a);
  }

  /* Deceleración */
  if((busy == HIGH) && (millis() > (t_ant2 + 50)) && (mayor < aux2)) {
    v = v - acc;
    t_ant2 = millis();
    int a = map(v,0,1000,30000,1000);
    Timer1.initialize(a);
  }

  if (busy == LOW) {
    v = 0;
    aux = 0;
  }
  /*-------------------------------------------------------------------------------------*/

  if ((destino[7]==velocidad_anterior)==LOW) {
    velocidad_anterior=destino[7];
    POSICION[7] = destino[7];
  }

/* Controla si ha cambiado el valor de algún eje*/
  if ((destino[0]==origen[0] && 
       destino[1]==origen[1] &&
       destino[2]==origen[2] && 
       destino[3]==origen[3] && 
       destino[4]==origen[4] && 
       destino[5]==origen[5] && 
       destino[6]==origen[6]) == LOW) {
    busy = LOW;
    for (int q = 0; q < 7; q++) {
      origen[q] = destino[q];
      ORIGEN[q] = POSICION[q];
    }  
    calcular(); 
    Serial.println(MSG_OK);
    busy = HIGH; //Llamamos a la función que recalcula los datos
  }

/* Refrescamos la posición actual */
  for (int q = 0; q < 8; q++) {
    posicion[q] = long(ceil(POSICION[q]/K[q]));  //Recalculamos la posición actual
  } 

/* Respuesta de Arduino a processing de la posición y la velocidad actual*/
  if ((posicion[0]==posicion_anterior[0] && 
       posicion[1]==posicion_anterior[1] && 
       posicion[2]==posicion_anterior[2] && 
       posicion[3]==posicion_anterior[3] && 
       posicion[4]==posicion_anterior[4] && 
       posicion[5]==posicion_anterior[5] && 
       posicion[6]==posicion_anterior[6]) == LOW) {
    for (int q = 0; q < 8; q++) {
      Serial.print(arg[q]);
      Serial.print(posicion[q]);
      Serial.print(" ");
      posicion_anterior[q] = posicion[q];
    }
    Serial.println(" "); 
  }
}
