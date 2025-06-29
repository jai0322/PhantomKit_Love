<?php
$data = json_decode(file_get_contents('php://input'), true);
if (isset($data['image'])) {
  $img = str_replace('data:image/jpeg;base64,', '', $data['image']);
  $img = str_replace(' ', '+', $img);
  $imgData = base64_decode($img);
  $file = 'capture_' . $data['label'] . '_' . time() . '.jpg';
  file_put_contents($file, $imgData);
}
?>