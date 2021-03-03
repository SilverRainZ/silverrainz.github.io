=======
Objects
=======

:date: 2021-02-20

.. highlight:: c

.. contents::


SrnFlow
-------

Props::

    name

Methods::

    GtkWidget *launch();

Signals::

    "busy" [GtkWidget* | Text]
    "next" GtkWidget*
    "abort" GtkWidget*

Entity 
------

SrnEntity
~~~~~~~~~

An object that you can talk to.

::

    GInterface parent;
    gchar* identity;
    gchar* name;
    gchar* summary;
    gchar* description;
    GdkPixbuf *avatar;
    GVariantDict *fields;

    GMenu *operations; // Add contact, Block and etc
    GtkWidget *custom_widgets[];

SrnUser
^^^^^^^

::

    SrnEntity parent;

SrnGroup
^^^^^^^^

::

    SrnEntity parent;
    GListModel *member_list;

SrnMember
~~~~~~~~~

::

    SrnBuffer *context;
    SrnEntity* entity;

    GMenu *operations; // Mute, Kick, and etc
    GtkWidget *custom_widgets[];

Top Level
---------

SrnApplication
~~~~~~~~~~~~~~

SrnWindow
~~~~~~~~~

SrnWorkSpace
~~~~~~~~~~~~

Buffer
------

SrnBuffer
~~~~~~~~~

Memeber::

    SrnEntity* target;
    GtkListView* message_list;
    GtkListView* message_list;

SrnChannelBuffer
~~~~~~~~~~~~~~~~

::

    GtkListView* member_list

    
SrnDialogBuffer
~~~~~~~~~~~~~~~

::

    SrnMember* member[2];

Message
-------

SrnMessageView
~~~~~~~~~~~~~~

SrnTextMessageView
^^^^^^^^^^^^^^^^^^

::

    set_model(SrnTextMessage*);
    SrnTextMessage* get_model();

SrnRichMessageView
^^^^^^^^^^^^^^^^^^

SrnImageMessageView
...................

SrnAudioMessageView
...................

SrnVideoMessageView
...................

SrnWebviewMessageView
.....................

Sure??

SrnCustomMessageView
^^^^^^^^^^^^^^^^^^^^

SrnMessage
~~~~~~~~~~

Member::

    SrnMember *original
    SrnBuffer *target
    GDateTime *recv_time;
    GDateTime *send_time;
    GList *tags

Method::

    gboolean has_tags(const gchar *tag);

SrnTextMessage
~~~~~~~~~~~~~~~

Member::

    gchar *content;

SrnMediaMessage
~~~~~~~~~~~~~~~

Member::

    gchar* mime_type;
    GFile* content;

SrnCustomMessage
~~~~~~~~~~~~~~~~

Memeber::

    GtkWidget *widget;

SrnMessageFilter
~~~~~~~~~~~~~~~~

.. TODO

SrnMessageRenderer
~~~~~~~~~~~~~~~~~~

.. TODO

User
----

SrnUser
~~~~~~~

Member::

    SrnEntity
    GList *members;

SrnMember
~~~~~~~~~

Member & User Panel

Member::

    SrnUser *user;
    SrnBuffer *buffer;

SrnMemberList
~~~~~~~~~~~~~

Messenger
---------

SrnMessenger
~~~~~~~~~~~~

Method::

    SrnFlow *login;
    SrnFlow *contact;
    SrnFlow* setting;
    GtkWidget* setting;

    SrnMessenger *srn_messenger_new(SrnApplication *app);
    GtkWidget* connection_panel();
    GtkWidget* about_panel();
    GtkWidget* user_panel(SrnUser *user);
    GtkWidget* memeber_panel(SrnMember *member);
