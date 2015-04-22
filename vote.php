<html>
<body>
<?php session_start();
ini_set('display_errors',1);  error_reporting(E_ALL);
$servername = "localhost";
$username = "root";
$password = "root";
$dbname = "radio";
$ipaddr = $_SERVER['REMOTE_ADDR'];
$yesnovar = $_GET["yesnovar"];
//echo $yesnovar;
if ($yesnovar=="yes") {
        $yesno = "yes=1, no=0";
} else {
        $yesno = "yes=0, no=1";
}

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

// SQL statement for finding device_id from IP
$sqldevice = "SELECT device_id FROM devices WHERE ip='$ipaddr' and active=1 limit 1;";

// $deviceid set to device_id form db
$deviceid = implode(mysqli_fetch_assoc(mysqli_query($conn, $sqldevice)));

// current_round update for user
$sql = "UPDATE current_round set $yesno where device_id='$deviceid';";
if ($conn->query($sql) === TRUE) {
    echo "Vote updated successfully - IP:$ipaddr and deviceid:$deviceid ";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}
$conn->close();
header("location:javascript://history.go(-1)");
?>
</body>
</html>
