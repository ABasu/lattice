class Heatmap{
  
  // Heatmap colors
  color MAX = color(50, 0, 0);
  color MIN = color(255, 220, 220);
  color FOCUS = color(255, 255, 0);
  
  // Heatmap co-ordinates
  int X_OFFSET;
  int Y_OFFSET;
  int X_SIZE;
  int Y_SIZE;
  int BORDER;
  int X_BOXSIZE;
  int Y_BOXSIZE;

  /*************************************************************************
   Sets the screen size parameters for heatmaps
  **************************************************************************/
  Heatmap(int x, int y, int width, int height){
    X_OFFSET = x;
    Y_OFFSET = y;
    BORDER = 5;
    X_BOXSIZE = (int) ((width - 2 * BORDER) / data.noOfTexts);
    Y_BOXSIZE = (int) ((height - 2 * BORDER) / data.noOfTexts);
    X_SIZE = (BORDER * 2) + (data.noOfTexts * X_BOXSIZE);
    Y_SIZE = (BORDER * 2)+ (data.noOfTexts * Y_BOXSIZE);
  }
  
  /*************************************************************************
   Draw the heatmap and handle mouseovers
  **************************************************************************/
  void update(){
    int r, c;
    int x, y;
    double percent;
    color col;
  
    fill(MODULE_BACKGROUND);
    noStroke();
    rect(X_OFFSET, Y_OFFSET, X_SIZE, Y_SIZE);
    
    for(r = 0; r < data.noOfTexts; r++){
      for(c = 0; c < data.noOfTexts; c++){
        if(data.distanceGrid[r][c] == 0){
          col = MODULE_BACKGROUND;
        }
        else{
          percent = (data.distanceGrid[r][c] - data.minDistance) / (data.maxDistance - data.minDistance);
          col = lerpColor(MAX, MIN, (float)percent, HSB);
        }
        fill(col);
        x = (X_OFFSET + BORDER) + (c * X_BOXSIZE);
        y = (Y_OFFSET + Y_SIZE - BORDER) - (r * Y_BOXSIZE);
        rect(x, y, X_BOXSIZE, -Y_BOXSIZE);
      }
    }
    
    if(
    mouseX > (X_OFFSET + BORDER) && 
    mouseX < (X_OFFSET + BORDER + (X_BOXSIZE * data.noOfTexts)) &&
    mouseY < (Y_OFFSET + Y_SIZE) &&
    mouseY > (Y_OFFSET + Y_SIZE) - (Y_BOXSIZE * data.noOfTexts)
    ){
      c = (mouseX - (X_OFFSET + BORDER)) / X_BOXSIZE;
      r = -1 * (mouseY - (Y_OFFSET + Y_SIZE)) / Y_BOXSIZE;
      if(lockTextPair == true){
        r = text1;
        c = text2;
      }
  
      x = (X_OFFSET + BORDER) + (c * X_BOXSIZE);
      y = (Y_OFFSET + Y_SIZE - BORDER) - (r * Y_BOXSIZE);
      fill(FOCUS);
      rect(x, y, X_BOXSIZE, -Y_BOXSIZE);
      text1 = r;
      text2 = c;
    }
  }
}
