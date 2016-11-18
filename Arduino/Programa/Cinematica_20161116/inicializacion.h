

void inicializacion() {
  pinMode(X1_MIN_PIN, INPUT_PULLUP);
  pinMode(X1_STEP_PIN, OUTPUT); 
  pinMode(X1_DIR_PIN, OUTPUT); 
  pinMode(X1_ENABLE_PIN, OUTPUT); 

  pinMode(Y1_MIN_PIN, INPUT_PULLUP);
  pinMode(Y1_STEP_PIN, OUTPUT); 
  pinMode(Y1_DIR_PIN, OUTPUT); 
  pinMode(Y1_ENABLE_PIN, OUTPUT);

  pinMode(Z1_MIN_PIN, INPUT_PULLUP);
  pinMode(Z1_STEP_PIN, OUTPUT); 
  pinMode(Z1_DIR_PIN, OUTPUT); 
  pinMode(Z1_ENABLE_PIN, OUTPUT);  

  pinMode(E1_MIN_PIN, INPUT_PULLUP);
  pinMode(E1_STEP_PIN, OUTPUT); 
  pinMode(E1_DIR_PIN, OUTPUT); 
  pinMode(E1_ENABLE_PIN, OUTPUT); 

  digitalWrite(X1_ENABLE_PIN, HIGH); 
  digitalWrite(Y1_ENABLE_PIN, HIGH);
  digitalWrite(Z1_ENABLE_PIN, HIGH);
  digitalWrite(E1_ENABLE_PIN, HIGH);

  Serial.begin(9600);

}
