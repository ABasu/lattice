class ScatterPlot{
  
  //Co-ordinates
  int X_OFFSET;
  int Y_OFFSET;
  int X_SIZE;
  int Y_SIZE;
  int BORDER;
  int DOT_SIZE;
  
  color C = latpairs.FOCUS;

  /*************************************************************************
   Initialize the panel
  *************************************************************************/
  ScatterPlot(int x, int y, int width, int height){
    X_OFFSET = x;
    Y_OFFSET = y;
    X_SIZE = width;
    Y_SIZE = height;
    DOT_SIZE = X_SIZE / 25;
    BORDER = DOT_SIZE + 5;
  }
  
  /*************************************************************************
   Update panel
  *************************************************************************/
  void update(){
    int i, x, y;
    double maxValue = latpairs.maxValue;
    int[][] latcoods = new int[data.noOfLATs][2];
  
    ellipseMode(CORNER);
    stroke(BACKGROUND);
    fill(MODULE_BACKGROUND);
    rect(X_OFFSET, Y_OFFSET, X_SIZE, Y_SIZE);
  
    // draw the scatterplot
    for(i = 0; i < data.noOfLATs; i++){
      latcoods[i][0] = (int)((data.LATGrid[text1][i] / maxValue) * (X_SIZE - BORDER * 2));
      latcoods[i][1] = (int)((data.LATGrid[text2][i] / maxValue) * (Y_SIZE - BORDER * 2));
      if(latcoods[i][0] > latcoods[i][1]){
        stroke(latpairs.FOCUS);
        fill(latpairs.TEXT1);
      }
      else if (latcoods[i][0] < latcoods[i][1]){
        stroke(latpairs.FOCUS);
        fill(latpairs.TEXT2);
      }
      else if (latcoods[i][0] == latcoods[i][1]){
        stroke(latpairs.FOCUS);
        fill(lerpColor(latpairs.FOCUS, color(0, 0, 0), .5));
      }

      ellipse(X_OFFSET + BORDER + latcoods[i][0], Y_OFFSET + Y_SIZE - BORDER - latcoods[i][1], DOT_SIZE, - DOT_SIZE);
    }
    
    if(
    mouseX > (X_OFFSET) && 
    mouseX < (X_OFFSET + X_SIZE) &&
    mouseY < (Y_OFFSET + Y_SIZE) &&
    mouseY > (Y_OFFSET)
    ){
      for(i = 0; i < data.noOfLATs; i++){
        if(
        mouseX > (X_OFFSET + BORDER + latcoods[i][0]) && 
        mouseX < (X_OFFSET + BORDER + latcoods[i][0] + DOT_SIZE) &&
        mouseY < (Y_OFFSET + Y_SIZE - BORDER - latcoods[i][1]) && 
        mouseY > (Y_OFFSET + Y_SIZE - BORDER - latcoods[i][1] - DOT_SIZE)
        ){
          fill(latpairs.FOCUS);
          ellipse(X_OFFSET + BORDER + latcoods[i][0], Y_OFFSET + Y_SIZE - BORDER - latcoods[i][1], DOT_SIZE, - DOT_SIZE);
          lat = i;
          break;
        }
      }
    }
    fill(latpairs.FOCUS);
    ellipse(X_OFFSET + BORDER + latcoods[lat][0], Y_OFFSET + Y_SIZE - BORDER - latcoods[lat][1], DOT_SIZE, - DOT_SIZE);
    latdiff = Math.abs(data.LATGrid[text1][lat] - data.LATGrid[text2][lat]);

  }
}
