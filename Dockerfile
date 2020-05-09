# -- jenkins offcial lts -- #
FROM jenkins/jenkins:lts-alpine AS main

# -- set variables -- #

# -- all command is executes as root -- #
USER root
ARG JENKINSMODEL

# -- get our plugins -- #
RUN mkdir -p /var/jenkins_plugins
WORKDIR /var/jenkins_plugins
COPY get_plugins.sh get_plugins.sh
COPY plugins.txt plugins.txt
RUN chmod +x get_plugins.sh
RUN ./get_plugins.sh $JENKINSMODEL

# copy over the plugins
FROM jenkins/jenkins:lts-alpine

# -- set variables -- #
ARG user=jenkins
ARG group=jenkins
ARG http_port=8080
ARG JENKINS_HOME=/var/jenkins_home
ARG JENKINSMODEL
ARG VERSION

# -- all command is executes as root -- #
USER root

# -- setup global profiles file -- #
WORKDIR /etc
COPY profile/profile profile
RUN echo 'UTC' > timezone

# -- install package -- #
WORKDIR /
RUN apk -q update
RUN apk add --no-cache tzdata \
	bash \
	bind-tools \
	curl \
	htop \
	tzdata \
	unzip \
	vim

COPY --from=main /var/jenkins_plugins/* /var/jenkins_home/plugins/
RUN chown -Rh ${user}:${group} /var/jenkins_home/

# -- getting the latest war file -- #
COPY get_jenkins.sh /usr/local/sbin/get_jenkins.sh
RUN chmod 0555 /usr/local/sbin/get_jenkins.sh
RUN /usr/local/sbin/get_jenkins.sh $JENKINSMODEL $VERSION

# -- for main web interface: --#
EXPOSE ${http_port}
