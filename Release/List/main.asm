
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _FND_Time=R5
	.DEF _tmr_cnt=R6
	.DEF _tmr_cnt_msb=R7
	.DEF _FND_Dig=R4
	.DEF _EEPROM_Init_Addr=R8
	.DEF _EEPROM_Init_Addr_msb=R9
	.DEF _L0_Addr=R10
	.DEF _L0_Addr_msb=R11
	.DEF _L1_Addr=R12
	.DEF _L1_Addr_msb=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  _ext_int1_isr
	JMP  0x00
	JMP  _timer2_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x1,0x0,0x0
	.DB  0x0,0x0,0x20,0x0
	.DB  0x30,0x0

_0x3:
	.DB  0x3F,0x0,0x6,0x0,0x5B,0x0,0x4F,0x0
	.DB  0x66,0x0,0x6D,0x0,0x7D,0x0,0x7,0x0
	.DB  0x7F,0x0,0x67,0x0,0x77,0x0,0x7C,0x0
	.DB  0x39,0x0,0x5E,0x0,0x79,0x0,0x71,0x0
	.DB  0x73
_0x4:
	.DB  0x50,0x72,0x6F,0x6A,0x65,0x63,0x74,0x20
	.DB  0x56,0x65,0x72,0x20,0x52,0x30,0x30
_0x5:
	.DB  0x1B,0x2,0x52,0x0,0x0,0x0,0x3,0xD
_0x6:
	.DB  0x1E

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x21
	.DW  _FND_Data
	.DW  _0x3*2

	.DW  0x0F
	.DW  _EEPROM_Init_Data
	.DW  _0x4*2

	.DW  0x08
	.DW  _rtnMsg
	.DW  _0x5*2

	.DW  0x01
	.DW  _RS232_RS_Limit
	.DW  _0x6*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : JST-LC24-2
