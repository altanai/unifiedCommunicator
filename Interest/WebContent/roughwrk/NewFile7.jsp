<!DOCTYPE HTML>
<html>
  <head>
    <style>
      body {
        margin: 0px;
        padding: 0px;
      }
    </style>
  </head>
  <body>
    <canvas id="myCanvas" width="578" height="400"></canvas>
    <script>
      var canvas = document.getElementById('myCanvas');
      var context = canvas.getContext('2d');
      var imageObj = new Image();

      imageObj.onload = function() {
        context.drawImage(imageObj, 69, 50);
      };
    //  imageObj.src = 'http://www.html5canvastutorials.com/demos/assets/darth-vader.jpg';
   // imageObj.src = 'https://www.google.com/search?q=tcs&source=lnms&tbm=isch&sa=X&ei=7r2mUp7RK4e4rgfzt4CYCQ&ved=0CAcQ_AUoAQ&biw=1215&bih=938';
      imageObj.src = 'http://www.html5canvastutorials.com/demos/assets/darth-vader.jpg';
   </script>
  </body>
</html>