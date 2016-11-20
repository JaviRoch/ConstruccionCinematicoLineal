import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CCL03 extends PApplet {




ControlP5 cp5;
Serial Port;
PImage img1;

float man_U = 0;
float man_V = 0;
float man_W = 0;
float man_X = 0;
float man_Y = 0;
float man_Z = 0;
float man_T = 0;
int step = 0;

boolean home = false;
boolean homeFin = false;


String mensajeSerial = null;

public void setup(){


  Port = new Serial(this, "COM4",9600);

//Abrimos visualizaci\u00f3n a pantalla completa en la pantalla n\u00famero 1
  

//Creamos oculto controlP5
  cp5 = new ControlP5(this);
  cp5.hide();
  
//Carga de elementos de manejo manuales
  pantallaManual();

//Carga de im\u00e1genes
  img1 = loadImage("lanzarote1.jpg");
  
}

public void keyPressed() {
  
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
  
} 

public void comSerial(){

  //"Si hay algo en el puerto serial". En esta l\u00ednea estamos accediendo a la funci\u00f3n de escucha dentro de la clase Serial, por medio de nuestra copia personalizada 'port'.
  if(Port.available()>0){
    //Igualamos a nuestra variable de texto a lo que nos devuelva la funci\u00f3n readStringUntil. 
    //Dicha funci\u00f3n lee todo lo que haya en el puerto serial hasta que encuentre un 'Enter', representado por el caracter especial '\n'.
    //Cabe destacar que este 'Enter' es el mismo que el Arduino escribe al final de cada l\u00ednea por usar Serial.println
    mensajeSerial = Port.readStringUntil('\n');
    println(65);
  }
  
  //Si el mensaje recibido por serial no est\u00e1 vac\u00edo.
  if(mensajeSerial!=null){

    mensajeSerial = Port.readString();
    println(mensajeSerial);
    println(65);
    
  }

}

public void draw(){

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

//Carga de datos en pantalla Manual
  datosManual();

  noStroke();

//Visualizaci\u00f3n de datos
  //println("man_U: "+man_U);
  //println("step: "+step);

}




  
public void datosManual(){

	cp5.getController("man_U").setValue(man_U);
	cp5.getController("man_V").setValue(man_V);
	cp5.getController("man_W").setValue(man_W);
	cp5.getController("man_X").setValue(man_X);
	cp5.getController("man_Y").setValue(man_Y);
	cp5.getController("man_Z").setValue(man_Z);
	cp5.getController("man_T").setValue(man_T);
	cp5.getController("step").setValue(step);


}
public void pantallaManual() {
    
// Creamos slider motor U   
   cp5.addNumberbox("man_U")
     .setPosition(20,40)
     .setSize(20,100)
     .setRange(0,1200)
     //.setMultiplier(0.1)
     .setScrollSensitivity(50.1f)
     .setValue(0)
     ;

// Creamos slider motor V en horizontal  
   cp5.addNumberbox("man_V")
     .setPosition(70,80)
     .setSize(100,20)
     .setRange(0,1200)
     //.setMultiplier(0.1)
     .setDirection(Controller.HORIZONTAL)
     .setScrollSensitivity(50.1f)
     .setValue(0)
     ;
  
// Creamos slider motor W en horizontal  
   cp5.addNumberbox("man_W")
     .setPosition(70,120)
     .setSize(100,20)
     .setRange(0,1200)
     //.setMultiplier(0.1)
     .setDirection(Controller.HORIZONTAL)
     .setScrollSensitivity(50.1f)
     .setValue(0)
     ;
     
// Creamos slider motor X   
   cp5.addNumberbox("man_X")
     .setPosition(20,200)
     .setSize(20,100)
     .setRange(0,1200)
     //.setMultiplier(0.1)
     .setScrollSensitivity(50.1f)
     .setValue(0)
     ;
  
// Creamos slider motor Y en horizontal 
   cp5.addNumberbox("man_Y")
     .setPosition(70,240)
     .setSize(100,20)
     .setRange(0,1200)
     //.setMultiplier(0.1)
     .setDirection(Controller.HORIZONTAL)
     .setScrollSensitivity(50.1f)
     .setValue(0)
     ;
  
// Creamos slider motor Z en horizontal  
   cp5.addNumberbox("man_Z")
     .setPosition(70,280)
     .setSize(100,20)
     .setRange(0,1200)
     //.setMultiplier(0.1)
     .setDirection(Controller.HORIZONTAL)
     .setScrollSensitivity(50.1f)
     .setValue(0)
     ;
  
// Creamos slider motor Y   
   cp5.addNumberbox("man_T")
     .setPosition(20,360)
     .setSize(170,20)
     .setRange(0,1200)
     //.setMultiplier(0.1)
     .setDirection(Controller.HORIZONTAL)
     .setScrollSensitivity(50.1f)
     .setValue(0)
     ; 

//Creamos el toggle de fin de Homing
  cp5.addButton("homeFin")
     .setPosition(20,460)
     .setSize(70,30)
     .setOn()
     ; 

//Creamos el slider de cambio de step
   cp5.addSlider("step")
     .setPosition(20,1020)
     .setSize(500,40)
     .setRange(0,20)
     ;
 
}
public void step0(){


//Activamos el Homing
	home = true;


//Simulaci\u00f3n temporal
	
	background(125);
 	textAlign(CENTER);
	textSize(82);
	text("home", width/2, 300); 
	fill(0, 102, 153);
	text("homing", width/2, 600);
	fill(0, 102, 153, 51);
	text("home", width/2, 900);
	

//Reseteamos el Homing
	if (homeFin == true){
		home = false;
		step = 1;
		homeFin = false;
	}
}
public void step1(){
	
background(0);

image(img1,200,100);

if (key == 's'){

	Port.write("U20 V30");	
}



}
public void step2(){
	
}
public void step3(){
	
}
public void step4(){
	
}
public void step5(){
	
}
public void step6(){
	
}
public void step7(){
	
}
public void step8(){
	
}
  public void settings() {  fullScreen(1); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CCL03" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
