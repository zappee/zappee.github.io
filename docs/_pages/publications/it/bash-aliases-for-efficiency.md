---
layout: single
parent: Publications
title: ""
permalink: /publications/it/bash-aliases-for-efficiency/
author_profile: false
classes: "wide smaller-text"
tags: [docker, terminal, devops]
sidebar:
  nav: "publications_sidebar"
---

## 🌐 🧭 Bash aliases for efficiency

### 1) Overview

The command line is one of the most powerful tools in a developer's arsenal, but it is also notorious for requiring repetitive typing.
Day after day, we find ourselves entering the exact same lengthy Git or Docker commands, navigating deep into nested directory structures, or executing complex build.
Over time, those thousands of redundant keystrokes turn into a massive burden on your time and mental focus.

This is where shell aliases come to the picture.

An alias is a simple shortcut that acts as a wrapper around complex terminal commands.
By mapping long, hard-to-remember arguments to just a few letters, you can completely automate your repetitive work while using the Linux terminal.
In this article, I have collected the most effective and useful shell aliases that I use every day to get things done faster.

| Alias | Command                                                                                                               | Description                      |
| :--- |:-----------------------------------------------------------------------------------------------------------------------|:---------------------------------|
| `li` | `alias li="docker image ls \| (sed -u 1q; sort -n -k1)"`                                                               | List docker images               |
| `lc` | `alias lc="docker ps -a"`                                                                                              | List docker containers           |
| `sc` | `alias sc='docker container stop $(docker ps -a -q)'`                                                                  | Stop docker containers           |
| `dc` | `alias dc='docker container rm $(docker ps -a -q)'`                                                                    | Delete docker containers         |
| `rmc` | `alias rmc='yes \| docker container prune'`                                                                           | Delete docker containers         |
| `lv` | `alias lv='docker volume ls'`                                                                                          | List volumes                     |
| `rmv` | `alias rmv='yes \| docker volume prune -a'`                                                                           | Remove volumes                   |
| `rmi` | `alias rmi='docker volume rm $(docker volume ls -qf dangling=true); docker rmi $(docker image ls -qf dangling=true)'` | Remove unused images and volumes |

### 💬 What did I miss?

These are the shortcuts that save my days.
But everyone's terminal is different.
What are the lifesaver aliases you can't live without?

Feel free to reach out, drop your favorites, or suggest more useful aliases to add to this list.
Let’s make our command lines faster together!
