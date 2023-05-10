<!doctype html>
<!-- (C) Saeed Mirjalili -->
<html>
<head>
    <title>Display Records of a table</title>
    <link rel="stylesheet" href="../css/style.css" />
</head>

<body>

    <?php
    $servername = "localhost";
    $dbname = "ParkingLotDB";
    $username = "root";
    $password = "";

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        echo "<p style='color:green'>Connection Was Successful</p>";
    } catch (PDOException $err) {
        echo "<p style='color:red'> Connection Failed: " . $err->getMessage() . "</p>\r\n";
    }

    try {
        $sql = "SELECT LicensePlate, VehicleType FROM Vehicle WHERE LicensePlate LIKE '$_POST[plate]%'";

        $stmnt = $conn->prepare($sql);   // read about prepared statement here: https://www.w3schools.com/php/php_mysql_prepared_statements.asp

        $stmnt->execute();

        $row = $stmnt->fetch();  // fetches the first row of the table
        if ($row) {
            echo '<table>';
            echo '<tr> <th>License Plate</th> <th>Vehicle Type</th>';
            do {
                echo "<tr><td>$row[LicensePlate]</td><td>$row[VehicleType]</td></tr>";
            } while ($row = $stmnt->fetch());
            echo '</table>';
        } else {
            echo "<p> No Record Found!</p>";
        }
    } catch (PDOException $err) {
        echo "<p style='color:red'>Record Retrieval Failed: " . $err->getMessage() . "</p>\r\n";
    }
    // Close the connection
    unset($conn);

    echo "<a href='../index.html'>Back to the Homepage</a>";

    ?>
</body>

</html>