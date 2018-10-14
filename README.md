
# Docker Compose for MySQL 8 InnoDB Cluster

****This is for testing only - don't use it in production.****  

Once the cluster has started you may use `./mysql-shell.sh` to start a MySQL shell on the first server.  
```
> ./mysql-shell.sh 
mysqlsh: [Warning] Using a password on the command line interface can be insecure.
Creating a session to 'root@localhost'
Fetching schema names for autocompletion... Press ^C to stop.
Your MySQL connection id is 345 (X protocol)
Server version: 8.0.12 MySQL Community Server - GPL
No default schema selected; type \use <schema> to set one.
MySQL Shell 8.0.12

Copyright (c) 2016, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type '\help' or '\?' for help; '\quit' to exit.


 MySQL  localhost:33060+ ssl  JS > dba.getCluster().status()
{
    "clusterName": "test", 
    "defaultReplicaSet": {
        "name": "default", 
        "primary": "server-1:3306", 
        "ssl": "REQUIRED", 
        "status": "OK", 
        "statusText": "Cluster is ONLINE and can tolerate up to ONE failure.", 
        "topology": {
            "server-1:3306": {
                "address": "server-1:3306", 
                "mode": "R/W", 
                "readReplicas": {}, 
                "role": "HA", 
                "status": "ONLINE"
            }, 
            "server-2:3306": {
                "address": "server-2:3306", 
                "mode": "R/O", 
                "readReplicas": {}, 
                "role": "HA", 
                "status": "ONLINE"
            }, 
            "server-3:3306": {
                "address": "server-3:3306", 
                "mode": "R/O", 
                "readReplicas": {}, 
                "role": "HA", 
                "status": "ONLINE"
            }
        }
    }, 
    "groupInformationSourceMember": "mysql://root@localhost:3306"
}
```

A Prometheus exporter is included and available on port 9104.  
```
> http --print=b localhost:9104/metrics | head
# HELP go_gc_duration_seconds A summary of the GC invocation durations.
# TYPE go_gc_duration_seconds summary
go_gc_duration_seconds{quantile="0"} 3.6624e-05
go_gc_duration_seconds{quantile="0.25"} 3.6624e-05
go_gc_duration_seconds{quantile="0.5"} 4.0184e-05
go_gc_duration_seconds{quantile="0.75"} 4.0184e-05
go_gc_duration_seconds{quantile="1"} 4.0184e-05
go_gc_duration_seconds_sum 7.6808e-05
go_gc_duration_seconds_count 2
# HELP go_goroutines Number of goroutines that currently exist.
```
