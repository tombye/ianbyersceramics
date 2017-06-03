{% extends "base.html" %}
{% load static from staticfiles %}

{% block bodyclass %}{% endblock %}

{% block title %}News | Ian Byers Ceramics{% endblock %}

{% block breadcrumb %}
<header class="page-header">
    <h1>News</h1>
    <ul class="breadcrumb" role="breadcrumbs">
        <li><a href="/">Home</a></li>
        <li>News</li>
    </ul>
</header>
{% endblock %}

{% block content %}
        <article class="intro">
            <h1>Yingge Ceramics Museum residency</h1>
            <p>I was the artist in residence at the <a href="http://www.ceramics.ntpc.gov.tw/en-us/Home.ycm">Yingge Ceramics Museum</a> in Taipei, Taiwan for September this year.</p>
            <p>I've written an article called <a href="/mining_uncertainty">mining uncertainty in Taiwan</a> containing reflections of my time at Yingge along with a bit about my history to give it context.</p>
            <p>Images of the work I produced during this time can be seen in the new <a href="/galleries/works-in-progress-2013/artworks/28/">Yingge gallery</a>. 
        </article>
        <article>
            <h1>3 makers</h1>
            <img class="inset-right" src="{% static 'img/news/gen.jpg' %}" alt="-Gen artwork" />
            <p>I took part in the <a href="http://tokarskagallery.co.uk/3makers">3 makers exhibition</a> at the Tokarska gallery in Walthamstow with <a href="http://amandadoidge.co.uk/">Amanda Doidge</a> and <a href="http://www.raewynharrison.com/">Raewyn Harrison</a> from May 9th to 1st June of this year.</p>
            <p>The exhibition included the following talks on contemporary ceramics:</p>
            <ul>
                <li><a href="http://www.keithharrisonattokarskagallery.eventbrite.com/">Talk by Keith Harrison</a></li>
                <li><a href="http://bonniekemskeattokarskagallery.eventbrite.com/">Talk by Bonnie Kemske</a></li>
            </ul>
            <p>You can view details of the exhibition on the <a href="http://tokarskagallery.co.uk/3makers">Tokarska gallery website</a> or as a <a href="{% static 'pdf/3_makers.pdf' %}">PDF (2402K)</a>.</p>
            <h2>Interviews</h2>
            <div class="video">
                <p>I've been interviewed about the work for this show.</p>
                <figure class="media-player-wrapper">
                    <iframe width="560" height="315" src="http://www.youtube.com/embed/gyJSMv-bjM8" frameborder="0" allowfullscreen></iframe>
                </figure>
            </div>
            <figcaption>
                <p><a href="#transcript" class="transcript-toggle">View a transcript of the interview</a></p>  
                <div class="video-transcript">
                    <p>I've been working with ceramics for a long time, actually and with one material and it's the material I emotionally respond to.</p>
                    <p>When you look at the work in the exhibition you'll see that actually there are really 2 different groups of work but they are related as well. Some of the work has got a strange name, <em>liminal</em> which means something is on a threshold, it could become something else and the other work is called <em>-gen</em> which I hope, when you look at the work you'll actually see it means something in relation to things like to generate something, to create something and it's really about life, you know, it's really about how life becomes, it changes, becomes something else all the time, we can never actually stay still, even in our lifetimes, all our cells change.</p>
                    <p>The show I think is interesting, it involves different people at different stages in their careers and I think that's part of the debate that could come out of this exhibition is what will be the future for ceramics, you know what's going to happen?</p>
                    <p>Education seems to be in a state of flux. We're at a stage where digitisation seems to be taking over in all forms of life and yet I think it's really important that we keep in touch with materials and being able to develop ourselves as much as the objects that we make through a knowledge and understanding of materials.</p>
                </div>
            </figcaption>
            <p>Interivews with the other artists can also be found on YouTube:</p>
            <ul>
                <li><a href="http://www.youtube.com/watch?v=QfCUTePyhQA">Interview with Raewyn Harrison</a></li>
                <li><a href="http://www.youtube.com/watch?v=7JswLFzRdIc">Interview with Amanda Doidge</a></li>
            </ul>
        </article>
        <article>
            <h1>Yingge Ceramics Museum residency selection</h1>
            <p>I have been selected to be an artist in residence at the <a href="http://www.ceramics.ntpc.gov.tw/en-us/Home.ycm">Yingge Ceramics Museum</a> in Taiwan during 2013.</p>
            <p>This will be a residency of up to three months, which will involve both collaborative work, lectures and the development of small sculptures in porcelain.</p>
        </article>
{% endblock %}

{% block footer %}
<ul>
	<li><a href="/process_and_material">Process and material</a></li>
    <li><a href="/about">About</a></li>
	<li><a href="/contact">Contact</a></li>
</ul>
{% endblock %}