<?php include 'baseUrl.php' ?>
<?php include $baseurl . 'layout/skeltonTop.php' ?>

<!-- Top Bar -->
<div class="topBar">
    <div class="topBarIcon"><a href="index.php"><img src="<?php $baseurl ?> asset/img/Logo.svg" alt=""></a></div>
    <ul>
        <a href="loginPage.php">Login</a>
        <a href="index.php#callContainer">Call Reserve</a>
        <a href="#bottomBar">About us</a>
    </ul>
</div>

<!-- Body Part -->
<div id="reserveBody">
    <div class="loginCard">
        <p>Reserve Taxi Here...👇🏻</p>
        <div class="reserveDetails">
            <div>
                <input class="logInput" type="text" placeholder="Pickup Date & Time">
                <div class="reserveImage"><img src="<?php $baseurl ?> asset/img/date.svg"></div>
            </div>
            <div>
                <input class="logInput" type="text" placeholder="Pickup Location">
                <div class="reserveImage"><img src="<?php $baseurl ?> asset/img/map.svg"></div>
            </div>
            <div>
                <input class="logInput" type="text" placeholder="Drop Location">
                <div class="reserveImage"><img src="<?php $baseurl ?> asset/img/map.svg"></div>
            </div>
            <input class="logInput" type="text" placeholder="Contact Number">
            <input class="logInput" type="text" placeholder="Note">
        </div>
        <div class="reserveBtns">
            <a href="">Clear</a>
            <a href="" class="pBtn">Reserve</a>
        </div>
    </div>
</div>

<!-- Bottom Bar -->
<?php include $baseurl . 'layout/bottomBar.php' ?>

<?php include $baseurl . 'layout/skeltonBtm.php' ?>