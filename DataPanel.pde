class DataPanel{
  
  // The panel co-ordinates
  int X_OFFSET;
  int Y_OFFSET;
  int X_SIZE;
  int Y_SIZE;
  int BORDER;
  
  // Colors - borrowed from the LATPairs panel
  color TEXT1 = lerpColor(latpairs.TEXT1, color(255,255,255), .5);
  color TEXT2 = lerpColor(latpairs.TEXT2, color(255,255,255), .5);
  color C = latpairs.FOCUS;
  
  PFont font = loadFont("Courier-24.vlw");
  DecimalFormat latformat = new DecimalFormat("##.###");

  // give each bit of text it's own object
  TextBox textlabel1;
  TextBox textlabel2;
  TextBox latlabel;
  TextBox latvalue1;
  TextBox latvalue2;
  TextBox latdiffvalue;
  
  DataPanel(int x, int y, int width, int height){
    X_OFFSET = x;
    Y_OFFSET = y;
    X_SIZE = width;
    Y_SIZE = height;
    BORDER = 2;
    
    int textheight = (int)(textAscent() + textDescent());

    textlabel1 = new TextBox(X_OFFSET + 10, Y_OFFSET + BORDER, X_SIZE / 2, textheight);
    textlabel2 = new TextBox(X_OFFSET + 10, Y_OFFSET + BORDER * 2 + textheight, X_SIZE / 2, textheight);
    latlabel = new TextBox(X_OFFSET + 10, Y_OFFSET + BORDER * 2 + textheight * 2, X_SIZE / 2, textheight);
    latvalue1 = new TextBox(X_OFFSET + X_SIZE / 2, Y_OFFSET + BORDER, X_SIZE / 2, textheight);
    latvalue2 = new TextBox(X_OFFSET + X_SIZE / 2, Y_OFFSET + BORDER * 2 + textheight, X_SIZE / 2, textheight);
    latdiffvalue = new TextBox(X_OFFSET + X_SIZE / 2, Y_OFFSET + BORDER * 2 + textheight * 2, X_SIZE / 2, textheight);
    
  }
  
  void update(){
    fill(MODULE_BACKGROUND);
    rect(X_OFFSET, Y_OFFSET, X_SIZE, Y_SIZE);
    textlabel1.write(data.textLabels[text1], LEFT, TEXT1);
    textlabel2.write(data.textLabels[text2], LEFT, TEXT2);
    if(lockTextPair){
      latvalue1.write("LAT1 value: " + data.LATGrid[text1][lat], LEFT, C);
      latvalue2.write("LAT2 value: " + data.LATGrid[text2][lat], LEFT, C);
      latlabel.write("LAT: " + data.LATLabels[lat], LEFT, C);
      latdiffvalue.write("Difference: " + latformat.format(latdiff), LEFT, C);
    }
  }
  
}
