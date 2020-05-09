#JENKINSMODEL=opensource
#VERSION=latest

JENKINSMODEL=cloudbees
VERSION=2.190

NAMESPACE=jenkins
IMAGE=jenkins-docker
TAG=$(IMAGE):$(VERSION)
DOCKERFILE=Dockerfile
