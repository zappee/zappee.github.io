---
layout: single
parent: Products
title: ""
permalink: /virtualization/docker/spring-box/
author_profile: false
classes: "wide smaller-text"
sidebar:
  nav: "virtualization_sidebar"
---

## ☁️ Spring Box: Spring Boot runner Docker container

![GitHub top language](https://img.shields.io/github/languages/top/zappee/spring-box)
![GitHub Issues](https://img.shields.io/github/issues/zappee/spring-box)
![GitHub Release](https://img.shields.io/github/v/release/zappee/spring-box)

#### ⭐⭐ Like this project? Support my work by giving it a star on [GitHub](https://github.com/zappee/spring-box/) ⭐⭐

![GitHub Repo stars](https://img.shields.io/github/stars/zappee/spring-box?style=flat)

### 1) Overview

The **Remal Spring Box** is an open-source development and production platform engineered to simplify the creation, deployment, and monitoring of Java and Spring Boot applications.
It eliminates enterprise boilerplate by offering a fully integrated environment featuring containerized runtimes, databases supporting the database-per-service pattern, data streaming, service discovery, security, and real-time operational metrics.

### 2) Context & Problem statement
Building a modern microservices architecture with Spring Boot requires stitching together dozens of complex infrastructure components:
* Service registries
* Load balancers
* Centralized configuration servers
* Private PKI management, issuing and revoking server certificates
* Secure communication channels
* Encryption key generation
* Distributed caching layers
* Event streaming and message networks
* Containerization and orchestration
* Database servers
* Real-time application monitoring and log history
* Historical infrastructure metrics (CPU load, memory consumption, connection pool sizes, stc.)
* Automated horizontal and vertical scaling
* etc.

Setting this up consistently across local development and production environments often leads to:
* **Configuration drift:** Features working perfectly on a local developer machine but unexpectedly failing in production environments.
* **Architecture overhead:** Significant engineering time spent configuring base infrastructure (Kafka, LDAP, OAuth, Key-Value stores) rather than writing core business logic.
* **Distributed state challenges:** The complexity of managing databases using the popular database-per-service pattern while keeping primary keys synchronized across isolated instances.
* **"Works on my machine" dilemma:** Environmental gaps between team members' laptops and live clusters that turn environment debugging into a massive time sink.

### 3) The Remal solution
The **Remal Spring Box** bridges this gap by providing a containerized pre-configured runtime building blocks for both local development and production environments.

By abstracting away complex structural infrastructure, it enables start-ups and small-to-medium teams to eliminate configuration overhead and focus entirely on delivering features at high velocity.

### 4) Key benefits
* **Embedded SSH server:** Offers standard secure access to active instances. Running containers can be connected to using native SSH clients, allowing to execute standard shell commands inside the container environments seamlessly.
* **Production-Identical local dev:** Eliminates environmental mismatches entirely. By using the exact same containerized runtime building blocks on local machines and production clusters, if it works on your laptop, it will work in production.
* **Instant feature delivery:** Saves weeks of foundational engineering. Startups and small teams can skip the tedious process of configuring Kafka brokers, security certificates, and service registries, and start writing business logic on day one.
* **Plug-and-Play security:** Automates complex network security. The built-in _Private CA Infrastructure_ automatically manages certificates, giving you enterprise-grade, secure service-to-service communication out of the box without manual intervention.
* **Instant observability:**  Built-in time- and counter-based telemetry dashboards to measure real-time endpoint latency, call volumes, and Kafka consumption rates for strict SLA reporting.
* **Architecture evolution:** Designed for zero-downtime scalability. The platform’s modular nature allows you to easily scale services horizontally or vertically, or swap out infrastructure components entirely as your application traffic and business needs grow.
* **Configuration management:** The integrated _Distributed Key-Value Registry_ acts as a single source of truth for runtime configurations, making it effortless to manage environment states and synchronize changes across all active instances.
* **Automated load balancing:** The _Distributed Service Registry_ tracks active microservice instances codelessly, dynamically routing traffic and balancing loads across healthy containers without manual network mapping.
* **Distributed Caching:** Integrated, cluster-wide **Distributed Cache** topologies drastically reduce database load, guarantee lightning-fast REST responses during heavy traffic spikes, and maintain request context across separate instances whenever necessary.

### 5) Docker containers in the _Spring Box_ ecosystem

![Spring Box image hierarchy](/assets/images/menu/virtualization/docker/spring-box/spring-box-image-hierarchy.png)

#### 5.1) Java containers
The platform supports production-ready runtimes for **OpenJDK 11, 17, 21, and 25**.
These core `Java` images provide your Spring Boot applications a reliable, high-performance execution environment for your Spring Boot application in the _Spring Box_ ecosystem.

Here is a typical `springbox-java` container configuration.
Don't worry, we will break down the entire Docker Compose setup in the next section.

```yaml
my-service:
    image: springbox-java-25:0.8.0
    container_name: my-service.${DOMAIN_NAME}
    hostname: my-service.${DOMAIN_NAME}
    ports:
        - "14012:22"   # SSH
        - "14013:8000" # JVM debug
    entrypoint: ["/wait-for-container.sh", "consul.${DOMAIN_NAME}"]
    environment:
        PKI_HOST: pki.${DOMAIN_NAME}
        CONSUL_SERVER_HOSTNAME: consul.${DOMAIN_NAME}
        JAVA_OPTS: >
            -XX:+UseContainerSupport
            -XX:MaxRAMPercentage=75.0
            -XX:+UseG1GC
            -XX:MaxGCPauseMillis=100
            -XX:+ParallelRefProcEnabled
            -XX:+UseStringDeduplication
            -XX:+HeapDumpOnOutOfMemoryError
            -XX:+ExitOnOutOfMemoryError
            -XX:HeapDumpPath=/heap-dump
    deploy:
        resources:
            limits:
                memory: 384M
    volumes:
        - $HOME/springbox/volumes/my-service/jar-to-run:/jar-to-run
        - $HOME/springbox/volumes/my-service/logs:/logs
        - $HOME/springbox/volumes/my-service/heap-dump:/heap-dump
```

**Configuration highlights**

* **Containers naming convention:**

  It is highly recommended to use the exact same name for both `hostname` and `container_name` to prevent internal network routing conflicts. We use Fully Qualified Domain Names (FQDN) by expanding the container name with a base domain.
  That way domain name remains unique per environment. For instance, the production domain can align with the company's officially registered domain name, while development environments can use the developer's nickname.
  This strategy provides massive advantages when working with a _Container Runtime_ system that dynamically manages the execution and lifecycle of Docker containers.

  The `${DOMAIN_NAME}` variable can be defined in a dedicated environment file, or as a shell variable, or CI/CD pipeline can provide.
  ```properties
  # remal.com.env file
  DOMAIN_NAME=arnold.com
  ```
  You can then spin up the stack using the following command: `docker compose --env-file=remal.com.env -f <compose-file> up`


* **Ports used by this container:**
  * **SSH Port (default: 22):** The embedded SSH server listens on the default port `22` for safe, remote shell management.
    * **User:** `root`
    * **Password:** `password`
    * **Connection string:** `sshpass -p password ssh -oStrictHostKeyChecking=no root@localhost -p <port>` *(where the port is mapped to `14012` in the example above).*
  * **JVM debug port (default: 8000):** External Java IDEs (such as IntelliJ IDEA) can utilize this port to attach a remote debugger directly to the running application inside the container.
  * **Readiness signal port (default: 1331):** This port opens automatically once the container has completely initialized and all `init` and `startup` scripts have executed successfully.
    It functions as a health indicator to orchestrate the startup dependency order of your containers.
    As seen in the example above, the `wait-for-container.sh` script queries this port to block `my-service` container from launching until the HashiCorp Consul container is fully ready.
    Passing this check triggers the container's original image entrypoint scripts.




#### 5.2) Java 21 and 25 with embedded Postgres Database
to support the database-per-service** pattern.

#### 5.3) Apache Tomcat 1⁰

#### 5.4) Private Certificate Authority (PKI)
to issue and revoke server and encryption keys using _OpenVPN_ and _EasyRSA_.

##### 5.5) Hazelcast cash platform
to support _Embedded-Cache_, _Client-Server Cache_, and  _Near-Cache_ topologies with zero configuration.

#### 5.6) Distributed service registry and key-value store
based on Hashicorp Consul.
Cluster wide

##### 5.7) Prometheus time-series database server
containers and data scraper container** that periodically pulls (scrapes) the formatted metric data from Micrometer and stores it securely, allowing you to run complex queries against your historical application performance data.

#### 5.8) Grafana

#### 5.9) LDAP server

### 6) Source core

[https://github.com/zappee/spring-box](https://github.com/zappee/spring-box)

### 7) Contributing

Contributions, feature requests, optimization, and bug reports are always welcome!
