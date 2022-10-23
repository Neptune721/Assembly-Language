# Assembly-Language
这次汇编作业是完成是9*9乘法表的输出，在该部分代码依然还是先用loop实现行循环，将cx的值赋为09H，每输出一行后cl-1，将dl赋值为01H来表示当前的列数，在循环过程中自增，用jxx循环来实现列的循环。

99mul.exe运行截图
![1666530799706](https://user-images.githubusercontent.com/85387738/197394302-51c55cf0-4742-46eb-a4d5-c3779f42d16d.png)
