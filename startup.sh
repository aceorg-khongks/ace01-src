#!/bin/bash
# © Copyright IBM Corporation 2019.
#
for FILE in /tmp/*.bar; do ibmint deploy --input-bar-file "$FILE" --output-work-directory /home/aceuser/ace-server/ 2>&1; done \
	&& IntegrationServer -w /home/aceuser/ace-server/