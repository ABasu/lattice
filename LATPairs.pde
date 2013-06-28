class LATPairs{
  
  // Pair histogram colors
  color TEXT1 = color(150, 0, 0);
  color TEXT2 = color(0, 0, 180);
  color FOCUS = color(255, 255, 255);

  // Pair histogram co-ordinates
  int X_OFFSET;
  int Y_OFFSET;
  int X_SIZE;
  int Y_SIZE;
  int BORDER;
  int HISTOGRAM_BAR_WIDTH;
  int HISTOGRAM_BAR_MAX_HEIGHT;
  
  // The maximum value in the LAT air - also used by other panels like the scatterplot
  double maxValue = 0;

  
  /*************************************************************************
   Initialize the pair comparison graph screen sizes
  *************************************************************************/
  LATPairs(int x, int y, int width, int height){
    X_OFFSET = x;
    Y_OFFSET = y;
    X_SIZE = width;
    Y_SIZE = height;
    BORDER = 10;
    HISTOGRAM_BAR_WIDTH = (int)((X_SIZE /*- (2 * BORDER)*/) / data.noOfLATs);     // Ignore the X-axis border - that will come from the rounding errors for the width
    HISTOGRAM_BAR_MAX_HEIGHT = (Y_SIZE - (2 * BORDER)) / 2;
  }
    
    
  /*************************************************************************
   Draw pair graph data and handle mouse
  *************************************************************************/
  void update(){
    int i, x, y, c;
    int barHeight;
    int xoffset = X_OFFSET + ((X_SIZE - (data.noOfLATs * HISTOGRAM_BAR_WIDTH)) / 2);
  
    fill(MODULE_BACKGROUND);
    rect(X_OFFSET, Y_OFFSET, X_SIZE, Y_SIZE);
    stroke(FOCUS);  
    
    // find out the maximum LAT value
    for(i = 0; i < data.noOfLATs; i++){
      if(data.LATGrid[text1][i] > maxValue)
        maxValue = data.LATGrid[text1][i];
      if(data.LATGrid[text2][i] > maxValue)
        maxValue = data.LATGrid[text2][i];
    }
    
    // draw the histograms
    for(i = 0; i < data.noOfLATs; i++){
      fill(TEXT1);
      if(i == lat)
        fill(FOCUS);
      barHeight = (int)((data.LATGrid[text1][i] / maxValue) * (double)(HISTOGRAM_BAR_MAX_HEIGHT));
      x = xoffset + (i * HISTOGRAM_BAR_WIDTH);
      y = Y_OFFSET + BORDER + HISTOGRAM_BAR_MAX_HEIGHT;
      rect(x, y, HISTOGRAM_BAR_WIDTH, - barHeight);
  
      fill(TEXT2);
      if(i == lat)
        fill(FOCUS);
      barHeight = (int)((data.LATGrid[text2][i] / maxValue) * (double)(HISTOGRAM_BAR_MAX_HEIGHT));
      x = xoffset + (i * HISTOGRAM_BAR_WIDTH);
      y = Y_OFFSET + BORDER + HISTOGRAM_BAR_MAX_HEIGHT;
      rect(x, y, HISTOGRAM_BAR_WIDTH, barHeight);
    }
    
    if(
    mouseX > xoffset && 
    mouseX < (xoffset + (HISTOGRAM_BAR_WIDTH * data.noOfLATs)) &&
    mouseY < (Y_OFFSET + Y_SIZE) &&
    mouseY > (Y_OFFSET + BORDER)
    ){
      lat = (mouseX - xoffset) / HISTOGRAM_BAR_WIDTH;
      fill(FOCUS);
      barHeight = (int)((data.LATGrid[text1][lat] / maxValue) * (double)(HISTOGRAM_BAR_MAX_HEIGHT));
      x = xoffset + (lat * HISTOGRAM_BAR_WIDTH);
      y = Y_OFFSET + BORDER + HISTOGRAM_BAR_MAX_HEIGHT;
      rect(x, y, HISTOGRAM_BAR_WIDTH, - barHeight);
  
      barHeight = (int)((data.LATGrid[text2][lat] / maxValue) * (double)(HISTOGRAM_BAR_MAX_HEIGHT));
      x = xoffset + (lat * HISTOGRAM_BAR_WIDTH);
      y = Y_OFFSET + BORDER + HISTOGRAM_BAR_MAX_HEIGHT;
      rect(x, y, HISTOGRAM_BAR_WIDTH, barHeight);
      
      latdiff = Math.abs(data.LATGrid[text1][lat] - data.LATGrid[text2][lat]);
    }
  } 
}