;Version : R00
;Date    : 2018-11-20
;Company : JoinST INC.
;Comments: 한국세라믹기술원 중소기업지원자금
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#define F_CPU 16000000UL
;//#define F_CPU 1000000
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <io.h>
;#include <delay.h>
;#include <stdio.h>
;#include <string.h>
;#include <eeprom.h>
;
;#include "define.c"
;    //////////////////////////////////////// FND ////////////////////////////////////////////
;    unsigned int    FND_Data[18]    =   {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x39, 0 ...

	.DSEG
;    #define         FND_PORT        PORTA
;    #define         FND0_D0          PORTB.2        // FND0.0 = 0 -> FND0의 첫번째 자리 On
;    #define         FND0_D1          PORTB.3        // FND0.1 = 0 -> FND0의 두번째 자리 On
;    #define         FND0_D2          PORTB.4        // FND0.2 = 0 -> FND0의 세번째 자리 On
;    #define         FND1_D0          PORTC.0
;    #define         FND1_D1          PORTC.1
;    #define         FND1_D2          PORTC.7
;    #define         L0_PWM           OCR1A          // L0 밝기값(PWM)
;    #define         L1_PWM           OCR1B          // L1 밝기값(PWM)
;    #define         L0_PORT          DDRD.5         // L0 == 0일때  완전 OFF안됨.. 그래서 DDR.5를 입력으로 변경하여 OFF
;    #define         L1_PORT          DDRD.4         // L1 == 0일때.... 위와 같은 용도
;    #define         SET_L0           PIND.6         // High 일때...L0 Manual Set(L0_PWM 현재값을 EEPROM에 저장)
;    #define         SET_L1           PIND.7         // High 일때...L1 Manual Set
;
;    //unsigned char   Fnd_Value   = 0;
;
;// Declare your global variables here
;    unsigned char   FND_Time    =   1;          // 1sms마다 FND 출력
;    int             tmr_cnt     =   0;
;    unsigned char   FND_Dig     =   0;          // 0 ~ 5까지....
;
;
;//////////////////////////////////////  EEPROM  //////////////////////////////////////
;unsigned int        EEPROM_Init_Addr        =   0x0000;
;unsigned char       EEPROM_Init_Data[16]    =   "Project Ver R00";
;unsigned int        L0_Addr                 =   0x0020;
;unsigned int        L1_Addr                 =   0x0030;
;
;
;//////////////////////////////////////  RS-232C  //////////////////////////////////////
;char	         UART0_DATA		    =	0;
;char			 RS232_BUFF[10];
;unsigned char    NDX_232 		    =	0;
;bit 			 RS232_FLAG  	    =   0;
;bit 			 RS_Finish_Flag     =   0;
;char             rtnMsg[8]          =   {0x1B, 0x02, 0x52, 0x00, 0x00, 0x00, 0x03, 0x0D};
;unsigned char    Tmr_Cnt0           =   0;
;unsigned char    RS232_RS_Limit     =   30;      // ms
;
;
;unsigned char EEPROM_read(unsigned int uiAddress);
;void EEPROM_write(unsigned int uiAddress, unsigned char ucData);
;void EEPROM_INIT();
;void PWM_WRITE(unsigned char Light);
;void PWM_UPDATE(unsigned char Light);
;void putchar0(char c);
;void putString0(char *c);
;
;void Clear_Set()
; 0000 002D {

	.CSEG
_Clear_Set:
; .FSTART _Clear_Set
; 0000 002E 	memset(RS232_BUFF,0x00,sizeof(RS232_BUFF));             //Buff 초기화
	LDI  R30,LOW(_RS232_BUFF)
	LDI  R31,HIGH(_RS232_BUFF)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _memset
; 0000 002F 	RS_Finish_Flag = 0;
	CLT
	BLD  R2,1
; 0000 0030     RS232_FLAG = 0;
	BLD  R2,0
; 0000 0031 	Tmr_Cnt0 = 0;
	CALL SUBOPT_0x0
; 0000 0032     NDX_232 = 0;
; 0000 0033 }
	RET
; .FEND
;
;void CHK_Light()
; 0000 0036 {
_CHK_Light:
; .FSTART _CHK_Light
; 0000 0037     rtnMsg[4] = L0_PWM ;   // L0_PWM 값을 rtnMsg[4]에 저장
	__POINTW2MN _rtnMsg,4
	IN   R30,0x2A
	ST   X,R30
; 0000 0038     rtnMsg[5] = L1_PWM;   // L1_PWM 값을 rtnMsg[5]에 저장
	__POINTW2MN _rtnMsg,5
	IN   R30,0x28
	ST   X,R30
; 0000 0039 
; 0000 003A     putString0(rtnMsg);    // 조명상태 전송
	LDI  R26,LOW(_rtnMsg)
	LDI  R27,HIGH(_rtnMsg)
	RCALL _putString0
; 0000 003B }
	RET
; .FEND
;
;
;//unsigned char cnt;
;unsigned char d100, d10, d1;
;
;
;#include "function.c"
;/*********************************************************************************************
;       unsigned char EEPROM_read(unsigned int uiAddress)
;
;***********************************************************************************************/
;    unsigned char EEPROM_read(unsigned int uiAddress)
; 0000 0042     {
_EEPROM_read:
; .FSTART _EEPROM_read
;            /* Wait for completion of previous write */
;            while(EECR & (1<<EEWE)) ;
	ST   -Y,R27
	ST   -Y,R26
;	uiAddress -> Y+0
_0x7:
	SBIC 0x1C,1
	RJMP _0x7
;
;            /* Set up address register */
;            EEAR = uiAddress;
	LD   R30,Y
	LDD  R31,Y+1
	OUT  0x1E+1,R31
	OUT  0x1E,R30
;
;            /* Start eeprom read by writing EERE */
;            EECR |= (1<<EERE);
	SBI  0x1C,0
;
;            /* Return data from data register */
;            return EEDR;
	IN   R30,0x1D
	RJMP _0x2080002
;    }
; .FEND
;
;
;
;/*********************************************************************************************
;      void EEPROM_write(unsigned int uiAddress, unsigned char ucData)
;
;***********************************************************************************************/
;    void EEPROM_write(unsigned int uiAddress, unsigned char ucData)
;    {
_EEPROM_write:
; .FSTART _EEPROM_write
;            /* Wait for completion of previous write */
;            while(EECR & (1<<EEWE));
	ST   -Y,R26
;	uiAddress -> Y+1
;	ucData -> Y+0
_0xA:
	SBIC 0x1C,1
	RJMP _0xA
;
;            /* Set up address and data registers */
;            EEAR = uiAddress;
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	OUT  0x1E+1,R31
	OUT  0x1E,R30
;            EEDR = ucData;
	LD   R30,Y
	OUT  0x1D,R30
;
;            /* Write logical one to EEMWE */
;            EECR |= (1<<EEMWE);
	SBI  0x1C,2
;
;            /* Start eeprom write by setting EEWE */
;            EECR |= (1<<EEWE);
	SBI  0x1C,1
;    }
	RJMP _0x2080001
; .FEND
;
;
;    void EEPROM_INIT()
;    {
_EEPROM_INIT:
; .FSTART _EEPROM_INIT
;        unsigned char cnt = 0;
;        for(cnt = 0; cnt <= (sizeof(EEPROM_Init_Data)/sizeof(unsigned char)); cnt++)
	ST   -Y,R17
;	cnt -> R17
	LDI  R17,0
	LDI  R17,LOW(0)
_0xE:
	CPI  R17,17
	BRSH _0xF
;        {
;            EEPROM_write(EEPROM_Init_Addr++, EEPROM_Init_Data[cnt]);
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_EEPROM_Init_Data)
	SBCI R31,HIGH(-_EEPROM_Init_Data)
	LD   R26,Z
	RCALL _EEPROM_write
;        }
	SUBI R17,-1
	RJMP _0xE
_0xF:
;    }
	LD   R17,Y+
	RET
