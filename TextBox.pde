class TextBox{
  
  //Co-ordinates
  int X_OFFSET;
  int Y_OFFSET;
  int X_SIZE;
  int Y_SIZE;

  // Constructor
  TextBox(int x, int y, int width, int height){
    X_OFFSET = x;
    Y_OFFSET = y;
    X_SIZE = width;
    Y_SIZE = height;
  }
  
  //Write the text
  void write(String text, int align, color col){
    fill(col);
    textAlign(align);
    text(text, X_OFFSET, Y_OFFSET, X_SIZE, Y_SIZE);
  }
}
