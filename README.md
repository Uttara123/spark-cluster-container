# spark-cluster-container
This project contains information on how to set up a spark cluster using docker containers on your mac
In the end you will have 3 containers with centos7,  1 for Spark Master and 2 for Spark Workers

## set up docker on your mac
Assumption is you have already installed and set up docker  on your mac

## download jdk and spark 
what you need in addition to whats in this repo is the JDK rpm and a spark tgz file downloaded from apache spark website. 
For example in my local dir on the mac , I have the following files in my working directory
pwd
/Users/utamhank/sparkcontainer
ctl-utamhank-m:sparkcontainer utamhank$ ls

Dockerfile			
jdk-linux-x64.rpm		
spark-2.1.0-bin-hadoop2.7.tgz
docker-compose.yml

## build the image
Dockerfile pulls a centos 7 image, installs jdk and spark and creates a image by the name sparkcluster when you issue the following commands :
cd to your working dir
export SPARK_HOME=/usr/lib/spark/spark-2.1.0-bin-hadoop2.7  
export MYIP=10.0.0.6   
docker build --build-arg SPARK_HOME=/usr/lib/spark/spark-2.1.0-bin-hadoop2.7 --build-arg SPARK_FILE=spark-2.1.0-bin-hadoop2.7.tgz  --build-arg JAVA_FILE=jdk-linux-x64.rpm -t sparkcluster .

In the above command the last node for spark home dir should match name of the spark tgz file downloaded (without the “.tgz”)
And the jdk file name should match the jdk rpm you have downloaded
And set the IP to your mac’s IP , ifconfig command will help find IP. 
Your mac’s IP could change each time you connect to a network and so this needs to be set after each disconnect from the network

## set up spark cluster containers

To set up the cluster , run the following command
cd <to your working dir>
export SPARK_HOME=/usr/lib/spark/spark-2.1.0-bin-hadoop2.7  
export MYIP=10.0.0.6  
docker-compose up

## Verify that the cluster is setup
From a browser on your mac , go to the following URL
http://macip:8080
You should be able tosee one master and 2 worker nodes
Click on the links to worker nodes and check their status