; .FEND
;
;
;    void PWM_WRITE(unsigned char Light)
;    {
;        if(Light)
;	Light -> Y+0
;        {
;            EEPROM_write(L1_Addr, L1_PWM);
;        }
;        else
;        {
;            EEPROM_write(L0_Addr, L0_PWM);
;            //eeprom_write_byte(L0_Addr, L0_PWM);
;        }
;    }
;
;
;    void PWM_UPDATE(unsigned char Light)
;    {
_PWM_UPDATE:
; .FSTART _PWM_UPDATE
;        unsigned char pwm_value;
;
;        if(Light)
	ST   -Y,R26
	ST   -Y,R17
;	Light -> Y+1
;	pwm_value -> R17
	LDD  R30,Y+1
	CPI  R30,0
	BREQ _0x12
;        {
;            pwm_value =  EEPROM_read(L1_Addr);
	MOVW R26,R12
	RCALL _EEPROM_read
	MOV  R17,R30
;            if(pwm_value != L1_PWM)
	IN   R30,0x28
	IN   R31,0x28+1
	MOV  R26,R17
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x13
;            {
;                EEPROM_write(L1_Addr, L1_PWM);
	ST   -Y,R13
	ST   -Y,R12
	IN   R30,0x28
	IN   R31,0x28+1
	MOV  R26,R30
	RCALL _EEPROM_write
;            }
;        }
_0x13:
;        else
	RJMP _0x14
_0x12:
;        {
;            pwm_value =  EEPROM_read(L0_Addr);
	MOVW R26,R10
	RCALL _EEPROM_read
	MOV  R17,R30
;            if(pwm_value != L0_PWM)
	IN   R30,0x2A
	IN   R31,0x2A+1
	MOV  R26,R17
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x15
;            {
;                EEPROM_write(L0_Addr, L0_PWM);
	ST   -Y,R11
	ST   -Y,R10
	IN   R30,0x2A
	IN   R31,0x2A+1
	MOV  R26,R30
	RCALL _EEPROM_write
;            }
;            //eeprom_write_byte(L0_Addr, L0_PWM);
;        }
_0x15:
_0x14:
;    }
	LDD  R17,Y+0
_0x2080002:
	ADIW R28,2
	RET
; .FEND
;  //EEPROM_write(PWM_Addr, PWM_On_CNT);
;#include "interrupt.c"
;     // External Interrupt 0 service routine
;    interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 0043     {
_ext_int0_isr:
; .FSTART _ext_int0_isr
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;        // Place your code here
;        if(PINB.0)
	SBIS 0x16,0
	RJMP _0x16
;        {
;            L0_PWM++;
	IN   R30,0x2A
	IN   R31,0x2A+1
	ADIW R30,1
	RJMP _0x7F
;        }
;        else
_0x16:
;        {
;            L0_PWM--;
	IN   R30,0x2A
	IN   R31,0x2A+1
	SBIW R30,1
_0x7F:
	OUT  0x2A+1,R31
	OUT  0x2A,R30
;        }
;
;        if(L0_PWM)
	IN   R30,0x2A
	IN   R31,0x2A+1
	SBIW R30,0
	BREQ _0x18
;        {
;            L0_PORT = 1;
	SBI  0x11,5
;        }
;        else
	RJMP _0x1B
_0x18:
;        {
;            L0_PORT = 0;
	CBI  0x11,5
;        }
_0x1B:
;
;    }
	RJMP _0x84
