:Date: 2022-10-05
:Tags: 色彩理论

.. default-role:: math

====
原色
====

.. term:: _

理论上而言，凡是彼此之间无法替代的颜色都可以被选为「原色」。实践上常用的有：:term:`色光三原色` 和 :term:`色料三原色`。

更精确一点，原色是一个相对概念，总是和对应的 :term:`色彩空间` 关联。

.. youtube:: Ob_ytLkqIuM

色光三原色
==========

.. term:: _

.. image:: https://upload.wikimedia.org/wikipedia/commons/0/05/AdditiveColorMixing.svg
   :width: 10%
   :align: right

红、绿、蓝。用于屏幕，投影仪。

色料三原色
==========

.. term:: _
  
.. image:: https://upload.wikimedia.org/wikipedia/commons/a/ac/SubtractiveColorMixing.png
   :width: 10%
   :align: right

青色（Cyan）、品红（Magenta）、黄色(Yellow)，用于印刷。

常见的疑惑
==========

同色异谱：为什么混合色和单色可能有同样的视觉效果？
--------------------------------------------------

假设单种视锥细胞对外只能输出一种非负信号。使用两种单色光 `L_1`、`L_2` 能分别单独刺激两种视锥细胞 `C_1` 和 `C_2`，分别得到两种信号 `S_{C_1}`、`S_{C_2}`，若存在一种单色光 `L_3` 能同时刺激两种细胞，同样得到等强度的两种信号 `S_{C_1}`、`S_{C_2}`。

细胞对外输出的信号是一致的，人脑的感受也应当是一致的，在人眼看来，`L_1 + L_2` 的混合光，就应该和单色光 `L_3` 的视觉感受是一致的。即 `L_1 + L_2 = L_3`。

   The human eye is sensitive to broad bands of light wavelengths, and thus the eye is *NOT a spectrometer*: *it interpolates colors depending which of the three cones are receiving light*. For example, there are two ways to make "yellow" light. 1) use equal amounts of red and green light. These stimulate the red and green cones, and the brain sees "yellow". 2) use a wavelength of light that is between red and green (about 565nm). Because the response of the red and green cones overlaps, this single color also stimulates both the red and green cones. The brain sees "yellow in both cases. [#]_

如上述，人眼不是光谱仪，颜色是人根据三种视锥细胞收到的光线（而产生的信号）插值而来，三种细胞产生的离散值拟合了线性的色彩空间。

经验法则 :zhwiki:`格拉斯曼定律` 更广泛地印证了上述的假说，可以认为上述假说是该定律的一个生物学猜测。

参见 :term:`三色刺激值`。

.. [#] https://web.archive.org/web/20150226091050/http://www.newton.dep.anl.gov/askasci/phy00/phy00871.htm

原色为什么常是三种？
--------------------

一种观点是，人眼中有三种 :zhwiki:`视锥细胞`，其识别范围构成了 :zhwiki:`可见光光谱`，在可见光谱中，分别对黄绿（L 型）、绿（M 型）、蓝紫光（S 型）最敏感。

.. figure:: https://commons.wikimedia.org/wiki/File:Cone-fundamentals-with-srgb-spectrum.svg#/media/File:Cone-fundamentals-with-srgb-spectrum.svg

   https://commons.wikimedia.org/wiki/File:Cone-fundamentals-with-srgb-spectrum.svg#/media/File:Cone-fundamentals-with-srgb-spectrum.svg

结合 同色异谱 中的假设，单种视锥细胞对外只能输出一种非负信号，人眼观察到的色彩由三种细胞输出信号的强度控制，那么使用三种能分别独立刺激三种细胞的光，我们就能组合出尽量大的色彩空间。借用一下别人的话：

   为什么是三原色？因为人类对色彩的感知结果位于一个三维的线性空间中。最少需要三种颜色的光才能有足够的表达能力来表现各种颜色。为什么选 RGB 作为三原色？因为色彩空间不是真正数学意义上的线性空间，从工程角度考虑，以 RGB 作为三原色，能让显示器能够显示更多的颜色（此外，最初测试人眼对 RGB 三色光的色匹配曲线，也是希望能尽量单独地刺激三种视锥细胞）。[#]_

.. [#] https://zhuanlan.zhihu.com/p/24214731
