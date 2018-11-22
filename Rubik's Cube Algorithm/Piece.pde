public class Piece implements IndividualPiece {//the Piece makes up each color on the side of the cube

  public final String[] colors = {"White", "Blue", "Yellow", "Green", "Red", "Orange"};//the possible piece colors
  public final String[] cols = {"W", "B", "Y", "G", "R", "O"};//abreviations for each color
  private int colorIndex;//the index of the color in the colors and cols arrays

  public Piece(int colorValue) {//create a new piece given the index of the color in the array
    colorIndex = colorValue;
  }

  public Piece(String col) {//create a new piece given the color of it
    for (int i = 0; i < colors.length; i++) {
      if (colors[i].equals(col)) {
        colorIndex = i;
        return;
      }
    }
  }

  public Piece copy() {//create a new copy of the piece in order to avoid any call by reference issues
    return new Piece(getColorIndex());
  }

  public String getColor() {//return the color (in string form) of the piece
    return colors[colorIndex];
  }

  public int getColorIndex() {//return the index of the colors in the arrays
    return colorIndex;
  }

  public boolean equals(Piece other) {//returns true if the two pieces have the same color, false otherwise
    return(colorIndex == other.getColorIndex());
  }

  public String printPart() {//print the abreviation (in the cols array) of the color
    return cols[colorIndex];
  }
}