# Assembly-Language
     过程调用练习
功能：接受年、月、日信息并进行显示
目的：掌握响铃符方法；掌握年、月、日的输入方法；掌握过程调用方法。
内容：先显示提示信息“WHAT IS THE DATE(MM/DD/YY)?"并响铃一次，然后接收键盘输入的月/日/年信息，并显示。

实现过程：这道题目第一眼看上去是个很好实现的功能，就是从键盘上接收到输入的月日年的信息，再将他们分开记录并显示出来，但用汇编实现其实对我来说还是有些困难。题目主要是为了去加深对过程调用，栈，call和ret，push和pop以及跳转指令这些其中的内在关系，还初次用到了响铃符，另外题目还涉及了多次的输入输出，对于段地址和偏移量的理解要求也更高了。因为本次题目要用过程调用的方法，所以在代码中多次用到了call和ret来进行跳转，通过debug的观察后面了解到，当我们用到call指令时，会进行两步操作，首先将IP压入栈中，对应的sp=sp-2，再通过jmp指令进行近转移，进入到对应的"函数"中去，当遇到ret指令时，则是利用前面压入栈中的数据，用pop指令，sp=sp+2，修改IP的内容，也实现近转移，有点类似于return，一般call和ret指令也都是成对出现。同时，这道题目涉及到的输入输出比较多，在汇编语言下大多数的输入输出样子基本都是靠自己来进行控制，所以经常会因为不小心而导致数据的错位从而得不到正确的答案这也是后面需要注意的点。

ShowDate.asm的运行截图
![1667136786087](https://user-images.githubusercontent.com/85387738/198881321-d487c6ee-4d81-444a-b8a5-a60603d6e5e7.png)
