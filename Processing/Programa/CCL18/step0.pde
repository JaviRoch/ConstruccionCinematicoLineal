void step0(){
  stroke (255);
  strokeWeight (2);
  
  int XendLine1;
  int YendLine1;
  int XendLine2;
  int YendLine2;
  boolean offLine2 = false;

//Arrancamos motores si ya ha arrancado arduino
  if(motoresOn == false & arranqueOk == true){
    myPort.write("ON\r");
  }

/*
//Enviamos orden de Home si ya han arrancado los motores
  if(motoresOn == true){
    myPort.write("ORIGEN\r");
  }
*/

//Cuando hayan terminado las líneas cambiamos el fondo y cargamos imagen
  if(m[8] == 1){
    stroke(0);
    strokeWeight (3);
    background(255);
    
  if (m[9] >= 0.0325){
    background(0);
  }
  
//Carga de imágenes
    img[0] = loadImage("Step0/lanzarote1.jpg");
    image(img[0],449,199);  
  }
//----------Extendemos línea 1-2 y borramos la 2 al terminar de mover vertice 1------------------
  if (m[9] >= 0.0325){
    XendLine1 = 1468;
    YendLine1 = 465;
    XendLine2 = 1468;
    YendLine2 = 712;
    offLine2 =true;
  }
  else{
    XendLine1 = 1276;
    YendLine1 = 470;
    XendLine2 = 1276;
    YendLine2 = 700;
  }

//------------------Creamos primera línea-------------------------

//Definimos el inicio del vector
  start[0] = new PVector (Xver1, Yver1);
//Definimos el final del vector
  end[0] = new PVector (XendLine1, YendLine1);
  
//Lanzamos la función vector con interacción Lerp
  PVector current = new PVector (lerp (start[0].x, end[0].x, m[0]), lerp (start[0].y, end[0].y, m[0]));

  
//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[0].x, start[0].y, current.x, current.y);


//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[0]+= 0.01;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[0] >= 1){
    m[0] = 1;
  }

//------------------Creamos segunda línea-------------------------
if (m[0] >= 0.5){
//Definimos el inicio del vector
  start[1] = new PVector (Xver1, Yver1);
//Definimos el final del vector
  end[1] = new PVector (Xver2, Yver2);
  
//Lanzamos la función vector con interacción Lerp
  PVector current1 = new PVector (lerp (start[1].x, end[1].x, m[1]), lerp (start[1].y, end[1].y, m[1]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[1].x, start[1].y, current1.x, current1.y);
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[1]+= 0.01;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[1] >= 1){
    m[1] = 1;
  }
}

//------------------Creamos tercera línea-------------------------
if (m[1] >= 0.5){
//Definimos el inicio del vector
  start[2] = new PVector (958, 439);
//Definimos el final del vector
  end[2] = new PVector (1276, 470);
  
//Lanzamos la función vector con interacción Lerp
  PVector current2 = new PVector (lerp (start[2].x, end[2].x, m[2]), lerp (start[2].y, end[2].y, m[2]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[2].x, start[2].y, current2.x, current2.y);
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[2]+= 0.01;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[2] >= 1){
    m[2] = 1;
  }
}

//------------------Creamos cuarta línea-------------------------
if (m[2] >= 0.5){


//Definimos el inicio del vector
  start[3] = new PVector (Xver1, Yver1);
//Definimos el final del vector
  end[3] = new PVector (449, 463);
  
//Lanzamos la función vector con interacción Lerp
  PVector current3 = new PVector (lerp (start[3].x, end[3].x, m[3]), lerp (start[3].y, end[3].y, m[3]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[3].x, start[3].y, current3.x, current3.y);
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[3]+= 0.005;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[3] >= 1){
    m[3] = 1;
  } 
}

//------------------Creamos quinta línea-------------------------
if (m[3] ==1){


//Definimos el inicio del vector
  start[4] = new PVector (449, 463);
//Definimos el final del vector
  end[4] = new PVector (958, 439);
  
//Lanzamos la función vector con interacción Lerp
  PVector current4 = new PVector (lerp (start[4].x, end[4].x, m[4]), lerp (start[4].y, end[4].y, m[4]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[4].x, start[4].y, current4.x, current4.y);
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[4]+= 0.005;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[4] >= 1){
    m[4] = 1;
  } 
}

//------------------Creamos sexta línea-------------------------
if (m[3] ==1 & offLine2 == false){
//Definimos el inicio del vector
  start[5] = new PVector (1276, 470);
//Definimos el final del vector
  end[5] = new PVector (1276, 700);
  
//Lanzamos la función vector con interacción Lerp
  PVector current5 = new PVector (lerp (start[5].x, end[5].x, m[5]), lerp (start[5].y, end[5].y, m[5]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[5].x, start[5].y, current5.x, current5.y);
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[5]+= 0.006;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[5] >= 1){
    m[5] = 1;
  } 
}

//------------------Creamos septima línea-------------------------
if (m[5] ==1){


//Definimos el inicio del vector
  start[6] = new PVector (Xver2, Yver2);
//Definimos el final del vector
  end[6] = new PVector (XendLine2,YendLine2);
  
//Lanzamos la función vector con interacción Lerp
  PVector current6 = new PVector (lerp (start[6].x, end[6].x, m[6]), lerp (start[6].y, end[6].y, m[6]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[6].x, start[6].y, current6.x, current6.y);
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[6]+= 0.006;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[6] >= 1){
    m[6] = 1;
  } 
}

//------------------Creamos octaba línea-------------------------
if (m[5] ==1){


//Definimos el inicio del vector
  start[8] = new PVector (Xver2, Yver2);
//Definimos el final del vector
  end[8] = new PVector (449, 673);
  
//Lanzamos la función vector con interacción Lerp
  PVector current8 = new PVector (lerp (start[8].x, end[8].x, m[8]), lerp (start[8].y, end[8].y, m[8]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[8].x, start[8].y, current8.x, current8.y);
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[8]+= 0.006;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[8] >= 1){
    m[8] = 1;
  } 
}



//------------------Movemos vertice 1-------------------------
if (m[8] == 1){
//Definimos el inicio del vector
  start[9] = new PVector (Xver1, Yver1);
//Definimos el final del vector
  end[9] = new PVector (707, 487);
  
//Lanzamos la función vector con interacción Lerp
  PVector current9 = new PVector (lerp (start[9].x, end[9].x, m[9]), lerp (start[9].y, end[9].y, m[9]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  Xver1 = current9.x;
  
  Yver1 = current9.y;
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[9]+= 0.0001;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[9] >= 1){
    m[9] = 1;
  }
}

//------------------Movemos vertice 2-------------------------
if (m[8] == 1){
//Definimos el inicio del vector
  start[10] = new PVector (Xver2, Yver2);
//Definimos el final del vector
  end[10] = new PVector (707, 660);
  
//Lanzamos la función vector con interacción Lerp
  PVector current10 = new PVector (lerp (start[10].x, end[10].x, m[10]), lerp (start[10].y, end[10].y, m[10]));

//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  Xver2 = current10.x;
  
  Yver2 = current10.y;
  
//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[10]+= 0.0001;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[10] >= 1){
    m[10] = 1;
  }
}


//------------------------------------------------------------------------------------
//Reseteamos el Homing cuando ya lo haya realizado
	if (homeFin == true){
		step = 1;
		homeFin = false;
	}
}