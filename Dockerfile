ARG  FROMIMAGE=cp.icr.io/cp/appc/ace-server-prod@sha256:246828d9f89c4ed3a6719cd3e4b71b1dec382f848c9bf9c28156f78fa05bc4e7
FROM ${FROMIMAGE}

ARG BAR_FILE=bars/*.bar

# USER root
# RUN microdnf update && microdnf clean all

ENV LICENSE=accept

COPY ${BAR_FILE} /tmp

RUN . /opt/ibm/ace-12/server/bin/mqsiprofile \
    && set -x \ 
    && for FILE in /tmp/*.bar; do echo "$FILE" >> /tmp/deploys \
    && ibmint package --compile-maps-and-schemas --input-bar-file "$FILE" --output-bar-file /tmp/temp.bar  2>&1 | tee -a /tmp/deploys \
    && ibmint deploy --input-bar-file /tmp/temp.bar --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys; done \
    && ibmint optimize server --work-dir /home/aceuser/ace-server

# RUN chmod -R ugo+rwx /home/aceuser/
# RUN chmod -R ugo+rwx /var/mqsi/registry
RUN chmod -R 777 /home/aceuser/ace-server /var/mqsi || /bin/true

# USER 1001