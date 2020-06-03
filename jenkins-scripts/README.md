# Jenkins snapshots script to automate the process 


jenkins-pod-snapshot.sh is a bash script that will do the following

Copies important files and folders from Jenkins server/pod to a directory called jenkins_home
Restores those files and folders back to the jenkins server/pod when needed.
Use Cases:
Taking backups of the following files and folders from Jenkins server regularly in case those files/folders deleted accidentally. (can be used with cronjob)
jobs
credentials.xml
config.xml
secrets
secret.key
When switching to a new cluster.
Script location
https://github.com/fuchicorp/common_scripts.git
Once this repo is cloned you can find the script under jenkins-scripts/jenkins-pod-snapshot.sh

Command to run to copy files and folders from Jenkins server/pod to a directory called jenkins_home :
sh jenkins-pod-snapshot.sh --sync
Once the above command is ran, then run the ls command.

You will see a directory called jenkins_home under the current directory < ./ > is created.

You will also see the following files and folders are copied from Jenkins server/pod to jenkins_home directory.

jobs
credentials.xml
config.xml
secrets
secret.key
Command to run to restore files and folders back to jenkins server/pod:
sh jenkins-pod-snapshot.sh --restore
This command will copy the above files and folders inside jenkins_home back to the Jenkins server/pod.
