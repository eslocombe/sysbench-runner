#!/bin/bash

PASS=$(egrep ^password /root/.my.cnf | head -1 | cut -f2 -d=)

apt-get install sysbench

mysql -BNe 'drop database if exists sbtest; create database sbtest'
mkdir -p /tmp/conf
cp -vr /etc/mysql/my.cnf /tmp/conf

# 10 million rows for extra funs
sysbench --test=oltp --oltp-table-size=10000000 --mysql-db=sbtest --mysql-user=root --mysql-password=${PASS} prepare
