---
layout: categories
title: Categories
permalink: /categories
---
<!--categories-->
<section class="c-archives">
{% for categorie in site.categories %}
	<h2 class="c-archives__year" id="{{categorie | first}}-ref">{{categorie | first}}</h2>
	<ul class="c-archives__list">
	
	{% for post in site.posts %}
		{% for post_cat in post.categories %}
			{% if post_cat == categorie.first %}
				<li class="c-archives__item">
					<h3><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></h3>
					<p>{{ post.date | date: "%b %-d, %Y" }}</p>
				</li>
			{% endif %}
		{% endfor %}
	{% endfor %}
	
	</ul>
{% endfor %}


<!--nil categorie-->
<h2 class="c-archives__year" id="{{categorie | first}}-ref">nil</h2>
<ul class="c-archives__list">
	{% for post in site.posts %}
	
		{% if post.categories.size == 0 %}
			<li class="c-archives__item">
				<h3><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></h3>
				<p>{{ post.date | date: "%b %-d, %Y" }}</p>
			</li>
		{% endif %}
		
	{% endfor %}
</ul>

</section>
