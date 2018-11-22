class square extends CubeGraph2D {// class with square info
  int x= 0;
  int y = 0;
  int face = 0;
  int[] col = {222, 222, 222};
  String colr = "";

  square(int x, int y, int face) {//square constructor for info on square
    this.x=x;
    this.y=y;
    this.face=face;
  } 
  square(int x, int y, int face, int[] col) {//square constructor for info on square
    this.x=x;
    this.y=y;
    this.face=face;
    this.col = col;
  }
}