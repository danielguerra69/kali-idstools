FROM danielguerra/docker-kali
MAINTAINER Daniel Guerra
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y dist-upgrade
RUN apt-get -yy install bro tshark suricata snort wireshark ntopng \
                        libgetopt-declare-perl libxml-simple-perl libdbi-perl libclass-dbi-mysql-perl \
                        python python-mysql.connector python-lxml python-pip \
                        python-ndg-httpsclient python-requests python-pika python-dateutil \
                        python-pcapy python-elasticsearch libnet-pcap-perl  python-geoip2 \
                        mariadb-client curl vim supervisor amqp-tools && \
    apt-get -y autoremove && apt-get clean
RUN pip install idstools
RUN mkdir -p /opt/maxmind
WORKDIR /opt/maxmind
RUN wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz
RUN tar xvfz GeoLite2-ASN.tar.gz
RUN rm -rf GeoLite2-ASN.tar.gz
RUN find ./ -name "*.mmdb" -exec mv {} . \;
WORKDIR /root
