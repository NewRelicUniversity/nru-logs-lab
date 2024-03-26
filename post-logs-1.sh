#!/bin/sh

JSON_FMT=$(cat <<EOF
[{
   "common": {
     "attributes": {
       "logtype": "nru-logs-lab",
       "service": "login-service",
       "hostname": "login.example.com"
     }
   }
   "logs": [{
       "message": "User 'xyz' logged in"
     },
     {
       "message": "User 'xyz' logged out",
       "attributes": {
         "auditId": 123
       }
     }]
}]
EOF
) 

curl -vvv -X POST 'https://log-api.newrelic.com/log/v1' \
-H 'Content-Type: application/json' \
-H 'Api-Key: '"$API_KEY"'' \
-d "$JSON_FMT"
