=======
Objects
=======

:date: 2021-02-20

.. highlight:: c

.. contents::

Top Level
---------

SrnApplication
~~~~~~~~~~~~~~

Method::

    const GList* list_windows();

SrnWindow
~~~~~~~~~

Method::

    const GList* list_buffers();
    const GList* list_service_desks();

Buffer
------

SrnServiceDesk
~~~~~~~~~~~~~~

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
    gchar *display_name;
    gchar *summary;
    gchar *description;
    GList *members;

SrnMember
~~~~~~~~~

MemberPanel & User Panel

Member::

    gchar *display_name;
    gchar *summary;
    gchar *description;
    GList *members;

SrnUserList
~~~~~~~~~~~

Messenger
---------

SrnMessenger
~~~~~~~~~~~~

Method::

    const char *version;
    const GtkWidget* connection_panel();
    const GtkWidget* concat_penel();
    const GtkWidget* user_panel(const char *user_id);
