---
layout: single
parent: Open Source
title: ""
permalink: /opensource/java/jms-message-sender/
author_profile: false
classes: "wide smaller-text"
sidebar:
  nav: "opensource_sidebar"
---

## 🐧 JMS Message Sender

![GitHub top language](https://img.shields.io/github/languages/top/zappee/jms-message-sender)
![GitHub Issues](https://img.shields.io/github/issues/zappee/jms-message-sender)
![GitHub Release](https://img.shields.io/github/v/release/zappee/jms-message-sender)


### 1) Overview
The **JMS Message Sender** is a flexible, lightweight Java command-line interface (CLI) utility designed to transmit text payloads to Java Message Service (JMS) queues or topics.
It bypasses enterprise integration overhead, allowing developers to interact directly with queues via command-line prompts.
It is cross-platform and suitable for automated DevOps pipelines, shell scripts, or Docker orchestration.


### 2) Key features

* **Direct message publishing:** Directly sends text messages into targeted enterprise JMS queues.
* **Flexible payload selection:** Read raw message contents from an inline string or parse payloads from a local file.
* **Header manipulation:** Inject native JMS metadata attributes like custom `Correlation ID` parameters.
* **Secure interactive authentication:** Prompt for connection passwords dynamically at runtime rather than exposing secrets in plaintext.


### 3) Key use cases

* **Message verification:** Instantly push operational test records into messaging pipelines.
* **Automated batch processing:** Trigger script-driven data sending streams.
* **DevOps infrastructure audits:** Confirm application container access pathways to destinations like WebLogic nodes.
* **SAF communication test:** A SAF (Store-and-Forward) communication test verifies the end-to-end reliability and high availability of messages sent across distributed application servers or distinct cluster domains.


### 4) Quick Start


#### 4.1) Preparation
Collect your JMS endpoint configurations:
* hosts
* ports
* connection factory JNDI name
* targets


#### 4.2) Text message transmission

```console
$ java -jar jms-sender-0.2.2-with-dependencies.jar \
   --protocol t3 \
   --host localhost \
   --port 7001 \
   --cf jms/QueueConnectionFactory \
   --queue jms/incomingQueue \
   --user weblogic \
   --password password \
   --message "Hello wordl!" \
   --verbose
```


#### 4.3) Text message transmission using password and payload file

```console
$ java -jar jms-sender-0.2.2-with-dependencies.jar \
   -T t3 \
   -H host.domain.com \
   -P 7001 \
   -c jms/QueueConnectionFactory \
   -q jms/LogQueue \
   -u admin \
   -i \
   -f payloads/invoice_payload.json \
   -o "CORR-ID-99882"
```


### 5) Summary of exit codes

* **`0`** : Successful program execution and message publishing.
* **`1`** : Usage configuration error or incorrect user input.
* **`2`** : Unexpected internal runtime failure or connection error.


### 6) CLI Reference & Command syntax

#### 6.1) Global context

Run this command to print the comprehensive application usage guidelines, available parameters, and error exit codes:

```console
$ java -jar jms-sender-0.2.2-with-dependencies.jar --help
```


### 7) Build

1. Register required WebLogic thin-client driver locally before building the project:
```bash
$ mvn install:install-file \
  -Dfile=libraries/wlthint3client.jar \
  -DgroupId=com.oracle.weblogic \
  -DartifactId=wlthint3client \
  -Dversion=12.2.1.4.0 \
  -Dpackaging=jar
```
2. run the package command to build the artifact:
```bash
$ mvn clean package
```


### 8) Source code

[https://github.com/zappee/jms-message-sender](https://github.com/zappee/jms-message-sender)


### 9) Contributing

Contributions, feature requests, optimization, and bug reports are always welcome!
