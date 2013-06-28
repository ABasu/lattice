class BoxPlot {

  //Co-ordinates
  int X_OFFSET;
  int Y_OFFSET;
  int X_SIZE;
  int Y_SIZE;
  int BORDER;
  
  int HEIGHT;
  int SELECT_HEIGHT;
  int SPACING = 3;
  int X_SCALE;
  
  int selected = 0;
  
  color C = lerpColor(latpairs.FOCUS, color(0, 0, 0), .5);

  /*************************************************************************
   Initialize the panel
  *************************************************************************/
  BoxPlot(int x, int y, int width, int height){
    X_OFFSET = x;
    Y_OFFSET = y;
    X_SIZE = width;
    Y_SIZE = height;
    BORDER = 10;
    
    SELECT_HEIGHT = (int)(Y_SIZE * .02);
    HEIGHT = (int)((height - (SELECT_HEIGHT + SPACING)) / data.noOfLATs) - SPACING;
    X_SCALE = X_SIZE - 2 * BORDER;

  }

  /*************************************************************************
   Update the panel
  *************************************************************************/
  void update(){
    int r, x, y, h;
    
    stroke(BACKGROUND);
    fill(MODULE_BACKGROUND);
    rect(X_OFFSET, Y_OFFSET, X_SIZE, Y_SIZE);
    ellipseMode(CENTER);
    
    stroke(latpairs.FOCUS);
    noFill();
    for(r = 0; r < lat; r++){
      y = Y_OFFSET + BORDER + r * (HEIGHT + SPACING);
      drawBoxPlot(r, y, HEIGHT);      
    }
    //lat == r
    y = Y_OFFSET + BORDER + lat * (HEIGHT + SPACING);
    drawBoxPlot(r, y, SELECT_HEIGHT);
    noStroke();
    fill(latpairs.FOCUS, 40);
    rect(X_OFFSET, y - SPACING, X_SIZE, SELECT_HEIGHT + 2 * SPACING);

    x = X_OFFSET + BORDER + getXcood(data.LATGrid[text1][r]);
    fill(latpairs.TEXT1);
    ellipse(x, y + SELECT_HEIGHT / 2, 2 * HEIGHT, 2 * HEIGHT);
    x = X_OFFSET + BORDER + getXcood(data.LATGrid[text2][r]);
    stroke(latpairs.TEXT2);
    fill(latpairs.TEXT2);
    ellipse(x, y + SELECT_HEIGHT / 2, 2 * HEIGHT, 2 * HEIGHT);

    stroke(latpairs.FOCUS);
    noFill();
    
    // after the selected lat
    for(r = lat + 1; r < data.noOfLATs; r++){
      y = Y_OFFSET + BORDER + (r - 1) * (HEIGHT + SPACING) + (SELECT_HEIGHT + SPACING);
      drawBoxPlot(r, y, HEIGHT);      
    }   
    
    handleMouse();
  }

  /*************************************************************************
   Calculate X for each boxplot
  *************************************************************************/
  int getXcood(double val){
    return((int)((X_SCALE / data.maxValue) * val));
  }  
  
  /*************************************************************************
   Mouse handler
  *************************************************************************/  
  void handleMouse(){
   if(
    mouseX > (X_OFFSET) && 
    mouseX < (X_OFFSET + X_SIZE) &&
    mouseY < (Y_OFFSET + BORDER + data.noOfLATs * (HEIGHT + SPACING)) &&
    mouseY > (Y_OFFSET + BORDER)
    ){
      if((mouseY - Y_OFFSET - BORDER) < (HEIGHT + SPACING) * lat){
        lat = (mouseY - Y_OFFSET - BORDER) / (HEIGHT + SPACING);
      } else if ((mouseY - Y_OFFSET - BORDER) < (HEIGHT + SPACING) * lat + SELECT_HEIGHT + SPACING) {
        lat = lat;
      } else if((mouseY - Y_OFFSET - BORDER) >= (HEIGHT + SPACING) * lat + SELECT_HEIGHT + SPACING) {
        lat = (mouseY - Y_OFFSET - BORDER) / (HEIGHT + SPACING);
      }
        
    }
  }
  
  /*************************************************************************
   Draw the plot
  *************************************************************************/
  void drawBoxPlot(int r, int y, int height){
      int x, x1;
      //min
      x = X_OFFSET + BORDER + getXcood(data.boxPlotMetrics[r][0]);
      rect(x, y, 0, height);
      //max
      x1 = X_OFFSET + BORDER + getXcood(data.boxPlotMetrics[r][4]);
      line(x, y + height / 2, x1, y + height / 2);
      rect(x1, y, 0, height);
      // box
      fill(C);
      x = X_OFFSET + BORDER + getXcood(data.boxPlotMetrics[r][1]);
      x1 = X_OFFSET + BORDER + getXcood(data.boxPlotMetrics[r][3]);
      rect(x, y, x1 - x, height);
      // median
      noFill();
      x = X_OFFSET + BORDER + getXcood(data.boxPlotMetrics[r][2]);
      rect(x, y, 0, height);
  }

}
