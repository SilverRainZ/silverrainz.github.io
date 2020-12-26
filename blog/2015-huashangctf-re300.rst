========================================
 2015 华山杯 CTF Reverse 300
========================================

.. post:: 2015-11-02
   :tags: CTF
   :author: LA
   :language: zh

程序在此： `toetrix-crackme.exe <http://jianguoyun.com/p/Dbz27p8QtNrvBRiq2w4>`_\ ， VC++ 6.0 编写，无壳， CLI 程序。

这题本来我是一点都不会的，幸得尖刀某大牛指点思路，之后回头看反编译的代码
总算是摸清楚了程序的流程。因为这种复杂度的题目之前没有做出来过，特此记录。

程序很像一个推箱子游戏，在一个 ``9*9`` 的二维地图中有三种元素： 0，1，\ ``10 * x + 2``
分别代表空气，障碍和箱子，你需要做的就是将所有的箱子推出地图。

程序储存的地图如下：

.. code-block:: c-objdump

   .data:00407030 ; char map[]
   .data:00407030 map             db 1, 1, 0, 1, 1, 1, 0, 1, 1
   .data:00407030                 db 1, 0, 0, 0, 0, 0, 0, 0, 1
   .data:00407030                 db 1, 0, 0, 0, 0, 0Ch, 16h, 0, 1
   .data:00407030                 db 1, 20h, 0, 0, 0, 2Ah, 0, 0, 1
   .data:00407030                 db 0, 0, 0, 0, 0, 0, 0, 0, 0
   .data:00407030                 db 1, 0, 0, 34h, 0, 0, 0, 0, 1
   .data:00407030                 db 0, 0, 0, 0, 0, 0, 3Eh, 0, 0
   .data:00407030                 db 1, 48h, 0, 0, 52h, 0, 0, 0, 1
   .data:00407030                 db 1, 1, 0, 1, 1, 1, 1, 0, 1

转化成十进制：

.. code-block::

   1,  1, 0,  1,  1,  1,  0, 1, 1
   1,  0, 0,  0,  0,  0,  0, 0, 1
   1,  0, 0,  0,  0, 12, 22, 0, 1
   1, 32, 0,  0,  0, 42,  0, 0, 1
   0,  0, 0,  0,  0,  0,  0, 0, 0
   1,  0, 0, 52,  0,  0,  0, 0, 1
   0,  0, 0,  0,  0,  0, 62, 0, 0
   1, 72, 0,  0, 82,  0,  0, 0, 1
   1,  1, 0,  1,  1,  1,  1, 0, 1

可以看到每个箱子都是 ``X2`` 形式的数字。

用 IDA 分析整理得到 main 函数代码如下：

.. code-block:: c

   int __cdecl main(int argc, const char **argv, const char **envp)
   {
       char *step; // esi@1
       char direct; // bl@2
       int start; // eax@2
       int result; // eax@13
       int x; // [sp+8h] [bp-30h]@2
       int y; // [sp+Ch] [bp-2Ch]@2
       char input; // [sp+10h] [bp-28h]@1
       char v10; // [sp+36h] [bp-2h]@1

       step = &input;
       printf(aInputYourSn);
       scanf(aS, &input);
       v10 = 0;
       if ( input )
       {
           do
           {
               direct = step[1];
               start = *step - 48;
               step += 2;
               if ( !find_start(start, (int)&y, (int)&x) )// 遍历数组 返回的 x y 是箱子坐标
                   break;
               switch ( direct )
               {
                   case 49:                                // '1' 左
                       go_left(y, x);
                       break;
                   case 50:                                // '2' 右
                       go_right(y, x);
                       break;
                   case 51:                                // '3' 上
                       go_up(y, x);
                       break;
                   default:
                       if ( direct != 52 )
                           goto LABEL_12;
                       go_down(y, x);                      // '4' 下
                       break;
               }
           }
           while ( *step );
       }
   LABEL_12:
       if ( check_no_start() )
       {
           printf(aBDBuzeBuDGoodJ);                        // ∑(っ °Д °;)っ  good job!
           result = 0;
       }
       else
       {
           printf(aIsbuzebuIsjrII);                        // (╯°Д°)╯︵ ┻━┻  try again!
           result = 0;
       }
       return result;
   }

