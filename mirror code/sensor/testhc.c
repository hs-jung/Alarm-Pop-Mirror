#include <stdio.h>
#include <wiringPi.h>

#define TRIG 5
#define ECHO 4
#define MAX 30
#define MIN 0

int main(void){

	int distance = 0;
	int pulse = 0;
	int count = 0; 
	int flag = 0;
	FILE *f;

	f = fopen("/var/www/html/mirror/flag.txt","w");
	fprintf(f,"{\"flag\":\"0\"}");
	fclose(f);

	if(wiringPiSetup() == -1){
		return 1;
	}

	pinMode(ECHO,OUTPUT);
	pinMode(ECHO,INPUT);

	for(;;){
		digitalWrite(TRIG,LOW);
		usleep(2);
		digitalWrite(TRIG,HIGH);
		usleep(20);

		digitalWrite(TRIG,LOW);

		while(digitalRead(ECHO) == LOW);
		long startTime = micros();
		while(digitalRead(ECHO) == HIGH);
		long travleTime = micros() - startTime;

		int distance = travleTime / 58;
		
		if(distance <=150){
			if(count < MAX){
				count ++;
			}
			if(count== MAX){
				if(flag == 0){
					flag = 1;
					f = fopen("/var/www/html/mirror/flag.txt","w");
					fprintf(f,"{\"flag\":\"1\"}");
					fclose(f);
				}	
		}
		}else{
			if(count> MIN){
				count --;
			}
			if(count == MIN){
				if(flag == 1){
					flag = 0;
					f = fopen("/var/www/html/mirror/flag.txt","w");
					fprintf(f,"{\"flag\":\"0\"}");
					fclose(f);
				}
			}
		}

		if(flag == 0){
			printf("Not Detected ,Distance : %dcm ,count : %d\n",distance,count);
		}else{
			printf("Detected ,Distance : %dcm, count : %d\n", distance,count);
		}
		delay(100);
	}
}	
