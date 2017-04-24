## -*- docker-image-name: "mcreations/fusiondirectory" -*-

FROM rezarahimi/debian-fusiondirectory
MAINTAINER Reza Rahimi <rahimi@m-creations.net>

ENV LDAP_PORT 389
ENV LDAP_HOST ldap-server
ENV LDAP_SERVER_URL ldap://${LDAP_HOST}:${LDAP_PORT}
ENV FUSIONDIRECTORY_VERSION 1.0.8.2
ENV FUSIONDIRECTORY_DEB_PKG_VERSION 1.0.8.2-5+deb8u1
ENV LDAP_ROOT Manager
ENV LDAP_TLS TRUE
ENV TLS_REQCERT never

ADD image/root/ /

#RUN sed -i -e 's/TLS_REQCERT.*/TLS_REQCERT\tnever/g' /etc/ldap/ldap.conf

RUN chown -R root:root /usr/share/fusiondirectory/include/jsonrpcphp/ && \
    a2dissite 000-default && \
    a2disconf fusiondirectory && \
    a2ensite fusiondirectory && \
    echo  "TLS_REQCERT    $TLS_REQCERT" >> /etc/ldap/ldap.conf

EXPOSE 80

CMD ["/start-fd"]
