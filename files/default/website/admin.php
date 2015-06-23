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
            <li><a href="/">Home</a></li>
            <li class="active"><a href="admin.php">Admin</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
  <div class="container">
    <div class="panel panel-default panel-presenter">
      <div class="panel-heading">
        <h3 class="panel-title">Create Presenter</h3>
      </div>
      <div class="panel-body">
        <form class="form-horizontal">
          <div class="form-group">
            <label for="inputName" class="col-sm-2 control-label">Name</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" id="inputName" placeholder="Name">
            </div>
          </div>
        <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Email</label>
          <div class="col-sm-10">
            <input type="email" class="form-control" id="inputEmail" placeholder="Email">
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
              <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>&nbsp;Create Presenter</button>
            </div>
          </div>
        </form>  
      </div>
    </div>
    <div class="panel panel-default panel-presenter">
      <div class="panel-heading">
        <h3 class="panel-title">Upload Presentation</h3>
      </div>
      <div class="panel-body">
        <form class="form-horizontal" id="formPresentation" action="upload" method="POST" enctype="multipart/form-data">
          <div class="form-group">
            <label for="inputPresentor" class="col-sm-2 control-label">Presentor</label>
            <div class="col-sm-10">
            <select id="inputPresentor" class="form-control" name="inputPresentor">
<?php
$sql = "SELECT id, name, email FROM presenters";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
      echo "<option value=\"".$row['email']."\">".$row['name']." (".$row['email'].")</option>";
    }
}
?>
</select>
          </div>
          </div>
          <div class="form-group">
            <label for="inputDescription" class="col-sm-2 control-label">Description</label>
            <div class="col-sm-10">
              <textarea class="form-control" rows="3" id="inputDescription" name="inputDescription"></textarea>
            </div>
          </div>
          <div class="form-group">
            <label for="inputFile" class="col-sm-2 control-label">Presentation</label>
            <div class="col-sm-10">
              <input type="file" id="inputFile" name="inputFile">
            </div>
          </div>
        <div class="form-group">
          <div class="col-sm-offset-2 col-sm-10">
              <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-upload" aria-hidden="true"></span>&nbsp;Upload Presentation</button>
            </div>
          </div>
        </form>  
      </div>
    </div>
  </div><!-- /.container -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script src="http://malsup.github.com/jquery.form.js"></script> 
    <script>
        $(document).ready(function() { 
            // bind 'myForm' and provide a simple callback function 
            $('#formPresentation').ajaxForm(function() { 
                alert("Presentation Uploaded!");
                $('#formPresentation').resetForm(); 
            }); 
        }); 
    </script>
  </body>
</html>

<?php
$conn.close();
?>

