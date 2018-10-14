
# Docker Compose for MySQL 8 InnoDB Cluster

**This is for testing only - don't use it in production.**  

Once the cluster is up, use `./mysql.sh` to execute the MySQL client on the first server:  
```
> ./mysql.sh --execute="SHOW DATABASES" | head
mysql: [Warning] Using a password on the command line interface can be insecure.
+-------------------------------+
| Database                      |
+-------------------------------+
| information_schema            |
| mysql                         |
| mysql_innodb_cluster_metadata |
| performance_schema            |
| sys                           |
+-------------------------------+
```

Similarly, use `./mysqlsh.sh` to execute a MySQL shell:  
```
> ./mysqlsh.sh --interactive --execute="dba.getCluster().status()" | head
mysqlsh: [Warning] Using a password on the command line interface can be insecure.
Creating a session to 'root@localhost'
Fetching schema names for autocompletion... Press ^C to stop.
Your MySQL connection id is 350 (X protocol)
Server version: 8.0.12 MySQL Community Server - GPL
No default schema selected; type \use <schema> to set one.
{
    "clusterName": "test", 
    "defaultReplicaSet": {
        "name": "default", 
```

A Prometheus exporter is included and available on port 9104:  
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
