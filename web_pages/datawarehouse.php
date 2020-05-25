<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--
Design by TEMPLATED
http://templated.co
Released for free under the Creative Commons Attribution License

Name       : FirstBase 
Description: A two-column, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20140404

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Data Warehouse</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Didact+Gothic" rel="stylesheet" />
<link href="default.css" rel="stylesheet" type="text/css" media="all" />
<link href="fonts.css" rel="stylesheet" type="text/css" media="all" />

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->

</head>

<body>
<div id="header-wrapper">
	<div id="header" class="container">
		
		<div id="menu">
			<ul>
				<li><a href="index.html" accesskey="1" title=""><b>Homepage</b></a></li>
				<li><a href="singer.html" accesskey="2" title=""><b>Singers</b></a></li>
				<li><a href="event.html" accesskey="3" title=""><b>Events</b></a></li>
				<li><a href="fan.html" accesskey="4" title=""><b>Fans</b></a></li>
				<li class="active"><a href="datawarehouse.php" accesskey="5" title=""><b>Data Warehouse</b></a></li>
			</ul>
		</div>
	</div>

<div id="banner-wrapper">
	<div id="banner" class="container">
		<div class="title">
			<h2>Gallery for Music Fans</h2>
			<span class="byline">MPCS 53001 Final Project</span>
		</div>
	</div>
</div>
</div>

<div id="wrapper">
	<div id="three-column" class="container">
		<div >
			<div class="title">
				<h3>Data Warehouse</h3>
			</div>
			<p>Using data warehouse would help people who care about music industry have a more accurate or realistic outlook for the industry.
				Specifically, this application would like to consider following two subjects:</p>
			<p>First, we would like to know which type of events is growing rapidly and attracting more famous singers. This likely plays an 
				important role in business decisions such as whether to sponsor an event. In this scenario, we need tables Event, Concert and 
				MusicFestival which record event date(part of primary key) for each entry to estimate growth rate over a specific time period 
				for different types of events. In addition, we intend to use tables Singer and Participates_in to measure the trend of events 
				prevalent among famous singers. Moreover, it is much easier to construct different statistical models for prediction using 
				data stored in data warehouse.</p>
			<p>Second, some record companies might actively evaluate talent singers that they would like to sign contracts with. Hence, we need 
			   integrated data from tables Singer, Song, Favorite, and Likes to find out who are the rising stars with great talent as well as
			   having certain amount of fans. Since data warehouse maintains data history, we can estimate changes (or growth rate) of number of 
			   fans for each singer. Moreover, attribute <i>start_year</i> in table Singer and attribute <i>year_released</i> in table Song let us 
			   have flexibility of setting time cutoff. </p>
		</div>			
	</div>    		
</div>
  

<div id="copyright" class="container">
	<p>Created by Shuting Chen | Photo by <a href="https://www.healingfrequenciesmusic.com/what-box-are-you-in/abstract-music-logo-music-wallpapers-hd1/">Music!</a> | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
</div>
</body>
</html>
