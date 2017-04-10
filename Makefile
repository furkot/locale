POT_DIR = templates/LC_MESSAGES
POT = $(POT_DIR)/messages.pot

LANGUAGES = ar bn de es fi fr he it nb nl pl pt-BR ru zh-TW

PO_FILES = $(LANGUAGES:%=%/LC_MESSAGES/messages.po)

MSGMERGE = msgmerge --sort-by-file --update
MSGINIT = msginit --no-translator

all: $(PO_FILES)

#  msginit if file is missing, msgmerge always to resort the .po file
%/LC_MESSAGES/messages.po: $(POT) | %/LC_MESSAGES
	[ -f $@ ] || $(MSGINIT) --input=$< --output-file=$@ -l $*
	$(MSGMERGE) $@ $<

%/LC_MESSAGES:
	mkdir -p $@

# translated only text only version
%.txt: %/LC_MESSAGES/messages.po
	msgexec --input $< 0 | xargs -0 -I M echo M > $@

# merge existing po files with new template
merge:
	$(foreach po,$(PO_FILES), $(MSGMERGE) $(po) $(POT);)

# commit latest changes, push to weblate branch, notify weblate server and reset to master
push:
	git commit -am 'updated to recent changes in UI'
	git push origin HEAD:weblate
	curl --silent --show-error https://translate.furkot.com/hooks/update/furkot/trips/ > /dev/null
	git reset --hard origin/master


.PHONY: all merge push
