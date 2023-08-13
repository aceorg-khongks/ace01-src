ARG  FROMIMAGE=cp.icr.io/cp/appc/ace:12.0.9.0-r1
FROM ${FROMIMAGE}

COPY *.bar /home/aceuser/initial-config/bars/