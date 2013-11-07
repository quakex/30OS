/* 告诉 C 编译器,有一个函数在别的文件里:函数的声明 */

void io_hlt(void);

void HariMain(void)
{
	int i;
	char *p;
	for (i = 0xa0000; i < 0xaffff; i++)
	{
		p = (char *) i;  // 代入地址
		*p = i & 0x0f;
	}

	for(;;){
		io_hlt();
	}

}
