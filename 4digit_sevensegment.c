#include<LPC17xx.h>
int main(){
	int arr[]={0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
	int n=0, count=0, temp, i, j, sw;
	SystemInit();
	SystemCoreClockUpdate();
	LPC_PINCON->PINSEL0 = 0;
	LPC_PINCON->PINSEL3 = 0;
	LPC_PINCON->PINSEL4 = 0;
	LPC_GPIO0->FIODIR = 0xFF<<4;
	LPC_GPIO1->FIODIR = 0xF<<23;
LPC_GPIO2->FIODIR = 0;
	while(1){
		if(count==500){
			sw = LPC_GPIO2 -> FIOPIN;
			sw = sw & 1<<0;
			if(sw == 0)
				n=(n+1)%10000;
			else{
				if(n==0)
					n=9999;
				else
					n=n-1;
			}
			count=0;
		}
		temp = n;
		for(i=0; i<4; i++){
			LPC_GPIO1->FIOPIN = i<<23;
			LPC_GPIO0->FIOPIN = arr[temp%10]<<4;
			temp = temp/10;
			for(j=0;j<10000;j++);
			count++;
		}
	}
}