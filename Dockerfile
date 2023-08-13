ARG  FROMIMAGE=cp.icr.io/cp/appc/ace:12.0.9.0-r1
FROM ${FROMIMAGE}

USER root

RUN microdnf update && microdnf clean all

ENV LICENSE=accept

COPY *.bar /tmp
COPY startup.sh /usr/local/bin

RUN set -x && \
    chmod -R ugo+rwx /home/aceuser/ && \
    chmod 777 /usr/local/bin/startup.sh && \
    chmod -R 777 /var/mqsi

USER aceuser  
WORKDIR  /home/aceuser  

ENTRYPOINT ["/usr/local/bin/startup.sh" ]