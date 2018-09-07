#include "MC20_Common.h"
#include "MC20_Arduino_Interface.h"
#include "MC20_GPRS.h"
#include "MC20_GNSS.h"
#include <Wire.h>
#include <rBase64.h>
\
// #define OLED_OPEN

#define RGBPIN 10
#define HOST "track-j.herokuapp.com"
#define URL_EVENT "/api/v1/posicoes/post_posicoes/"
#define PORT 80
#define AUTH "fb24239cefa19d5f025cceae7b63cb54"



GPRS gprs = GPRS();
GNSS gnss = GNSS();

char body[180];

const char apn[10] = "CMNET";
const char URL[100] = "track-j.herokuapp.com";
char http_cmd[100] = "POST /api/v1/posicoes/post_posicoes";
int port = 80;

int ret = 0;
String coordinate;
void postCoordinate();


void setup() {
  pinMode(12, OUTPUT);
  digitalWrite(12, HIGH);
  pinMode(RGBPIN, OUTPUT);
  digitalWrite(RGBPIN, LOW);
  SerialUSB.begin(115200);
  gprs.Power_On();
  SerialUSB.println("\n\rPower On!");



  /**
     Init GNSS
  */
  while (!gnss.open_GNSS(EPO_QUICK_MODE)) {
    SerialUSB.println("Open GNSS failed!");
  }
  SerialUSB.println("Open GNSS OK.");

  // delay(2000);

  /**
     Init GPRS
  */
  if (!(ret = gprs.init(apn))) {
    SerialUSB.print("GPRS init error: ");
    SerialUSB.println(ret);
  }

  gprs.join();
  SerialUSB.print("\n\rIP: ");
  SerialUSB.print(gprs.ip_string);

}

void loop()
{
  static uint32_t searchCnt = 0;
  /**
     Get GPS coordinate
  */
  // char buffer[64];
  if (gnss.getCoordinate())
  {
    SerialUSB.print("GNSS: ");

    float latitude = gnss.latitude;
    float longitude = gnss.longitude;

    coordinate = "";
    coordinate += F("-");
    coordinate += String(latitude, 6);
    coordinate += F(",-");
    coordinate += String(longitude, 6);

    SerialUSB.println(coordinate);
  }
  else
  {
    SerialUSB.println("Error!");
  }

  postCoordiante(coordinate);
  delay(1000);
}

/**
   POST to server
*/
void postCoordiante(String coordinate)
{
  SerialUSB.println("------POST-----");
  SerialUSB.println(coordinate);
  char body[180];
  if (gprs.connectTCP(URL, port))
  {
    bool ret;
    char postContent[200];

//    char coordenadas[50];
//    coordenadas = strcat("", coordinate);

    sprintf(body, "{\"coordenadas_geograficas\":\"%s\",\"captured_at\": \"2018-01-01\",\"token\": \""AUTH"\"}", coordinate.c_str());

    /**
        Load latlng data to postContent
    */
    MC20_clean_buffer(postContent, 100);
//    rbase64.encode(Encoding.Default.GetBytes(AUTH + ":" + ""));

//    sprintf(postContent, "POST %s HTTP/1.1\r\nContent-Type: application/json\r\nHost: %s\r\nAuthorization: Basic %s\r\nContent-Length: %d\r\n\r\n%s", URL_EVENT, HOST, rbase64.encode(AUTH ":"), strlen(body), body);
    sprintf(postContent, "POST %s HTTP/1.1\r\nContent-Type: application/json\r\nHost: %s\r\nContent-Length: %d\r\n\r\n%s", URL_EVENT, HOST, strlen(body), body);
    SerialUSB.print(postContent);
    gprs.sendTCPData(postContent);   // Send HTTP request
    ret = MC20_wait_for_resp("CLOSED\r\n", CMD, 10, 2000, true);
    SerialUSB.print("Wait for request: ");
    SerialUSB.println(ret, DEC);
  }
  else
  {
    SerialUSB.println("Connect Error!");
  }
}
