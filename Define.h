/********************************************************************************
        Type                        Size (Bits)            Range
        bit, _Bit                       1                   0 , 1
        bool, _Bool                     8                   0 , 1
        char                            8               -128 to 127
        unsigned char                   8                  0 to 255
        signed char                     8               -128 to 127
        int                             16            -32768 to 32767
        short int                       16            -32768 to 32767
        unsigned int                    16                 0 to 65535
        signed int                      16		      -32768 to 32767
        long int                        32	     -2147483648 to 2147483647
        unsigned long int               32	               0 to 4294967295
        signed long int                 32	     -2147483648 to 2147483647
        float                           32	      ±1.175e-38 to ±3.402e38
        double                          32	      ±1.175e-38 to ±3.402e38
***********************************************************************************/


//////////////////////////////////////  Main  //////////////////////////////////////

unsigned char   PgmMode         =       0;
bit             SetFlag         =       0;      // Setting Mode 일때 1

unsigned char   UserSel_Key     =       0;      // S/W 입력 값

bit             BUZZER_STAT     =       0;
unsigned char   BUZZER_CNT      =       0;

#define         LED_PORT                PORTE
unsigned char   LED_PORT_DATA   =       0;
unsigned int    LED_DATA        =       0;
unsigned char   LED_CNT         =       0;

bit             Select_Key_Flag =       0;
bit             SET_END_FLAG    =       0;
unsigned char   SET_LEVEL       =       0;
unsigned char   SET_Key_Level0  =       0;
unsigned char   SET_Key_Level1  =       0;



//////////////////////////////////////  EEPROM  //////////////////////////////////////
unsigned int    EEPROM_Init_Addr        =   0x0000;
unsigned char   EEPROM_Init_Data[16]    =   "Project Ver R00";
unsigned int    PgmMode_Addr            =   0x0020;
unsigned int    PWM_Addr                =   0x0030;



//////////////////////////////////////// UART ////////////////////////////////////////////
//unsigned char  UART0_DATA         =   0;
unsigned char  UART1_DATA           =   0;

bit             RS485_FLAG          =   0;
unsigned char   RS485_BUFF[15];
unsigned char   NDX_485             =   0;
bit             RS485_LCD_FLAG      =   0;
unsigned int    RS485_LCD_CNT       =   0;
#define         RS485_LCD_TIME          2000



//////////////////////////////////////// LCD ////////////////////////////////////////////
char           LCD_Data_Line0[16] = {0,};
char           LCD_Data_Line1[16] = {0,};
#define        LCD_PORT    PORTA



//////////////////////////////////////// FND ////////////////////////////////////////////
unsigned int    FND_Data[18]    =   {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71,0x73};  //0x73 = P
#define         FND_OUT         PORTB
#define         FND0            PORTD.6
#define         FND1            PORTD.7
unsigned char   FndData0        =       0;      // Fnd 1번째 자리 Data
unsigned char   FndData1        =       0;      // Fnd 2번째 자리 Data
bit             FND_COM_SEQ     =       0;      // FND On -> Off -> On -> Off


//////////////////////////////////////// DS1307 ////////////////////////////////////////////
unsigned char   TimeH[2];
unsigned char   TimeM[2];
unsigned char   TimeS[2];


//////////////////////////////////////// TMR ////////////////////////////////////////////
unsigned char   TMR_FND         =       0;
#define         TMR_FND_TIME            4
//bit           Flag_100ms      =     0;
#define         BUZZER_ON_TIME          50          // BUZZER 울리는 시간 = 0.05sec
#define         TMR_LED_TIME            1000        // Mode1에서 LED 변경 시간 1초
unsigned int    TMR_LED_CNT     =       0;

//////////////////////////////////////// ADC ////////////////////////////////////////////
// Voltage Reference: AVCC pin
#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))
unsigned int    ADC_READ_TMR    =       0;
#define         ADC_TMR_CNT             1000
unsigned char   ADC_CNT         =       0;
unsigned int    ADC_CH0         =       0;
unsigned int    ADC_CH1         =       0;
unsigned char   ADC_BUFF_CH0[4];
unsigned char   ADC_BUFF_CH1[4];


//////////////////////////////////////// PWM ////////////////////////////////////////////
unsigned int    PWM             =       0;
#define         PWM_Def                 10
#define         PWM_DIV                 255
unsigned int    PWM_On_CNT      =       0;
unsigned char   PWM_Buff[4];
unsigned char   PWM_Loop_CNT    =       0;




