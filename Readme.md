# Furkot locale

Translations and other locale specific data for [Furkot] road trip planner.

This repository contains all the translatable resources from Furkot road trip
planner. If you want to help translating Furkot into your language [let us
know][furkot-email]

## Translating

Furkot is using [gettext] compatible [.po] file format. If you're familiar
with github and gettext feel free to fork this repo and send PRs. If you want
to help but terms line _fork_, _PR_, _git_ are foreign to you here's what you
can do:

1. download .po file for your language
2. review and edit the file
3. send the resulting file to trips@furkot.com

### Editing message.po files

`.po` files can be edited in pretty much any text editor. Format is quite
`.self-explanatory:

````po
# You can add more comments here
#. Some comments for translator
#: file.jade:45           <<-- you can safely ignore this
#, fuzzy                  <<-- fuzzy indicator
msgid "Trip map"	      <<-- original string
msgstr "Mapa padróży"     <<-- translated string
````

There are also specialized editor available. If you don't have any that you
regularly use try one of these two:

* [PoEdit] - versions for Windows, Mac OS X and Linux are available
* [PoEditor] - works in your browser

`messages.po` file includes English strings and automatically generated (as
in: really bad and awkward) translation in your language. All automatically
translated strings are marked as _fuzzy_.

As a reviewer translator you go through the list of strings and do **one** of
the 3 things:

- approve the existing translation - by removing the _fuzzy_ indicator
- translate the entry - delete the existing translation, type your version,
  **and** remove _fuzzy_ indicator
- do nothing - which means you leave it for someone else to tackle it

Feel free to add comments and questions - most editors allow for that.

Don't feel like you have to go through the entire file. Every little bit
helps. You are also always welcome to improve the existing translation.

### Removing _fuzzy_

If you use text editor removing _fuzzy_ means removing the entire line with
_fuzzy_ comment. All specialized .po editors (like [PoEdit] or similar
software) have a dedicated _fuzzy_/_not fuzzy_  button which makes it easy to
toggle that state.

## Adding your language

If you don't see you language open an issue or [e-mail us][furkot-email]

Alternatively - but only if you are comfortable with [gettext] toolkit - you can
also use `make`. For example to add Hungarian add `hu` to `LANGUAGES` variable
and then run.

    make

To update a `.po` file you run:

    make hu/LC_MESSAGES/messages.po  # only updates Hungarian location


## Credits

Let us know how you want to be credited: we will list your name here and in Furkot.
We can also include (or not) your e-mail or/and a link to your website.


[Furkot]: https://trips.furkot.com
[furkot-email]: mailto:trips@furkot.com
[gettext]: https://www.gnu.org/software/gettext/
[.po]: https://www.gnu.org/software/gettext/manual/gettext.html#PO-Files
[PoEdit]: http://poedit.net
[PoEditor]: https://localise.biz/free/poeditor
