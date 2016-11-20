void step1(){
	
background(0);
noCursor();

image(img1,200,100);

/*
Creamos primera línea
*/

//Definimos el inicio del vector
  start = new PVector (20, 50);
//Definimos el final del vector
  end = new PVector (900, 700);
  
//Lanzamos la función vector con interacción Lerp
  PVector current = new PVector (lerp (start.x, end.x, m), lerp (start.y, end.y, m));

  strokeWeight (3);
  stroke (255);
//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start.x, start.y, current.x, current.y);


//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m+= 0.01;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m >= 1){
    m = 1;
  }
 
/*
Creamos segunda línea
*/
  
//Definimos el inicio del vector
  start1 = new PVector (1200, 500);
//Definimos el final del vector
  end1 = new PVector (900, 700);

  
  
//Lanzamos la función vector con interacción Lerp
  PVector current1 = new PVector (lerp (start1.x, end1.x, m1), lerp (start1.y, end1.y, m1));

  strokeWeight (3);
  stroke (255);
//Dibujamos la línea desde el inicio hasta la variable temporal de PVector
  line (start1.x, start1.y, current1.x, current1.y);


//Aumentamos el valor de interpolación en cada ciclo, irá desde 0.0 hasta 1.0
//Modificando este valor definiremos la velocidad.
  m1+= 0.01;
//Cuando m sea mayor o igual que uno le cargamos 1 a m para fijar la línea. Esto ocurre cuando la línea ha llegado a sus coordenadas de final
  if (m1 >= 1){
    m1 = 1;
  }

//!!!!!Poner a 0 variables m al salir del step!!!!!!!!!!

}