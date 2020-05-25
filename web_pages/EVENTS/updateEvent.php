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
<title>Update Events</title>
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
        <li><a href="singer.html" accesskey="2" title=""><b>Singers</b></a></li>
        <li class="active"><a href="event.html" accesskey="3" title=""><b>Events</b></a></li>
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


<div><h2>Update Information for Existing Events</h2></div>
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

$mysqli = new mysqli($host, $username, $password, $database);

// Attempting to connect
//$dbcon = mysqli_connect($host, $username, $password, $database)
   //or die('Could not connect: ' . mysqli_connect_error());

// Getting the input parameters:
$event_name = trim($_REQUEST['event_name']);
$event_date = trim($_REQUEST['event_date']);
$country = trim($_REQUEST['country']);
$city = trim($_REQUEST['city']);

// Prevent apdating the same info to table Event:
$query_oricountrycity = "CALL event6_1('$event_name', '$event_date');";

$oricountry;
$oricity;

//http://php.net/manual/en/mysqli.prepare.php
if ($stmt = $mysqli->prepare($query_oricountrycity)){

    /* execute query */
    $stmt->execute();

    /* bind result variables */
    $stmt->bind_result($oricountry,$oricity);

    /* fetch value */
    $stmt->fetch();

    /* close statement */
    $stmt->close();
}

/*
while ($tuple = mysqli_fetch_array($result_oricountrycity)) {
  $oricountry = $tuple[0];
  echo $oricountry;
  $oricity = $tuple[1];
  echo $oricity;
}
*/

// Update Event info  
if (preg_match('/[\'^£$%&*()}{@#~?!><>,:;"|=_+¬]/', $event_name) || $event_name === ' ') {
    echo "Sorry, this is not a valid event name. Please try again.";
} 
elseif ((ctype_alpha(str_replace(' ', '', $country)) === false && $country!== '') ||
    preg_match('/[\'^£$%&*()}{@#~?!><>,:;"|=_+¬]/', $country)) {
    echo 'Country must contain letters and spaces only (excluding space only). Please try again.';
}
elseif ((ctype_alpha(str_replace(' ', '', $city)) === false && $city!== '') ||
    preg_match('/[\'^£$%&*()}{@#~?!><>,:;"|=_+¬]/', $city)) {
    echo 'City must contain letters and spaces only (excluding space only). Please try again.';
}
elseif ($country === '' && $city === '') {
  echo 'Oops, nothing is provided. Please try again.';
}
elseif ($country === $oricountry && $city === $oricity && $city !== '' && $country !== '') { 
  echo 'Oops, nothing needs to be updated. Please try again.';
}
elseif ($country === $oricountry && $city !== $oricity && $country !== '') {
  echo 'Country is up-to-date. You can leave it blank.';
}
elseif ($country !== $oricountry && $city === $oricity && $city !== '') {
  echo 'City is up-to-date.  You can leave it blank.';
}
elseif (!($oricountry === $country && $oricity === $city)) {
  
  $query = "CALL event6('$event_name', '$event_date', '$country', '$city');";


  if ($newStmt = $mysqli->prepare($query)){
    
    /* execute query */
    $newStmt->execute();

    $newResult = $newStmt ->get_result();

  // Show results in a table

  if ($newResult->num_rows > 0) {

      // printf("Result set has %d rows.\n", $newResult->num_rows);

      echo 'Congratulations! Following information has been updated successfully:';
      echo "<table>
            <tr>
            <th>Event Name</th>
            <th>Event Date</th>
            <th>Country</th>
            <th>City</th>
            </tr>";

      // output data of each row
      while($row = $newResult->fetch_assoc()) {
          printf("<tr>
                <td>". $row["name"] ."</td>
                <td>". $row["date"] ."</td>
                <td>". $row["country"] ."</td>
                <td>". $row["city"] ."</td>
                </tr>");
       }
      echo "</table>";
  } 
  else {
    echo "Sorry the update failed. </br>";
    echo "Please make sure that event name and event date are exactly the same as 
          those found in section <i>Explore Events You Are Interested In</i>."; 
  }
    
    
    /* close statement */
    $newStmt->close();

  }
}else {
    echo "Sorry the update failed. </br>";
    echo "Please make sure that event name and event date are exactly the same as 
          those found in section <i>Explore Events You Are Interested In</i>."; 
}


// Closing connection
$mysqli->close();

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