; .FEND
;
;    // External Interrupt 1 service routine
;    interrupt [EXT_INT1] void ext_int1_isr(void)
;    {
_ext_int1_isr:
; .FSTART _ext_int1_isr
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;        // Place your code here
;            if(PINB.1)
	SBIS 0x16,1
	RJMP _0x1E
;            {
;                L1_PWM++;
	IN   R30,0x28
	IN   R31,0x28+1
	ADIW R30,1
	RJMP _0x80
;            }
;            else
_0x1E:
;            {
;                L1_PWM--;
	IN   R30,0x28
	IN   R31,0x28+1
	SBIW R30,1
_0x80:
	OUT  0x28+1,R31
	OUT  0x28,R30
;            }
;
;            if(L1_PWM)
	IN   R30,0x28
	IN   R31,0x28+1
	SBIW R30,0
	BREQ _0x20
;            {
;                 L1_PORT = 1;
	SBI  0x11,4
;            }
;            else
	RJMP _0x23
_0x20:
;            {
;                L1_PORT = 0;
	CBI  0x11,4
;            }
_0x23:
;     }
_0x84:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;   // Timer2 overflow interrupt service routine
;interrupt [TIM2_OVF] void timer2_ovf_isr(void)
;{
_timer2_ovf_isr:
; .FSTART _timer2_ovf_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;        // Reinitialize Timer2 value
;        TCNT2=0x06;
	LDI  R30,LOW(6)
	OUT  0x24,R30
;
;        // Place your code here
;        if(RS232_FLAG)
	SBRS R2,0
	RJMP _0x26
;        {
;            Tmr_Cnt0++;
	LDS  R30,_Tmr_Cnt0
	SUBI R30,-LOW(1)
	STS  _Tmr_Cnt0,R30
;        }
;
;        if(Tmr_Cnt0 >= RS232_RS_Limit)
_0x26:
	LDS  R30,_RS232_RS_Limit
	LDS  R26,_Tmr_Cnt0
	CP   R26,R30
	BRLO _0x27
;        {
;            Clear_Set();
	RCALL _Clear_Set
;        }
;
;
;
;        if(tmr_cnt++ >= FND_Time)
_0x27:
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	SBIW R30,1
	MOVW R26,R30
	MOV  R30,R5
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	BRGE PC+2
	RJMP _0x28
;        {
;            tmr_cnt =   0;
	CLR  R6
	CLR  R7
;
;            FND0_D0 = 0;
	CBI  0x18,2
;            FND0_D1 = 0;
	CBI  0x18,3
;            FND0_D2 = 0;
	CBI  0x18,4
;            FND1_D0 = 0;
	CBI  0x15,0
;            FND1_D1 = 0;
	CBI  0x15,1
;            FND1_D2 = 0;
	CBI  0x15,7
;
;
;            if(FND_Dig > 2)
	LDI  R30,LOW(2)
	CP   R30,R4
	BRSH _0x35
;            {
;                d100 = L1_PWM % 1000/100;
	IN   R30,0x28
	IN   R31,0x28+1
	CALL SUBOPT_0x1
;                d10 = L1_PWM % 100/10;
	IN   R30,0x28
	IN   R31,0x28+1
	CALL SUBOPT_0x2
;                d1 = L1_PWM % 10;
	IN   R30,0x28
	IN   R31,0x28+1
	RJMP _0x81
;            }
;            else
_0x35:
;            {
;                d100 = L0_PWM % 1000/100;
	IN   R30,0x2A
	IN   R31,0x2A+1
	CALL SUBOPT_0x1
;                d10 = L0_PWM % 100/10;
	IN   R30,0x2A
	IN   R31,0x2A+1
	CALL SUBOPT_0x2
;                d1 = L0_PWM % 10;
	IN   R30,0x2A
	IN   R31,0x2A+1
_0x81:
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	STS  _d1,R30
;            }
;
;            switch (FND_Dig++)
	MOV  R30,R4
	INC  R4
;            {
;                case 0:
	CPI  R30,0
	BRNE _0x3A
;                     FND_PORT = FND_Data[d100];
	CALL SUBOPT_0x3
;                     FND0_D0 = 1;
	SBI  0x18,2
;                     break;
	RJMP _0x39
;
;                case 1:
_0x3A:
	CPI  R30,LOW(0x1)
	BRNE _0x3D
;                    FND_PORT = FND_Data[d10];
	CALL SUBOPT_0x4
;                    FND0_D1 = 1;
	SBI  0x18,3
;                    break;
	RJMP _0x39
;
;                case 2:
_0x3D:
	CPI  R30,LOW(0x2)
	BRNE _0x40
;                    FND_PORT = FND_Data[d1];
	CALL SUBOPT_0x5
;                    FND0_D2 = 1;
	SBI  0x18,4
;                    break;
	RJMP _0x39
;
;                case 3:
_0x40:
	CPI  R30,LOW(0x3)
	BRNE _0x43
;                    FND_PORT = FND_Data[d100];
	CALL SUBOPT_0x3
;                    FND1_D0 = 1;
	SBI  0x15,0
;                    break;
	RJMP _0x39
;
;                case 4:
_0x43:
	CPI  R30,LOW(0x4)
	BRNE _0x46
;                    FND_PORT= FND_Data[d10];
	CALL SUBOPT_0x4
;                    FND1_D1 = 1;
	SBI  0x15,1
;                    break;
	RJMP _0x39
;
;                case 5:
_0x46:
	CPI  R30,LOW(0x5)
	BRNE _0x39
;                    FND_PORT = FND_Data[d1];
	CALL SUBOPT_0x5
;                    FND1_D2 = 1;
	SBI  0x15,7
;                    FND_Dig = 0;
	CLR  R4
;                    break;
;            };    // End of Switch
_0x39:
;       }   // End of  if(tmr_cnt++ >= FND_Time)
;
;}
_0x28:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;#include "uart.c"
;
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;
;/*
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 16
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE <= 256
;unsigned char rx_wr_index=0,rx_rd_index=0;
;#else
;unsigned int rx_wr_index=0,rx_rd_index=0;
;#endif
;
;#if RX_BUFFER_SIZE < 256
;unsigned char rx_counter=0;
;#else
;unsigned int rx_counter=0;
;#endif
;
;// This flag is set on USART Receiver buffer overflow
;bit rx_buffer_overflow;
;*/
;
;void putchar0(char c)
; 0000 0044 {
;    while ((UCSRA & DATA_REGISTER_EMPTY)==0);
;	c -> Y+0
;    UDR=c;
;}
;
;
;void putString0(char *c)
;{
_putString0:
; .FSTART _putString0
;    unsigned char PcCnt = 0;
;
;    for(PcCnt = 0; PcCnt <= 7 ; PcCnt++)
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
;	*c -> Y+1
;	PcCnt -> R17
	LDI  R17,0
	LDI  R17,LOW(0)
_0x50:
	CPI  R17,8
	BRSH _0x51
;    {
;        while ((UCSRA & DATA_REGISTER_EMPTY)==0);
_0x52:
	SBIS 0xB,5
	RJMP _0x52
;        UDR=c[PcCnt];
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CLR  R30
	ADD  R26,R17
	ADC  R27,R30
	LD   R30,X
	OUT  0xC,R30
;    }
	SUBI R17,-1
	RJMP _0x50
_0x51:
;
;}
	LDD  R17,Y+0
