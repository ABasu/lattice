import java.text.*;

// Environment height adjustment to take care of any menus on the Mac etc.
int WINDOW_HEIGHT = screen.height - 75;
int WINDOW_WIDTH = screen.width;
color BACKGROUND = color(190, 190, 190);
color MODULE_BACKGROUND = color(40, 40, 40);

// Current text pair
int text1 = 0;
int text2 = 0;
int lat = 0;
double latdiff = 0;
boolean lockTextPair = false;

// The panels
Data data;
Heatmap heatmap;
Heatmap locked_heatmap;
LATPairs latpairs;
LATDiffs latdiffs;
DataPanel datapanel;
ScatterPlot locked_scatterplot;
ScatterPlot scatterplot;
BoxPlot boxplot;



/*************************************************************************
 The main setup functions - runs once
 *************************************************************************/
void setup(){
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  data = new Data();
    heatmap = new Heatmap(2, 2, WINDOW_HEIGHT, WINDOW_HEIGHT);
    latpairs = new LATPairs(heatmap.X_SIZE + 4, 2, WINDOW_WIDTH - (heatmap.X_SIZE + 4) - 2, WINDOW_HEIGHT / 2);
    datapanel = new DataPanel(latpairs.X_OFFSET, latpairs.Y_OFFSET + latpairs.Y_SIZE + 2, latpairs.X_SIZE, (int)((textAscent() + textDescent()) * 3 + 10)); 
    latdiffs = new LATDiffs(datapanel.X_OFFSET, datapanel.Y_OFFSET + datapanel.Y_SIZE + 2, latpairs.X_SIZE, WINDOW_HEIGHT - (datapanel.Y_OFFSET + datapanel.Y_SIZE + 2) - 2);
    scatterplot = new ScatterPlot(latpairs.X_OFFSET + latpairs.X_SIZE/2, datapanel.Y_OFFSET, WINDOW_WIDTH - (latpairs.X_OFFSET + latpairs.X_SIZE/2) - 2, WINDOW_WIDTH - (latpairs.X_OFFSET + latpairs.X_SIZE/2) - 2);

    locked_heatmap = new Heatmap(2, 2, heatmap.X_SIZE / 2, heatmap.X_SIZE / 2);
    locked_scatterplot = new ScatterPlot(2, locked_heatmap.Y_OFFSET + locked_heatmap.Y_SIZE + 2, locked_heatmap.X_SIZE, locked_heatmap.Y_SIZE);
    boxplot = new BoxPlot(locked_heatmap.X_OFFSET + locked_heatmap.X_SIZE + 2, 2, heatmap.X_SIZE - locked_heatmap.X_SIZE -2, WINDOW_HEIGHT - 4);
}

/*************************************************************************
 The main draw function - loops
 *************************************************************************/
void draw(){
  fill(BACKGROUND);
  rect(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
  latpairs.update();
  latdiffs.update();
  datapanel.update();
  if(lockTextPair){
    locked_scatterplot.update();
    locked_heatmap.update();
    boxplot.update();
  } else{
    heatmap.update();
    scatterplot.update();
  }
}

/*************************************************************************
 Mouse clicks
 *************************************************************************/
void mouseClicked(){
  if(lockTextPair == true)
    lockTextPair = false;
  else
    lockTextPair = true;
}

