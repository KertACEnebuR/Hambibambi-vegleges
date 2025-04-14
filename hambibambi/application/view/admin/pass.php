<?php
$hashed_password = password_hash("adminPass", PASSWORD_DEFAULT);
echo $hashed_password;
