<?php

  // Load the SQL Schema if the database is empty
  $db_host = getenv('DATABASE_HOST');
  $db_name = getenv('DATABASE_NAME');
  $db_user = getenv('DATABASE_USER');
  $db_pass = getenv('DATABASE_PASS');
  
  // Todo: handle "db" container to create the database
  // =====
  $dsn = "mysql:host=$db_host;dbname=$db_name";
  
  // Wait for db connection (each 3s, timeout to DATABASE_TIMEOUT seconds)
  $try = 0; 
  $sleeptime = 5;
  echo "Waiting for the DB...\n"; 
  do
  {
    try {
      $db = new PDO($dsn, $db_user, $db_pass);
      echo "DB is ready, going on...\n"; 
      break;
    } catch (PDOException $e) {
      echo "DB not ready (try $try) : " . $e->getMessage() . "\n";
    }
    sleep ($sleeptime); $try++;
  } while ( $try < getenv('DATABASE_TIMEOUT')/$sleeptime );
  
  $res = $db->query("SELECT count(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='$db_name'")->fetch(PDO::FETCH_NUM);
  
  if ($res[0] == 0) {
      echo "Loading schema...\n";
      $sql = file_get_contents('/tmp/initial-db.sql');
      $qr = $db->exec($sql);
  } else {
      echo "Database already exists.\n";
  }
?>
