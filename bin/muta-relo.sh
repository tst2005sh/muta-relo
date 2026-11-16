#!/bin/bash

STARTPWD="$(pwd)"
cd -- "$(dirname "$(readlink -f "$0")")/.." || exit 1
BASEDIR="$(pwd)"
cd -- "$STARTPWD" || exit 1

mutarelo() {
	# POSIX code get the last argument
	local last;for last do :; done

	if [ ! -t 0 ] && [ "$last" = "-" ]; then
		# POSIX code to remove the last argument
		local a n=$#;for a do shift;n=$((n-1));[ "$n" -le 0 ]||set -- "$@" "$a";done

		. "$BASEDIR/deps/muta/lib/muta.lib.sh"

		MUTA_MAXPROCS="${MUTA_MAXPROCS:-20}" \
		MUTA_KEEPLOG="${MUTA_KEEPLOG:-false}" \
		MUTA_PROGRESS="${MUTA_PROGRESS:-true}" \
		\
		MU_TA="$BASEDIR/deps/muta/bin/_ta.sh" \
		muta "$BASEDIR/deps/relo/bin/relo.sh" "$@"
	elif [ ! -t 0 ]; then
		echo >&2 'Warning: possible syntax error. There is something in stdin but the last argument is not "-"'
		return 1
	else
		"$BASEDIR/deps/relo/bin/relo.sh" "$@"
	fi
}
mutarelo "$@"
exit $?