_0x2080001:
	ADIW R28,3
	RET
; .FEND
;
;
;
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
;{
_usart_rx_isr:
; .FSTART _usart_rx_isr
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;    char status,data;
;    status=UCSRA;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
;    data=UDR;
	IN   R16,12
;   // PORTC.6 = 0xff;
;
;
;    if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x55
;    {
;        UART0_DATA=data;
	STS  _UART0_DATA,R16
;        //putchar0(UART0_DATA);
;        //PORTC.6 = 0xff;    ?? 19.11.19 주석처리
;
;        if(UART0_DATA == 0x1B)
	LDS  R26,_UART0_DATA
	CPI  R26,LOW(0x1B)
	BRNE _0x56
;        {
;            Tmr_Cnt0 = 0;
	CALL SUBOPT_0x0
;            NDX_232 = 0;
;            RS232_FLAG = 1;
	SET
	BLD  R2,0
;        }
;
;        if(RS232_FLAG)
_0x56:
	SBRS R2,0
	RJMP _0x57
;        {
;            //PORTC.6 = 0xff;
;            //if(UART0_DATA == 0x02)
;            if(UART0_DATA == 0x1B)
	LDS  R26,_UART0_DATA
	CPI  R26,LOW(0x1B)
	BRNE _0x58
;            {
;                RS232_BUFF[NDX_232] =   UART0_DATA;
	LDS  R30,_NDX_232
	RJMP _0x82
;            }
;            else
_0x58:
;            {
;                RS232_BUFF[++NDX_232] =   UART0_DATA;
	LDS  R30,_NDX_232
	SUBI R30,-LOW(1)
	STS  _NDX_232,R30
_0x82:
	LDI  R31,0
	SUBI R30,LOW(-_RS232_BUFF)
	SBCI R31,HIGH(-_RS232_BUFF)
	LDS  R26,_UART0_DATA
	STD  Z+0,R26
;            }
;
;
;            //if(UART0_DATA ==  0x03 && NDX_232 == 4)
;            if((UART0_DATA ==  0x0D && NDX_232 == 5) || (UART0_DATA == 0x0D && NDX_232 == 7))
	CPI  R26,LOW(0xD)
	BRNE _0x5B
	LDS  R26,_NDX_232
	CPI  R26,LOW(0x5)
	BREQ _0x5D
_0x5B:
	LDS  R26,_UART0_DATA
	CPI  R26,LOW(0xD)
	BRNE _0x5E
	LDS  R26,_NDX_232
	CPI  R26,LOW(0x7)
	BREQ _0x5D
_0x5E:
	RJMP _0x5A
_0x5D:
;            {
;                RS_Finish_Flag = 1;
	SET
	BLD  R2,1
;                //RS232_FLAG = 0;
;                //NDX_232 = 0;
;            }	        // END of if(상태요청, 또는 조명 상태변경 일 경우)
;
;        }
_0x5A:
;
;        UART0_DATA = 0;
_0x57:
	LDI  R30,LOW(0)
	STS  _UART0_DATA,R30
;
;    }
;}
_0x55:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;
;
;void main(void)
; 0000 0049 {
_main:
; .FSTART _main
; 0000 004A 
; 0000 004B     #include "init.c"
;    DDRA = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
;    PORTA = 0xFF;
	OUT  0x1B,R30
;
;    //DDRB    = 0b00111111;   // DDRB.0 ~ 1 : Encoder Switch 입력, DDRB.2 ~ 4 : FND set
;    //PORTB   = 0b00111111;
;    DDRB    = 0b11111100;   // DDRB.0 ~ 1 : Encoder Switch 입력, DDRB.2 ~ 4 : FND set
	LDI  R30,LOW(252)
	OUT  0x17,R30
;    PORTB   = 0b11111100;
	OUT  0x18,R30
;
;    DDRC = 0xFF;
	LDI  R30,LOW(255)
	OUT  0x14,R30
;    PORTC = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;
;    DDRD = 0b00110000;
	LDI  R30,LOW(48)
	OUT  0x11,R30
;    PORTD = 0b00000000;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;
;    // Timer/Counter 0 initialization
;    // Clock source: System Clock
;    // Clock value: Timer 0 Stopped
;    // Mode: Normal top=0xFF
;    // OC0 output: Disconnected
;        TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
;        TCNT0=0x00;
	OUT  0x32,R30
;        OCR0=0x00;
	OUT  0x3C,R30
;
;     // Timer/Counter 1 initialization
;    // Clock source: System Clock
;    // Clock value: 250.000 kHz
;    // Mode: Fast PWM top=0x00FF
;    // OC1A output: Non-Inverted PWM
;    // OC1B output: Non-Inverted PWM
;    // Noise Canceler: Off
;    // Input Capture on Rising Edge
;    // Timer Period: 1.024 ms
;    // Output Pulse(s):
;    // OC1A Period: 1.024 ms Width: 0 us
;    // OC1B Period: 1.024 ms Width: 0 us
;    // Timer1 Overflow Interrupt: Off
;    // Input Capture Interrupt: Off
;    // Compare A Match Interrupt: Off
;    // Compare B Match Interrupt: Off
;    TCCR1A=(1<<COM1A1) | (0<<COM1A0) | (1<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (1<<WGM10);
	LDI  R30,LOW(161)
	OUT  0x2F,R30
;    TCCR1B=(0<<ICNC1) | (1<<ICES1) | (0<<WGM13) | (1<<WGM12) | (0<<CS12) | (1<<CS11) | (1<<CS10);
	LDI  R30,LOW(75)
	OUT  0x2E,R30
;    TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;    TCNT1L=0x00;
	OUT  0x2C,R30
;    ICR1H=0x00;
	OUT  0x27,R30
;    ICR1L=0x00;
	OUT  0x26,R30
;    OCR1AH=0x00;
	OUT  0x2B,R30
;    OCR1AL=0x00;
	OUT  0x2A,R30
;    OCR1BH=0x00;
	OUT  0x29,R30
;    OCR1BL=0x00;
	OUT  0x28,R30
;
;    // Timer/Counter 2 initialization
;    // Clock source: System Clock
;    // Clock value: 250.000 kHz
;    // Mode: Normal top=0xFF
;    // OC2 output: Disconnected
;    // Timer Period: 1 ms
;    ASSR=0<<AS2;
	OUT  0x22,R30
;    TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (1<<CS22) | (0<<CS21) | (0<<CS20);
	LDI  R30,LOW(4)
	OUT  0x25,R30
;    TCNT2=0x06;
	LDI  R30,LOW(6)
	OUT  0x24,R30
;    OCR2=0x00;
	LDI  R30,LOW(0)
	OUT  0x23,R30
;
;    // Timer(s)/Counter(s) Interrupt(s) initialization
;    //TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
;    TIMSK=(0<<OCIE2) | (1<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	LDI  R30,LOW(64)
	OUT  0x39,R30
;
;    // External Interrupt(s) initialization
;    // INT0: On
;    // INT0 Mode: Rising Edge
;    // INT1: On
;    // INT1 Mode: Rising Edge
;    // INT2: Off
;        GICR|=(1<<INT1) | (1<<INT0) | (0<<INT2);
	IN   R30,0x3B
	ORI  R30,LOW(0xC0)
	OUT  0x3B,R30
;        MCUCR=(1<<ISC11) | (1<<ISC10) | (1<<ISC01) | (1<<ISC00);
	LDI  R30,LOW(15)
	OUT  0x35,R30
;        MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
;        GIFR=(1<<INTF1) | (1<<INTF0) | (0<<INTF2);
	LDI  R30,LOW(192)
	OUT  0x3A,R30
;
;        //EIMSK = 0x03;   // 외부인터럽트 0,1 Set(INT0, INT1)
;        //EICRA  =0x0E;   // INT0, INT1 상승에지 선언(ob00001111)
;
;      // USART initialization
;    // Communication Parameters: 8 Data, 1 Stop, No Parity
;    // USART Receiver: On
;    // USART Transmitter: On
;    // USART Mode: Asynchronous
;    // USART Baud Rate: 9600
;    UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	LDI  R30,LOW(0)
	OUT  0xB,R30
;    UCSRB=(1<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(152)
	OUT  0xA,R30
;    UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
;    UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;    UBRRL=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
;
; 0000 004C 
; 0000 004D     #asm("sei")             // Global enable interrupts
	sei
; 0000 004E 
; 0000 004F     if(EEPROM_read(EEPROM_Init_Addr) == 0xFF)
	MOVW R26,R8
	RCALL _EEPROM_read
	CPI  R30,LOW(0xFF)
	BRNE _0x61
; 0000 0050     {
; 0000 0051         EEPROM_INIT();
	RCALL _EEPROM_INIT
; 0000 0052     }
; 0000 0053 
; 0000 0054     L0_PWM = EEPROM_read(L0_Addr);
_0x61:
	MOVW R26,R10
	RCALL _EEPROM_read
	LDI  R31,0
	OUT  0x2A+1,R31
	OUT  0x2A,R30
; 0000 0055     L1_PWM = EEPROM_read(L1_Addr);
	MOVW R26,R12
	RCALL _EEPROM_read
	LDI  R31,0
	OUT  0x28+1,R31
	OUT  0x28,R30
; 0000 0056 /*
; 0000 0057    if(!L0_PWM)
; 0000 0058     {
; 0000 0059         L0_PORT = 0;
; 0000 005A     }
; 0000 005B 
; 0000 005C     if(!L1_PWM)
; 0000 005D     {
; 0000 005E         L1_PORT = 0;
; 0000 005F     }
; 0000 0060 
; 0000 0061     //L0_PWM  =   123;
; 0000 0062     //L1_PWM  =   215;
; 0000 0063 */
; 0000 0064     while (1)
_0x62:
; 0000 0065     {
; 0000 0066 
; 0000 0067         // Place your code here
; 0000 0068         if(SET_L0 || SET_L1)
	SBIC 0x10,6
	RJMP _0x66
	SBIS 0x10,7
	RJMP _0x65
_0x66:
; 0000 0069         {
; 0000 006A             if(SET_L0)
	SBIS 0x10,6
	RJMP _0x68
; 0000 006B             {
; 0000 006C                 PWM_UPDATE(0);
	LDI  R26,LOW(0)
	RJMP _0x83
; 0000 006D                  //PWM_WRITE(0);
; 0000 006E             }
; 0000 006F             else
_0x68:
; 0000 0070             {
; 0000 0071                 PWM_UPDATE(1);
	LDI  R26,LOW(1)
_0x83:
	RCALL _PWM_UPDATE
; 0000 0072                 //PWM_WRITE(1);
; 0000 0073             }
; 0000 0074         }
; 0000 0075 
; 0000 0076         if(RS_Finish_Flag)
_0x65:
	SBRS R2,1
	RJMP _0x6A
; 0000 0077         {
; 0000 0078             switch (RS232_BUFF[2])
	__GETB1MN _RS232_BUFF,2
	LDI  R31,0
; 0000 0079             {
; 0000 007A                 case 0x53 :     // 상태요청
	CPI  R30,LOW(0x53)
	LDI  R26,HIGH(0x53)
	CPC  R31,R26
	BREQ _0x6D
; 0000 007B                    // CHK_Light();
; 0000 007C                     break;
; 0000 007D 
; 0000 007E                 case 0x43 :    // 조명변경
	CPI  R30,LOW(0x43)
	LDI  R26,HIGH(0x43)
	CPC  R31,R26
	BRNE _0x6F
; 0000 007F                     L0_PWM = RS232_BUFF[4];
	CALL SUBOPT_0x6
; 0000 0080                     L1_PWM = RS232_BUFF[5];
; 0000 0081                    // CHK_Light();      // 조명상태 전송
; 0000 0082                     break;
	RJMP _0x6D
; 0000 0083 
; 0000 0084                  case 0x57 :    // 조명상태 저장
_0x6F:
	CPI  R30,LOW(0x57)
	LDI  R26,HIGH(0x57)
	CPC  R31,R26
	BRNE _0x6D
; 0000 0085                     L0_PWM = RS232_BUFF[4];
	CALL SUBOPT_0x6
; 0000 0086                     L1_PWM = RS232_BUFF[5];
; 0000 0087                     PWM_UPDATE(0);      // L0 EEPROM Update
	LDI  R26,LOW(0)
	RCALL _PWM_UPDATE
; 0000 0088                     PWM_UPDATE(1);      // L1 EEPROM Update
	LDI  R26,LOW(1)
	RCALL _PWM_UPDATE
; 0000 0089                     // CHK_Light();      // 조명상태 전송
; 0000 008A                     break;
; 0000 008B             }
_0x6D:
; 0000 008C 
; 0000 008D             if(!L0_PWM)
	IN   R30,0x2A
	IN   R31,0x2A+1
	SBIW R30,0
	BRNE _0x71
; 0000 008E             {
; 0000 008F                 L0_PORT = 0;
	CBI  0x11,5
; 0000 0090             }
; 0000 0091             else
	RJMP _0x74
_0x71:
; 0000 0092             {
; 0000 0093                 L0_PORT = 1;
	SBI  0x11,5
; 0000 0094             }
_0x74:
; 0000 0095 
; 0000 0096             if(!L1_PWM)
	IN   R30,0x28
	IN   R31,0x28+1
	SBIW R30,0
	BRNE _0x77
; 0000 0097             {
; 0000 0098                 L1_PORT = 0;
	CBI  0x11,4
; 0000 0099             }
; 0000 009A             else
	RJMP _0x7A
_0x77:
; 0000 009B             {
; 0000 009C                 L1_PORT = 1;
	SBI  0x11,4
; 0000 009D             }
_0x7A:
; 0000 009E 
; 0000 009F             CHK_Light();      // 조명상태 전송
	RCALL _CHK_Light
; 0000 00A0             Clear_Set();
	RCALL _Clear_Set
; 0000 00A1 
; 0000 00A2         }
; 0000 00A3 
; 0000 00A4          // putString0(RS232_BUFF);
; 0000 00A5 
; 0000 00A6     } // End of while
_0x6A:
	RJMP _0x62
; 0000 00A7 
; 0000 00A8 } // End of main()
_0x7D:
	RJMP _0x7D
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
	ADIW R28,5
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_FND_Data:
	.BYTE 0x24
_EEPROM_Init_Data:
	.BYTE 0x10
_UART0_DATA:
	.BYTE 0x1
_RS232_BUFF:
	.BYTE 0xA
_NDX_232:
	.BYTE 0x1
_rtnMsg:
	.BYTE 0x8
_Tmr_Cnt0:
	.BYTE 0x1
_RS232_RS_Limit:
	.BYTE 0x1
_d100:
	.BYTE 0x1
_d10:
	.BYTE 0x1
_d1:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	STS  _Tmr_Cnt0,R30
	STS  _NDX_232,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	MOVW R26,R30
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CALL __MODW21U
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21U
	STS  _d100,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2:
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __MODW21U
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	STS  _d10,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x3:
	LDS  R30,_d100
	LDI  R26,LOW(_FND_Data)
	LDI  R27,HIGH(_FND_Data)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x4:
	LDS  R30,_d10
	LDI  R26,LOW(_FND_Data)
	LDI  R27,HIGH(_FND_Data)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x5:
	LDS  R30,_d1
	LDI  R26,LOW(_FND_Data)
	LDI  R27,HIGH(_FND_Data)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	__GETB1MN _RS232_BUFF,4
	LDI  R31,0
	OUT  0x2A+1,R31
	OUT  0x2A,R30
	__GETB1MN _RS232_BUFF,5
	LDI  R31,0
	OUT  0x28+1,R31
	OUT  0x28,R30
	RET


	.CSEG
__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

;END OF CODE MARKER
__END_OF_CODE:
