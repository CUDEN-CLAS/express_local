<?php
if (in_array(@$_SERVER['REMOTE_ADDR'], array('127.0.0.1', '::1'))) {
    if (opcache_reset()) {
      print '<pre>';
      print 'All Clear!';
      var_dump(opcache_get_status());
      print '</pre>';
    }
    else {
      print 'Clearing Failed!';
    }
  }
  else {
    die('Connection only allowed from localhost');
  }
?>