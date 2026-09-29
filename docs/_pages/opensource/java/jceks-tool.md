---
layout: single
parent: Open Source
title: ""
permalink: /opensource/java/jceks-tool/
author_profile: false
classes: "wide smaller-text"
sidebar:
  nav: "opensource_sidebar"
---

## 🐧 JCEKS Keystore Tool

![GitHub top language](https://img.shields.io/github/languages/top/zappee/jceks-tool)
![GitHub Issues](https://img.shields.io/github/issues/zappee/jceks-tool)
![GitHub Release](https://img.shields.io/github/v/release/zappee/jceks-tool)

### 1) Overview

The _JCEKS Keystore Tool_ is a specialized, enterprise-ready Java command-line interface (CLI) utility designed to manage, inspect, and manipulate Java Cryptography Extension KeyStore (JCEKS) repositories.
Standard Java platforms offer the default `keytool` utility.
However, native tools lack the flexibility to directly read or securely clone Symmetric Secret Keys (such as AES or 3DES keys used for encryption, payload signing) between separated keystore files.

This tool fills that structural gap, providing a way for engineers to work with secret keys without writing custom Java boilerplate.


### 2) Key Features

The tool focuses on two primary capabilities: viewing key values and copying entries between keystores:
1. **Secret key inspection:** Securely decrypts and outputs the raw underlying byte values of an isolated secret key alias directly into your runtime terminal stream.
2. **Secret key migration:** Pulls a target secret key payload from a designated source keystore and safely inserts it into an existing or fresh target keystore container—handling cross-alias naming or individual entries password updates on-the-fly.


### 3) Key use cases

* **View Secret Keys:** Inspect and display the raw value of any secret key entry.
* **Key Migration:** Copy secret key entries securely between separate keystores.
* **Script Automation:** Native support for Linux shell scripts (.sh).
* **Auditing a key using password file:** This prevents system logs or command history streams from capturing the plaintext password entries:


### 4) Quick start

#### 4.1) Display an entry value

```console
$ java -jar jceks-tool.jar show \
   --keystore transportkey.jceks \
   --keystore-password-file .storepass \
   --alias sms.transport.key \
   --entry-password-file .keypass
```

#### 4.2) The copy command
The command requires source and target keystore paths, aliases, and associated source/target password arguments or files.
For full parameter lists, please check the documentation: `java -jar jceks-tool.jar --help`.

```console
$ java -jar jceks-tool.jar copy \
   --source-keystore transportkey.jceks \
   --source-keystore-password-file .storepass \
   --source-alias sms.transport.key \
   --source-entry-password-file .keypass \
   --target-keystore pipeline.jceks \
   --target-keystore-password-file .storepass \
   --target-alias pipeline.key.sms.transport \
   --target-entry-password changeit
```

General Flags:
* **?, --help:** Displays the comprehensive help syntax and command parameters.
* **-q, --quiet:** Silent operational mode to suppresses standard terminal logging output. Ideal for production crontabs or background execution.

### 5) Summary of exit codes

* **0:** for success
* **1:** for unexpected internal errors
* **2:** for invalid input arguments


### 6) CLI Reference & Command Syntax

#### 6.1) Global Context

```console
$ java -jar jceks-tool-0.1.0.jar

Usage: jceks-tool [?=<main>]... (show | copy)
JCEKS keystore command line tool.

? , --help   display this help message

Commands:
  show  Show the value of a secret key.
  copy  Copy a secret key from the source keystore to a target keystore.

Exit codes:
  0    Successful program execution.
  1    An unexpected error appeared while executing the tool.
  2    Exit code on Invalid input.

Please report issues at arnold.somogyi@gmail.com.
Documentation, source code: https://github.com/zappee/jceks-tool.git
```

#### 6.2) The `show` command
Extracts and prints the raw value of a designated secret key entry.

```console
$ java -jar target/jceks-tool-0.1.0.jar show

Usage: jceks-tool show [-q] -a=<alias> -k=<keystoreLocation> (-p=<keystorePassword> 
                       | -f=<keystorePasswordFile>) (-e=<entryPassword> | -n=<entryPasswordFile>)

Show the value of a secret key.

   -q, --quiet                   In this mode nothing will be printed to the output.
   -k, --keystore                path to the keystore
   -p, --keystore-password       password for the keystore
   -f, --keystore-password-file  keystore password file
   -a, --alias                   alias name of the keystore entry
   -e, --entry-password          password for the keystore entry
   -n, --entry-password-file     keystore entry password file

Please report issues at arnold.somogyi@gmail.com.
Documentation, source code: https://github.com/zappee/jceks-tool.git
```

#### 6.3) The `copy` command

Duplicates a secret key entry from a source keystore file into a target keystore file.

```console
$ java -jar target/jceks-tool-0.1.0.jar copy

Usage: jceks-tool copy [-q] -a=<sourceAlias> -l=<targetAlias> -s=<sourceKeystoreLocation> -t=<targetKeystoreLocation>
                       (-p=<sourceKeystorePassword> | -f=<sourceKeystorePasswordFile>)
                       (-e=<sourceEntryPassword> | -n=<sourceEntryPasswordFile>)
                       (-o=<targetKeystorePassword> | -u=<targetKeystorePasswordFile>)
                       (-r=<targetEntryPassword> | -z=<targetEntryPasswordFile>)

Copy a secret key from the source keystore to a target keystore.

   -q, --quiet                          In this mode nothing will be printed to the output.
   -s, --source-keystore                path to the source keystore
   -p, --source-keystore-password       password for the source keystore
   -f, --source-keystore-password-file  source keystore password file
   -a, --source-alias                   alias name of the source keystore entry
   -e, --source-entry-password          password for the source keystore entry
   -n, --source-entry-password-file     source keystore entry password file
   -t, --target-keystore                path to the target keystore
   -o, --target-keystore-password       password for the target keystore
   -u, --target-keystore-password-file  target keystore password file
   -l, --target-alias                   alias name of the target keystore entry
   -r, --target-entry-password          password for the target keystore entry
   -z, --target-entry-password-file     target keystore entry password file

Please report issues at arnold.somogyi@gmail.com.
Documentation, source code: https://github.com/zappee/jceks-tool.git
```


### 7) Source core

[https://github.com/zappee/jceks-tool](https://github.com/zappee/jceks-tool)


### 8) Contributing

Contributions, feature requests, optimization, and bug reports are always welcome!
