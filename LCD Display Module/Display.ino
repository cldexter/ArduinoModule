/*
  Arduino驱动LCD12864显示
  BY YFRobot
*/

#include "LCD12864RSPI.h"
#define AR_SIZE( a ) sizeof( a ) / sizeof( a[0] )
unsigned char show0[]="M01:OFF|"; //YFROBOT
unsigned char show1[]="M02:ON |"; //工作室
unsigned char show2[]="M03:OFF|"; //Touch You Future
unsigned char show3[]="M04:OFF|";

void setup(){
  LCDA.Initialise(); // 屏幕初始化
  delay(100);
}


void moterCondition(){
  LCDA.CLEAR();//清屏
  LCDA.DisplayString(0,0,show0,AR_SIZE(show0));//第一行第一格开始，显示"YFROBOT"
  LCDA.DisplayString(1,0,show1,AR_SIZE(show1));//第一行第五个字开始，显示文字"工作室"
  LCDA.DisplayString(2,0,show2,AR_SIZE(show2));//第三行第一格开始，显示"Touch You Future"
  LCDA.DisplayString(3,0,show3,AR_SIZE(show3));
}

void loop(){  
  moterCondition();
  delay(3000);
}