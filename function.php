<?php

function add_file($yourname, $email_address, $title, $userfile_location, $userfile_name)
{
//"asdadsasddsdsd"

/*
This takes the form File Info and stores it in a mySQL database. Take the file I have
included and setup the database. Once that is all done uncomment the area below to
start using the database. This script will uplaod files just fine to your site without using
a database but this gives you the option of the database for later use of the files and
storing info.
*/

/*
  $db_name = "File_Info";
  $table_name = "myfiles";

  $link = mysql_connect("localhost", "UserName", "Password") or die("Could not connect to server!");
  $db = mysql_select_db($db_name, $link) or die("Could not select database!");

  $query = "INSERT INTO $table_name (username, title, file_location, file)
  VALUES
  ('$yourname', '$title', '$userfile_location', '$userfile_name')";

  mysql_query($query) or die("Could not complete update of database");
*/

  //This constructs the email to be sent to varify to the user it was uploaded
  $To = "$email_address";
  $Subject = "$yourname, Thanks for your File submission";
  $Msg = "Just wanted to let you know $yourname, your File has been added to our database of Files.\n\n";
  $Msg .= "User ID: $yourname\n";
  $Msg .= "Title: $title\n";
  $Msg .= "Upload File Location: $userfile_location\n";
  $Msg .= "Upload File: $userfile_name\n";
  $Msg .= "Thanks from the staff at Your Site.\n\n";

  //This sends the actual email
  mail ($To, $Subject, $Msg, "From: youremail@yourdomain.com");

  //Once complete the directs you to a confimation page that the file has been uploaded
  header("Location: upload.php?option=confirm&name=$yourname");

}

function email_validation($email)
{
  //This Trims the email address getting rid of spaces
  $email = trim("$email");

  //Creates a global variable
  global $not_valid;

  //This is the pattern used to Validate the email address the user typed into the form
  $pattern =  "^([0-9a-z]+)([a-z0-9\._-]+)@([a-z0-9\._-]+)\.([0-9a-z]{2,3}$)";

  //This checks the email address with the pattern to make sure it is valid
  if (eregi($pattern, $email)) {
    //This sets gloabal variable to false if email address is valid
    $not_valid = false;
  } else {
    require("header.php");
    echo "Please hit the back button and enter a valid email address!<BR>\n
          <B>$email</B> is not a valid email address!<BR><BR>\n";
    require("footer.php");
    exit;
  }
}

?>
