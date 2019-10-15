     // External Interrupt 0 service routine
    interrupt [EXT_INT0] void ext_int0_isr(void)
    {
        // Place your code here
        if(PINB.0)
        {
            L0_PWM++;
        }
        else
        {
            L0_PWM--;
        }

        if(L0_PWM)
        {
            L0_PORT = 1;
        }
        else
        {
            L0_PORT = 0;
        }

    }

    // External Interrupt 1 service routine
    interrupt [EXT_INT1] void ext_int1_isr(void)
    {
        // Place your code here
            if(PINB.1)
            {
                L1_PWM++;
            }
            else
            {
                L1_PWM--;
            }

            if(L1_PWM)
            {
                 L1_PORT = 1;
            }
            else
            {
                L1_PORT = 0;
            }
     }

   // Timer2 overflow interrupt service routine
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
        // Reinitialize Timer2 value
        TCNT2=0x06;

        // Place your code here
        if(RS232_FLAG)
        {
            Tmr_Cnt0++;
        }

        if(Tmr_Cnt0 >= RS232_RS_Limit)
        {
            Clear_Set();
        }



        if(tmr_cnt++ >= FND_Time)
        {
            tmr_cnt =   0;

            FND0_D0 = 0;
            FND0_D1 = 0;
            FND0_D2 = 0;
            FND1_D0 = 0;
            FND1_D1 = 0;
            FND1_D2 = 0;


            if(FND_Dig > 2)
            {
                d100 = L1_PWM % 1000/100;
                d10 = L1_PWM % 100/10;
                d1 = L1_PWM % 10;
            }
            else
            {
                d100 = L0_PWM % 1000/100;
                d10 = L0_PWM % 100/10;
                d1 = L0_PWM % 10;
            }

            switch (FND_Dig++)
            {
                case 0:
                     FND_PORT = FND_Data[d100];
                     FND0_D0 = 1;
                     break;

                case 1:
                    FND_PORT = FND_Data[d10];
                    FND0_D1 = 1;
                    break;

                case 2:
                    FND_PORT = FND_Data[d1];
                    FND0_D2 = 1;
                    break;

                case 3:
                    FND_PORT = FND_Data[d100];
                    FND1_D0 = 1;
                    break;

                case 4:
                    FND_PORT= FND_Data[d10];
                    FND1_D1 = 1;
                    break;

                case 5:
                    FND_PORT = FND_Data[d1];
                    FND1_D2 = 1;
                    FND_Dig = 0;
                    break;
            };    // End of Switch
       }   // End of  if(tmr_cnt++ >= FND_Time)

}
