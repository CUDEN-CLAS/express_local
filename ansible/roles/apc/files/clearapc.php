<?php

  if (in_array(@$_SERVER['REMOTE_ADDR'], array('127.0.0.1', '::1'))) {
    if (apc_clear_cache('opcode')) {
      print '<pre>';
      print 'All Clear!';
      print_r(apc_cache_info());
      print '</pre>';
    }
    else {
      print 'Clearing Failed!';
    }
  }
  else {
    die('Connection only allowed from localhost');
  }
