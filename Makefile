POT = templates/LC_MESSAGES/messages.pot

LANGUAGES = ar bn de el es fi fr he hu it nb nl pl pt pt-BR ru uk zh-TW

PO_FILES = $(LANGUAGES:%=%/LC_MESSAGES/messages.po)
PO_GLOSS = $(LANGUAGES:%=%/glossary.po)
PO_ALL = $(PO_FILES) $(PO_GLOSS)

MSGMERGE := msgmerge --update --no-fuzzy-matching --backup=none
MSGINIT := msginit --no-translator

all: merge

# translated only text only version
%.txt: %/LC_MESSAGES/messages.po
	msgexec --input $< 0 | xargs -0 -I M echo M > $@

#  msginit if file is missing, msgmerge always to resort the .po file
define merge-messages =
	mkdir --parent $(@D)
	[ -f $@ ] || $(MSGINIT) --input=$< --output-file=$@ -l $*
	$(MSGMERGE) $1 $@ $<
endef

%/glossary.po: templates/glossary.pot
	$(call merge-messages, --sort-output)

%/LC_MESSAGES/messages.po: templates/LC_MESSAGES/messages.pot
	$(call merge-messages, --sort-by-file)

# create update glossaries
glossary: $(PO_GLOSS)

.PHONY: glossary

messages: $(PO_FILES)

.PHONY: messages

# merge existing po files with new template
merge: glossary messages

# commit latest changes, push to weblate branch, notify weblate server and reset to master
push:
	git commit -am 'updated to recent changes in UI'
	git push origin HEAD:weblate
	curl --silent --show-error https://translate.furkot.com/hooks/update/furkot/trips/ > /dev/null
	git reset --hard origin/master

%.po.check: %.po
	msgfmt --check $<

check: $(PO_ALL:%=%.check)

.PHONY: all merge push check
