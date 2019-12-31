.POSIX:
.SUFFIXES:

DIR_SCONNECT=$(HOME)/.sconnect
DIR_MOZILLA=$(HOME)/.mozilla/native-messaging-hosts
HOST_FILE=sconnect_host_linux

.PHONY: install
install: \
$(DIR_SCONNECT)/$(HOST_FILE) \
$(DIR_SCONNECT)/$(HOST_FILE)-nonfree \
$(DIR_MOZILLA)/com.gemalto.sconnect.json \

.PHONY: kill
kill:
	-pkill sconnect_host_l
	-pkill -f sconnect_host_linux

$(DIR_SCONNECT) $(DIR_MOZILLA):
	mkdir -p $@

$(DIR_MOZILLA)/com.gemalto.sconnect.json: com.gemalto.sconnect-ff.json | $(DIR_MOZILLA)
	chmod +w $@
	cp $< $@
	sed -i 's/<<<user>>>/'$(USER)'/g' $@

$(DIR_SCONNECT)/$(HOST_FILE)-nonfree: $(HOST_FILE) | $(DIR_SCONNECT)
	chmod +w $@
	cp $< $@
	chmod 500 $@

$(DIR_SCONNECT)/$(HOST_FILE): firejail_$(HOST_FILE).sh | $(DIR_SCONNECT)
	chmod +w $@
	cp $< $@
	chmod 500 $@
