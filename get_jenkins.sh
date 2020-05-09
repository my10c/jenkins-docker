#!/bin/bash

if [[ ! -z "$1" ]] ; then
	case "$1"
	in
		cloudbees)
			curl -fsSL https://downloads.cloudbees.com/jenkins-enterprise/fixed/"$2"/latest/jenkins.war \
				-o /usr/share/jenkins/jenkins.war
		;;

		opensource)
			curl -fsSL https://updates.jenkins-ci.org/"$2"/jenkins.war -o /usr/share/jenkins/jenkins.war
		;;

		*)
			curl -fsSL $1 -o /usr/share/jenkins/jenkins.war
		;;
	esac
fi
exit 0
