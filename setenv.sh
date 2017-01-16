cd /Users/utamhank/sparkcontainer
env SPARK_HOME=/usr/lib/spark/spark-2.1.0-bin-hadoop2.7
env MYIP=10.0.0.6
docker build --build-arg SPARK_HOME=/usr/lib/spark/spark-2.1.0-bin-hadoop2.7 --build-arg SPARK_FILE=spark-2.1.0-bin-hadoop2.7.tgz  --build-arg JAVA_FILE=jdk-linux-x64.rpm -t sparkcluster .
