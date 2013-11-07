; haribote-os

; 有关BOOT_INFO
CYLS	EQU		0x0ff0			; 设定启动区，这个地址是从ipl.nas 中
								; MOV [0X0FF0] CH
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; 关于颜色数目的信息.颜色的位数
SCRNX	EQU		0x0ff4			; 分辨率的 x
SCRNY	EQU		0x0ff6			; 分辨率的 y
VRAM	EQU		0x0ff8			; 图像缓冲区的开始地址

		ORG		0xc200

		MOV 	AL,0x13 		; VGA 显卡，320*200*8 位彩色
		MOV 	AH,0x00
		INT 	0x10

		MOV		BYTE [VMODE],8	; 记录画面模式
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; 用 BIOS 取的键盘上各种 LED 指示灯的状态

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL
fin:
    	HLT
      	JMP   	fin
