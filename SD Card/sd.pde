/*
 
 此例子展示如何在SD卡中创建于删除文件
 * SD卡与arduino控制板使用SPI总线连接
 ** MOSI - pin 11
 ** MISO - pin 12
 ** CLK - pin 13
 ** CS - pin 4
          
 */
#include <SD.h>
 
File myFile;
 
void setup()
{
  Serial.begin(9600);  //设置串口通信波特率为9600
  Serial.print("Initializing SD card...");  //串口输出数据Initializing SD card...
  pinMode(53, OUTPUT);
 
  if (!SD.begin(4)) {  //如果从CS口与SD卡通信失败，串口输出信息initialization failed!
    Serial.println("initialization failed!");
    return;
  }
  Serial.println("initialization done.");  //CS口与SD卡通信成功，串口输出信息initialization done.
 
  if (SD.exists("example.txt")) {  //检查example.txt文件是否存在
    Serial.println("example.txt exists.");  //如果存在输出信息example.txt exists.至串口
  }
  else {
    Serial.println("example.txt doesn't exist.");  //不存在输出信息example.txt doesn't exist.至串口
  }
 
  Serial.println("Creating example.txt...");
  myFile = SD.open("example.txt", FILE_WRITE);  //打开example.txt，如果没有自动创建，写入状态
  myFile.close();  //关闭文件
 
  if (SD.exists("example.txt")) {
    Serial.println("example.txt exists.");
  }
  else {
    Serial.println("example.txt doesn't exist.");  
  }
 
  Serial.println("Removing example.txt...");
  SD.remove("example.txt");  //删除文件example.txt
 
  if (SD.exists("example.txt")){ 
    Serial.println("example.txt exists.");
  }
  else {
    Serial.println("example.txt doesn't exist.");  
  }
}
 
void loop()
{
 
}