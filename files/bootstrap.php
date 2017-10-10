<?php

// Load the SQL Schema if the database is empty

$db_host = getenv('DATABASE_HOST');
$db_name = getenv('DATABASE_NAME');
$db_user = getenv('DATABASE_USER');
$db_pass = getenv('DATABASE_PASS');

// Todo: handle linked "db" container to create the database
// =====
$dsn = "mysql:host=$db_host;dbname=$db_name";
$db = new PDO($dsn, $db_user, $db_pass);
$res = $db->query("SELECT count(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='$db_name'")->fetch(PDO::FETCH_NUM);

if ($res[0] == 0) {
    print "Loading schema...";
    $sql = file_get_contents('/var/www/html/SQL/mysql.initial.sql');
    $qr = $db->exec($sql);
    print "$qr";
} else {
    print "Database exists.\n";
}
?>
