#!/bin/bash

_update_url="http://updates.jenkins-ci.org/download/plugins"
_plugins_file="plugins.txt"
_plugins_dir="/var/jenkins_plugins"

function _get_plugins() {
	while read _line
	do
		_name="${_line%:*}"
		_version="${_line#*:}"
		_get_url="${_update_url}/${_name}/${_version}/${_name}.hpi"

		curl -fsSL "$_get_url" -o "$_name".hpi
	done < $_plugins_file
}

if [[ ! -z "$1" ]] ; then
	case "$1"
	in
		cloudbees)	_update_url="http://jenkins-updates.cloudbees.com/download/plugins" ; exit 0 ;;
		opensource)	_update_url="http://updates.jenkins-ci.org/download/plugins" ;;
	esac
fi
_get_plugins
exit 0

