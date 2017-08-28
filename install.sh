#!/bin/sh
ANSIBLE=ansible-playbook
PLAYBOOK=test.yml

if test 0 -eq $(id -u); then
	echo "error: do not run this program as root" >&2
	exit 1
fi

type -a "${ANSIBLE}" 2>&1 >/dev/null || {
	echo "error: ansible must be installed first" >&2
	exit 1
}

EXTRAVARS="extravars.yml"
if test -f "./${EXTRAVARS}"; then
	EXTRAVARS="-e@${EXTRAVARS}"
else
	EXTRAVARS=""
fi

${ANSIBLE} "${PLAYBOOK}" --ask-become-pass ${EXTRAVARS} $@
