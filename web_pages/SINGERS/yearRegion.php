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
<title>SingersYearRegion</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Didact+Gothic" rel="stylesheet" />
<link href="default.css" rel="stylesheet" type="text/css" media="all" />
<link href="fonts.css" rel="stylesheet" type="text/css" media="all" />

 <style>
  table, th, td {
    border: 1px solid white;
  }
</style>
</head>
<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->

<body>

<div id="header-wrapper">
  <div id="header" class="container">
    
    <div id="menu">
      <ul>
        <li><a href="index.html" accesskey="1" title=""><b>Homepage</b></a></li>
        <li class="active"><a href="singer.html" accesskey="2" title=""><b>Singers</b></a></li>
        <li><a href="event.html" accesskey="3" title=""><b>Events</b></a></li>
        <li><a href="fan.html" accesskey="4" title=""><b>Fans</b></a></li>
        <li><a href="datawarehouse.php" accesskey="5" title=""><b>Data Warehouse</b></a></li>
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



<div><h2>Singers by Start-year and Region</h2></div>
</br>
<p>
<button onclick="goBack()">Go Back</button>
<script>
function goBack() {
    window.history.back();
}
</script>
</p>



<p>
<?php

// Connection parameters 
$host = 'mpcs53001.cs.uchicago.edu';
$username = 'sche93';
$password = 'tina931105';
$database = $username.'DB';

// Attempting to connect
$dbcon = mysqli_connect($host, $username, $password, $database)
   or die('Could not connect: ' . mysqli_connect_error());


// Getting the input parameters:
$start_year = trim($_REQUEST['start_year']); // In this case, start year cannot be ''. 
$region = $_REQUEST['region']; 
$minYear = 1900;
$maxYear = 2018;

// Singers by starting-year and region 
if ($start_year < $minYear || $start_year > $maxYear || preg_match('/[\'^£$%&*()}{@#~?!><>,:;"|=_+¬]/', $start_year) 
    || $start_year === ' ') {
  echo 'Sorry, this is not a valid year. Please try again.';
}
else {
  $query = "CALL sectionFour($start_year, '$region')";
  $result = mysqli_query($dbcon, $query)
    or die('Sorry, this is not a valid year. Please try again.'); 

  // Show results in a table 
  if ($result->num_rows > 0) {
      echo "In $start_year, following singers from $region started their career:"; 
      echo "<table>
            <tr>
            <th>Singer</th>
            <th>Date of Birth</th>
            <th>Belonging Company Name</th>
            </tr>";
      // output data of each row
      while($row = $result->fetch_assoc()) {
          echo "<tr>
                <td>" . $row["singer_name"] . "</td>
                <td>" . $row["singer_birth_date"] . "</td>
                <td>" . $row["comp_name"] . "</td>
                </tr>";
       }
      echo "</table>";
  } else {
    echo 'Oops, no results found in our database! </br>';
    echo "You are very welcome to enrich our database!";
  }

}



// Free result
mysqli_free_result($result);

// Closing connection
mysqli_close($dbcon);
?> 

</p>


<button onclick="goBack()">Go Back</button>

<script>
function goBack() {
    window.history.back();
}
</script>

<div id="copyright" class="container">
  <p>Created by Shuting Chen | Photo by <a href="https://www.healingfrequenciesmusic.com/what-box-are-you-in/abstract-music-logo-music-wallpapers-hd1/">Music!</a> | Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
</div>

</body>
</html>



