public class Turn implements IndividualPiece {//this represents each and every turn in the algorithm
  final String[] turnPositions = {"Top", "Front", "Bottom", "Back", "Left", "Right", "Cube"}; //the possibe faces that can be turned
  private String face;//a face from the turnPositions array
  private int faceIndex; //the index of the face in the turnPositions array
  private String clock;//the string version of direction (clowise or counter-clockwise)
  private boolean direction;//true is clockwise, false is counter clockwise
  private int ID;//will be used to send algorithm to graphics

  public Turn(String face, boolean direction) {
    //sets all of the class variables based off of what the algorithm inputs as the turn
    this.face = face;
    for (int i = 0; i < turnPositions.length; i++) {//assigns turn based on turnPositions array and passed value
      if (face == turnPositions[i]) {
        faceIndex = i;
      }
    }
    this.direction = direction;//set direction class variables
    if (direction == true) clock = "clockwise";//set class variables to string forms of the direction
    else if (direction == false) clock = "counter-clockwise";
    switch(faceIndex) {//the switch statement creates ID references for each turn of the cube
    case 0:
      if (direction) ID = 7;
      else ID = 1;
      break;
    case 1:
      if (direction) ID = 9;
      else ID = 3;
      break;
    case 2:
      if (direction) ID = 2;
      else ID = 8;
      break;
    case 3:
      if (direction) ID = 4;
      else ID = 10;
      break;
    case 4:
      if (direction) ID = 5;
      else ID = 11;
      break;
    case 5:
      if (direction) ID = 6;
      else ID = 12;
      break;
    case 6:
      ID = 13;
      break;
    }
  }

  public int getID() {//give ID
    return ID;
  }

  public String getFace() {//gets face
    return face;
  }

  public int getFaceIndex() {//gets face index
    return faceIndex;
  }

  public String getClock() {//gets string form of direction
    return clock;
  }

  public boolean getDirection() {//true is clockwise, false is counter-clockwise
    return direction;
  }

  public boolean equals(Turn other) {//true if the turns are equal, false if they are not
    return (other.getFaceIndex() == faceIndex && other.getDirection() == direction);
  }

  public boolean isOpposite(Turn other) {//true if same face but different direction, false otherwise
    return (other.getFaceIndex() == faceIndex && other.getDirection() != direction);
  }

  public String printPart() {//prints the face and then the direction as a String (clock)
    return face + " " + clock + "\n";
  }
}