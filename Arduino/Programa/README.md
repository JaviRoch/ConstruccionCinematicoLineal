# Programación Arduino 
                                             
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