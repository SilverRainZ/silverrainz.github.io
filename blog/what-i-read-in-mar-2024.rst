======================
2025 年 3 月我读了什么
======================

.. post::
   :tags: 阅读
   :author: LA
   :category: 阅读记录
   :language: zh_CN

03-06: `DeepSeek 新手上路 (二) 模型自部署`__
============================================

相关工具
   - 部署：Ollama

     .. seealso:: `开源大模型的本地部署,本地大语言模型部署工具对比：Ollama vs LM Studio 如何选择适合自己的 AI 助手 - 开发调优 - LINUX DO <https://linux.do/t/topic/414577>`_

   - 查看显卡状态：:archpkg:`nvidia-utils` 的 ``nvidia-smi``、:ghrepo:`XuehaiPan/nvitop`
   - 模型导入导出：https://gist.github.com/nahushrk/5d980e676c4f2762ca385bd6fb9498a9

.. term:: 蒸馏
   模型蒸馏（Model Distillation）是一种用于模型压缩、加速的通用方法。用一个容量较大的预训练模型作为教师模型，利用其输出来进一步训练学生模型（往往是参数规模更小的模型）。学生模型的规模上往往是更易部署的，同时在泛化能力上要远优于使用原始数据集训练的同等规模模型，但与满血版本的教师模型显然是存在差异的。

   以 ``deepseek-r1`` 的 ``1.5b-qwen-distill-fp16`` 版本为例，使用了通义千问 `qwen` 作为学生模型。

.. term:: 量化
   模型量化（Model Quantization）通常指的是将模型中的参数（例如权重和偏置）从浮点数转换为低位宽度的整数，例如从32 位的浮点数转换为 8 位整数。

   以 ``deepseek-r1`` 的 ``671b-fp16`` 版本为例，``fp16`` 就是使用了 16 位浮点数未经量化的版本，``671b-q8_0`` 为 8 位量化版本，``671b-q4_K_M`` 为 4 为量化版本。

   其他的参数可以理解为参数取整的策略？参看？`llama.cpp里面的Q8_0,Q6_K_M,Q4_K_M量化原理是什么？ - 知乎 <https://www.zhihu.com/question/633365088>`_

Troubleshooting
   Ollama 不使用 GPU
      安装 :archpkg:`ollama-cuda`，参见 `ollama-cuda <https://wiki.archlinux.org/title/Ollama>`_。

   Prompt 编写
      也可以让 AI 写……闭环了。

   爆显存
      `GPU System Requirements for Running DeepSeek-R1 <https://apxml.com/posts/gpu-requirements-deepseek-r1>`_
