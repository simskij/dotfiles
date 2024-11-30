#!/usr/bin/env bash
set -ueo pipefail

_error() {
	notify "Failed retrieving secrets"
}

notify() {
  # Set another icon if you don't want 1Password by setting `op_icon` variable
	: op_icon="${op_icon:="$(readlink -f "$(which 1password)" | rev | cut -d/ -f 3- | rev)/share/icons/hicolor/512x512/apps/1password.png"}"
	export op_icon
	notify-send -i "${op_icon}"  "${*}"
}

: "${PINENTRY_PROGRAM:=pinentry-rofi}"
_timeout_conf="15s"


pin() {
	for i in $(seq 4); do
		local progress="$(seq -s= $(((i-1)*25))|tr -d '[:digit:]')"
		local pin="$(printf '%s\n' "SETPROMPT 1Password Login" \
				"SETDESC ${progress:- }" "GETPIN" \
				| "${PINENTRY_PROGRAM}" || true)"
		# if user hit escape skip processing
		if echo "${pin}" | grep -q "^ERR"; then
			# somehow continues execution if exit 0
			exit 1
		# check if pin was correct
		# else repeat
		elif echo "${pin}" | grep -oP 'D \K.*' | op signin --raw; then
			# finish loop after successful signin
			return
		fi
	done
	notify "Too many failed attempts"
	exit 1
}

login() {
	pin | secret-tool store --label='onepassword' onepassword session
}

print-account-list() {
  # TODO would be nice to cache this output, making rofi display entries faster 
	op item list --format=json | jq -r '.[] | .id + "\t" + .title + "/" + .additional_information'
}

rofi-launch() {
# FIXME rofi display columns doesn't trim the tab somehow
	print-account-list | \
		rofi -dmenu -display-columns 2 -i | \
		xargs --no-run-if-empty "${0}"
}

retrieve-secret() {
	op item get "${item}" --fields label=password
}

temp-copy() {
	pass="${1}"
	name="${2}"
	clip="$(wl-paste || echo '')"
	echo -n "${pass}" | wl-copy
	notify "Copied '${name}'"
	sleep "${_timeout_conf}"
	if [ "$(wl-paste)" = "${pass}" ]; then
		echo "${clip}" | wl-copy
		notify "Cleared '${name}'"
	fi
}

retrieve-copy() {
	item="${1}"
	name="${*:2}"
	temp-copy "$(retrieve-secret "${item}")" "${name}"
}

export_secrets() {
	# TODO support more than one account
	userUUID="$(op account list --format=json | jq -r '.[0] | .user_uuid' || { notify op cli configuration missing; exit 1; })"
	# TODO be smarter about login ceremony
	export "OP_SESSION_${userUUID}=$(secret-tool lookup onepassword session || true)"
	# verify auth on account retrieval attempt
	# could be done differently, you're losing 0.5 seconds to network for this
	op vault list &>/dev/null || login;
	export "OP_SESSION_${userUUID}=$(secret-tool lookup onepassword session)"
}


# If not sourced
if ! [[ "${ZSH_EVAL_CONTEXT:-}" =~ :file$ ]]; then
	# trap only when not in clI
	trap _error ERR
	export_secrets
	if [ -z "${1:-}" ]; then
		rofi-launch
	elif [ -n "${1:-}" ]; then
		retrieve-copy "${@}"
	fi
fi
