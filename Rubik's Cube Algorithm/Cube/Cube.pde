class Cube implements IndividualPiece{//this will create the cube that the algorithm uses to solve
  
  public final String[] colors = {"White","Blue","Yellow","Green","Red","Orange"};//the colors in order of the sides  in the sides array
  final String[] sidePositions = {"Top", "Front", "Bottom", "Back", "Left", "Right"};//the order of sides that optipizes turnning efficiency
  public Side[] sides = new Side[6];//these six sides make up the actual cube
  private ArrayList algorithm = new ArrayList<Turn>();  //this arrayList will keep track of the algorithm
  
  public Cube(boolean classic){//true means fill completed cube, false means to scramble the cube randomly
    if(classic){
      //Fill solved Rubik's Cube 
      fillSolvedCube();
    } else{
        //first fill solved cube
        fillSolvedCube();
        //then mix up cube with 20 non-repeating moves
        scrambleCube();
        //then erase the algorithm arrayList so that those 20 moves do not appear as part of the solution
        algorithm.clear();
    }
  }
  
  public Cube(Side top, Side front, Side bottom, Side back, Side left, Side right){//create a new cube given six sides
    //set each side to the cube
    sides[0] = top;
    sides[1] = front;
    sides[2] = bottom;
    sides[3] = back;
    sides[4] = left;
    sides[5] = right;
  }
  
  public Cube(Piece[][] top, Piece[][] front, Piece[][] bottom, Piece[][] back, Piece[][] left, Piece[][] right){//create a new cube from six arrays of pieces
    //create a side from each 2D array and set the cube with them
    sides[0] = new Side(top);
    sides[1] = new Side(front);
    sides[2] = new Side(bottom);
    sides[3] = new Side(back);
    sides[4] = new Side(left);
    sides[5] = new Side(right);
  }
  
  public boolean isComplete(){
    for(Side side: sides){
      if(!side.isSingleColor()) return false;
    }
    return true;
  }
  
  public void addToAlg(Turn turn){//adds a new turn to the algorithm
    algorithm.add(turn);
  }
  
  public ArrayList getAlgorithm(){//returns the algorithm as an arrayList of Turns
    return algorithm;
  }
  
  public void fillSolvedCube(){//creates a classically filled cube
    for(int i = 0; i < colors.length; i++){
      sides[i] = new Side(colors[i]);
    }
  }
  
  public void scrambleCube(){//mix up cube with 20 non-repeating moves
    int remainingScrambles = 20;
    int lastMove = 0;
    while(remainingScrambles > 0){//will do 20 random moves
      boolean direction = random(1) > 0.5;//randomizes turn selection 
      int makeMove = int(random(0,5));
      if(makeMove == lastMove){
        makeMove--;
        if(makeMove == -1) makeMove = 5;
      }      
      switch(makeMove){//executes the random turn selected above
        case 0:
          turnTop(direction);
          break;
        case 1:
          turnFront(direction);
          break;
        case 2:
          turnBottom(direction);
          break;
        case 3:
          turnBack(direction);
          break;
        case 4:
          turnLeft(direction);
          break;
        case 5:
          turnRight(direction);
          break;
      }
      lastMove = makeMove;
      remainingScrambles--;
    }
  }
  
  public void turnTopAssistant(boolean direction){//a class used as an assistant for all turns
    sides[0].spinSide(direction);
    if(direction){//turn top clockwise
      Piece[] temp = new Piece[3];
      for(int i = 0; i < 3; i++) temp[i] = new Piece(sides[1].getPiece(0,i).getColor());
      sides[1].setRow("A", sides[5].getRow("A"));
      sides[5].setRow("A", sides[3].getRow("A"));
      sides[3].setRow("A", sides[4].getRow("A"));
      sides[4].setRow("A", temp);
    } else{//turn top counter-clockwise
      Piece[] temp = new Piece[3];
      for(int i = 0; i < 3; i++) temp[i] = new Piece(sides[1].getPiece(0,i).getColor());
      sides[1].setRow("A", sides[4].getRow("A"));
      sides[4].setRow("A", sides[3].getRow("A"));
      sides[3].setRow("A", sides[5].getRow("A"));
      sides[5].setRow("A", temp);
    }
  }
  
  public void spinFrontTopBackBottom(){//spins the entire cube so that the front becomes the top, the top becomes the back...
    //set temp to the initial top
    Side temp = new Side(sides[0].copySide());
    //move front to top
    sides[0].setPieces(sides[1].copySide());
    //move bottom to front
    sides[1].setPieces(sides[2].copySide());
    //move back to bottom
    sides[2].setPieces(sides[3].copySide());
    sides[2].spinSide(false);
    sides[2].spinSide(false);
    //move initial top to back
    sides[3].setPieces(temp.copySide());
    sides[3].spinSide(true);
    sides[3].spinSide(true);
    //spin right clockwise
    sides[5].spinSide(true);
    //spin left counterclockwise
    sides[4].spinSide(false);
  }
  
  public void spinRightTopLeftBottom(){//spins the entire cube so that the right becomes the top, the top becomes the left...
    //set temp to the initial top
    Side temp = new Side(sides[0].copySide());
    //move right to top
    sides[0] = new Side(sides[5].copySide());
    sides[0].spinSide(false);
    //move bottom to right
    sides[5] = new Side(sides[2].copySide());
    sides[5].spinSide(false);
    //move left to bottom
    sides[2] = new Side(sides[4].copySide());
    sides[2].spinSide(false);
    //move initial top to left
    sides[4] = temp;
    sides[4].spinSide(false);
    //spin front counter clockwise
    sides[1].spinSide(false);
    //spin back clockwise
    sides[3].spinSide(true);
  }
  
  //for all turns, if the direction parameter is true it turns clockwise, if false it turns counter-clockwise
  
  public void turnTop(boolean direction){//spins the top and then turns the adjacent rows from each side
    algorithm.add(new Turn("Top", direction));//adds turn to algorithm ArrayList
    turnTopAssistant(direction);
  }
  
  public void turnFront(boolean direction){//turns the front to the top, spins the top, and turns the top back to the front
    algorithm.add(new Turn("Front", direction));//adds turn to algorithm ArrayList
    //spin cube so current fornt becomes top
    for(int i = 0; i < 1; i++){
      spinFrontTopBackBottom();
    }
    //turn top
    turnTopAssistant(direction);
    //spin cube back to origional position
    for(int i = 0; i < 3; i++){
      spinFrontTopBackBottom();
    }
  }
  
  public void turnBottom(boolean direction){//turns the bottom to the top, turns the top, turns the top back to the bottom
    algorithm.add(new Turn("Bottom", direction));//adds turn to algorithm ArrayList
    //spin cube so current bottom becomes top
    for(int i = 0; i < 2; i++){
      spinRightTopLeftBottom();
    }
    //turn top
    turnTopAssistant(direction);
    //spin cube back to origional position
    for(int i = 0; i < 2; i++){
      spinRightTopLeftBottom();
    }
  }
  
  public void turnBack(boolean direction){//thrns the back to the top, turns the top, tutns the top back to the back
    algorithm.add(new Turn("Back", direction));//adds turn to algorithm ArrayList
    //spin cube so current back becomes top
    for(int i = 0; i < 3; i++){
      spinFrontTopBackBottom();
    }
    //turn top
    turnTopAssistant(direction);
    //spin cube back to origional position
    for(int i = 0; i < 1; i++){
      spinFrontTopBackBottom();
    }
  }
  
  public void turnLeft(boolean direction){//turns the left to the top, turns the left, turns the top back to the left
    algorithm.add(new Turn("Left", direction));//adds turn to algorithm ArrayList
    //spin cube so current left becomes top
    for(int i = 0; i < 3; i++){
      spinRightTopLeftBottom();
    }
    //turn top
    turnTopAssistant(direction);
    //spin cube back to origional position
    for(int i = 0; i < 1; i++){
      spinRightTopLeftBottom();
    }
  }
  
  public void turnRight(boolean direction){//turns the right to the top, turns the top, turns the top back to the right
    algorithm.add(new Turn("Right", direction));//adds turn to algorithm ArrayList
    //spin cube so current left becomes top
    for(int i = 0; i < 1; i++){
      spinRightTopLeftBottom();
    }
    //turn top
    turnTopAssistant(direction);
    //spin cube back to origional position
    for(int i = 0; i < 3; i++){
      spinRightTopLeftBottom();
    }
  }
  
  public boolean isPiece(String colorOne, String side, int row, int col){//returns true if the piece on the side at the given row and column is the given color
    int sideNum = 0;
    switch(side){//sets the correct side number
      case "Top":
        sideNum = 0;
        break;
      case "Front":
        sideNum = 1;
        break;
      case "Bottom":
        sideNum = 2;
        break;
      case "Back":
        sideNum = 3;
        break;
      case "Left":
        sideNum = 4;
        break;
      case "Right":
        sideNum = 5;
        break;
    }
    return(colorOne == sides[sideNum].whatColor(row, col));//return if the color of the piece at the given spot is the same color as the parameter
  }
   
  public String printPart() {//prints each side with a label for it
    String cube = "";
    for(int i = 0; i < 6; i++){//adds each side to the cube string
      cube += (sidePositions[i] + ":\n" + sides[i].printPart() + "\n");
    }
    return cube;
  }
 
}