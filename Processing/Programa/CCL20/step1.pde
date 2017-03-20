void step1(){
	
background(255);

//Carga de imágenes
  img[1] = loadImage("lanzarote1.jpg");
  image(img[1],200,100);

//Enviamos coordenadas a arduino
if(okCoordenadas == false){
  distanciaOn = true;
  myPort.write("U300V0W100X300Y0Z5F30\r");
  destAlcanzado = false; //Reseteamos la anterior señal de destino alcanzado
}

//------------------Creamos primera línea-------------------------

//Definimos el inicio del vector
  start[0] = new PVector (20, 50);
//Definimos el final del vector
  end[0] = new PVector (900, 700);
  
//Lanzamos la función vector con interacción Lerp
  PVector current = new PVector (lerp (start[0].x, end[0].x, m[0]), lerp (start[0].y, end[0].y, m[0]));

  strokeWeight (2);
  stroke (0);
//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[0].x, start[0].y, current.x, current.y);


//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[0]+= 0.01;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[0] >= 1){
    m[0] = 1;
  }
 
//---------------------Creamos segunda línea---------------------------------
  
//Definimos el inicio del vector
  start[1] = new PVector (1200, 500);
//Definimos el final del vector
  end[1] = new PVector (900, 700);

  
  
//Lanzamos la función vector con interacción Lerp
  PVector current1 = new PVector (lerp (start[1].x, end[1].x, m[1]), lerp (start[1].y, end[1].y, m[1]));

  strokeWeight (2);
  strokeJoin(BEVEL);
  stroke (0);
//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start[1].x, start[1].y, current1.x, current1.y);


//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m[1]+= 0.01;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m[1] >= 1){
    m[1] = 1;
  }
  
//----------------------------Creamos visualización línea física---------------------

  stroke (255,0,0);
  line(virU,virV,virX,virY);
}

//!!!!!Poner a 0 variables m al salir del step!!!!!!!!!!
//!!!!!Poner a false okCoordenadas salir del step!!!!!!!!!!
//!!!!!Poner a false distanciaOn!!!