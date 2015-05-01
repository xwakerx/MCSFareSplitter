<?php

// Put your device token here (without spaces):
//David
$deviceToken = 'f05ea7c9c19e07d423b32bc0fe6d9bd8f86b42c2ec17bd828bb53b3dbb93e50b';

//Sergio
//$deviceToken = '328749ca224c316f321bae91f82ec3a31bb323a7f875f5e334e774b317a64e00';

//Jose
//$deviceToken = '75f92184bcc59076ab2092a0e47a0fe347be439db70d0a8712cc638e94076994';

//Manuel
//$deviceToken = '429c2d9e3cd5c92f7ab28057658a7d2964bc852ea27f057f5280f327d82a3e34';

// Private key's passphrase:
$passphrase = 'splitter';

// Alert message:
$message = 'Que trancita banda?';

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
	'ssl://gateway.sandbox.push.apple.com:2195', $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

echo 'Prueba';

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$body['aps'] = array(
	'alert' => $message,
	'sound' => 'Paid'
);
$body['tabSplitter'] = array (
    'type' => 'Paid'
);

//echo $body;

// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));

if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);
