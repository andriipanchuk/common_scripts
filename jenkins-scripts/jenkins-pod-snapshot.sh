#!/bin/bash

# Color codes
green=$(tput setaf 2)
red=$(tput setaf 1)
reset=$(tput sgr0)



# Variables
JENKINS_POD_NAME="$(kubectl get pods -n tools | grep jenkins-deploy | awk '{print $1}')"
# echo $JENKINS_POD_NAME

JENKINS_HOME='./jenkins_home'
# echo $JENKINS_HOME



# Creates jenkins_home folder under current directory if it doesn't exist.
if [ ! -d "$JENKINS_HOME" ]; then
  mkdir -p "$JENKINS_HOME"

  echo "${green}<$JENKINS_HOME)> directory created${reset}"
fi



# Copies important folders from jenkins pod to jenkins_home directory under ./
if [ "$1" = "--sync" ]; then
  kubectl cp tools/$JENKINS_POD_NAME:/var/jenkins_home/secrets $JENKINS_HOME/secrets  2 > /dev/null
  kubectl cp tools/$JENKINS_POD_NAME:/var/jenkins_home/secret.key $JENKINS_HOME/secret.key 2 > /dev/null
  kubectl cp tools/$JENKINS_POD_NAME:/var/jenkins_home/jobs $JENKINS_HOME/jobs 2 > /dev/null
  kubectl cp tools/$JENKINS_POD_NAME:/var/jenkins_home/credentials.xml $JENKINS_HOME/credentials.xml 2 > /dev/null
  kubectl cp tools/$JENKINS_POD_NAME:/var/jenkins_home/config.xml  $JENKINS_HOME/config.xml  2 > /dev/null

  echo "${green}Successfully copied necessary folders from jenkins server to jenkins_home <($JENKINS_HOME)> directory!${reset}" 
fi



# Copies folders under ./jenkins_home back to jenkins pod
if [ "$1" = "--restore" ]; then
  kubectl cp $JENKINS_HOME/secrets tools/$JENKINS_POD_NAME:/var/jenkins_home 2 > /dev/null
  kubectl cp $JENKINS_HOME/secret.key tools/$JENKINS_POD_NAME:/var/jenkins_home 2 > /dev/null
  kubectl cp $JENKINS_HOME/jobs tools/$JENKINS_POD_NAME:/var/jenkins_home 2 > /dev/null
  kubectl cp $JENKINS_HOME/credentials.xml tools/$JENKINS_POD_NAME:/var/jenkins_home 2 > /dev/null
  kubectl cp $JENKINS_HOME/config.xml tools/$JENKINS_POD_NAME:/var/jenkins_home/config.xml 2 > /dev/null

  echo "${green}Successfully copied jenkins folders from <($JENKINS_HOME)> back to jenkins server!${reset}"
fi
