=======================================================
chezetc: Extending chezmoi to manage files under `/etc`
=======================================================

.. post:: 2025-09-22
   :tags: Chezmoi, DevOps, Shell
   :author: LA
   :language: en
   :location: 燕郊
   :external_link: https://silverrainz.me/chezetc/


If you are Chzemoi user and want to use Chzemoi to manage files outside ``$HOME``. This script is for you :D

Chezetc enhances chezmoi, transforming it from a ``$HOME`` manager into a tool that can seamlessly:

- Manage files in /etc and other directories owned by root.
- Manage multiple chezmoi repositories without manually specifying ``--config <PATH>``.
