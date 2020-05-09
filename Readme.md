# Jenkins Docker


Base on the official jenkins/jenkins:lts-alpine image


### Background

Small adjustment by adding couple packages and always download the latest jenkins.war file if
opensource and for Cloudbees it is defined in the file include/makefile.inc.

Furtheri it will install plugins that I use a lot :)


### Extra

Base on the official jenkins lts-alpine image is can also pull the Cloudbees Enterprise jenkins.war file.


### Configuration

Edit the file include/makefile.inc to your need


### Installation

build image : make build
run container based on the built image : make run
shell into the running container : make shell
see logs (incude the initial password : make logs
start/stop/status of the container : make |start|stop|status


### Plugins

To add, remove plugins: edit the file plugins.txt
The syntax is : directory-name-at-jenkins-plugins-site:version-of-the plugin

To see the correct name, visit he URL's below.
Remember the name of the plugin is not (most of the time) the same name of the plugin location.

**Please note that plugins from the opensource might not be compatible with Cloudbees, which will cause jenkin not to start**

For opensource location: http://updates.jenkins-ci.org/download/plugins

For Cloudbees location: http://jenkins-updates.cloudbees.com/download/plugins



Enjoy

momo
