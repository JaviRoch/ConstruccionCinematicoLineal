

void inicializacion() {
  
/* Configuración de salidas eje T*/
  pinMode(T_STEP_PIN, OUTPUT); 
  pinMode(T_DIR_PIN, OUTPUT); 
  pinMode(T_ENABLE_PIN, OUTPUT);
  pinMode(T_MIN_PIN, INPUT_PULLUP); 
  pinMode(T_MAX_PIN, INPUT_PULLUP); 

/* Configuración de salidas eje U*/
  pinMode(U_STEP_PIN, OUTPUT); 
  pinMode(U_DIR_PIN, OUTPUT); 
  pinMode(U_ENABLE_PIN, OUTPUT);
  pinMode(U_MIN_PIN, INPUT_PULLUP); 
  pinMode(U_MAX_PIN, INPUT_PULLUP); 

/* Configuración de salidas eje V*/
  pinMode(V_STEP_PIN, OUTPUT); 
  pinMode(V_DIR_PIN, OUTPUT); 
  pinMode(V_ENABLE_PIN, OUTPUT);  
  pinMode(V_MIN_PIN, INPUT_PULLUP); 
  pinMode(V_MAX_PIN, INPUT_PULLUP); 

/* Configuración de salidas eje W*/
  pinMode(W_STEP_PIN, OUTPUT); 
  pinMode(W_DIR_PIN, OUTPUT); 
  pinMode(W_ENABLE_PIN, OUTPUT); 
  pinMode(W_MIN_PIN, INPUT_PULLUP); 
  pinMode(W_MAX_PIN, INPUT_PULLUP); 

/* Configuración de salidas eje X*/
  pinMode(X_STEP_PIN, OUTPUT); 
  pinMode(X_DIR_PIN, OUTPUT); 
  pinMode(X_ENABLE_PIN, OUTPUT); 
  pinMode(X_MIN_PIN, INPUT_PULLUP); 
  pinMode(X_MAX_PIN, INPUT_PULLUP); 

/* Configuración de salidas eje Y*/
  pinMode(Y_STEP_PIN, OUTPUT); 
  pinMode(Y_DIR_PIN, OUTPUT); 
  pinMode(Y_ENABLE_PIN, OUTPUT); 
  pinMode(Y_MIN_PIN, INPUT_PULLUP); 
  pinMode(Y_MAX_PIN, INPUT_PULLUP); 

/* Configuración de salidas eje Z*/
  pinMode(Z_STEP_PIN, OUTPUT); 
  pinMode(Z_DIR_PIN, OUTPUT); 
  pinMode(Z_ENABLE_PIN, OUTPUT); 
  pinMode(Z_MIN_PIN, INPUT_PULLUP); 
  pinMode(Z_MAX_PIN, INPUT_PULLUP); 

/* Desconectamos los motores al arrancar */
  digitalWrite(T_ENABLE_PIN, HIGH); 
  digitalWrite(U_ENABLE_PIN, HIGH);
  digitalWrite(V_ENABLE_PIN, HIGH);
  digitalWrite(W_ENABLE_PIN, HIGH);
  digitalWrite(X_ENABLE_PIN, HIGH);
  digitalWrite(Y_ENABLE_PIN, HIGH);
  digitalWrite(Z_ENABLE_PIN, HIGH);

/* Configuramos la velocidad de comunicación */
  Serial.begin(57600);

}
