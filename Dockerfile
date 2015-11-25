FROM java:openjdk-8-jdk

MAINTAINER Aurélien Leboulanger <leboulanger.aurelien@gmail.com>

ADD runAgent /opt/TeamCity/

RUN chmod 755 /opt/TeamCity/runAgent

CMD ["/opt/TeamCity/runAgent"]
