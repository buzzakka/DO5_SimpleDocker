#!/bin/bash

spawn-fcgi -p 8080 server.out
nginx -g 'daemon off;'