#!/usr/bin/env bash
echo "Running Http Server Listening At Port 80 ...."

( exec http-server --cors -p80 /swagger-editor-master/ )
