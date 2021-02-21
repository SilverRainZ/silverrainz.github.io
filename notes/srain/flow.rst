====
Flow
====

:date: 2021-02-21

Login
=====

1. [A] App run
1. [A] Select Messenger
1. [A] Query connection panel
1. [M] Connect and create buffers with contact panel

Join
====

1. [M] Operate on contact panel
2. [A] Create channel buffer and connect signal

Message
=======

Send Text
---------

1. [M] Register text entry signal handler
2. [A] User type in text entry
3. [M] Read message from text entry
4. [M] Sending
5. [A] Add a pending message
6. [M] Sent
7. [A] Update message state

Send Media
----------

1. [M] Register a button
2. [A] User click the button
3. [M] Sending
4. [A] Add a pending message
5. [M] Sent
6. [A] Update message state

Recv text
---------

1. [M] Recv callback
2. [A] Add message to buffer

Recv media
----------

1. [M] Recv callback
2. [A] Add message to buffer
3. [M] Recv done 
4. [A] Update message state

User
====

Init user list
---------------
