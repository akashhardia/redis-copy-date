## This document describes steps to migrate Redis data from one host to another.

 ### Prerequisites

- Needs URI for **Source** as well as **Target** Redis connections.  `redis://abcdefe.com:6379/9`

- You must terminate all existing connections to these Redis' before proceeding.

- If there is already an encryption, follow this doc:  [Elasticache for Redis in-transit encryption](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/in-transit-encryption.html)

- You need to perform this operation from such place (EC2, etc) that is under same network with both of these Redis connections.


 ### Instructions
 

Follow these steps to copy the DATA:

- Get the shell of EC2 instance having access to both the Redis instances.

- Test each connection from shell: (source & destination redis)

       redis-cil -u <source_host:port> ping

       redis-cil -u <target_host:port> ping
       

    Make sure these are reachable & you get `PONG` back in response.

- Download the script file attached at the bottom of this page & take care of the file execution permissions.

- Run this to execute the script:

      `sh copy_redis_data.sh -s "source_uri" -t "target_uri"`   , where:

      -s, source uri     redis://localhost:6379

      -t, target uri      redis://abcdefe.com:6379/9'

> If the connection has in-transit TLS encryption, please update in script with --tls in redis-cli command.
> Similarly, if there is cluster mode enabled, add -c flag in the redis-cli command for the respective host (source/destination).
