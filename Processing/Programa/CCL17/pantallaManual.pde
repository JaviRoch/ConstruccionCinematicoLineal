void pantallaManual() {
    
//Creamos la fuente para manual
  PFont font = createFont("arial",20);

//Creamos campo entrada variable Velocidad
  cp5.addTextfield("cuerda_T")
     .setPosition(20,100)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;

//Creamos campo texto variable cuerda Velocidad
  myTextarea0 = cp5.addTextarea("txt0")
                   .setPosition(160,100)
                   .setSize(60,40)
                   .setFont(createFont("arial",20))
                   .setColor(color(255))
                   ;

//Creamos campo entrada variable eje U
  cp5.addTextfield("eje_U")
     .setPosition(20,200)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
     
//Creamos campo texto variable eje U
  myTextarea1 = cp5.addTextarea("txt1")
                   .setPosition(160,200)
                   .setSize(60,40)
                   .setFont(createFont("arial",20))
                   .setColor(color(255))
                   ;
                   
//Creamos campo entrada variable eje V
  cp5.addTextfield("eje_V")
     .setPosition(20,300)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;

//Creamos campo texto variable eje V
  myTextarea2 = cp5.addTextarea("txt2")
                   .setPosition(160,300)
                   .setSize(60,40)
                   .setFont(createFont("arial",20))
                   .setColor(color(255))
                   ;
                   
//Creamos campo entrada variable eje W
  cp5.addTextfield("eje_W")
     .setPosition(20,400)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;    
     
//Creamos campo texto variable eje W
  myTextarea3 = cp5.addTextarea("txt3")
                   .setPosition(160,400)
                   .setSize(60,40)
                   .setFont(createFont("arial",20))
                   .setColor(color(255))
                   ;

//Creamos campo entrada variable eje X
  cp5.addTextfield("eje_X")
     .setPosition(20,500)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ; 
     
//Creamos campo texto variable eje X
  myTextarea4 = cp5.addTextarea("txt4")
                   .setPosition(160,500)
                   .setSize(60,40)
                   .setFont(createFont("arial",20))
                   .setColor(color(255))
                   ;

//Creamos campo entrada variable eje Y
  cp5.addTextfield("eje_Y")
     .setPosition(20,600)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ; 
     
//Creamos campo texto variable eje Y
  myTextarea5 = cp5.addTextarea("txt5")
                   .setPosition(160,600)
                   .setSize(60,40)
                   .setFont(createFont("arial",20))
                   .setColor(color(255))
                   ;
                   
//Creamos campo entrada variable eje Z
  cp5.addTextfield("eje_Z")
     .setPosition(20,700)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ; 
     
//Creamos campo texto variable eje Z
  myTextarea6 = cp5.addTextarea("txt6")
                   .setPosition(160,700)
                   .setSize(60,40)
                   .setFont(createFont("arial",20))
                   .setColor(color(255))
                   ;

//Creamos campo entrada variable cuerda F
  cp5.addTextfield("velocidad_F")
     .setPosition(20,800)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;

//Creamos campo texto variable cuerda F
  myTextarea7 = cp5.addTextarea("txt7")
                   .setPosition(160,800)
                   .setSize(60,40)
                   .setFont(createFont("arial",20))
                   .setColor(color(255))
                   ;

  cp5.addBang("Carga_datos")
     .setPosition(20, 900)
     .setSize(80, 35)
     ;

//Creamos el slider de cambio de step
  cp5.addSlider("step")
     .setPosition(20,1020)
     .setSize(500,40)
     .setRange(0,20)
     ;
}