#!/bin/bash -x
# LICENSE UPL 1.0
#
# Copyright (c) 1982-2018 Oracle and/or its affiliates. All rights reserved.
#
# Since: December, 2016
# Author: gerald.venzl@oracle.com
# Description: Sets up the unix environment for DB installation.
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#

# Setup filesystem and oracle user
# Adjust file permissions, go to /opt/oracle as user 'oracle' to proceed with Oracle installation
# ------------------------------------------------------------
groupadd    --gid 54321 oinstall && \
groupadd    --gid 54322 dba && \
useradd --uid 54321 --gid oinstall --groups dba  oracle && \

mkdir -p $ORACLE_BASE/scripts/setup && \
mkdir $ORACLE_BASE/scripts/startup && \
mkdir -p $ORACLE_BASE/scripts/extensions/setup && \
mkdir $ORACLE_BASE/scripts/extensions/startup && \
ln -s $ORACLE_BASE/scripts /docker-entrypoint-initdb.d && \
mkdir $ORACLE_BASE/oradata && \
mkdir -p $ORACLE_HOME && \
chmod ug+x $ORACLE_BASE/*.sh && \
rm -rf /var/cache/yum && \
ln -s $ORACLE_BASE/$PWD_FILE /home/oracle/ && \
echo oracle:oracle | chpasswd && \
chown -R oracle:dba $ORACLE_BASE
