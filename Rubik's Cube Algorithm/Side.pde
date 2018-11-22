public class Side implements IndividualPiece {//the side is an array of pieces that represents each side of the cube

  private Piece[][] pieces = new Piece[3][3];//this is the 2D array of pieces that represents a side
  private final int[][] spots = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};//these are positions that are referenced in some methods to find specific pieces
  //these are row and column identifiers that are referenced in some methods
  private final static String rowCol0 = "AD";//first row(A) and column(D)
  private final static String rowCol1 = "BE";//second row(B) and column(E)
  private final static String rowCol2 = "CF";//third row(C) and column(F)

  public Side(String col) {//if a side is to be completely filled with one color, that color is passed as a parameter
    for (int r = 0; r < pieces.length; r++) {
      for (int c = 0; c < pieces[r].length; c++) {
        pieces[r][c] = new Piece(col);
      }
    }
  }

  public Side(Piece[][] initialSide) {//if a side is created as an array of pieces
    setPieces(initialSide);
  }

  public Piece getPiece(int r, int c) {//get a specific piece from a row and col index
    return pieces[r][c].copy();
  }

  public Piece getPiece(int spot) {//get a specific piece from its assigned position identifier
    int spotR = 0, spotC = 0;
    for (int r = 0; r < spots.length; r++) {
      for (int c = 0; c < spots[r].length; c++) {
        if (spots[r][c] == spot && spotR == 0 && spotC == 0) {
          spotR = r;
          spotC = c;
        }
      }
    }
    return pieces[spotR][spotC].copy();
  }

  public void setPiece(int spot, Piece newPiece) {//set a piece with its position identifier and new Piece
    int spotR = 0, spotC = 0;
    for (int r = 0; r < spots.length; r++) {
      for (int c = 0; c < spots[r].length; c++) {
        if (spots[r][c] == spot && spotR == 0 && spotC == 0) {
          spotR = r;
          spotC = c;
        }
      }
    }
    pieces[spotR][spotC] = newPiece.copy();
  }

  public String whatColor(int row, int col) {//return the color of the piece at the given row and col index
    return(pieces[row][col].getColor());
  }

  public boolean isFullSideColor(String col) {//returns true if the entire side is the color of the passed parameter
    for (Piece[] row : pieces) {
      for (Piece pieceCol : row) {
        if (pieceCol.getColor() != col) return false;
      }
    }
    return true;
  }

  public boolean isSingleColor() {//if the entire side is a single color return true
    int index1 = pieces[0][0].getColorIndex();
    for (Piece[] row : pieces) {
      for (Piece piece : row) {
        if (piece.getColorIndex() != index1) return false;//return false if the color is not the same as the color of the piece at [0,0]
      }
    }
    return true;
  }

  public Piece[][] copySide() {//copys the entire side with new pieces to avoid any call be reference issues
    Piece[][] returnThis = new Piece[3][3];
    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        returnThis[r][c] = pieces[r][c].copy();//fill the returnThis array with new pieces that are copies of the old pieces
      }
    }
    return returnThis;
  }

  public void setPieces(Piece[][] newSide) {//set the entire side with new pieces to avoid any call by reference issues
    for (Piece[] row : newSide) {
      for (Piece piece : row) {
        piece = piece.copy();
      }
    }
    pieces = newSide;
  }

  public Piece[] copyRow(Piece[] copyThis) {//copy an entire row (or col) with new pieces to avoid any call by reference issues
    for (int i = 0; i < 3; i++) {
      copyThis[i] = copyThis[i].copy();
    }
    return copyThis;
  }

  public Piece[] getRow(String rowID) {//return an entire row (ditermined by the passed row identifier)
    int rowNum = findRowColNum(rowID);
    if (rowNum == -1) return null;
    else return copyRow(pieces[rowNum]);
  }

  public void setRow(String rowID, Piece[] newRow) {//set a row from a given row identifier and new row
    int rowNum = findRowColNum(rowID);
    if (rowNum != 1) {
      for (int i = 0; i < 3; i++) {
        pieces[rowNum][i] = newRow[i].copy();
      }
    }
  }

  public Piece[] getCol(String colID) {//return an entire col given by passed column identifier
    Piece[] col = new Piece[3];
    int colNum = findRowColNum(colID);
    if (colNum == -1) return null;
    else {
      for (int i = 0; i < col.length; i++) {
        col[i] = pieces[i][colNum].copy();
      }
      return col;
    }
  }

  public void setCol(String colID, Piece[] newCol) {//set the call with the passed col identifier to the passed new col
    int colNum = findRowColNum(colID);
    if (colNum == -1) return;
    else {
      for (int i = 0; i < pieces.length; i++) {
        pieces[i][colNum] = newCol[i].copy();
      }
    }
  }

  private int findRowColNum(String rowColID) {//return the index of a row or col given its identifier
    if (rowCol0.indexOf(rowColID) > -1) return 0; 
    else if (rowCol1.indexOf(rowColID) > -1) return 1;
    else if (rowCol2.indexOf(rowColID) > -1) return 2;
    else return -1;
  }

  public void resetSide(Side side) {//reset an entire side by replacing each row with a new one
    Piece[] newRow0 = side.getRow("A");
    Piece[] newRow1 = side.getRow("B");
    Piece[] newRow2 = side.getRow("C");
    setRow("A", newRow0);
    setRow("B", newRow1);
    setRow("C", newRow2);
  }

  public void spinSide(boolean clockwise) {//spin the entire side the direction of the passed variable
    if (clockwise) {//rotate matrix clockwise
      for (int r = 0; r < pieces.length / 2; r++) {
        for (int c = r; c < pieces.length-1-r; c++) {
          Piece temp = pieces[r][c].copy();
          pieces[r][c] = pieces[pieces.length-1-c][r].copy();
          pieces[pieces.length-1-c][r] = pieces[pieces.length-1-r][pieces.length-1-c].copy();
          pieces[pieces.length-1-r][pieces.length-1-c] = pieces[c][pieces.length-1-r].copy();
          pieces[c][pieces.length-1-r] = temp;
        }
      }
    } else {//rotate matrix counterclockwise
      for (int r = 0; r < pieces.length / 2; r++) {
        for (int c = r; c < pieces.length-1-r; c++) {
          Piece temp = pieces[r][c].copy();
          pieces[r][c] = pieces[c][pieces.length-1-r].copy();
          pieces[c][pieces.length-1-r] = pieces[pieces.length-1-r][pieces.length-1-c].copy();
          pieces[pieces.length-1-r][pieces.length-1-c] = pieces[pieces.length-1-c][r].copy();
          pieces[pieces.length-1-c][r] = temp;
        }
      }
    }
  }

  public String printPart() {//print the entire side so that it looks like the side of a Rubik's Cube
    return("-------------\n" + 
      "| " + pieces[0][0].printPart() + " | " + pieces[0][1].printPart() + " | " + pieces[0][2].printPart() + " |\n" +
      "-------------\n" + 
      "| " + pieces[1][0].printPart() + " | " + pieces[1][1].printPart() + " | " + pieces[1][2].printPart() + " |\n" +
      "-------------\n" + 
      "| " + pieces[2][0].printPart() + " | " + pieces[2][1].printPart() + " | " + pieces[2][2].printPart() + " |\n" +
      "-------------");
  }
}