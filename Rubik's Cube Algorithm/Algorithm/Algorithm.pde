public class Algorithm {

  private Cube cube;//this is the cube that will be solved
  public int codeTime;
  public ArrayList<Turn> algorithm = new ArrayList();

  public Algorithm(Cube newCube) {//assigns an already made cube to the cube
    cube = newCube;
    initiateAlgorithm();
  }

  public Algorithm(boolean classic) {//creates a fully solved(true) or scrabled(false) cube
    cube = new Cube(classic);
    initiateAlgorithm();
  }

  public Algorithm(Side side0, Side side1, Side side2, Side side3, Side side4, Side side5) {//sets the cube to the six given sides
    cube = new Cube(side0, side1, side2, side3, side4, side5);
    initiateAlgorithm();
  }

  public Algorithm(Piece[][] side0, Piece[][] side1, Piece[][] side2, Piece[][] side3, Piece[][] side4, Piece[][] side5) {//sets the cube to the six given Piece arrays
    cube = new Cube(side0, side1, side2, side3, side4, side5);
    initiateAlgorithm();
  }

  public void initiateAlgorithm() {
    int startTime = millis();
    runAlgorithm();
    int endTime = millis();
    codeTime = endTime - startTime;

    //optimize and print the algorithm
    //String algString = "";
    algorithm = getAlgorithm();
    //for(int i = 0; i < algorithm.size(); i++){
    //  algString += algorithm.get(i).printPart();
    //}
    //println(algString);
  }

  public void runAlgorithm() {//initiates and prints/returns the algorithm
    if (cube.isComplete()) return;//exits if the cube is complete
    fillTopWhite();
    if (cube.isComplete()) return;//exits if the cube is complete
    for (int i = 0; i < 2; i++) {
      cube.spinFrontTopBackBottom();//flip cube so unsolved part is on top (this just lets the user see their progress)
      cube.addToAlg(new Turn("Cube", true));//add the flip cube turns to the algorithm
    }
    if (cube.isComplete()) return;//exits if the cube is complete
    fillSecondRow();
    if (cube.isComplete()) return;//exits if the cube is complete
    finishCube();
  }

  public ArrayList<Turn> getAlgorithm() {//returns the algorithm as an ArrayList of Turn objects
    return cube.getAlgorithm();
  }

  public void fillTopWhite() {//the first step of the cube is to fill the entire white face (with respect to some other things)
    //topWhiteCenter();
    topWhiteFlower();
    topWhiteCorners();
  }

  public void topWhiteCenter() {//if the white center piece is not on op, find it and move it to the top by spinning the entire cube
    if (cube.isPiece("White", "Top", 1, 1)) return;
    else if (cube.isPiece("White", "Front", 1, 1)) {
      cube.spinFrontTopBackBottom();
    } else if (cube.isPiece("White", "Bottom", 1, 1)) {
      for (int i = 0; i < 2; i++) cube.spinFrontTopBackBottom();
    } else if (cube.isPiece("White", "Back", 1, 1)) {
      for (int i = 0; i < 3; i++) cube.spinFrontTopBackBottom();
    } else if (cube.isPiece("White", "Left", 1, 1)) {
      for (int i = 0; i < 3; i++) cube.spinRightTopLeftBottom();
    } else if (cube.isPiece("White", "Right", 1, 1)) {
      cube.spinRightTopLeftBottom();
    }
  }

  public void topWhiteFlower() {//moves the whit flower pedals to their correct spots (Red, green, orange, blue -- when clockwise from the front)
    findPlaceEdgePiece("White", "Red", 0);
    findPlaceEdgePiece("White", "Green", 1);
    findPlaceEdgePiece("White", "Orange", 2);
    findPlaceEdgePiece("White", "Blue", 3);
  }

  public void findPlaceEdgePiece(String col1, String col2, int position/*0,1,2,3*/) {
    //this finds an edge piece that contains the two needed colors and moves it to the passed position
    int[][] sideSpots = {{0, 1, 2, 1}, {1, 2, 1, 0}};
    for (int i = 0; i < cube.sides.length; i++) {
      for (int j = 0; j < sideSpots[0].length; j++) {
        if (col1 == cube.sides[i].whatColor(sideSpots[0][j], sideSpots[1][j]) && col2 == confirmEdgePieceColor(cube.sidePositions[i], sideSpots[0][j], sideSpots[1][j])) {
          moveWhiteToTop(cube.sidePositions[i], sideSpots[0][j], sideSpots[1][j], position);
        }
      }
    }
  }

  public String confirmEdgePieceColor(String side, int row, int col) {//this returns the complimentary color of an edge piece on the given side and at the given row/col
    if (side == "Top") {
      if (row == 0 && col == 1) {
        return (cube.sides[3].whatColor(0, 1));
      } else if (row == 1 && col == 0) {
        return (cube.sides[4].whatColor(0, 1));
      } else if (row == 1 && col == 2) {
        return (cube.sides[5].whatColor(0, 1));
      } else if (row == 2 && col == 1) {
        return (cube.sides[1].whatColor(0, 1));
      }
    } else if (side == "Front") {
      if (row == 0 && col == 1) {
        return (cube.sides[0].whatColor(2, 1));
      } else if (row == 1 && col == 0) {
        return (cube.sides[4].whatColor(1, 2));
      } else if (row == 1 && col == 2) {
        return (cube.sides[5].whatColor(1, 0));
      } else if (row == 2 && col == 1) {
        return (cube.sides[2].whatColor(0, 1));
      }
    } else if (side == "Bottom") {
      if (row == 0 && col == 1) {
        return (cube.sides[1].whatColor(2, 1));
      } else if (row == 1 && col == 0) {
        return (cube.sides[4].whatColor(2, 1));
      } else if (row == 1 && col == 2) {
        return (cube.sides[5].whatColor(2, 1));
      } else if (row == 2 && col == 1) {
        return (cube.sides[3].whatColor(2, 1));
      }
    } else if (side == "Back") {
      if (row == 0 && col == 1) {
        return (cube.sides[0].whatColor(0, 1));
      } else if (row == 1 && col == 0) {
        return (cube.sides[5].whatColor(1, 2));
      } else if (row == 1 && col == 2) {
        return (cube.sides[4].whatColor(1, 0));
      } else if (row == 2 && col == 1) {
        return (cube.sides[2].whatColor(2, 1));
      }
    } else if (side == "Left") {
      if (row == 0 && col == 1) {
        return (cube.sides[0].whatColor(1, 0));
      } else if (row == 1 && col == 0) {
        return (cube.sides[3].whatColor(1, 2));
      } else if (row == 1 && col == 2) {
        return (cube.sides[1].whatColor(1, 0));
      } else if (row == 2 && col == 1) {
        return (cube.sides[2].whatColor(1, 0));
      }
    } else if (side == "Right") {
      if (row == 0 && col == 1) {
        return (cube.sides[0].whatColor(1, 2));
      } else if (row == 1 && col == 0) {
        return (cube.sides[1].whatColor(1, 2));
      } else if (row == 1 && col == 2) {
        return (cube.sides[3].whatColor(1, 0));
      } else if (row == 2 && col == 1) {
        return (cube.sides[2].whatColor(1, 2));
      }
    }
    return null;
  }

  public void moveWhiteToTop(String side, int row, int col, int position/*0,1,2,3*/) {
    //this moves an edge piece from anywhere on the cube to it's white flower pedal position without messing up any of the other pedals
    if (side == "Top") {
      int currentPosition = 0;
      if (row == 0) currentPosition = 0;
      else if (row == 1) {
        if (col == 0) currentPosition = 3;
        else currentPosition = 1;
      } else if (row == 2) currentPosition = 2;
      if (currentPosition == position) return;
      switch(currentPosition) {
      case 1:
        if (position == 0) cube.turnTop(false); 
        break;
      case 2:
        if (position == 0) for (int i = 0; i < 2; i++) cube.turnTop(false); 
        else if (position == 1) {
          cube.turnFront(true);
          moveWhiteToTop("Right", 1, 0, position);
        }
        break;
      case 3:
        if (position == 0) cube.turnTop(true); 
        else if (position == 1 || position == 2) {
          cube.turnLeft(true);
          moveWhiteToTop("Front", 1, 0, position);
        }
        break;
      }
    } else if (side == "Front") {
      int currentPosition = 0;
      if (row == 0) currentPosition = 0;
      else if (row == 1) {
        if (col == 0) currentPosition = 3;
        else currentPosition = 1;
      } else if (row == 2) currentPosition = 2;
      switch(currentPosition) {
      case 0:
        cube.turnFront(true);
        moveWhiteToTop("Front", 1, 2, position);
        break;
      case 1:
        if (position == 0) {
          cube.turnTop(true);
          cube.turnRight(true);
          cube.turnTop(false);
        } else if (position == 1) {
          cube.turnRight(true);
        } else if (position == 2) {
          cube.turnTop(false);
          cube.turnRight(true);
          cube.turnTop(true);
        } else if (position == 3) {
          for (int i = 0; i < 2; i++) cube.turnTop(true);
          cube.turnRight(true);
          for (int i = 0; i < 2; i++) cube.turnTop(false);
        }
        break;
      case 2:
        cube.turnBottom(false);
        moveWhiteToTop("Left", 2, 1, position);
        break;
      case 3:
        if (position == 0) {
          cube.turnTop(false);
          cube.turnLeft(false);
          cube.turnTop(true);
        } else if (position == 1) {
          for (int i = 0; i < 2; i++) cube.turnTop(true);
          cube.turnLeft(false);
          for (int i = 0; i < 2; i++) cube.turnTop(false);
        } else if (position == 2) {
          cube.turnTop(true);
          cube.turnLeft(false);
          cube.turnTop(false);
        } else if (position == 3) {
          cube.turnLeft(false);
        }
        break;
      }
    } else if (side == "Bottom") {
      int positionOnBottom = 0;
      if (row == 0) positionOnBottom = 0;
      else if (row == 1) {
        if (col == 0) positionOnBottom = 3;
        else positionOnBottom = 1;
      } else if (row == 2) positionOnBottom = 2;
      switch(positionOnBottom) {
      case 0:
        if (position == 0) {
          for (int i = 0; i < 2; i++) cube.turnTop(true);
          for (int i = 0; i < 2; i++) cube.turnFront(false);
          for (int i = 0; i < 2; i++) cube.turnTop(false);
        } else if (position == 1) {
          cube.turnTop(true);
          for (int i = 0; i < 2; i++) cube.turnFront(false);
          cube.turnTop(false);
        } else if (position == 2) {
          for (int i = 0; i < 2; i++) cube.turnFront(false);
        } else if (position == 3) {
          cube.turnTop(false);
          for (int i = 0; i < 2; i++) cube.turnFront(false);
          cube.turnTop(true);
        }
        break;
      case 1:
        if (position == 0) {
          cube.turnBottom(true);
          for (int i = 0; i < 2; i++) cube.turnBack(true);
        } else if (position == 1) {
          for (int i = 0; i < 2; i++) cube.turnRight(true);
        } else if (position == 2) {
          cube.turnBottom(false);
          for (int i = 0; i < 2; i++) cube.turnFront(false);
        } else if (position == 3) {
          for (int i = 0; i < 2; i++) cube.turnBottom(true);
          for (int i = 0; i < 2; i++) cube.turnLeft(false);
        }
        break;
      case 2:
        if (position == 0) {
          for (int i = 0; i < 2; i++) cube.turnBack(true);
        } else if (position == 1) {
          cube.turnBottom(false);
          for (int i = 0; i < 2; i++) cube.turnRight(true);
        } else if (position == 2) {
          for (int i = 0; i < 2; i++) cube.turnBottom(false);
          for (int i = 0; i < 2; i++) cube.turnFront(false);
        } else if (position == 3) {
          cube.turnBottom(true);
          for (int i = 0; i < 2; i++) cube.turnLeft(false);
        }
        break;
      case 3:
        if (position == 0) {
          cube.turnBottom(false);
          for (int i = 0; i < 2; i++) cube.turnBack(true);
        } else if (position == 1) {
          for (int i = 0; i < 2; i++) cube.turnBottom(true);
          for (int i = 0; i < 2; i++) cube.turnRight(true);
        } else if (position == 2) {
          cube.turnBottom(true);
          for (int i = 0; i < 2; i++) cube.turnFront(false);
        } else if (position == 3) {
          for (int i = 0; i < 2; i++) cube.turnLeft(false);
        }
        break;
      }
    } else if (side == "Back") {
      int currentPosition = 0;
      if (row == 0) currentPosition = 0;
      else if (row == 1) {
        if (col == 0) currentPosition = 3;
        else currentPosition = 1;
      } else if (row == 2) currentPosition = 2;
      switch(currentPosition) {
      case 0:
        cube.turnBack(false);
        moveWhiteToTop("Back", 1, 0, position);
        break;
      case 1:
        if (position == 0) {
          cube.turnTop(false);
          cube.turnLeft(true);
          cube.turnTop(true);
        } else if (position == 1) {
          for (int i = 0; i < 2; i++) cube.turnTop(false);
          cube.turnLeft(true);
          for (int i = 0; i < 2; i++) cube.turnTop(true);
        } else if (position == 2) {
          //here
          cube.turnTop(true);
          cube.turnLeft(true);
          cube.turnTop(false);
        } else if (position == 3) {
          cube.turnLeft(true);
        }
        break;
      case 2:
        if (position == 0) {
          cube.turnBack(true);
          cube.turnRight(false);
          cube.turnTop(false);
        } else if (position == 1 || position == 2 || position == 3) {
          cube.turnBottom(true);
          moveWhiteToTop("Left", 2, 1, position);
        }
        break;
      case 3:
        if (position == 0) {
          cube.turnRight(false);
          cube.turnTop(false);
        } else if (position == 1) {
          cube.turnRight(false);
        } else if (position == 2) {
          cube.turnTop(false);
          cube.turnRight(false);
          cube.turnTop(true);
        } else if (position == 3) {
          for (int i = 0; i < 2; i++) cube.turnTop(false);
          cube.turnRight(false);
          for (int i = 0; i < 2; i++) cube.turnTop(true);
        }
        break;
      }
    } else if (side == "Left") {
      int currentPosition = 0;
      if (row == 0) currentPosition = 0;
      else if (row == 1) {
        if (col == 0) currentPosition = 3;
        else currentPosition = 1;
      } else if (row == 2) currentPosition = 2;
      switch(currentPosition) {
      case 0:
        cube.turnLeft(true);
        moveWhiteToTop("Left", 1, 2, position);
        break;
      case 1:
        if (position == 0) {
          for (int i = 0; i < 2; i++) cube.turnTop(false);
          cube.turnFront(true);
          for (int i = 0; i < 2; i++) cube.turnTop(true);
        } else if (position == 1) {
          cube.turnTop(true);
          cube.turnFront(true);
          cube.turnTop(false);
        } else if (position == 2) {
          cube.turnFront(true);
        } else if (position == 3) {
          cube.turnTop(false);
          cube.turnFront(true);
          cube.turnTop(true);
        }
        break;
      case 2:
        cube.turnLeft(true);
        moveWhiteToTop("Left", 1, 0, position);
        break;
      case 3:
        if (position == 0) {
          cube.turnBack(false);
        } else if (position == 1) {
          cube.turnTop(false);
          cube.turnBack(false);
          cube.turnTop(true);
        } else if (position == 2) {
          for (int i = 0; i < 2; i++) cube.turnTop(false);
          cube.turnBack(false);
          for (int i = 0; i < 2; i++) cube.turnTop(true);
        } else if (position == 3) {
          cube.turnTop(true);
          cube.turnBack(false);
          cube.turnTop(false);
        }
        break;
      }
    } else if (side == "Right") {
      int currentPosition = 0;
      if (row == 0) currentPosition = 0;
      else if (row == 1) {
        if (col == 0) currentPosition = 3;
        else currentPosition = 1;
      } else if (row == 2) currentPosition = 2;
      switch(currentPosition) {
      case 0:
        cube.turnRight(false);
        moveWhiteToTop("Right", 1, 0, position);
        break;
      case 1:
        if (position == 0) {
          cube.turnBack(true);
        } else if (position == 1) {
          cube.turnTop(false);
          cube.turnBack(true);
          cube.turnTop(true);
        } else if (position == 2) {
          for (int i = 0; i < 2; i++) cube.turnTop(false);
          cube.turnBack(true);
          for (int i = 0; i < 2; i++) cube.turnTop(true);
        } else if (position == 3) {
          cube.turnTop(true);
          cube.turnBack(true);
          cube.turnTop(false);
        }
        break;
      case 2:
        if (position == 0) {
          cube.turnRight(false);
          cube.turnBack(true);
        } else if (position == 1) {
          cube.turnRight(false);
          cube.turnTop(false);
          cube.turnBack(true);
          cube.turnTop(true);
        } else if (position == 2 || position == 3) {
          for (int i = 0; i < 2; i++) cube.turnBottom(false);
          moveWhiteToTop("Left", 2, 1, position);
        }
        break;
      case 3:
        if (position == 0) {
          for (int i = 0; i < 2; i++) cube.turnTop(true);
          cube.turnFront(false);
          for (int i = 0; i < 2; i++) cube.turnTop(false);
        } else if (position == 1) {
          cube.turnTop(true);
          cube.turnFront(false);
          cube.turnTop(false);
        } else if (position == 2) {
          cube.turnFront(false);
        } else if (position == 3) {
          cube.turnTop(false);
          cube.turnFront(false);
          cube.turnTop(true);
        }
        break;
      }
    }
  }

  public void topWhiteCorners() {//this finds and places the four top white corners in their respective places, completing the white face and the 1st row
    int[][] sideSpots = {{0, 0, 2, 2}, {0, 2, 2, 0}};
    while (!cube.sides[0].isFullSideColor("White") || cube.sides[1].whatColor(0, 0) != cube.sides[1].whatColor(0, 1) ||
      cube.sides[3].whatColor(0, 0) != cube.sides[3].whatColor(0, 1) || cube.sides[4].whatColor(0, 0) != cube.sides[4].whatColor(0, 1) ||
      cube.sides[5].whatColor(0, 0) != cube.sides[5].whatColor(0, 1)) {
      for (int i = 0; i < cube.sidePositions.length; i++) {
        for (int position = 0; position < sideSpots[0].length; position++) {
          if ("White" == cube.sides[i].whatColor(sideSpots[0][position], sideSpots[1][position])) {
            String right = getCornerCompliment(cube.sidePositions[i], sideSpots[0][position], sideSpots[1][position], true);
            String left = getCornerCompliment(cube.sidePositions[i], sideSpots[0][position], sideSpots[1][position], false);
            if ("Top" == cube.sidePositions[i]) {
              switch(position) {
              case 0:
                if (left != cube.sides[3].whatColor(0, 1)) {
                  cube.turnLeft(false);
                  cube.turnBottom(false);
                  cube.turnLeft(true);
                  whiteToTopFromRightBottomRight(left);
                }
                break;
              case 1:
                if (left != cube.sides[5].whatColor(0, 1)) {
                  cube.turnBack(false);
                  cube.turnBottom(false);
                  cube.turnBack(true);
                  cube.turnBottom(true);
                  whiteToTopFromRightBottomRight(left);
                }
                break;
              case 2:
                if (left != cube.sides[1].whatColor(0, 1)) {
                  cube.turnRight(false);
                  cube.turnBottom(false);
                  cube.turnRight(true);
                  for (int j = 0; j < 2; j++) cube.turnBottom(true);
                  whiteToTopFromRightBottomRight(left);
                }
                break;
              case 3:
                if (left != cube.sides[4].whatColor(0, 1)) {
                  cube.turnFront(false);
                  for (int j = 0; j < 2; j++) cube.turnBottom(true);
                  cube.turnFront(true);
                  whiteToTopFromRightBottomRight(left);
                }
                break;
              }
            } else if ("Front" == cube.sidePositions[i]) {
              switch(position) {
              case 0:
                cube.turnFront(false);
                cube.turnBottom(false);
                cube.turnFront(true);
                whiteToTopFromLeftBottomLeft(left);
                break;
              case 1:
                cube.turnFront(true);
                cube.turnBottom(true);
                cube.turnFront(false);
                whiteToTopFromRightBottomRight(left);
                break;
              case 2:
                cube.turnBottom(true);
                whiteToTopFromRightBottomRight(left);
                break;
              case 3:
                cube.turnBottom(false);
                whiteToTopFromLeftBottomLeft(left);
                break;
              }
            } else if ("Bottom" == cube.sidePositions[i]) {
              switch(position) {
              case 0:
                while (right != cube.sides[1].whatColor(0, 1)) {
                  cube.turnTop(false);
                }
                cube.turnFront(false);
                cube.turnBottom(true);
                cube.turnFront(true);
                cube.turnBottom(true);
                whiteToTopFromLeftBottomLeft(left);
                while (cube.sides[1].whatColor(0, 1) != "Orange") {
                  cube.turnTop(true);
                }
                break;
              case 1:
                while (left != cube.sides[1].whatColor(0, 1)) {
                  cube.turnTop(false);
                }
                cube.turnFront(true);
                cube.turnBottom(false);
                cube.turnFront(false);
                cube.turnBottom(false);
                whiteToTopFromRightBottomRight(left);
                while (cube.sides[1].whatColor(0, 1) != "Orange") {
                  cube.turnTop(true);
                }
                break;
              case 2:
                while (right != cube.sides[3].whatColor(0, 1)) {
                  cube.turnTop(false);
                }
                cube.turnRight(true);
                cube.turnBottom(false);
                cube.turnRight(false);
                for (int j = 0; j < 2; j++) cube.turnBottom(false);
                whiteToTopFromRightBottomRight(left);
                while (cube.sides[1].whatColor(0, 1) != "Orange") {
                  cube.turnTop(true);
                }
                break;
              case 3:
                while (left != cube.sides[3].whatColor(0, 1)) {
                  cube.turnTop(false);
                }
                cube.turnLeft(false);
                cube.turnBottom(true);
                cube.turnLeft(true);
                for (int j = 0; j < 2; j++) cube.turnBottom(true);
                whiteToTopFromLeftBottomLeft(left);
                while (cube.sides[1].whatColor(0, 1) != "Orange") {
                  cube.turnTop(true);
                }
                break;
              }
            } else if ("Back" == cube.sidePositions[i]) {
              switch(position) {
              case 0:
                cube.turnBack(false);
                for (int j = 0; j < 2; j++) cube.turnBottom(true);
                cube.turnBack(true);
                cube.turnBottom(false);
                whiteToTopFromLeftBottomLeft(left);
                break;
              case 1:
                cube.turnBack(true);
                for (int j = 0; j < 2; j++) cube.turnBottom(false);
                cube.turnBack(false);
                cube.turnBottom(true);
                whiteToTopFromRightBottomRight(left);
                break;
              case 2:
                cube.turnBottom(false);
                whiteToTopFromRightBottomRight(left);
                break;
              case 3:
                cube.turnBottom(true);
                whiteToTopFromLeftBottomLeft(left);
                break;
              }
            } else if ("Left" == cube.sidePositions[i]) {
              switch(position) {
              case 0:
                cube.turnLeft(false);
                cube.turnBottom(false);
                cube.turnLeft(true);
                cube.turnBottom(true);
                whiteToTopFromLeftBottomLeft(left);
                break;
              case 1:
                cube.turnLeft(true);
                cube.turnBottom(true);
                cube.turnLeft(false);
                cube.turnBottom(true);
                whiteToTopFromRightBottomRight(left);
                break;
              case 2:
                for (int j = 0; j < 2; j++) cube.turnBottom(true);
                whiteToTopFromRightBottomRight(left);
                break;
              case 3:
                whiteToTopFromLeftBottomLeft(left);
                break;
              }
            } else if ("Right" == cube.sidePositions[i]) {
              switch(position) {
              case 0:
                cube.turnRight(false);
                cube.turnBottom(false);
                cube.turnRight(true);
                cube.turnBottom(false);
                whiteToTopFromLeftBottomLeft(left);
                break;
              case 1:
                cube.turnRight(true);
                cube.turnBottom(true);
                cube.turnRight(false);
                cube.turnBottom(true);
                whiteToTopFromRightBottomRight(left);
                break;
              case 2:
                whiteToTopFromRightBottomRight(left);
                break;
              case 3:
                for (int j = 0; j < 2; j++) cube.turnBottom(true);
                whiteToTopFromLeftBottomLeft(left);
                break;
              }
            }
          }
        }
      }
    }
  }

  public void whiteToTopFromRightBottomRight(String left) {//this moves the right side's bottom right corner to the top given the color of the left side of the piece
    if (left == cube.sides[5].whatColor(0, 1)) {
      cube.turnRight(true);
      cube.turnBottom(true);
      cube.turnRight(false);
    } else if (left == cube.sides[1].whatColor(0, 1)) {
      cube.turnBottom(true);
      cube.turnRight(false);
      for (int j = 0; j < 2; j++) cube.turnBottom(false);
      cube.turnRight(true);
    } else if (left == cube.sides[3].whatColor(0, 1)) {
      cube.turnLeft(false);
      cube.turnBottom(true);
      cube.turnLeft(true);
    } else if (left == cube.sides[4].whatColor(0, 1)) {
      cube.turnFront(false);
      for (int j = 0; j < 2; j++) cube.turnBottom(true);
      cube.turnFront(true);
    }
  }

  public void whiteToTopFromLeftBottomLeft(String left) {//this moves the left side's bottom left corner to the top given the color of the left side of the piece
    if (left == cube.sides[5].whatColor(0, 1)) {
      cube.turnRight(true);
      cube.turnBottom(false);
      cube.turnRight(false);
    } else if (left == cube.sides[1].whatColor(0, 1)) {
      for (int j = 0; j < 2; j++) cube.turnBottom(false);
      cube.turnRight(false);
      cube.turnBottom(false);
      cube.turnRight(true);
    } else if (left == cube.sides[3].whatColor(0, 1)) {
      cube.turnLeft(false);
      cube.turnBottom(false);
      cube.turnLeft(true);
    } else if (left == cube.sides[4].whatColor(0, 1)) {
      cube.turnBottom(false);
      cube.turnLeft(true);
      for (int j = 0; j < 2; j++) cube.turnBottom(true);
      cube.turnLeft(false);
    }
  }

  public String getCornerCompliment(String side, int row, int col, boolean clockwise) {//this gets the not-white complimentary color of the corner 
    String comp = "";
    int position = 0;
    if (row == 0) {
      if (col == 0) position = 0;
      else position = 1;
    } else if (row == 2) {
      if (col == 2) position = 2;
      else position = 3;
    }
    switch(side) {
    case "Top":
      switch(position) {
      case 0:
        if (clockwise) comp = cube.sides[4].whatColor(0, 0);
        else comp = cube.sides[3].whatColor(0, 2);
        break;
      case 1:
        if (clockwise) comp = cube.sides[3].whatColor(0, 0);
        else comp = cube.sides[5].whatColor(0, 2);
        break;
      case 2:
        if (clockwise) comp = cube.sides[5].whatColor(0, 0);
        else comp = cube.sides[1].whatColor(0, 2);
        break;
      case 3:
        if (clockwise) comp = cube.sides[1].whatColor(0, 0);
        else comp = cube.sides[4].whatColor(0, 2);
        break;
      }
      break;
    case "Front":
      switch(position) {
      case 0:
        if (clockwise) comp = cube.sides[4].whatColor(0, 2);
        else comp = cube.sides[0].whatColor(2, 0);
        break;
      case 1:
        if (clockwise) comp = cube.sides[0].whatColor(2, 2);
        else comp = cube.sides[5].whatColor(0, 0);
        break;
      case 2:
        if (clockwise) comp = cube.sides[5].whatColor(2, 0);
        else comp = cube.sides[2].whatColor(0, 2);
        break;
      case 3:
        if (clockwise) comp = cube.sides[2].whatColor(0, 0);
        else comp = cube.sides[4].whatColor(2, 2);
        break;
      }
      break;
    case "Bottom":
      switch(position) {
      case 0:
        if (clockwise) comp = cube.sides[4].whatColor(2, 2);
        else comp = cube.sides[1].whatColor(2, 0);
        break;
      case 1:
        if (clockwise) comp = cube.sides[1].whatColor(2, 2);
        else comp = cube.sides[5].whatColor(2, 0);
        break;
      case 2:
        if (clockwise) comp = cube.sides[5].whatColor(2, 2);
        else comp = cube.sides[3].whatColor(2, 0);
        break;
      case 3:
        if (clockwise) comp = cube.sides[3].whatColor(2, 2);
        else comp = cube.sides[4].whatColor(2, 0);
        break;
      }
      break;
    case "Back":
      switch(position) {
      case 0:
        if (clockwise) comp = cube.sides[5].whatColor(0, 2);
        else comp = cube.sides[0].whatColor(0, 2);
        break;
      case 1:
        if (clockwise) comp = cube.sides[0].whatColor(0, 0);
        else comp = cube.sides[4].whatColor(0, 0);
        break;
      case 2:
        if (clockwise) comp = cube.sides[4].whatColor(2, 0);
        else comp = cube.sides[2].whatColor(2, 0);
        break;
      case 3:
        if (clockwise) comp = cube.sides[2].whatColor(2, 2);
        else comp = cube.sides[5].whatColor(2, 2);
        break;
      }
      break;
    case "Left":
      switch(position) {
      case 0:
        if (clockwise) comp = cube.sides[3].whatColor(0, 2);
        else comp = cube.sides[0].whatColor(0, 0);
        break;
      case 1:
        if (clockwise) comp = cube.sides[0].whatColor(2, 0);
        else comp = cube.sides[1].whatColor(0, 0);
        break;
      case 2:
        if (clockwise) comp = cube.sides[1].whatColor(2, 0);
        else comp = cube.sides[2].whatColor(0, 0);
        break;
      case 3:
        if (clockwise) comp = cube.sides[2].whatColor(2, 0);
        else comp = cube.sides[3].whatColor(2, 2);
        break;
      }
      break;
    case "Right":
      switch(position) {
      case 0:
        if (clockwise) comp = cube.sides[1].whatColor(0, 2);
        else comp = cube.sides[0].whatColor(2, 2);
        break;
      case 1:
        if (clockwise) comp = cube.sides[0].whatColor(0, 2);
        else comp = cube.sides[3].whatColor(0, 0);
        break;
      case 2:
        if (clockwise) comp = cube.sides[3].whatColor(2, 0);
        else comp = cube.sides[2].whatColor(2, 2);
        break;
      case 3:
        if (clockwise) comp = cube.sides[2].whatColor(0, 2);
        else comp = cube.sides[1].whatColor(2, 2);
        break;
      }
      break;
    }
    return comp;
  }

  public void fillSecondRow() {//this calls the methods that fill the second row.
    makeTs();
    findPlaceSecondRowEdges();
  }

  public void makeTs() {
    while (cube.sides[1].whatColor(2, 1) != cube.sides[1].whatColor(1, 1)) {
      cube.turnBottom(true);
    }
  }

  public void findPlaceSecondRowEdges() {
    if (cube.sides[1].whatColor(1, 0) == cube.sides[4].whatColor(1, 1) && cube.sides[1].whatColor(1, 1) == cube.sides[4].whatColor(1, 2)) {
      //if the right piece is in the spot but has the wrong orientation
      moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
      for (int i = 0; i < 2; i++) cube.turnTop(true);
      moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
    } else {
      //if it is on a top edge somewhere
      if (cube.sides[1].whatColor(0, 1) == cube.sides[1].whatColor(1, 1) && cube.sides[0].whatColor(2, 1) == cube.sides[4].whatColor(1, 1)) {
        moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[4].whatColor(0, 1) == cube.sides[1].whatColor(1, 1) && cube.sides[0].whatColor(1, 0) == cube.sides[4].whatColor(1, 1)) {
        cube.turnTop(false);
        moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[3].whatColor(0, 1) == cube.sides[1].whatColor(1, 1) && cube.sides[0].whatColor(0, 1) == cube.sides[4].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(false);
        moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[5].whatColor(0, 1) == cube.sides[1].whatColor(1, 1) && cube.sides[0].whatColor(1, 2) == cube.sides[4].whatColor(1, 1)) {
        cube.turnTop(true);
        moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[1].whatColor(0, 1) == cube.sides[4].whatColor(1, 1) && cube.sides[0].whatColor(2, 1) ==  cube.sides[1].whatColor(1, 1)) {
        cube.turnTop(true);
        moveAlignedLeftEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[4].whatColor(0, 1) == cube.sides[4].whatColor(1, 1) && cube.sides[0].whatColor(1, 0) ==  cube.sides[1].whatColor(1, 1)) {
        moveAlignedLeftEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[3].whatColor(0, 1) == cube.sides[4].whatColor(1, 1) && cube.sides[0].whatColor(0, 1) ==  cube.sides[1].whatColor(1, 1)) {
        cube.turnTop(false);
        moveAlignedLeftEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[5].whatColor(0, 1) == cube.sides[4].whatColor(1, 1) && cube.sides[0].whatColor(1, 2) ==  cube.sides[1].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(true);
        moveAlignedLeftEdgeToFrontLeftSecondRowEdge();
      } 
      //if it is in another edge piece spot
      else if (cube.sides[1].whatColor(1, 2) == cube.sides[4].whatColor(1, 1) && cube.sides[5].whatColor(1, 0) == cube.sides[1].whatColor(1, 1)) {
        moveAlignedFrontEdgeToFrontRightSecondRowEdge();
        for (int i = 0; i < 2; i++) cube.turnTop(true);
        moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[5].whatColor(1, 0) == cube.sides[4].whatColor(1, 1) && cube.sides[1].whatColor(1, 2) == cube.sides[1].whatColor(1, 1)) {
        moveAlignedFrontEdgeToFrontRightSecondRowEdge();
        cube.turnTop(false);
        moveAlignedLeftEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[5].whatColor(1, 2) == cube.sides[4].whatColor(1, 1) && cube.sides[3].whatColor(1, 0) == cube.sides[1].whatColor(1, 1)) {
        moveAlignedRightEdgeToBackRightSecondRowEdge();
        cube.turnTop(false);
        moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[3].whatColor(1, 0) == cube.sides[4].whatColor(1, 1) && cube.sides[5].whatColor(1, 2) == cube.sides[1].whatColor(1, 1)) {
        moveAlignedRightEdgeToBackRightSecondRowEdge();
        moveAlignedLeftEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[3].whatColor(1, 2) == cube.sides[4].whatColor(1, 1) && cube.sides[4].whatColor(1, 0) == cube.sides[1].whatColor(1, 1)) {
        moveAlignedLeftEdgeToBackLeftSecondRowEdge();
        for (int i = 0; i < 2; i++) cube.turnTop(false);
        moveAlignedLeftEdgeToFrontLeftSecondRowEdge();
      } else if (cube.sides[4].whatColor(1, 0) == cube.sides[4].whatColor(1, 1) && cube.sides[3].whatColor(1, 2) == cube.sides[1].whatColor(1, 1)) {
        moveAlignedLeftEdgeToBackLeftSecondRowEdge();
        cube.turnTop(true);
        moveAlignedFrontEdgeToFrontLeftSecondRowEdge();
      }
    }
    if (cube.sides[3].whatColor(1, 2) == cube.sides[4].whatColor(1, 1) && cube.sides[4].whatColor(1, 0) == cube.sides[3].whatColor(1, 1)) {
      //if the right piece is in the spot but has the wrong orientation
      moveAlignedLeftEdgeToBackLeftSecondRowEdge();
      for (int i = 0; i < 2; i++) cube.turnTop(false);
      moveAlignedLeftEdgeToBackLeftSecondRowEdge();
    } else {
      //if it is on a top edge somewhere
      if (cube.sides[4].whatColor(0, 1) == cube.sides[4].whatColor(1, 1) && cube.sides[0].whatColor(1, 0) == cube.sides[3].whatColor(1, 1)) {
        moveAlignedLeftEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[3].whatColor(0, 1) == cube.sides[4].whatColor(1, 1) && cube.sides[0].whatColor(0, 1) == cube.sides[3].whatColor(1, 1)) {
        cube.turnTop(false);  
        moveAlignedLeftEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[5].whatColor(0, 1) == cube.sides[4].whatColor(1, 1) && cube.sides[0].whatColor(1, 2) == cube.sides[3].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(false);  
        moveAlignedLeftEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[1].whatColor(0, 1) == cube.sides[4].whatColor(1, 1) && cube.sides[0].whatColor(2, 1) == cube.sides[3].whatColor(1, 1)) {
        cube.turnTop(true);  
        moveAlignedLeftEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[4].whatColor(0, 1) == cube.sides[3].whatColor(1, 1) && cube.sides[0].whatColor(1, 0) == cube.sides[4].whatColor(1, 1)) {
        cube.turnTop(true);
        moveAlignedBackEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[3].whatColor(0, 1) == cube.sides[3].whatColor(1, 1) && cube.sides[0].whatColor(0, 1) == cube.sides[4].whatColor(1, 1)) {
        moveAlignedBackEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[5].whatColor(0, 1) == cube.sides[3].whatColor(1, 1) && cube.sides[0].whatColor(1, 2) == cube.sides[4].whatColor(1, 1)) {
        cube.turnTop(false);
        moveAlignedBackEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[1].whatColor(0, 1) == cube.sides[3].whatColor(1, 1) && cube.sides[0].whatColor(2, 1) == cube.sides[4].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(false);
        moveAlignedBackEdgeToBackLeftSecondRowEdge();
      } 
      //if it is in another edge piece spot
      else if (cube.sides[1].whatColor(1, 2) == cube.sides[4].whatColor(1, 1) && cube.sides[5].whatColor(1, 0) == cube.sides[3].whatColor(1, 1)) {
        moveAlignedFrontEdgeToFrontRightSecondRowEdge();
        moveAlignedBackEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[5].whatColor(1, 0) == cube.sides[4].whatColor(1, 1) && cube.sides[1].whatColor(1, 2) == cube.sides[3].whatColor(1, 1)) {
        moveAlignedFrontEdgeToFrontRightSecondRowEdge();
        cube.turnTop(false);
        moveAlignedLeftEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[5].whatColor(1, 2) == cube.sides[4].whatColor(1, 1) && cube.sides[3].whatColor(1, 0) == cube.sides[3].whatColor(1, 1)) {
        moveAlignedRightEdgeToBackRightSecondRowEdge();
        cube.turnTop(true);
        moveAlignedBackEdgeToBackLeftSecondRowEdge();
      } else if (cube.sides[3].whatColor(1, 0) == cube.sides[4].whatColor(1, 1) && cube.sides[5].whatColor(1, 2) == cube.sides[3].whatColor(1, 1)) {
        moveAlignedRightEdgeToBackRightSecondRowEdge();
        moveAlignedLeftEdgeToBackLeftSecondRowEdge();
      }
    }
    if (cube.sides[5].whatColor(1, 2) == cube.sides[3].whatColor(1, 1) && cube.sides[3].whatColor(1, 0) == cube.sides[5].whatColor(1, 1)) {
      //if the right piece is in the spot but has the wrong orientation
      moveAlignedRightEdgeToBackRightSecondRowEdge();
      for (int i = 0; i < 2; i++) cube.turnTop(true);
      moveAlignedRightEdgeToBackRightSecondRowEdge();
    } else {
      //if it is on a top edge somewhere
      if (cube.sides[3].whatColor(0, 1) == cube.sides[3].whatColor(1, 1) && cube.sides[0].whatColor(0, 1) == cube.sides[5].whatColor(1, 1)) {
        moveAlignedBackEdgeToBackRightSecondRowEdge();
      } else if (cube.sides[5].whatColor(0, 1) == cube.sides[3].whatColor(1, 1) && cube.sides[0].whatColor(1, 2) == cube.sides[5].whatColor(1, 1)) {
        cube.turnTop(false);
        moveAlignedBackEdgeToBackRightSecondRowEdge();
      } else if (cube.sides[1].whatColor(0, 1) == cube.sides[3].whatColor(1, 1) && cube.sides[0].whatColor(2, 1) == cube.sides[5].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(true);
        moveAlignedBackEdgeToBackRightSecondRowEdge();
      } else if (cube.sides[4].whatColor(0, 1) == cube.sides[3].whatColor(1, 1) && cube.sides[0].whatColor(1, 0) == cube.sides[5].whatColor(1, 1)) {
        cube.turnTop(true);
        moveAlignedBackEdgeToBackRightSecondRowEdge();
      } else if (cube.sides[3].whatColor(0, 1) == cube.sides[5].whatColor(1, 1) && cube.sides[0].whatColor(0, 1) == cube.sides[3].whatColor(1, 1)) {
        cube.turnTop(true);
        moveAlignedRightEdgeToBackRightSecondRowEdge();
      } else if (cube.sides[5].whatColor(0, 1) == cube.sides[5].whatColor(1, 1) && cube.sides[0].whatColor(1, 2) == cube.sides[3].whatColor(1, 1)) {
        moveAlignedRightEdgeToBackRightSecondRowEdge();
      } else if (cube.sides[1].whatColor(0, 1) == cube.sides[5].whatColor(1, 1) && cube.sides[0].whatColor(2, 1) == cube.sides[3].whatColor(1, 1)) {
        cube.turnTop(false);
        moveAlignedRightEdgeToBackRightSecondRowEdge();
      } else if (cube.sides[4].whatColor(0, 1) == cube.sides[5].whatColor(1, 1) && cube.sides[0].whatColor(1, 0) == cube.sides[3].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(false);
        moveAlignedRightEdgeToBackRightSecondRowEdge();
      } 
      //if it is in another edge piece spot
      else if (cube.sides[1].whatColor(1, 2) == cube.sides[3].whatColor(1, 1) && cube.sides[5].whatColor(1, 0) == cube.sides[5].whatColor(1, 1)) {
        moveAlignedRightEdgeToFrontRightSecondRowEdge();
        cube.turnTop(true);
        moveAlignedBackEdgeToBackRightSecondRowEdge();
      } else if (cube.sides[5].whatColor(1, 0) == cube.sides[3].whatColor(1, 1) && cube.sides[1].whatColor(1, 2) == cube.sides[5].whatColor(1, 1)) {
        moveAlignedRightEdgeToFrontRightSecondRowEdge();
        for (int i = 0; i < 2; i++) cube.turnTop(true);
        moveAlignedRightEdgeToBackRightSecondRowEdge();
      }
    }
    if (cube.sides[5].whatColor(1, 0) == cube.sides[1].whatColor(1, 1) && cube.sides[1].whatColor(1, 2) == cube.sides[5].whatColor(1, 1)) {
      //if the right piece is in the spot but has the wrong orientation
      moveAlignedFrontEdgeToFrontRightSecondRowEdge();
      for (int i = 0; i < 2; i++) cube.turnTop(true);
      moveAlignedFrontEdgeToFrontRightSecondRowEdge();
    } else {
      //if it is on a top edge somewhere
      if (cube.sides[5].whatColor(0, 1) == cube.sides[5].whatColor(1, 1) && cube.sides[0].whatColor(1, 2) == cube.sides[1].whatColor(1, 1)) {
        moveAlignedRightEdgeToFrontRightSecondRowEdge();
      } else if (cube.sides[1].whatColor(0, 1) == cube.sides[5].whatColor(1, 1) && cube.sides[0].whatColor(2, 1) == cube.sides[1].whatColor(1, 1)) {
        cube.turnTop(false);
        moveAlignedRightEdgeToFrontRightSecondRowEdge();
      } else if (cube.sides[4].whatColor(0, 1) == cube.sides[5].whatColor(1, 1) && cube.sides[0].whatColor(1, 0) == cube.sides[1].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(false);
        moveAlignedRightEdgeToFrontRightSecondRowEdge();
      } else if (cube.sides[3].whatColor(0, 1) == cube.sides[5].whatColor(1, 1) && cube.sides[0].whatColor(0, 1) == cube.sides[1].whatColor(1, 1)) {
        cube.turnTop(true);
        moveAlignedRightEdgeToFrontRightSecondRowEdge();
      } else if (cube.sides[5].whatColor(0, 1) == cube.sides[1].whatColor(1, 1) && cube.sides[0].whatColor(1, 2) == cube.sides[5].whatColor(1, 1)) {
        cube.turnTop(true);  
        moveAlignedFrontEdgeToFrontRightSecondRowEdge();
      } else if (cube.sides[1].whatColor(0, 1) == cube.sides[1].whatColor(1, 1) && cube.sides[0].whatColor(2, 1) == cube.sides[5].whatColor(1, 1)) {
        moveAlignedFrontEdgeToFrontRightSecondRowEdge();
      } else if (cube.sides[4].whatColor(0, 1) == cube.sides[1].whatColor(1, 1) && cube.sides[0].whatColor(1, 0) == cube.sides[5].whatColor(1, 1)) {
        cube.turnTop(false);  
        moveAlignedFrontEdgeToFrontRightSecondRowEdge();
      } else if (cube.sides[3].whatColor(0, 1) == cube.sides[1].whatColor(1, 1) && cube.sides[0].whatColor(0, 1) == cube.sides[5].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(false);  
        moveAlignedFrontEdgeToFrontRightSecondRowEdge();
      }
    }
  }

  public void moveAlignedFrontEdgeToFrontLeftSecondRowEdge() {
    cube.turnTop(false);
    cube.turnLeft(false);
    cube.turnTop(false);
    cube.turnLeft(true);
    cube.turnTop(true);
    cube.turnFront(true);
    cube.turnTop(true);
    cube.turnFront(false);
  }

  public void moveAlignedLeftEdgeToFrontLeftSecondRowEdge() {
    cube.turnTop(true);
    cube.turnFront(true);
    cube.turnTop(true);
    cube.turnFront(false);
    cube.turnTop(false);
    cube.turnLeft(false);
    cube.turnTop(false);
    cube.turnLeft(true);
  }

  public void moveAlignedLeftEdgeToBackLeftSecondRowEdge() {
    cube.turnTop(false);
    cube.turnBack(false);
    cube.turnTop(false);
    cube.turnBack(true);
    cube.turnTop(true);
    cube.turnLeft(true);
    cube.turnTop(true);
    cube.turnLeft(false);
  }

  public void moveAlignedBackEdgeToBackLeftSecondRowEdge() {
    cube.turnTop(true);
    cube.turnLeft(true);
    cube.turnTop(true);
    cube.turnLeft(false);
    cube.turnTop(false);
    cube.turnBack(false);
    cube.turnTop(false);
    cube.turnBack(true);
  }

  public void moveAlignedBackEdgeToBackRightSecondRowEdge() {
    cube.turnTop(false);
    cube.turnRight(false);
    cube.turnTop(false);
    cube.turnRight(true);
    cube.turnTop(true);
    cube.turnBack(true);
    cube.turnTop(true);
    cube.turnBack(false);
  }

  public void moveAlignedRightEdgeToBackRightSecondRowEdge() {
    cube.turnTop(true);
    cube.turnBack(true);
    cube.turnTop(true);
    cube.turnBack(false);
    cube.turnTop(false);
    cube.turnRight(false);
    cube.turnTop(false);
    cube.turnRight(true);
  }

  public void moveAlignedRightEdgeToFrontRightSecondRowEdge() {
    cube.turnTop(false);
    cube.turnFront(false);
    cube.turnTop(false);
    cube.turnFront(true);
    cube.turnTop(true);
    cube.turnRight(true);
    cube.turnTop(true);
    cube.turnRight(false);
  }

  public void moveAlignedFrontEdgeToFrontRightSecondRowEdge() {
    cube.turnTop(true);
    cube.turnRight(true);
    cube.turnTop(true);
    cube.turnRight(false);
    cube.turnTop(false);
    cube.turnFront(false);
    cube.turnTop(false);
    cube.turnFront(true);
  }

  public void finishCube() {
    makeYellowFlower();
    positionYellowFlowerPedals();
    placePositionCorners();
  }

  public void makeYellowFlower() {
    //if its already in a flower
    if (cube.sides[0].whatColor(0, 1) == "Yellow" && cube.sides[0].whatColor(1, 2) == "Yellow" &&
      cube.sides[0].whatColor(2, 1) == "Yellow" && cube.sides[0].whatColor(1, 0) == "Yellow") return;
    //if it is not already in a yellow flower 
    if (cube.sides[0].whatColor(0, 1) != "Yellow" && cube.sides[0].whatColor(1, 2) != "Yellow" && 
      cube.sides[0].whatColor(2, 1) != "Yellow" && cube.sides[0].whatColor(1, 0) != "Yellow") {
      //if the only yellow on top is in the center
      yellowFlowerAlg();
    }
    if (cube.sides[0].whatColor(0, 1) == "Yellow" && cube.sides[0].whatColor(1, 2) == "Yellow" &&
      cube.sides[0].whatColor(2, 1) != "Yellow" && cube.sides[0].whatColor(1, 0) != "Yellow") {
      //if an L is in the top right
      cube.turnTop(false);
    } else if (cube.sides[0].whatColor(1, 2) == "Yellow" && cube.sides[0].whatColor(2, 1) == "Yellow" &&
      cube.sides[0].whatColor(0, 1) != "Yellow" && cube.sides[0].whatColor(1, 0) != "Yellow") {
      //if an L is in the bootom right
      for (int i = 0; i < 2; i++) cube.turnTop(false);
    } else if (cube.sides[0].whatColor(2, 1) == "Yellow" && cube.sides[0].whatColor(1, 0) == "Yellow" &&
      cube.sides[0].whatColor(0, 1) != "Yellow" && cube.sides[0].whatColor(1, 2) != "Yellow") {
      //if an L is in the bottom Left
      cube.turnTop(true);
    }
    if (cube.sides[0].whatColor(1, 2) != "Yellow" && cube.sides[0].whatColor(2, 1) != "Yellow" &&
      cube.sides[0].whatColor(1, 0) == "Yellow" && cube.sides[0].whatColor(0, 1) == "Yellow") {
      //if a flower or line has not been made yet
      yellowFlowerAlg();
    }
    if (cube.sides[0].whatColor(0, 1) == "Yellow" && cube.sides[0].whatColor(2, 1) == "Yellow" &&
      cube.sides[0].whatColor(1, 2) != "Yellow" && cube.sides[0].whatColor(1, 0) != "Yellow") {
      cube.turnTop(true);
    }
    if (cube.sides[0].whatColor(0, 1) != "Yellow" && cube.sides[0].whatColor(2, 1) != "Yellow" &&
      cube.sides[0].whatColor(1, 2) == "Yellow" && cube.sides[0].whatColor(1, 0) == "Yellow") {
      yellowFlowerAlg();
    }
  }

  public void yellowFlowerAlg() {
    cube.turnFront(true);
    cube.turnRight(true);
    cube.turnTop(true);
    cube.turnRight(false);
    cube.turnTop(false);
    cube.turnFront(false);
  }

  public void positionYellowFlowerPedals() {
    while (cube.sides[1].whatColor(0, 1) != cube.sides[1].whatColor(1, 1)) {
      cube.turnTop(true);
    }
    if (cube.sides[4].whatColor(0, 1) != cube.sides[4].whatColor(1, 1)) {
      if (cube.sides[5].whatColor(0, 1) == cube.sides[4].whatColor(1, 1)) {
        for (int i = 0; i < 2; i++) cube.turnTop(true);
        swapYellowFlowerPedalAlg();
        for (int i = 0; i < 2; i++) cube.turnTop(true);
      }
      if (cube.sides[3].whatColor(0, 1) == cube.sides[4].whatColor(1, 1)) {
        cube.turnTop(false);
        swapYellowFlowerPedalAlg();
        cube.turnTop(true);
      }
    }
    if (cube.sides[5].whatColor(0, 1) == cube.sides[3].whatColor(1, 1)) {
      for (int i = 0; i < 2; i++) cube.turnTop(true);
      swapYellowFlowerPedalAlg();
      for (int i = 0; i < 2; i++) cube.turnTop(false);
    }
  }

  public void swapYellowFlowerPedalAlg() {
    cube.turnRight(true);
    cube.turnTop(true);
    cube.turnRight(false);
    cube.turnTop(true);
    cube.turnRight(true);
    for (int i = 0; i < 2; i++) cube.turnTop(true);
    cube.turnRight(false);
    cube.turnTop(true);
  }

  public void placePositionCorners() {
    //move the Yellow corner pieces to their correct spots
    if (!isCornerPiece(3, cube.sides[1].whatColor(1, 1), cube.sides[4].whatColor(1, 1)) &&
      !isCornerPiece(0, cube.sides[4].whatColor(1, 1), cube.sides[3].whatColor(1, 1)) &&
      !isCornerPiece(1, cube.sides[3].whatColor(1, 1), cube.sides[5].whatColor(1, 1)) &&
      !isCornerPiece(2, cube.sides[5].whatColor(1, 1), cube.sides[1].whatColor(1, 1))) {
      swapYellowCornerPiecesAlgWithPosition3AsCorrectPiece();
    }
    if (isCornerPiece(3, cube.sides[1].whatColor(1, 1), cube.sides[4].whatColor(1, 1))) {
      while (!isCornerPiece(3, cube.sides[1].whatColor(1, 1), cube.sides[4].whatColor(1, 1)) ||
        !isCornerPiece(0, cube.sides[4].whatColor(1, 1), cube.sides[3].whatColor(1, 1)) ||
        !isCornerPiece(1, cube.sides[3].whatColor(1, 1), cube.sides[5].whatColor(1, 1)) ||
        !isCornerPiece(2, cube.sides[5].whatColor(1, 1), cube.sides[1].whatColor(1, 1))) {
        swapYellowCornerPiecesAlgWithPosition3AsCorrectPiece();
      }
    } else if (isCornerPiece(0, cube.sides[4].whatColor(1, 1), cube.sides[3].whatColor(1, 1))) {
      while (!isCornerPiece(3, cube.sides[1].whatColor(1, 1), cube.sides[4].whatColor(1, 1)) ||
        !isCornerPiece(0, cube.sides[4].whatColor(1, 1), cube.sides[3].whatColor(1, 1)) ||
        !isCornerPiece(1, cube.sides[3].whatColor(1, 1), cube.sides[5].whatColor(1, 1)) ||
        !isCornerPiece(2, cube.sides[5].whatColor(1, 1), cube.sides[1].whatColor(1, 1))) {
        cube.turnFront(true);
        cube.turnTop(false);
        cube.turnBack(false);
        cube.turnTop(true);
        cube.turnFront(false);
        cube.turnTop(false);
        cube.turnBack(true);
        cube.turnTop(true);
      }
    } else if (isCornerPiece(1, cube.sides[3].whatColor(1, 1), cube.sides[5].whatColor(1, 1))) {
      while (!isCornerPiece(3, cube.sides[1].whatColor(1, 1), cube.sides[4].whatColor(1, 1)) ||
        !isCornerPiece(0, cube.sides[4].whatColor(1, 1), cube.sides[3].whatColor(1, 1)) ||
        !isCornerPiece(1, cube.sides[3].whatColor(1, 1), cube.sides[5].whatColor(1, 1)) ||
        !isCornerPiece(2, cube.sides[5].whatColor(1, 1), cube.sides[1].whatColor(1, 1))) {
        cube.turnFront(false);
        cube.turnTop(true);
        cube.turnBack(true);
        cube.turnTop(false);
        cube.turnFront(true);
        cube.turnTop(true);
        cube.turnBack(false);
        cube.turnTop(false);
      }
    } else if (isCornerPiece(2, cube.sides[5].whatColor(1, 1), cube.sides[1].whatColor(1, 1))) {
      while (!isCornerPiece(3, cube.sides[1].whatColor(1, 1), cube.sides[4].whatColor(1, 1)) ||
        !isCornerPiece(0, cube.sides[4].whatColor(1, 1), cube.sides[3].whatColor(1, 1)) ||
        !isCornerPiece(1, cube.sides[3].whatColor(1, 1), cube.sides[5].whatColor(1, 1)) ||
        !isCornerPiece(2, cube.sides[5].whatColor(1, 1), cube.sides[1].whatColor(1, 1))) {
        cube.turnLeft(false);
        cube.turnTop(true);
        cube.turnRight(true);
        cube.turnTop(false);
        cube.turnLeft(true);
        cube.turnTop(true);
        cube.turnRight(false);
        cube.turnTop(false);
      }
    }
    //position the yellow corner pieces to complete the cube
    for (int i = 0; i < 4; i++) {
      positionYellowCornerPiece();
      cube.turnTop(true);
    }
  }

  public boolean isCornerPiece(int position, String col1, String col2) {
    switch(position) {
    case 0:
      if (cube.sides[0].whatColor(0, 0) == col1 || cube.sides[3].whatColor(0, 2) == col1 || cube.sides[4].whatColor(0, 0) == col1) {
        return (cube.sides[0].whatColor(0, 0) == col2 || cube.sides[3].whatColor(0, 2) == col2 || cube.sides[4].whatColor(0, 0) == col2);
      }
      return false;
    case 1:
      if (cube.sides[0].whatColor(0, 2) == col1 || cube.sides[5].whatColor(0, 2) == col1 || cube.sides[3].whatColor(0, 0) == col1) {
        return (cube.sides[0].whatColor(0, 2) == col2 || cube.sides[5].whatColor(0, 2) == col2 || cube.sides[3].whatColor(0, 0) == col2);
      }
      return false;
    case 2:
      if (cube.sides[0].whatColor(2, 2) == col1 || cube.sides[5].whatColor(0, 0) == col1 || cube.sides[1].whatColor(0, 2) == col1) {
        return (cube.sides[0].whatColor(2, 2) == col2 || cube.sides[5].whatColor(0, 0) == col2 || cube.sides[1].whatColor(0, 2) == col2);
      }
      return false;
    case 3:
      if (cube.sides[0].whatColor(2, 0) == col1 || cube.sides[1].whatColor(0, 0) == col1 || cube.sides[4].whatColor(0, 2) == col1) {
        return (cube.sides[0].whatColor(2, 0) == col2 || cube.sides[1].whatColor(0, 0) == col2 || cube.sides[4].whatColor(0, 2) == col2);
      }
      return false;
    }
    return false;
  }

  public void swapYellowCornerPiecesAlgWithPosition3AsCorrectPiece() {
    cube.turnRight(true);
    cube.turnTop(false);
    cube.turnLeft(false);
    cube.turnTop(true);
    cube.turnRight(false);
    cube.turnTop(false);
    cube.turnLeft(true);
    cube.turnTop(true);
  }

  public void positionYellowCornerPiece() {
    while (cube.sides[0].whatColor(2, 2) != "Yellow") {
      cube.turnRight(false);
      cube.turnBottom(false);
      cube.turnRight(true);
      cube.turnBottom(true);
    }
  }
  /*
  public void optimizeAlgorithm(ArrayList<Turn> aCode){
   //if there are three of the same turn in a row, switch it with a single turn of the same face in the opposite direction
   for(int i = aCode.size()-3; i >= 0; i--){
   if(aCode.get(i).equals(aCode.get(i+1)) && aCode.get(i).equals(aCode.get(i+2))){
   aCode.set(i+2, new Turn(aCode.get(i).getFace(), !aCode.get(i).getDirection()));
   for(int j = 0; j < 2; j++) aCode.remove(i);
   }
   }
   //if there are turns back to back that cancel each other out, remove them
   for(int i = 0; i < 2; i++){
   for(int j = aCode.size()-2; j >= 0; j--){
   if(aCode.get(j).isOpposite(aCode.get(j+1))){
   for(int k = 0; k < 2; k++) aCode.remove(j);
   }
   }
   }
   }*/
}