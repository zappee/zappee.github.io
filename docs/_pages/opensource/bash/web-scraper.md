---
layout: single
parent: Open Source
title: ""
permalink: /opensource/bash/web-scraper/
author_profile: false
sidebar:
  nav: "opensource_sidebar"
---

## 🐧 Web Scraper for AI

This web scraper is a software tool used to extract textual data from websites and convert it into structured text content that you can use to feed AI and ask questions about the content.

You need a web scraper to feed an AI because AI models cannot directly read a website URL, and they usualy have no direct access to Internet.
So they require raw text or structured data to process information.
While you see visual layouts, images, and buttons on your browser, an AI needs the clean, underlying textual data stripped of code and styling to answer questions about it.

The main reasons you need a scraper

1. Cleaning the noise

    Webpages are filled with stile definitions, code, images, scripts  navigation bars, footers, and cookie banners.
    If you pass a raw website to an AI, it will waste your tokens trying to read code instead of your content. 
    A scraper extracts only the relevant text (like the blog body, product description, or article text).


2. AI prompt size limit
   AI models have a _context window_ (a maximum limit of text they can read at one time).
   Without a scraper, a single webpage's raw source code can be massive, easily exhausting the AI's limit.
   With a scraper the webpage content is compressed into pure text, allowing you to feed the AI significantly more information at a lower cost.


3. Handling multipage sites
   If your website has 20 pages, you cannot manually copy and paste every link. 
   A scraper can act as a crawler, automatically following internal links, mapping out your entire website, and gathering all the text into a single text file that the AI can instantly process.
