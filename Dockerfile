ARG  FROMIMAGE=cp.icr.io/cp/appc/ace:12.0.9.0-r1@sha256:0e03de28d175e15238896b1ae00b54ddda6a46b793173f9a7707187d6b58202e
FROM ${FROMIMAGE}

USER root

RUN microdnf update && microdnf clean all

COPY integration.bar /tmp
# RUN export LICENSE=accept \
#     && . /opt/ibm/ace-12/server/bin/mqsiprofile \
#     && set -x && for FILE in /tmp/*.bar; do \
# #       echo "$FILE" >> /tmp/deploys && \
# #       ibmint package --compile-maps-and-schemas --input-bar-file "$FILE" --output-bar-file /tmp/temp.bar  2>&1 | tee -a /tmp/deploys && \
# #       ibmint deploy --input-bar-file $FILE --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys; done \
#        ibmint deploy --input-bar-file $FILE --output-work-directory /home/aceuser/ace-server/ 2>&1; done \
#     && ibmint optimize server --work-dir /home/aceuser/ace-server \
#     && chmod -R ugo+rwx /home/aceuser/

RUN export LICENSE=accept
RUN . /opt/ibm/ace-12/server/bin/mqsiprofile
RUN set -x
RUN for FILE in /tmp/*.bar; do \
    echo $FILE && \
    echo "$FILE" >> /tmp/deploys && \
    ibmint deploy --input-bar-file $FILE --output-work-directory /home/aceuser/ace-server/ 2>&1; done 
RUN ibmint optimize server --work-dir /home/aceuser/ace-server
RUN chmod -R ugo+rwx /home/aceuser/

USER 1001