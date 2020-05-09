#!/usr/bin/env bash
#
# BSD 3-Clause License
#
# Copyright (c) 2020, © Badassops LLC / Luc Suryo
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#*
#* File			:	get_jenkins.sh
#*
#* Description	:	get the jenkins.war file
#*
#* Author	:	Luc Suryo <luc@badassops.com>
#*
#* Version	:	0.1
#*
#* Date		:	May 7, 2020
#*
#* History	:
#* 		Date:			Author:				Info:
#*		May 7,2020		LIS					First Release to public
#*

_program="${0##*/}"
_author='Luc Suryo'
_copyright="Copyright 2020 - $(date "+%Y") (c) Badassops LLC"
_license='License BSD, http://www.freebsd.org/copyright/freebsd-license.html'
_version='0.1'
_email='luc@badassops.com'
_summary='Script to get the jenkins.war file'
_info="$_program $_version\n$_copyright\n$_license\n\nWritten by $_author <$_email>\n$_summary\n"

_echo_flag='-e'
_war_dir="/usr/share/jenkins/jenkins.war"

function help() {
	echo $_echo_flag "$_info"
	echo $_echo_flag "Usage : $_program type version"
	echo $_echo_flag 'type can be "opensource", "cloudbees" or the "full url" to pull the war file.'
	echo $_echo_flag 'when it a url, the given version is ignored."'
	echo $_echo_flag "war file in installed in as $_war_dir"
}

if [[ ! -z "$1" ]] ; then
	case "$1"
	in
		cloudbees)
			curl -fsSL https://downloads.cloudbees.com/jenkins-enterprise/fixed/"$2"/latest/jenkins.war -o $_war_dir
			exit $?
		;;

		opensource)
			curl -fsSL https://updates.jenkins-ci.org/"$2"/jenkins.war -o $_war_dir
			exit $?
		;;

		*)
			curl -fsSL $1 -o $_war_dir
			exit $?
		;;
	esac
fi
help
exit 0
