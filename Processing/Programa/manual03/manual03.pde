import controlP5.*;

ControlP5 cp5;

public float man_U = 0;
public float man_V = 0;
public float man_W = 0;
public float man_X = 0;
public float man_Y = 0;
public float man_Z = 0;
public float man_T = 0;
public int step = 0;



public void setup(){

  //Abrimos visualización a pantalla completa en la pantalla número 1
  fullScreen(1);

  //Creamos oculto controlP5
  cp5 = new ControlP5(this);
  cp5.hide();
  
  //Carga de elementos de manejo manuales
  pantallaManual();
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

  //Aumentamos de step con signo'+'
  if (key == '+') {
    step = step +1;
    
  }
  
} 

public void draw(){

  //Carga de datos en pantalla Manual
  datosManual();

  background(0);
  noStroke();

  //Visualización de datos
  

  println("man_U: "+man_U);
  println("step: "+step);

}




  