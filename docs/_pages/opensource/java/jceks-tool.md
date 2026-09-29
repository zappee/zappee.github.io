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

The **JCEKS Keystore Tool** is a specialized, enterprise-ready Java command-line interface (CLI) utility designed to manage, inspect, and manipulate _Java Cryptography Extension KeyStore (JCEKS)_ repositories.
While standard Java platforms provide the default `keytool` utility, native tools lack the flexibility to directly read or securely clone symmetric secret keys (such as AES or 3DES keys used for encryption and payload signing) between separated keystore files.

This tool fills that structural gap, allowing engineers to work with secret keys without writing custom Java boilerplate.
It is lightweight, cross-platform, and designed explicitly to integrate with Linux shell scripts.


### 2) Key Features

The tool focuses on two primary operational modes:
1. **Secret key inspection:** Securely decrypts and outputs the raw, underlying byte values of a secret key entry directly into your terminal.
2. **Secret key migration:** Pulls a secret key payload from a source keystore and safely inserts it into an existing or new target keystore, handling alias renaming and password updates on-the-fly.


### 3) Key use cases

* **View secret keys:** Inspect and print the raw value of any secret key entry.
* **Key migration:** Copy secret key entries securely between separate keystores.
* **Script automation:** Native support for seamless integration into DevOps and automated shell scripts.
* **Auditing a key using password file:** Read passphrases from password files instead of plaintext parameters to prevent system logs or command histories from capturing raw secrets.

### 4) Quick start

#### 4.1) Display an entry value
```console
$ java -jar jceks-tool.jar show \
   --keystore transportkey.jceks \
   --keystore-password-file .storepass \
   --alias sms.transport.key \
   --entry-password-file .keypass
```

#### 4.2) Clone a key entry
The `copy` command requires source and target keystore paths, aliases, and associated credentials.
For a full parameter reference list, execute `java -jar jceks-tool.jar --help`.

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

#### 4.3) Global options
* **`?`, `--help`** : Displays the comprehensive help syntax and command parameters.
* **`-q`, `--quiet`** : Silent operational mode that suppresses standard terminal logging output. Ideal for crontab or automatated execution.

### 5) Summary of exit codes

The tool returns standardized exit codes to ensure robust error handling:
* **`0`** : Successful program execution.
* **`1`** : An unexpected internal runtime error occurred.
* **`2`** : Invalid input parameters or command syntax error.

---

### 6) CLI reference & Command syntax

#### 6.1) Global context
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

Usage: jceks-tool show [-q] -a=<alias> -k=<keystoreLocation> (-p=<keystorePassword> |
                            -f=<keystorePasswordFile>) (-e=<entryPassword> | -n=<entryPasswordFile>)

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

Usage: jceks-tool copy [-q] -a=<sourceAlias> -l=<targetAlias>
                            -s=<sourceKeystoreLocation> -t=<targetKeystoreLocation>
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


### 7) Source code

[https://github.com/zappee/jceks-tool](https://github.com/zappee/jceks-tool)


### 8) Contributing

Contributions, feature requests, optimization, and bug reports are always welcome!
