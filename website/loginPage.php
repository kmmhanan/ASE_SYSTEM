<?php include 'baseUrl.php' ?>
<?php include $baseurl . 'layout/skeltonTop.php' ?>

<!-- Top Bar -->
<div class="topBar">
    <div class="topBarIcon"><a href="index.php"><img src="<?php $baseurl ?> asset/img/Logo.svg"></a></div>
    <ul>
        <a href="#">Login</a>
        <a href="index.php#callContainer">Call Reserve</a>
        <a href="#bottomBar">About us</a>
    </ul>
</div>

<!-- Body Part -->
<div id="loginBody">
    <div class="loginCard">
        <p>Login here</p>
        <div class="loginDetails">
            <div class="loginImage"><img src="<?php $baseurl ?> asset/img/user.svg"></div>
            <input class="logInput" type="email" placeholder="User ID / Email">
            <input class="logInput" type="password" placeholder="User ID">
        </div>
        <a href="reservePage.php" class="pBtn">Login</a>
    </div>
</div>

<!-- Bottom Bar -->
<?php include $baseurl . 'layout/bottomBar.php' ?>

<?php include $baseurl . 'layout/skeltonBtm.php' ?>