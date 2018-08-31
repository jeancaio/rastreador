#include "MC20_Common.h"
#include "MC20_Arduino_Interface.h"
#include "MC20_GPRS.h"
#include "MC20_GNSS.h"
#include <Wire.h>

// #define OLED_OPEN

#define RGBPIN 10
#define HOST "track-j.herokuapp.com"
#define URL_EVENT "/api/v1/posicoes/post_posicoes/"
#define PORT 80



GPRS gprs = GPRS();
GNSS gnss = GNSS();

char body[180];

const char apn[10] = "CMNET";
const char URL[100] = "http://track-j.herokuapp.com";
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
  coordinate = "";
  /**
     Get GPS coordinate
  */
  // char buffer[64];
  if (gnss.getCoordinate())
  {
    SerialUSB.print("GNSS: ");
    //    SerialUSB.print(gnss.longitude, 6);
    //    SerialUSB.print(",");
    //    SerialUSB.println(gnss.latitude, 6);
    //    SerialUSB.print(gnss.str_longitude);
    //    SerialUSB.print(",");
    //    SerialUSB.println(gnss.str_latitude);


    float latitude = gnss.latitude;
    float longitude = gnss.longitude;

    coordinate += String(latitude, 6);
    coordinate += F(",");
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

void puostCoordiante(String coordinate) {

}

/**
   POST to server
*/
void postCoordiante(String coordinate)
{
    char body[180];
  if (gprs.connectTCP(URL, port))
  {
    bool ret;
    char postContent[200];

    sprintf(body, "{\"coordenadas_geograficas\":\"John\",\"captured_at\": \"2018-01-01\"}");
    //    sprintf(body,"%s%s", body, "\"coordenadas_geograficas\":\"" + COORDINATE + "\"");
    //    sprintf(body,"%s%s", body, "\"}");
    SerialUSB.print("BODY: ");
    SerialUSB.println(body);
    /**
        Load latlng data to postContent
    */
    MC20_clean_buffer(postContent, 100);

    sprintf(postContent, "POST %s HTTP/1.1\r\nContent-Type: application/json\r\nHost: %s\r\nContent-Length: %d\r\n\r\n%s", URL_EVENT, HOST, strlen(body), body);
//    sprintf(postContent, "POST /api/v1/posicoes/post_posicoes/ HTTP/1.0\n\r\n\r");
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
