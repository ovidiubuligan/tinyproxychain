FROM ubuntu

MAINTAINER ovidiubuligan@gmail.com

RUN  apt-get update \
	 && apt-get install -y --force-yes tinyproxy \
     && apt-get install -y --force-yes proxychains \
     && mkdir /app

COPY start.sh /app/
EXPOSE 8080

VOLUME /configdata

CMD /bin/bash /app/start.sh