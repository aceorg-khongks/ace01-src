ARG  FROMIMAGE=cp.icr.io/cp/appc/ace:12.0.9.0-r1
FROM ${FROMIMAGE}

USER root

# RUN microdnf update && microdnf clean all

ENV LICENSE=accept

COPY *.bar /tmp

RUN . /opt/ibm/ace-12/server/bin/mqsiprofile \
    && set -x \ 
    && for FILE in /tmp/*.bar; do echo "$FILE" >> /tmp/deploys \
    && ibmint package --compile-maps-and-schemas --input-bar-file "$FILE" --output-bar-file /tmp/temp.bar  2>&1 | tee -a /tmp/deploys \
    && ibmint deploy --input-bar-file /tmp/temp.bar --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys; done \
    && ibmint optimize server --work-dir /home/aceuser/ace-server \
    && chmod -R ugo+rwx /home/aceuser/

USER 1001