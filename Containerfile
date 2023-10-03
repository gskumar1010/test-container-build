FROM quay.io/redhattraining/httpd-parent

RUN yum install -y --nodocs --disableplugin=subscription-manager httpd && \
    yum clean all --disableplugin=subscription-manager -y && \
    echo "Hello from parent httpd-parent" > /var/www/html/index.html

ONBUILD COPY src/ /var/www/html/
EXPOSE 8080

RUN rm -rf /run/httpd && mkdir /run/httpd

RUN sed -i "s/Listen 80/Listen 8080/g" etc/httpd/conf/httpd.conf

RUN chgrp -R 0 /var/log/httpd /var/run/httpd && \
    chmod -R g=u /var/log/httpd /var/run/httpd

USER 1001

CMD /usr/sbin/httpd -DFOREGROUND	
