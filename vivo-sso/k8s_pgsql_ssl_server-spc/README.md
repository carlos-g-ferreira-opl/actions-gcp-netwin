# PostgreSQL on k8s

# Testing IAM db connection

```bash
$ kubectl -n iam exec -it <postgresql pod> --  psql -h localhost -U iam -p 5432 iam

psql (11.16 (Debian 11.16-1.pgdg90+1))
Type "help" for help.

iam=> \l
                                  List of databases
   Name    |   Owner   | Encoding |  Collate   |   Ctype    |    Access privileges    
-----------+-----------+----------+------------+------------+-------------------------
 iam       | psqladmin | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/psqladmin          +
           |           |          |            |            | psqladmin=CTc/psqladmin+
           |           |          |            |            | iam=CTc/psqladmin
 postgres  | psqladmin | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | psqladmin | UTF8     | en_US.utf8 | en_US.utf8 | =c/psqladmin           +
           |           |          |            |            | psqladmin=CTc/psqladmin
 template1 | psqladmin | UTF8     | en_US.utf8 | en_US.utf8 | =c/psqladmin           +
           |           |          |            |            | psqladmin=CTc/psqladmin
(4 rows)

iam=>
```

