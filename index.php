<html>
<head>
	<title>Aquarium Control</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<?PHP

		function getTemp( &$fht) {
			// File to read
			$file = '/sys/bus/w1/devices/28-80000026c2d2/w1_slave';
			// Read the file line by line
			$lines = file($file);
			// Get temp from second line
			$temp = explode('=' , $lines[1]);
			// Setup formatting
			$temp = number_format($temp[1] / 1000, 1, '.', '');
			// Convert to fahrenheit
			$fht = ($temp * 9/5) + 32;
		}

		// global fahrenheit
		$f = 0;

		// Global Fahrenheit temp
		getTemp($f);

		// Refresh temp button
		if(isset($_POST['Refresh1'])){
			// $f = getTemp();
			getTemp($f);
		}
		// Toggle lights on and off
		if(isset($_POST['ON_L'])){
			system("sudo python /home/pi/Desktop/pwrON.py");
		}
		if(isset($_POST['OFF_L'])){
			system("sudo python /home/pi/Desktop/pwrOFF.py");
		}
		// Toggle heater on and off
		if(isset($_POST['ON_H'])){
			system("sudo python /home/pi/Desktop/htrON.py");
		}
		if(isset($_POST['OFF_H'])){
			system("sudo python /home/pi/Desktop/htrOFF.py");
		}
		// Toggle filter on and off
		if(isset($_POST['ON_F'])){
			system("sudo python /home/pi/Desktop/fltrON.py");
		}
		if(isset($_POST['OFF_F'])){
			system("sudo python /home/pi/Desktop/fltrOFF.py");
		}
		// Toggle air pump on and off
		if(isset($_POST['ON_A'])){
			system("sudo python /home/pi/Desktop/airON.py");
		}
		if(isset($_POST['OFF_A'])){
			system("sudo python /home/pi/Desktop/airOFF.py");
		}
		// Toggle all outlets on and off
		if(isset($_POST['ON_O'])){
			system("sudo python /home/pi/Desktop/outltON.py");
		}
		if(isset($_POST['OFF_O'])){
			system("sudo python /home/pi/Desktop/outltOFF.py");
		}
	?>

</head>
<body>

	<div>
    	<br />
    	<iframe src="http://aquariumcontrol.ddns.net:8081" width="320" height="240"></iframe>
  	</div>
	<p>In case you were wondering, the wall is yellow/brown and so are the lights.</p>
	<p>The water is clear but the lighting makes it look nasty...</p>
<FORM NAME="form1" METHOD="POST" ACTION="index.php">
	<P>-------------------------------</P>
	The current temp is: <?php print $f; ?> &#8457;
	<INPUT TYPE="Submit" Name="Refresh1" VALUE="Refresh">
	<P>-------------------------------</P>
	<P>Lights
	<BUTTON NAME="ON_L">ON</BUTTON>&nbsp;
	<BUTTON NAME="OFF_L">OFF</BUTTON><br>
	<P></P>
	<P>Heater
	<BUTTON NAME="ON_H">ON</BUTTON>&nbsp;
	<BUTTON NAME="OFF_H">OFF</BUTTON><br>
	<P></P>
	<P>Filter
	<BUTTON NAME="ON_F">ON</BUTTON>&nbsp;
	<BUTTON NAME="OFF_F">OFF</BUTTON><br>
	<P></P>
	<P>Air Pump
	<BUTTON NAME="ON_A">ON</BUTTON>&nbsp;
	<BUTTON NAME="OFF_A">OFF</BUTTON><br>
	<P>-------------------------------</P>
	<P>Outlets
	<BUTTON NAME="ON_O">ON</BUTTON>&nbsp;
	<BUTTON NAME="OFF_O">OFF</BUTTON><br>

</FORM>
</body>
</html>


