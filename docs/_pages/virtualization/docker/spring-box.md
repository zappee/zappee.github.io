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

## ☁️ Spring Box: the ultimate Spring Boot runner

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
* **Distributed Caching:** The built-in, cluster-wide Hazelcast-based distributed cache solution offered by _Spring Box_ simplifies the implementation of lightning-fast REST services and it can be used to maintain a persistent request context across separate instances. You can significantly reduce database load by utilizing different caching strategies. By pairing _Spring Box_ with the _Bucket4j_ library, you can easily implement robust, multi-instance, IP-based rate limiting (throttling) and circuit breakers to protect your API endpoints against DDoS attacks.
  The architecture supports three distinct caching mechanisms: Embedded Cache, Client-Server topology, and Near-Cache:
  ![Supported caching architectures](bbbbb)


### 5) Docker containers in the _Spring Box_ ecosystem

![Spring Box image hierarchy](/assets/images/menu/virtualization/docker/spring-box/spring-box-image-hierarchy.png)

### 6) Java runtime containers
The platform supports production-ready runtimes for **OpenJDK 11, 17, 21, and 25**.
These core `Java` images provide your Spring Boot applications a reliable, high-performance execution environment in the _Spring Box_ ecosystem.

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
                memory: 384M # hard limit
            reservations:
                memory: 300M # soft limit
    volumes:
        - $HOME/springbox/volumes/my-service/jar-to-run:/jar-to-run
        - $HOME/springbox/volumes/my-service/logs:/logs
        - $HOME/springbox/volumes/my-service/heap-dump:/heap-dump
```

**Configuration highlights**

* **Containers naming convention:**

  It is highly recommended to use the exact same name for both `hostname` and `container_name` to prevent internal network routing conflicts. We use Fully Qualified Domain Names (FQDN) by expanding the container name with a base domain.
  That way container name remains unique per environment. For instance, the production domain can align with the company's officially registered domain name, while development environments can use the developer's nickname.
  This strategy provides massive advantages when working with a _Container Runtime System_ that dynamically manages the execution and lifecycle of Docker containers.

  The `${DOMAIN_NAME}` variable can be defined in a dedicated environment file, or as a shell variable, or CI/CD pipeline can provide.
  ```properties
  # arnold.com.env file
  DOMAIN_NAME=arnold.com
  ```
  You can then spin up the stack using the following command: `docker compose --env-file=arnold.com.env -f <compose-file> up`


* **Ports used by the container:**

  * **SSH Port (default: 22):** The embedded SSH server listens on the default port 22 for safe, remote shell management.
    * **User:** `root`
    * **Password:** `password`
    * **Connection string:** `sshpass -p password ssh -oStrictHostKeyChecking=no root@localhost -p <port>` *(where the port is mapped to `14012` in the example above).*
  * **JVM debug port (default: 8000):** External Java IDEs (such as IntelliJ IDEA) can utilize this port to attach a remote debugger directly to the running application inside the container.
  * **Readiness signal port (default: 1331):** This port opens automatically once the container has completely initialized and all `init` and `startup` scripts have executed successfully.
    It functions as a health indicator to orchestrate the startup dependency order of your containers.
    As seen in the example above, the `wait-for-container.sh` script queries this port to block the `my-service` container from launching until the HashiCorp Consul container is fully ready.
    Without this check, the Spring Boot application would fail immediately, as it strictly requires an active configuration Key-Value store during its startup phase.
    Passing this check triggers the container's original image entrypoint scripts.#

    Use this feature with caution, as misconfiguration can result in an infinite loop and your container will not start.


* **Override the container entrypoint:**

  To orchestrate your cluster's container startup order, you can utilize the built-in `wait-for-container.sh` utility script.
  This script expects exactly one parameter: the hostname of the target container that your service depends on.
  It queries the **Readiness Signal Port** of that specified container in a loop (polling every 0.5 seconds), safely blocking your service's startup until the dependency is fully online.
  
  Usage example:
  ```yaml
  entrypoint: ["/wait-for-container.sh", "consul.${DOMAIN_NAME}"]
  ```


* **Container environment variables:**

  These configuration keys are injected directly into the container's runtime environment, becoming active shell variables inside the container so that your application (such as Spring Boot) can seamlessly read them.

  Variables utilized by this image:
  * **PKI_HOST:** Specifies the hostname of the **Private PKI Management** container within the _Spring Box_ network.
  * **CONSUL_SERVER_HOSTNAME:** Defines the hostname of the **HashiCorp Consul** container inside the platform.
  * **JAVA_OPTS:** A standard environment variable used to pass crucial startup arguments and optimization flags directly to the Java Virtual Machine (JVM) upon initialization.

  The following diagram illustrates the JVM memory structure and its corresponding configuration flags:

  ![JVM memory space](/assets/images/menu/virtualization/docker/spring-box/jvm-memory-space.png)

* **Container memory limit:**

  In Docker Compose, you can manage memory usage for your containers by defining memory limits and reservations in your `docker-compose.yml` file.
  This helps prevent containers from consuming excessive resources, which can lead to system instability.
  
  The container memory limits defined here must align precisely with the internal JVM configurations.


* **Docker volume configuration:**

  Docker volumes store persistent data outside a container’s writable disk, ensuring data remains intact even after the container is removed.
  _Spring Box_ uses Docker volumes to share files between the host machine and the container.

  * **/jar-to-run:** Host to container, input. The executable Java application `.jar` file must be placed in this folder to be passed into the container for execution This folder must contain exactly one `.jar` file, as each individual Java container in the _Spring Box_ ecosystem is designed to execute a single application.
  - **/logs:** Container to host, output. Application and server log files generated by the active processes inside the container are streamed out the host machine via this shared folder.
  - **/heap-dump:** Container to host, output. This is the place where the JVM outputs binary memory snapshots upon a critical failure.


### 7) Java runtime with PostgreSQL containers


### 6) Private Certificate Authority (PKI)


### 7) Hashicorp Consul integration










### 7) Java 21 and 25 with an embedded PostgreSQL database
This image extends our core [Java Containers](#6-java-containers) layers by adding a pre-installed, and ready-to-use PostgreSQL database server on top of the original image.
While everything detailed in the [Java Containers](#6-java-containers) section applies to this image as well, this image requires a few extra configuration steps to operate the embedded database engine.



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
