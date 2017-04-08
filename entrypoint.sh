#!/bin/bash
set -e


BLD_ACTION=${BLD_ACTION:-${1}} # default action to first argument
BLD_SOURCE=${BLD_SOURCE:-/bld/src}
BLD_RESULT=${BLD_RESULT:-/bld/result}
BLD_SMATCH_LOG=${BLD_SMATCH_LOG:-${BLD_RESULT}/smatch.log}
BLD_SMATCH_WLOG=${BLD_SMATCH_WLOG:-${BLD_RESULT}/smatch.warn.log}
BLD_SMATCH_WLOG_ENV=${BLD_SMATCH_WLOG_ENV:-${BLD_RESULT}/smatch.warn.env}


export PATH=$PATH:/usr/share/smatch/smatch_scripts

function smatch_test_kernel
{
	# use default if not given
	local target=""
	if [ ! -z "$1" ]; then
	    target="--target $1"
	fi
	pushd $BLD_SOURCE
	time test_kernel.sh --endian --log $BLD_SMATCH_LOG --wlog $BLD_SMATCH_WLOG $target
	NR_WARN=`wc -l $BLD_SMATCH_WLOG | gawk '{ print $1 }'`
	echo "NR_WARN=$NR_WARN" > $BLD_SMATCH_WLOG_ENV
	echo "SMATCH_NR_WARN=$NR_WARN" >> $BLD_SMATCH_WLOG_ENV
	echo "Finish. Found $NR_WARN warnings"
	popd
}

mkdir -p ${BLD_RESULT}

case "$BLD_ACTION" in
	smatch_test_kernel)
		smatch_test_kernel
		;;
	## TODO add userspace tools compilation
	## TODO add sparse kernel compilation
	## TODO add real kernel compilation
esac
exit 0
