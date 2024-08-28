=============
HTTP 认证方式
=============

:Date: 2024-07-27

Cookie
======

:URL: https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Cookies

一种基于 HTTP Header 数据储存机制，为无状态的 HTTP 协议带来一定的状态管理能力。
现代 HTTP 协议使用 Cookie 用于会话管理、个性化设置和隐私追踪，其他的数据储存需求
由 Web Storage 或者 IndexedDB 取代。

.. uml::
   :caption: Set-Cookie and Cookie

   actor Client
   Client -> Server:
   Server --> Client: Set-Cookie: foo=bar
   Client -> Server: Cookie: foo=bar

可以使用 `Document.cookie <https://developer.mozilla.org/zh-CN/docs/Web/API/Document/cookie>`_ 读写 Cookie：

.. code:: javascript

   console.log(document.cookie);

`Cookie 的同源策略 <https://developer.mozilla.org/zh-CN/docs/Web/Security/Same-origin_policy#%E8%B7%A8%E6%BA%90%E6%95%B0%E6%8D%AE%E5%AD%98%E5%82%A8%E8%AE%BF%E9%97%AE>`_：

   一个页面可以为本域和其父域设置 cookie，只要是父域不是公共后缀（public suffix）即可。Firefox 和 Chrome 使用 Public Suffix List 检测一个域是否是公共后缀。当你设置 cookie 时，你可以使用 Domain、Path、Secure 和 HttpOnly 标记来限定可访问性。当你读取 cookie 时，你无法知道它是在哪里被设置的。即使只使用安全的 https 连接，你所看到的任何 cookie 都有可能是使用不安全的连接进行设置的。

Session
=======

通常指一种「利用 Cookie_ 存储 SessionID」的会话管理方式。

.. uml::
   :caption: Seesion-based Authorization (only good paths)

   actor Client
   Client -> Server: Authorization, e.g. user=foo&password=***
   activate Server
   Server --> Server: Verify, then storage session info and create seesionID
   Server --> Client: Set-Cookie: sessionID=blahblah
   Client -> Server: Access resources, Cookie: sessionID=blahblah
   Server --> Server: Load session info by sessionID
   Server --> Client: Return the resources
   ...Continuous communication...

实际上的 Session 信息存在 Server 端的 DB 里，Seesion ID 作为存取用户信息的凭据。

Seesion ID、Session 的具体格式似乎没有标准，和具体使用的框架有关 |?|。

Session 引入了全局状态（所有节点都需要共享一个存储以获取 Session 信息），这可能对系统的 Scalability 有所影响，并且存在单点故障风险。

JWT: JSON Web Token
===================

:Spec: https://jwt.io/
:URL: https://docs.authing.cn/v2/concepts/jwt-token.html

在 Client 侧存储三段式 ``Header.Payload.Sign`` 的信息，每次请求都传递给 Server，Server 可以通过验证 Sign 无状态地验证 token，无状态也导致了 Server 端无法 revoke 制定的 token，只能等待其自然失效。

如何传递：
   - 通过 Set-Cookie/Cookie，无需额外的 Client 逻辑支持，但受同源策略限制
   - 通过其他 Header，需要 Client 有一定的逻辑支持（从约定好的地方读取 token 并存储，在每次请求时带上），可跨域使用，例如用来实现 `SSO: Single sign-on`_

     - 通过标准的 ``Authorization: Bearer XXX``
     - 通过非标准的 ``X-JWT-Token``、``X-Auth-Token`` 等 |todo|

       - 使用非标准 header 有什么好处？

实践上会引入一个专门的 Server（下图 AuthServer）来签发 JWT token，一次认证结束后无需再访问。只需要携带该 Token 即可用于多个业务（下图 BizServer），业务侧只需简单引入本地验证的逻辑即可。

.. uml::
   :caption: JWT-based Authorization (only good paths)

   actor Client
   Client -> AuthServer: Authorization, e.g. user=foo&password=***
   activate AuthServer
   AuthServer --> AuthServer: Verify, then generate JWT Token
   AuthServer --> Client: Return JWT token
   Client -> Client: Store JWT token locally
   deactivate AuthServer

   Client -> BizServer: Access resources, with JWT token
   activate BizServer
   BizServer --> BizServer: Verify JWT token locally
   BizServer --> Client: Return the resources
   ...Continuous communication...

.. todo:: Refresh Token

SSO: Single sign-on
===================

使用一次登陆为多个服务授权。

LDAP 可以实现 SSO，但似乎很复杂 |?|。`JWT: JSON Web Token`_ 也可以实现 SSO，但似乎要实现额外的逻辑才能做精细化的权限控制 |todo|
