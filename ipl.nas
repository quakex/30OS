;haribote-ipl

		ORG 	0x7c00 			; 指明程序的装载地址

; 以下这段是标准 FAT12格式软盘专用代码
		JMP 	entry
		DB		0x90
		DB		"HARIBOTE"		; 启动区的名称可以是任意的字符串（8字节）
		DW		512				; 每个扇区的大小（必须为512字节）
		DB		1				; 蔟cluster的大小（必须为一个扇区）
		DW		1				; FAT的起始位置（一般从第一个扇区开始）
		DB		2				; FAT的个数（必须为2）
		DW		224				; 根目录的大小（一般设置成224项）
		DW		2880			; 该磁盘的大小（必须是2880扇区）
		DB		0xf0			; 磁盘的种类（必须是0xf0）
		DW		9				; FAT的长度（必须是9扇区）
		DW		18				; 一个磁道有几个扇区（必须是18）
		DW		2				; 磁头数
		DD		0				; 不使用分区，必须是0
		DD		2880			; 重写一次磁盘大小
		DB		0,0,0x29		; 意义不明，固定
		DD		0xffffffff		; （可能是）卷标号码
		DB		"HARIBOTEOS "	; 磁盘的名称（11字节）
		DB		"FAT12   "		; 磁盘格式名称
		RESB	18				; 先空出18字节

; 程序主体
entry:
		MOV 	AX,0 			;初始化寄存器
		MOV 	SS,AX
		MOV 	SP,0x7c00		;??这一句的含义？
		MOV 	DS,AX
		MOV 	ES,AX

; 读磁盘

		MOV 	AX,0X0820
		MOV		ES,AX
		MOV		CH,0 			; 柱面0
		MOV		DH,0 			; 磁头0
		MOV		CL,2 			; 扇区2

		MOV 	AH,0X02 		; 读盘
		MOV		AL,1 			; 一个扇区
		MOV  	BX,0
		MOV 	DL,0X00 		; A 驱动器
		INT 	0X13 			; 调用磁盘 BIOS
		JC 		error

fin:
		HLT 					; 让 CPU 停止，等待指令
		JMP fin					; 无限循环

error:
		MOV 	SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			;给 SI+1
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 显示一个文字
		MOV		BX,15			; 指定字符颜色
		INT		0x10			; 调用显卡 BIOS
		JMP		putloop

; 信息显示部分
msg:
		DB		0x0a, 0x0a		; 2个换行
		DB		"MASTER, LOAD ERROR!"
		DB		0x0a			; 换行
		DB		0

		RESB	0x7dfe-$			; 填写0x00，直到0x001fe

		DB		0x55, 0xaa

