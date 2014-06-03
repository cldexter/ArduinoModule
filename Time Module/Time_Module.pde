/* 
Example sketch for interfacing with the DS1302 timekeeping chip.
http://quadpoint.org/projects/arduino-ds1302
*/

#include <stdio.h>
#include <string.h>
#include <DS1302.h> //用配套的库(库名一样, 但是代码不通用的)

int buzzerPin=7;       // pin for buzzer

/* Set the appropriate digital I/O pin connections */
uint8_t T_CE_PIN   = 13; //"RST,R,黄色,固定"
uint8_t T_IO_PIN   = 12; //"DAT,D,橙色,固定"
uint8_t T_SCLK_PIN = 11; //"CLK,C,红色,固定"

/* Create buffers */
char T_time[50];
char T_time_s[15];
char T_weekday[10];

/* Create a DS1302 object 定义1302模块调用针脚*/
DS1302 rtc(T_CE_PIN, T_IO_PIN, T_SCLK_PIN);


void print_time()
{
  /* Get the current time and date from the chip */
  Time t = rtc.time();

  /* Name the day of the week 显示时间信息*/
  memset(T_weekday, 0, sizeof(T_weekday));  /* clear T_weekday buffer */
  switch (t.day) {
    case 1:
      strcpy(T_weekday, "SUN");
      break;
    case 2:
      strcpy(T_weekday, "MON");
      break;
    case 3:
      strcpy(T_weekday, "TUE");
      break;
    case 4:
      strcpy(T_weekday, "WED");
      break;
    case 5:
      strcpy(T_weekday, "THU");
      break;
    case 6:
      strcpy(T_weekday, "FRI");
      break;
    case 7:
      strcpy(T_weekday, "SAT");
      break;
  }

  /* Format the time and date and insert into the temporary bufffer */
  snprintf(T_time, sizeof(T_time), "%s %04d-%02d-%02d %02d:%02d:%02d",
           T_weekday,
           t.yr, t.mon, t.date,
           t.hr, t.min, t.sec);

  snprintf(T_time_s, sizeof(T_time_s), "%02d-%02d %02d:%02d:%02d",
           t.mon, t.date, t.hr, t.min, t.sec);

  /* Print the formatted string to serial so we can see the time */
  Serial.println(T_time);
  delay(1000);
  Serial.println(T_time_s);//简化的时间

  if(t.min == 23){
  beep();
  }

}

//下面的代码只需要做一次即可
void setup()
{
  Serial.begin(9600);
  pinMode(buzzerPin,OUTPUT);//设置模拟信号IO脚模式，OUTPUT为输出
  /* Initialize a new chip by turning off write protection and clearing the
     clock halt flag. These methods needn't always be called. See the DS1302
     datasheet for details. */
  // rtc.write_protect(false);
  // rtc.halt(false);

  // /* Make a new time object to set the date and time */
  // /*   2014年6月1日14点15分50秒周日.            */
  // Time t(2014, 6, 1, 14, 15, 50, 1);

  // /* Set the time and date on the chip */
  // rtc.time(t);
}

void beep()
{
  tone(buzzerPin,1209,100);
  delay(100);
  tone(buzzerPin,697,100);
}

/* Loop and print the time every second */
void loop()
{
  print_time();
  delay(1000);
}
