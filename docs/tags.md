---
layout: page
title: "Browse by Tags"
permalink: /tags/
---

<!-- 1. DISPLAY THE TAG CLOUD/LIST -->
<div class="tag-cloud">
  {% assign tags = site.tags | sort %}
  {% for tag in tags %}
    {% assign tag_name = tag[0] %}
    <a href="#{{ tag_name | slugify }}" class="tag-btn">
      #{{ tag_name }} ({{ tag[1] | size }})
    </a>
  {% endfor %}
</div>

<hr>

<!-- 2. DISPLAY POSTS GROUPED BY TAG -->
<div class="tag-groups">
  {% for tag in tags %}
    {% assign tag_name = tag[0] %}
    {% assign posts = tag[1] %}

    <h3 id="{{ tag_name | slugify }}">{{ tag_name | capitalize }}</h3>
    <ul>
      {% for post in posts %}
        <li>
          <a href="{{ post.url | relative_url }}">{{ post.title }}</a> 
          <small>— {{ post.date | date_to_string }}</small>
        </li>
      {% endfor %}
    </ul>
{% endfor %}
</div>
