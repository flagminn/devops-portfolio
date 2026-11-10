#!/bin/bash

gcc /server/main.c -lfcgi -o /server/server

spawn-fcgi -p 8080 /server/server

nginx -g "daemon off;"