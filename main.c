/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : JST-LC24-2
Version : R00
Date    : 2018-11-20
Company : JoinST INC.
Comments: �ѱ�����ͱ���� �߼ұ�������ڱ�


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#define F_CPU 16000000UL
//#define F_CPU 1000000

#include <mega16.h>
#include <io.h>
#include <delay.h>
#include <stdio.h>
#include <string.h>
#include <eeprom.h>

#include "define.c"


unsigned char EEPROM_read(unsigned int uiAddress);
void EEPROM_write(unsigned int uiAddress, unsigned char ucData);
void EEPROM_INIT();
void PWM_WRITE(unsigned char Light);
void PWM_UPDATE(unsigned char Light);
void putchar0(char c);
void putString0(char *c);

void Clear_Set()
{
	memset(RS232_BUFF,0x00,sizeof(RS232_BUFF));             //Buff �ʱ�ȭ
	RS_Finish_Flag = 0;
    RS232_FLAG = 0;
	Tmr_Cnt0 = 0;
    NDX_232 = 0;
}

void CHK_Light()
{
    rtnMsg[4] = L0_PWM ;   // L0_PWM ���� rtnMsg[4]�� ����
    rtnMsg[5] = L1_PWM;   // L1_PWM ���� rtnMsg[5]�� ����

    putString0(rtnMsg);    // �������� ����
}


//unsigned char cnt;
unsigned char d100, d10, d1;


#include "function.c"
#include "interrupt.c"
#include "uart.c"



void main(void)
{

    #include "init.c"

    #asm("sei")             // Global enable interrupts

    if(EEPROM_read(EEPROM_Init_Addr) == 0xFF)
    {
        EEPROM_INIT();
    }

    L0_PWM = EEPROM_read(L0_Addr);
    L1_PWM = EEPROM_read(L1_Addr);
/*
    //L0_PWM  =   123;
    //L1_PWM  =   215;
*/
    while (1)
    {

        // Place your code here
        if(SET_L0 || SET_L1)
        {
            if(SET_L0)
            {
                PWM_UPDATE(0);
                 //PWM_WRITE(0);
            }
            else
            {
                PWM_UPDATE(1);
                //PWM_WRITE(1);
            }
        }

        if(RS_Finish_Flag)
        {
            switch (RS232_BUFF[2])
            {
                case 0x53 :     // ���¿�û
                   // CHK_Light();
                    break;

                case 0x43 :    // ��������
                    L0_PWM = RS232_BUFF[4];
                    L1_PWM = RS232_BUFF[5];
                   // CHK_Light();      // �������� ����
                    break;

                 case 0x57 :    // �������� ����
                    L0_PWM = RS232_BUFF[4];
                    L1_PWM = RS232_BUFF[5];
                    PWM_UPDATE(0);      // L0 EEPROM Update
                    PWM_UPDATE(1);      // L1 EEPROM Update
                    // CHK_Light();      // �������� ����
                    break;
            }

            if(!L0_PWM)
            {
                L0_PORT = 0;
            }
            else
            {
                L0_PORT = 1;
            }

            if(!L1_PWM)
            {
                L1_PORT = 0;
            }
            else
            {
                L1_PORT = 1;
            }

            CHK_Light();      // �������� ����
            Clear_Set();

        }

         // putString0(RS232_BUFF);

    } // End of while

} // End of main()
