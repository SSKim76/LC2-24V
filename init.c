    DDRA = 0xFF;
    PORTA = 0xFF;

    //DDRB    = 0b00111111;   // DDRB.0 ~ 1 : Encoder Switch 입력, DDRB.2 ~ 4 : FND set
    //PORTB   = 0b00111111;
    DDRB    = 0b11111100;   // DDRB.0 ~ 1 : Encoder Switch 입력, DDRB.2 ~ 4 : FND set
    PORTB   = 0b11111100;

    DDRC = 0xFF;
    PORTC = 0x00;

    DDRD = 0b00110000;
    PORTD = 0b00000000;


    // Timer/Counter 0 initialization
    // Clock source: System Clock
    // Clock value: Timer 0 Stopped
    // Mode: Normal top=0xFF
    // OC0 output: Disconnected
        TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
        TCNT0=0x00;
        OCR0=0x00;

/* 2019년 11월 26일 PWM Timer Period 1.024ms -> 0.016ms 변경, 아래 내용은 기존 1.024ms 임

     // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: 250.000 kHz
    // Mode: Fast PWM top=0x00FF
    // OC1A output: Non-Inverted PWM
    // OC1B output: Non-Inverted PWM
    // Noise Canceler: Off
    // Input Capture on Rising Edge
    // Timer Period: 1.024 ms
    // Output Pulse(s):
    // OC1A Period: 1.024 ms Width: 0 us
    // OC1B Period: 1.024 ms Width: 0 us
    // Timer1 Overflow Interrupt: Off
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (1<<WGM10);
    TCCR1B=(0<<ICNC1) | (1<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);
    TCNT1H=0x00;
    TCNT1L=0x00;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x00;
    OCR1AL=0x00;
    OCR1BH=0x00;
    OCR1BL=0x00;

    여기까지 2019년 11월 26일 PWM Timer Period 1.024ms -> 0.016ms 변경을 위해 주석처리

*/



// 2019년 11월 26일 PWM Timer Period 1.024ms -> 0.016ms 변경

    // Timer/Counter 1 initialization
    // Clock source: System Clock
    // Clock value: 16000.000 kHz
    // Mode: Fast PWM top=0x00FF
    // OC1A output: Non-Inverted PWM
    // OC1B output: Non-Inverted PWM
    // Noise Canceler: Off
    // Input Capture on Rising Edge
    // Timer Period: 0.016 ms
    // Output Pulse(s):
    // OC1A Period: 0.016 ms Width: 0 us
    // OC1B Period: 0.016 ms Width: 0 us
    // Timer1 Overflow Interrupt: Off
    // Input Capture Interrupt: Off
    // Compare A Match Interrupt: Off
    // Compare B Match Interrupt: Off
    TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (1<<WGM10);
    TCCR1B=(0<<ICNC1) | (1<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (0<<CS11) | (1<<CS10);
    TCNT1H=0x00;
    TCNT1L=0x00;
    ICR1H=0x00;
    ICR1L=0x00;
    OCR1AH=0x00;
    OCR1AL=0x00;
    OCR1BH=0x00;
    OCR1BL=0x00;

// 여기까지 추가된 내용


    // Timer/Counter 2 initialization
    // Clock source: System Clock
    // Clock value: 250.000 kHz
    // Mode: Normal top=0xFF
    // OC2 output: Disconnected
    // Timer Period: 1 ms
    ASSR=0<<AS2;
    TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (1<<CS22) | (0<<CS21) | (0<<CS20);
    TCNT2=0x06;
    OCR2=0x00;

    // Timer(s)/Counter(s) Interrupt(s) initialization
    //TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
    TIMSK=(0<<OCIE2) | (1<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);




    // External Interrupt(s) initialization
    // INT0: On
    // INT0 Mode: Rising Edge
    // INT1: On
    // INT1 Mode: Rising Edge
    // INT2: Off
        GICR|=(1<<INT1) | (1<<INT0) | (0<<INT2);
        MCUCR=(1<<ISC11) | (1<<ISC10) | (1<<ISC01) | (1<<ISC00);
        MCUCSR=(0<<ISC2);
        GIFR=(1<<INTF1) | (1<<INTF0) | (0<<INTF2);

        //EIMSK = 0x03;   // 외부인터럽트 0,1 Set(INT0, INT1)
        //EICRA  =0x0E;   // INT0, INT1 상승에지 선언(ob00001111)

      // USART initialization
    // Communication Parameters: 8 Data, 1 Stop, No Parity
    // USART Receiver: On
    // USART Transmitter: On
    // USART Mode: Asynchronous
    // USART Baud Rate: 9600
    UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
    UCSRB=(1<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
    UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
    UBRRH=0x00;
    UBRRL=0x67;

