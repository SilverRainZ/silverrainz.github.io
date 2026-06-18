===========
SilverRainZ
===========

.. data.render::

   {% set revs = load_extra('recentupdate', count=6, current_doc=True) %}

   .. dropdown:: 修改记录
      :icon: history

      {% for r in revs %}
      :{{ r.date.strftime('%Y 年 %m 月') }}: {{ r.message[0] }}
      {% endfor %}

.. friend:: _
            Shengyu Zhang
            LA
            i
            me
            谷月轩
   :blog: https://silverrainz.me/
   :avatar: https://github.com/SilverRainZ.png

   I am Shengyu Zhang (张盛宇), AKA ``SilverRainZ``, ``LA``.
   I was born in 1995, from Guangdong, China, and now live in Hebei, China.

   I used to work for Chaitin Tech Inc. (2017~2020), ByteDance Inc. (2021~2024).

I am...

:a programmer: I am SilverRainZ__ on GitHub, checkout my resume__ if you are interested
:an artist on the road: my :doc:`works </gallery>` are listed here, todo: portfolio
:a |linux| user: also a member of `Arch Linux CN Community`__
:an |oss| author: I created `Srain IRC Client`__, `Sphinx Notes`__ and `more...`__

__ https://github.com/SilverRainZ
__ https://silverrainz.me/resume/
__ http://archlinuxcn.org
__ https://srain.silverrainz.me/
__ https://sphinx.silverrainz.me/
__ https://github.com/SilverRainZ?tab=repositories&q=&type=source&language=&sort=stargazers

.. |linux| replace:: :abbr:`Linux (I use Arch, btw)` 
.. |oss| replace:: :abbr:`OSS (Open Source Software)` 

.. _contact-me:

Contact
-------

You can contact me in the following ways:

:Email:                    :email:`i@silverrainz.me`
:Email (for job issue):    :email:`job@silverrainz.me`
:Email (for arch issue):   :email:`la@archlinuxcn.org`
:IRC:                      :literal_strike:`SilverRainZ@LiberaChat`, inactive since 2025
:Matrix:                   :literal_strike:`@la:mozilla.org`, inactive since 2026
:WeChat:                   ``@SilverRainZ``

Timeline
--------

Events worth recording:

.. include:: ./events.dot
