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


### 7) Source code

[https://github.com/zappee/jms-message-sender](https://github.com/zappee/jms-message-sender)


### 8) Contributing

Contributions, feature requests, optimization, and bug reports are always welcome!
