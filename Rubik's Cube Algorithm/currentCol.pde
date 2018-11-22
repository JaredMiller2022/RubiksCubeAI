class currentCol extends CubeGraph2D {// class for easy color reference
  int col[] = {222, 222, 222};
  int[][] colorTable;
  currentCol() {
  }

  currentCol( int[] ray) {// constructor for color reference
    col[0]=int(ray[0]);
    col[1]=int(ray[1]);
    col[2]=int(ray[2]);
  }
}