FROM tomcat:9.0.0.M19-alpine
WORKDIR /var/jenkins_home/workspace/puzzlie15pipeline/
COPY ./target/Puzzle15-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/