程序接受的输入以两个十进制位位为一组，
第一位 ``start`` 来指定一个箱子： 地图中值为（\ ``10 * start + 2``\ ）的元素
（在 ``find_start`` 函数中处理，返回 x，y 为箱子的坐标）；
第二位 ``direct`` 用来指定推箱子的方向，\ **字符** 1 2 3 4 分别代表方向左右上下
（由 ``go_xx`` 函数处理）。

..

   比如序列 2321 就是把值为 ``2*10 + 2 = 22`` 的箱子往上 ``3`` 移动， 再把该箱子往左 ``1`` 移动。


看一下 ``find_start`` 函数：

.. code-block:: c

   char __cdecl find_start(int start, int e_y, int e_x)
   {
       int x; // ecx@3
       int y; // eax@5

       *(_DWORD *)e_y = 0;
       while ( 2 )
       {
           *(_DWORD *)e_x = 0;
           do
           {
               x = *(_DWORD *)e_x;
               /* *(&map + 9 * (*e_y) + *e_x)  ->  map[y][x] */
               if ( *(&map[8 * *(_DWORD *)e_y] + *(_DWORD *)e_y + *(_DWORD *)e_x) == 10 * start + 2 )
                   return 1;
               *(_DWORD *)e_x = x + 1;
           }
           while ( x + 1 < 9 );
           y = *(_DWORD *)e_y + 1;
           *(_DWORD *)e_y = y;
           if ( y < 9 )
               continue;
           break;
       }
       return 0;
   }

函数遍历整个二维数组 ``map``\ ，如果在 map 中发现等于 ``10 * start + 2`` 的数字就 return
此时 ``e_x`` ``e_y`` 中便是该点坐标。

接下来看 ``go_left`` 函数：

.. code-block:: c

   char *__cdecl go_left(int y, int x)
   {
     int i; // eax@1

     for ( i = x - 1; i >= 0; --i )
     {
       if ( *(&map[9 * y] + i) )                   // 遇到非 0 点
         break;
     }
     if ( i == -1 )
       *(&map[8 * y] + y + x) = 1;                 // 边缘检测
     return xchg_point(y, x, y, i + 1);            // 交换本次起点和终点的值，如果到达边缘，交换的就是同一个点。
   }

该函数接受箱子的坐标，然后往坐标的左边走（\ ``x -> 0``\ ），
如果遇到一个非 0 点，即跳出循环。

如果 ``i == -1`` 说明从该箱子左边到边界都是 0，箱子可以移出地图了，
于是把该箱子坐标处的值标记为 1（变成障碍了，便于接下来交换）。

接下来函数把箱子的坐标 ``(x, y)`` 和 移动终点的坐标 ``(i+1, y)`` 传给函数 ``xchg_point``\ ，
函数 ``xchg_point`` 比较简单，仅仅是交换两个点的值。

这样就完成了一次左移，\ ``go_right`` ``go_up`` 等函数同理。

..

   **注意：** 如果终点是边界的话，箱子的值会被置为 1，
   交换后的结果就是：箱子处变为 0，终点变为 1。


处理完一次移动之后 ``step`` 自增 2，进行下一次移动，直到整个序列结束。
就执行 ``check_no_start`` 做最后的检查：

.. code-block:: c

   char check_no_start()
   {
       signed int y; // esi@1
       signed int x; // ecx@2

       y = (signed int)map;
       while ( 2 )
       {
           x = 0;
           do
           {
               if ( *(_BYTE *)(y + x) % 10 == 2 )      // 有一个箱子
                   return 0;
               ++x;
           }
           while ( x < 9 );
           y += 9;
           if ( y < (signed int)&end_of_map )
               continue;
           break;
       }
       return 1;
   }

检查整个 ``map`` 中是否有形如 ``X2`` 的数字，即是否还有箱子存在，
如果没有的话，返回 1，这就是我们期望的结果。

根据以上流程我们就可以手动算出一个能移除所有箱子的序列，

..

   注意每个箱子移动可以不是连续的，可以先移动一个箱子到一个地方，再去移动另一个。


移动箱子的顺序的和路径如下：

.. code-block::

   62 = 62
   52 = 515351
   82 = 8183
   72 = 7372
   42 = 4441
   12 = 141114
   32 = 3431
   22 = 23
   42 = 4244

因此得到 key： ``625153518183737244411411143431234244``


附上分析时使用的 `idb 数据库 <http://jianguoyun.com/p/DaHaiScQtNrvBRjo2w4>`_
