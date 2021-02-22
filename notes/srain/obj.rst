=======
Objects
=======

:date: 2021-02-20

.. highlight:: c

.. contents::


Entity 
------

SrnEntity
~~~~~~~~~

::

    gchar* identity;
    gchar* name;
    gchar* summary;
    gchar* description;
    GdkPixbuf *avatar;
    GVariantDict *fields;

SrnAction
~~~~~~~~~

Top Level
---------

SrnApplication
~~~~~~~~~~~~~~

Method::

    const GList* add_messenger(SrnMessenger);
    const GList* list_windows();

SrnWindow
~~~~~~~~~

Method::

    const GList* list_workspace();
    new_workspace();

SrnWorkSpace
~~~~~~~~~~~~

::

    const GList* list_pages();

Buffer
------

Memeber::

    GtkListView* message_list;

SrnServiceBuffer
~~~~~~~~~~~~~~~~

Member::

    SrnUser *self;

Method::

    set_child(GtkWidget* widget);

SrnBuffer
~~~~~~~~~

Memeber::

    GtkListView* message_list;

SrnChannelBuffer
~~~~~~~~~~~~~~~~

    
SrnDialogBuffer
~~~~~~~~~~~~~~~

Message
-------

SrnMessage
~~~~~~~~~~

Member::

    SrnMember *origin
    SrnBuffer *target
    GDateTime *time;
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
~~~~~~~~~~~~~~~

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

    gchar *identity;
    gchar *name;
    gchar *summary;
    gchar *description;
    GList *members;

SrnMember
~~~~~~~~~

Member & User Panel

Member::

    gchar *name;
    gchar *summary;
    gchar *description;
    SrnBuffer *buffer;
    SrnUser *user;

SrnMemberList
~~~~~~~~~~~~~

Messenger
---------

io_loop

SrnMessengerFeature
~~~~~~~~~~~~~~~~~~~

SrnMessenger
~~~~~~~~~~~~

Method::

    GtkWidget* connection_panel();
    GtkWidget* service_penel();
    GtkWidget* setting_panel();
    GtkWidget* about_panel();
    GtkWidget* user_panel(SrnUser *user);
    GtkWidget* memeber_panel(SrnMember *member);
