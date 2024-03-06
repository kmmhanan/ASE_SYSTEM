<?php include 'baseUrl.php' ?>
<?php include $baseurl . 'layout/skeltonTop.php' ?>

<!-- Top Bar -->
<div class="topBar">
    <div class="topBarIcon"><a href="index.php"><img src="<?php $baseurl ?> asset/img/Logo.svg" alt=""></a></div>
    <ul>
        <a href="loginPage.php">Login</a>
        <a href="#callContainer">Call Reserve</a>
        <a href="#bottomBar">About us</a>
    </ul>
</div>

<!-- Body Part -->
<div class="webBody">
    <div class="introContainer">
        <div class="introImage"><img src="<?php $baseurl ?> asset/img/IntroVector.svg" alt=""></div>
        <div class="introContent">
            <div class="text">
                <p>Welcome to our</p>
                <span>City Taxi</span>
                <p>Service Website</p>
            </div>
            <div class="quote">
                "where convenience meets reliability!<br>Discover hassle-free transportation solutions<br>tailored to your needs."
            </div>
            <ul>
                <li>Sit Back</li>
                <li>Relax</li>
                <li>Enjoy</li>
            </ul>
        </div>
    </div>
    <hr>
    <div class="callContainer" id="callContainer">
        <div class="callContent">
            <p>For unregistered customer</p>
            <p>Reserve taxi via call</p>
        </div>
        <div class="callNumber">
            <a href="tel:+94771234567">+94 77 123 4567</a>
        </div>
    </div>
    <hr>
    <div class="loginContainer">
        <div class="loginUser">
            <div>
                <p>Registered</p>
                <p>Login here to reserve taxi</p>
            </div>
            <a href="loginPage.php" class="pBtn">Login</a>
        </div>
        <div class="loginStaff">
            <p>Staffs</p>
            <a href="loginPage.php">Login</a>
        </div>

    </div>
</div>

<!-- Bottom Bar -->
<?php include $baseurl . 'layout/bottomBar.php' ?>

<?php include $baseurl . 'layout/skeltonBtm.php' ?>