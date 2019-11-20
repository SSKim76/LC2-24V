    //////////////////////////////////////// FND ////////////////////////////////////////////
    unsigned int    FND_Data[18]    =   {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71,0x73};  //0x73 = P
    #define         FND_PORT        PORTA
    #define         FND0_D0          PORTB.2        // FND0.0 = 0 -> FND0�� ù��° �ڸ� On
    #define         FND0_D1          PORTB.3        // FND0.1 = 0 -> FND0�� �ι�° �ڸ� On
    #define         FND0_D2          PORTB.4        // FND0.2 = 0 -> FND0�� ����° �ڸ� On
    #define         FND1_D0          PORTC.0
    #define         FND1_D1          PORTC.1
    #define         FND1_D2          PORTC.7
    #define         L0_PWM           OCR1A          // L0 ��Ⱚ(PWM)
    #define         L1_PWM           OCR1B          // L1 ��Ⱚ(PWM)
    #define         L0_PORT          DDRD.5         // L0 == 0�϶�  ���� OFF�ȵ�.. �׷��� DDR.5�� �Է����� �����Ͽ� OFF
    #define         L1_PORT          DDRD.4         // L1 == 0�϶�.... ���� ���� �뵵
    #define         SET_L0           PIND.6         // High �϶�...L0 Manual Set(L0_PWM ���簪�� EEPROM�� ����)
    #define         SET_L1           PIND.7         // High �϶�...L1 Manual Set

    //unsigned char   Fnd_Value   = 0;

// Declare your global variables here
    unsigned char   FND_Time    =   1;          // 1sms���� FND ���
    int             tmr_cnt     =   0;
    unsigned char   FND_Dig     =   0;          // 0 ~ 5����....


//////////////////////////////////////  EEPROM  //////////////////////////////////////
unsigned int        EEPROM_Init_Addr        =   0x0000;
unsigned char       EEPROM_Init_Data[16]    =   "Project Ver R00";
unsigned int        L0_Addr                 =   0x0020;
unsigned int        L1_Addr                 =   0x0030;


//////////////////////////////////////  RS-232C  //////////////////////////////////////
char	         UART0_DATA		    =	0;
char			 RS232_BUFF[10];
unsigned char    NDX_232 		    =	0;
bit 			 RS232_FLAG  	    =   0;
bit 			 RS_Finish_Flag     =   0;
char             rtnMsg[8]          =   {0x1B, 0x02, 0x52, 0x00, 0x00, 0x00, 0x03, 0x0D};
unsigned char    Tmr_Cnt0           =   0;
unsigned char    RS232_RS_Limit     =   30;      // ms
