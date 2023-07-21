#!/usr/bin/env bash

function sh_getbgcolor {
	local cfile="$HOME/.config/bigbashview_lightmode"
	local lightmode=0
	local result
	local status

	# Open Autodetect and read saved background color
	if ! test -s "$cfile"; then
		# Read background color
		if result="$(kreadconfig5 --group "Colors:Window" --key BackgroundNormal)"; then
			if (( -n "$result" )); then
				KDE_BG_COLOR="$(bc | sed 's|^|(|g;s|,|+|g;s|$|)/3|g' <<< "$result")"
				# Verify if is light or not
				if [[ "$KDE_BG_COLOR" -gt "127" ]]; then
					lightmode=1
				fi
			fi
		fi
	else
		lightmode=$(printf "%s" "$(<"$cfile")")
	fi

	if ((lightmode)); then
		echo '<body class=light-mode>'
	else
		echo '<body>'
	fi
}

function sh_setbgcolor {
	local cfile="$HOME/.config/bigbashview_lightmode"
	local lightmode=0

	[[ "$1" = "true" ]] && lightmode=1
	echo "$lightmode" >"$cfile"
}

function sh_language_hebraico {
	grep ^he <<< "$LANG"
	return "$?"
}

function sh_getcpu {
	#awk -F ':' 'NR==1 {print $2}' <<< "$(grep 'model name' /proc/cpuinfo)"
	grep 'model name' /proc/cpuinfo | awk -F ':' 'NR==1 {print $2}'
}

function sh_getmemory {
	awk -F' ' 'NR==2 {print $2}' < <(free -h)
}

function sh_getvga {
	awk -F: '/VGA/ {print $3}' < <(lspci)
}

function sh_catecho {
	echo "$(<"$1")"
}

function sh_catprintf {
	printf "%s" "$(<"$1")"
}

function sh_printfile {
	sh_catecho "$1"
}

