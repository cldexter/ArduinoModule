int buzzerPin=7;       // 固定脚,7,棕黄,"I"

void setup()  {
  Serial.begin(9600);
  // declare pin 9 to be an output:
  pinMode(buzzerPin,OUTPUT);//设置模拟信号IO脚模式，OUTPUT为输出
}

void beep()
{
  tone(buzzerPin,1209,100);
  tone(buzzerPin,697,100);
}
