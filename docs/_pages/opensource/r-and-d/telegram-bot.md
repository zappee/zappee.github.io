---
layout: single
parent: Open Source
title: ""
permalink: /opensource/r-and-d/telegram-bot/
author_profile: false
classes: "wide smaller-text"
sidebar:
  nav: "opensource_sidebar"
---

## 🐧 Telegram Bot

![GitHub top language](https://img.shields.io/github/languages/top/zappee/telegram-bot)
![GitHub Issues](https://img.shields.io/github/issues/zappee/telegram-bot)

### 1) Overview
**Telegram-Bot** is a simple proof of concept **Java Spring Boot** application designed to get your custom Telegram bot up and running in minutes.
Instead of dealing with confusing setup files and complex integrations, this project handles the basic connection and event tracking right out of the box.

Whether you want to build an automated notification system, manage your group chats, or set up custom alerts for your phone, this repository gives you a clean starting point to quickly add your own logic and expand your bot's capabilities.

### 2) Getting started

#### 2.1) Prerequisites
* Java Development Kit (JDK) 21 or higher.

#### 2.2) Build & Execution

1. Clone the repository into your local directory:
   ```bash
   $ git clone https://github.com/zappee/telegram-bot.git
   $ cd telegram-bot
   ```

2. **Configure environment variables:**
   Open the `src/main/resources/application.properties` file and update the following data:
   * **telegram.botToken=** Your bot's unique secret password. It authenticates your application with Telegram's servers. You get this key from `@BotFather` when creating the bot.
   * **telegram.botName=** Your bot's exact username on Telegram (e.g., MyCoolBot). The code uses this to identify your bot during initial setup and registration.
   * **telegram.myUserId=** • Your personal Telegram account ID number. The script uses this to ensure the bot only responds to you (or sends notifications directly to your chat), locking out unauthorized users.

### 6) Source core

[https://github.com/zappee/telegram-bot](https://github.com/zappee/telegram-bot)

### 7) Contributing

Contributions, feature requests, and optimization are always welcome!
