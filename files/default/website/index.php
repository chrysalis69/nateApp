<?php
  include 'config.php';
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>nateAPP</title>

    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/base.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <img class="navbar-logo navbar-brand" src='img/logo.png' />
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">nateAPP</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="admin.php">Admin</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container">

      <div class="starter-template">
        <h1><img class="large-logo" src="img/logo.png" />nateApp</h1>
      </div>
<?php
$sql = "SELECT id, name, email FROM presenters";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
?>
      <div class="row well">
        <div class="col-md-3 presenter">
          <img class="img-circle" src="<?php echo $grav_preurl.md5(strtolower(trim($row['email']))).$grav_posturl; ?>" alt="Generic placeholder image" width="140" height="140">
          <h3><?php echo $row['name'];?></h3>
        </div><!-- /.col-lg-4 -->
        <div class="col-md-9">
<?php
   $presentationSQL = "SELECT* FROM presentations where presenter = ".$row['id'];
   $presentationResult = $conn->query($presentationSQL);
   if ($presentationResult->num_rows > 0){
   while($presentationRow = $presentationResult->fetch_assoc()) {
?>
          <div class="col-md-6">
            <img src="presentation/<?php echo $presentationRow['guid']; ?>/<?php echo $presentationRow['filename']; ?>;thumb" onclick="window.open('show.php?guid=<?php echo $presentationRow['guid']; ?>','<?php echo $presentationRow['filename']; ?>');"/>
            <p><?php echo $presentationRow['description']; ?></p>
          </div>
<?php
 }
}
?>

        </div><!-- /.col-lg-8 -->
      </div><!-- /.row -->
<?php 
  }
}
?>
    </div><!-- /.container -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>

<?php
$conn.close();
?>
