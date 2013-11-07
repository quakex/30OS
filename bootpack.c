/* 告诉 C 编译器,有一个函数在别的文件里:函数的声明 */

void io_hlt(void);

void HariMain(void)
{

fin:
   /* 执行 naskfunc.nas 里的_io_hlt*/
	io_hlt();
	goto fin;

}
