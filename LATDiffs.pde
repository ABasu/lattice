class LATDiffs{
  
  // Difference histogram co-ordinates
  int X_OFFSET;
  int Y_OFFSET;
  int X_SIZE;
  int Y_SIZE;
  int BORDER;
  int HISTOGRAM_BAR_WIDTH;
  int HISTOGRAM_BAR_MAX_HEIGHT;
  
  // Difference histogram colors - matched with the LATPair colors
  color TEXT1 = color(150, 0, 0);
  color TEXT2 = color(0, 0, 180);
  color FOCUS = color(255, 255, 255);

  /*************************************************************************
   Initialize the difference graph screen sizes
  *************************************************************************/
  LATDiffs(int x, int y, int width, int height){
    X_OFFSET = x;
    Y_OFFSET = y;
    X_SIZE = width;
    Y_SIZE = height;
    BORDER = 5;
    HISTOGRAM_BAR_WIDTH = (int)((X_SIZE - (2 * BORDER)) / data.noOfLATs);
    HISTOGRAM_BAR_MAX_HEIGHT = (Y_SIZE - (2 *BORDER));
  }
  
  /*************************************************************************
   Draw Difference graph data and handle mouse
  *************************************************************************/
  void update(){
    float MINDIFF = .05;   // The minimum difference between LAT values to qualify for this graph
    int i = 0, x = 0, y = 0, c = 0;
    int noOfBars = 0;
    int barHeight;
    double maxBar = 0;
    int xoffset = 0;
    
    double[] diffArray;
    int[] diffLATLabelIndex = null;
    
    stroke(FOCUS);
    fill(MODULE_BACKGROUND);
    rect(X_OFFSET, Y_OFFSET, X_SIZE, Y_SIZE);
    
    // If both texts are the same then nothing to draw here  
    if(text1 != text2){  
      // make an array of differences
      diffArray = new double[data.noOfLATs];
      diffLATLabelIndex = new int[data.noOfLATs];
      for(i=0; i < data.noOfLATs; i++){
        if(Math.abs(data.LATGrid[text1][i] - data.LATGrid[text2][i]) > 0.0001){
          diffArray[i] = data.LATGrid[text1][i] - data.LATGrid[text2][i];
          diffLATLabelIndex[i] = i;
        }
      }

      // Bubblesort the arrays
      boolean swapped = true;
      c = data.noOfLATs;
      double tempDiff;
      int tempIndex;
      while(swapped){
        swapped = false;
        for(i = 1; i < c; i++){
          if(Math.abs(diffArray[i-1]) < Math.abs(diffArray[i])){
            tempDiff = diffArray[i];
            diffArray[i] = diffArray[i-1];
            diffArray[i-1] = tempDiff;
            tempIndex = diffLATLabelIndex[i];
            diffLATLabelIndex[i] = diffLATLabelIndex[i-1];
            diffLATLabelIndex[i-1] = tempIndex;
            swapped = true;
          }
        }
        c--;
      }
  
      noOfBars = 1;
      
      while(Math.abs(diffArray[noOfBars]) > MINDIFF){
        noOfBars++;
      }
        
      HISTOGRAM_BAR_WIDTH = (int)((X_SIZE - (2 * BORDER)) / noOfBars);
      xoffset = X_OFFSET + BORDER; 
      maxBar = Math.abs(diffArray[0]);
      
      // draw the histograms
      for(i = 0; i < noOfBars; i++){
        if(diffArray[i] > 0){
          fill(TEXT1);
        }
        else{
          fill(TEXT2);
          diffArray[i] = Math.abs(diffArray[i]);
        }
        if(diffLATLabelIndex[i] == lat)
          fill(FOCUS);
        barHeight = (int)((diffArray[i] / maxBar) * (double)(HISTOGRAM_BAR_MAX_HEIGHT));
        x = xoffset + (i * HISTOGRAM_BAR_WIDTH);
        y = Y_OFFSET + BORDER + HISTOGRAM_BAR_MAX_HEIGHT;
        rect(x, y, HISTOGRAM_BAR_WIDTH, - barHeight);
      }   
      
      // handle the mouseover
      if(
      mouseX > xoffset && 
      mouseX < (xoffset + (HISTOGRAM_BAR_WIDTH * noOfBars)) &&
      mouseY < (Y_OFFSET + Y_SIZE) &&
      mouseY > (Y_OFFSET + BORDER)
      ){
        c = (mouseX - xoffset) / HISTOGRAM_BAR_WIDTH;
        fill(FOCUS);
        barHeight = (int)((diffArray[c] / maxBar) * (double)(HISTOGRAM_BAR_MAX_HEIGHT));
        x = xoffset + (c * HISTOGRAM_BAR_WIDTH);
        y = Y_OFFSET + BORDER + HISTOGRAM_BAR_MAX_HEIGHT;
        rect(x, y, HISTOGRAM_BAR_WIDTH, - barHeight);
        latdiff = diffArray[c];
        lat = diffLATLabelIndex[c];  
      }
    }
  }
}
