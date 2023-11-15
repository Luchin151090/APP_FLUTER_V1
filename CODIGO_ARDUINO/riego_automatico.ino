#include<SoftwareSerial.h>
float p_humedad = 0.0;
int in_ana = A0;
int lectura = 0;
int low =8;
int medium = 9;
int high = 10;


SoftwareSerial miBT(11, 12); //Instancia la conexion al bluetooth - PIN 10 a TX y PIN 11 a RX

char NOMBRE[21] = "HC-06-Bluetooth"; // NOMBRE DE 20 CARACTERES MAXIMO
char BPS        = '4'; //1=1200, 2=2400, 3=4800, 4=9600, 5=19200, 6=38400, 7=57600, 8=115200 
char PASSWORD[5]   = "4444"; //PIN O CLAVE DE 4 CARACTERES     

void setup(){
   Serial.begin(9600); 
  /* ESTABLECER CONFIGURACIÓN BLUETOOTH*/
  miBT.begin(9600); //Inicia la comunicacion en el modulo HC-06

  Serial.println("Todos OK");

  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH); //Encinde el LED 13
  delay(5000); //Se enciende por 5s

  digitalWrite(13, LOW);

  Serial.println("Enviando comandos AT"); //Imprime en el monitor serial

  miBT.print("AT"); //INICIALIZA COMANDO AT
  delay(1000); //esperamos 1 segundo

  miBT.print("AT+NAME"); //Configurando el nuevo nombre
  miBT.print(NOMBRE);
  delay(1000);

  miBT.print("AT+BAUD"); //Configurando la nueva velocidad
  miBT.print(BPS);
  delay(1000);

  miBT.print("AT+PIN"); //Configurando el nuevo PASSWORD
  miBT.print(PASSWORD);
  delay(1000);

  Serial.println("Fin de los comandos AT");



   pinMode(in_ana,INPUT);
  //SALIDAS
   pinMode(low,OUTPUT);
   pinMode(medium,OUTPUT);
   pinMode(high,OUTPUT);
  //INICIAMOS APAGADO
   digitalWrite(low,LOW);
  digitalWrite(medium,LOW);
  digitalWrite(high,LOW);
}

void loop(){
  lectura = analogRead(in_ana);
  p_humedad = map(lectura,950,0,0,100);
  p_humedad = constrain(p_humedad,0,100);

  if(p_humedad >=0 && p_humedad <=30){
  	digitalWrite(low,HIGH);
    digitalWrite(medium,LOW);
  digitalWrite(high,LOW);
  }
  else if(p_humedad >30 && p_humedad <=60){
    digitalWrite(medium,HIGH);
    digitalWrite(low,LOW);
  digitalWrite(high,LOW);
  }
  else if(p_humedad >60){
    digitalWrite(high,HIGH);
    digitalWrite(medium,LOW);
  digitalWrite(low,LOW);
  }

  miBT.print("  ");
  miBT.print(p_humedad);
  
  Serial.println(p_humedad);  // Imprime la lectura analógica directamente
  
  delay(1000);  // Añade un pequeño retardo para facilitar la visualización de los valores
}
