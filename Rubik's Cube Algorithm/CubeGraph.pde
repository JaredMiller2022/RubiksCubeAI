class CubeGraph {
  PVector[][][] squareMatrix;
  int[][] colorTable = {  {182, 18, 52}, //red
    {255, 88, 0}, //orange
    {0, 70, 173}, //blue
    {0, 155, 72}, //green
    {255, 213, 0}, //yellow
    {255, 255, 255}  };  //white

  CubeGraph() {//The points for each square on the face

    squareMatrix = new PVector[6][9][4];// cube display
    
    //PVector -- gives a movement value to objects

    for (int i = 0; i<3; i++)// front side display
      for (int j = 0; j<3; j++) {
        squareMatrix[0][i*3+j][0] = new PVector((i-1.5)*scaler, (j-1.5)*scaler, 1.5*scaler);
        squareMatrix[0][i*3+j][1] = new PVector((i-1.5)*scaler, (j-1.5+1)*scaler, 1.5*scaler);
        squareMatrix[0][i*3+j][2] = new PVector((i-1.5+1)*scaler, (j-1.5+1)*scaler, 1.5*scaler);
        squareMatrix[0][i*3+j][3] = new PVector((i-1.5+1)*scaler, (j-1.5)*scaler, 1.5*scaler);
      }
    for (int i = 0; i<3; i++)
      for (int j = 0; j<3; j++) { // back side display
        squareMatrix[1][i*3+j][0] = new PVector((i-1.5)*scaler, (j-1.5)*scaler, -1.5*scaler);
        squareMatrix[1][i*3+j][1] = new PVector((i-1.5)*scaler, (j-1.5+1)*scaler, -1.5*scaler);
        squareMatrix[1][i*3+j][2] = new PVector((i-1.5+1)*scaler, (j-1.5+1)*scaler, -1.5*scaler);
        squareMatrix[1][i*3+j][3] = new PVector((i-1.5+1)*scaler, (j-1.5)*scaler, -1.5*scaler);
      }
    for (int i = 0; i<3; i++)
      for (int j = 0; j<3; j++) { // left side display
        squareMatrix[2][i*3+j][0] = new PVector((i-1.5)*scaler, 1.5*scaler, (j-1.5)*scaler);
        squareMatrix[2][i*3+j][1] = new PVector((i-1.5)*scaler, 1.5*scaler, (j-1.5+1)*scaler);
        squareMatrix[2][i*3+j][2] = new PVector((i-1.5+1)*scaler, 1.5*scaler, (j-1.5+1)*scaler);
        squareMatrix[2][i*3+j][3] = new PVector((i-1.5+1)*scaler, 1.5*scaler, (j-1.5)*scaler);
      }
    for (int i = 0; i<3; i++)
      for (int j = 0; j<3; j++) { // middle display
        squareMatrix[3][i*3+j][0] = new PVector((i-1.5)*scaler, -1.5*scaler, (j-1.5)*scaler);
        squareMatrix[3][i*3+j][1] = new PVector((i-1.5)*scaler, -1.5*scaler, (j-1.5+1)*scaler);
        squareMatrix[3][i*3+j][2] = new PVector((i-1.5+1)*scaler, -1.5*scaler, (j-1.5+1)*scaler);
        squareMatrix[3][i*3+j][3] = new PVector((i-1.5+1)*scaler, -1.5*scaler, (j-1.5)*scaler);
      }
    for (int i = 0; i<3; i++)
      for (int j = 0; j<3; j++) { // right side display
        squareMatrix[4][i*3+j][0] = new PVector(1.5*scaler, (i-1.5)*scaler, (j-1.5)*scaler);
        squareMatrix[4][i*3+j][1] = new PVector(1.5*scaler, (i-1.5)*scaler, (j-1.5+1)*scaler);
        squareMatrix[4][i*3+j][2] = new PVector(1.5*scaler, (i-1.5+1)*scaler, (j-1.5+1)*scaler);
        squareMatrix[4][i*3+j][3] = new PVector(1.5*scaler, (i-1.5+1)*scaler, (j-1.5)*scaler);
      }
    for (int i = 0; i<3; i++)
      for (int j = 0; j<3; j++) { // bottom side display
        squareMatrix[5][i*3+j][0] = new PVector(-1.5*scaler, (i-1.5)*scaler, (j-1.5)*scaler);
        squareMatrix[5][i*3+j][1] = new PVector(-1.5*scaler, (i-1.5)*scaler, (j-1.5+1)*scaler);
        squareMatrix[5][i*3+j][2] = new PVector(-1.5*scaler, (i-1.5+1)*scaler, (j-1.5+1)*scaler);
        squareMatrix[5][i*3+j][3] = new PVector(-1.5*scaler, (i-1.5+1)*scaler, (j-1.5)*scaler);
      }
  }

  void display() {//will display the values created in the method above
    for (int i = 0; i<6; i++) {
      fill(colorTable[i][0], colorTable[i][1], colorTable[i][2]);//If the surface colors are read from camera, the fill() should be insert in the Shape module
      for (int j = 0; j<9; j++) {
        fill(cords[i*9+j].col[0], cords[i*9+j].col[1], cords[i*9+j].col[2]);// assigns color to the arraylist for reference
        if (!isSolving) {
          if (cords[i*9+j].col[0]==222 && cords[i*9+j].col[1]==222 && cords[i*9+j].col[2]==222)
            cords[i*9+j].colr = "Gray";
          if (cords[i*9+j].col[0]==182 && cords[i*9+j].col[1]==18 && cords[i*9+j].col[2]==52)
            cords[i*9+j].colr = "Red";
          if (cords[i*9+j].col[0]==255 && cords[i*9+j].col[1]==88 && cords[i*9+j].col[2]==0)
            cords[i*9+j].colr = "Orange";
          if (cords[i*9+j].col[0]==255 && cords[i*9+j].col[1]==213 && cords[i*9+j].col[2]==0)
            cords[i*9+j].colr = "Yellow";
          if (cords[i*9+j].col[0]==0 && cords[i*9+j].col[1]==155 && cords[i*9+j].col[2]==72)
            cords[i*9+j].colr = "Green";
          if (cords[i*9+j].col[0]==0 && cords[i*9+j].col[1]==70 && cords[i*9+j].col[2]==173)
            cords[i*9+j].colr = "Blue";
          if (cords[i*9+j].col[0]==255 && cords[i*9+j].col[1]==255 && cords[i*9+j].col[2]==255)
            cords[i*9+j].colr = "White";
        }
        beginShape(QUAD);
        vertex(squareMatrix[i][j][0].x, squareMatrix[i][j][0].y, squareMatrix[i][j][0].z);// displays 3d cube with vector values
        vertex(squareMatrix[i][j][1].x, squareMatrix[i][j][1].y, squareMatrix[i][j][1].z);
        vertex(squareMatrix[i][j][2].x, squareMatrix[i][j][2].y, squareMatrix[i][j][2].z);
        vertex(squareMatrix[i][j][3].x, squareMatrix[i][j][3].y, squareMatrix[i][j][3].z);
        endShape();
      }
    }
  }

  void rTransform(PVector p, int axis, int direction) {//Simple rotation algorithm implemented in all turn
    float temp;
    if (axis == 1) {
      temp = p.y;
      p.y = p.y * cos(radians(direction * turnRate))- p.z * sin(radians(direction * turnRate));
      p.z = temp *sin(radians(direction * turnRate))+ p.z * cos(radians(direction * turnRate));
    } else if (axis == 2) {
      temp = p.x;
      p.x = p.x * cos(radians(direction * turnRate))- p.z * sin(radians(direction * turnRate));
      p.z = temp *sin(radians(direction * turnRate))+ p.z * cos(radians(direction * turnRate));
    } else {
      temp = p.x;
      p.x = p.x * cos(radians(direction * turnRate))- p.y * sin(radians(direction * turnRate));
      p.y = temp *sin(radians(direction * turnRate))+ p.y * cos(radians(direction * turnRate));
    }
  }

  /*-----------------------------------------------------------------------------Start of Twists-------------------------------------------------------------------------------------------*/
  void middleTwist() {// turns whole cube 90 degrees
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].x>=-(1.5*scaler+1))||(squareMatrix[i][j][1].x>=-(1.5*scaler+1))||(squareMatrix[i][j][2].x>=-(1.5*scaler+1))||(squareMatrix[i][j][3].x>=(1.5*scaler+1))) {
          rTransform(squareMatrix[i][j][0], 1, 1);
          rTransform(squareMatrix[i][j][1], 1, 1);
          rTransform(squareMatrix[i][j][2], 1, 1);
          rTransform(squareMatrix[i][j][3], 1, 1);
        }
  }
  void rightTwist() {//turns right side
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].x>=1.5*scaler-1)||(squareMatrix[i][j][1].x>=1.5*scaler-1)||(squareMatrix[i][j][2].x>=1.5*scaler-1)||(squareMatrix[i][j][3].x>=1.5*scaler-1)) {
          rTransform(squareMatrix[i][j][0], 1, 1);
          rTransform(squareMatrix[i][j][1], 1, 1);
          rTransform(squareMatrix[i][j][2], 1, 1);
          rTransform(squareMatrix[i][j][3], 1, 1);
        }
  }
  void reverseRightTwist() {//turns right side backwards
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].x>=1.5*scaler-1)||(squareMatrix[i][j][1].x>=1.5*scaler-1)||(squareMatrix[i][j][2].x>=1.5*scaler-1)||(squareMatrix[i][j][3].x>=1.5*scaler-1)) {
          rTransform(squareMatrix[i][j][0], 1, -1);
          rTransform(squareMatrix[i][j][1], 1, -1);
          rTransform(squareMatrix[i][j][2], 1, -1);
          rTransform(squareMatrix[i][j][3], 1, -1);
        }
  }
  void leftTwist() {//turns left side
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].x<=-(1.5*scaler-1))||(squareMatrix[i][j][1].x<=-(1.5*scaler-1))||(squareMatrix[i][j][2].x<=-(1.5*scaler-1))||(squareMatrix[i][j][3].x<=-(1.5*scaler-1))) {
          rTransform(squareMatrix[i][j][0], 1, -1);
          rTransform(squareMatrix[i][j][1], 1, -1);
          rTransform(squareMatrix[i][j][2], 1, -1);
          rTransform(squareMatrix[i][j][3], 1, -1);
        }
  }
  void reverseLeftTwist() {//turns left side backwards
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].x<=-(1.5*scaler-1))||(squareMatrix[i][j][1].x<=-(1.5*scaler-1))||(squareMatrix[i][j][2].x<=-(1.5*scaler-1))||(squareMatrix[i][j][3].x<=-(1.5*scaler-1))) {
          rTransform(squareMatrix[i][j][0], 1, 1);
          rTransform(squareMatrix[i][j][1], 1, 1);
          rTransform(squareMatrix[i][j][2], 1, 1);
          rTransform(squareMatrix[i][j][3], 1, 1);
        }
  }
  void bottomTwist() {// truns bottom
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].y>=1.5*scaler-1)||(squareMatrix[i][j][1].y>=1.5*scaler-1)||(squareMatrix[i][j][2].y>=1.5*scaler-1)||(squareMatrix[i][j][3].y>=1.5*scaler-1)) {
          rTransform(squareMatrix[i][j][0], 2, -1);
          rTransform(squareMatrix[i][j][1], 2, -1);
          rTransform(squareMatrix[i][j][2], 2, -1);
          rTransform(squareMatrix[i][j][3], 2, -1);
        }
  }     
  void reverseBottomTwist() {// turns bottom backwards
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].y>=1.5*scaler-1)||(squareMatrix[i][j][1].y>=1.5*scaler-1)||(squareMatrix[i][j][2].y>=1.5*scaler-1)||(squareMatrix[i][j][3].y>=1.5*scaler-1)) {
          rTransform(squareMatrix[i][j][0], 2, 1);
          rTransform(squareMatrix[i][j][1], 2, 1);
          rTransform(squareMatrix[i][j][2], 2, 1);
          rTransform(squareMatrix[i][j][3], 2, 1);
        }
  }
  void upTwist() {// twists upwards
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].y<=-(1.5*scaler-1))||(squareMatrix[i][j][1].y<=-(1.5*scaler-1))||(squareMatrix[i][j][2].y<=-(1.5*scaler-1))||(squareMatrix[i][j][3].y<=-(1.5*scaler))) {
          rTransform(squareMatrix[i][j][0], 2, -1);
          rTransform(squareMatrix[i][j][1], 2, -1);
          rTransform(squareMatrix[i][j][2], 2, -1);
          rTransform(squareMatrix[i][j][3], 2, -1);
        }
  }
  void reverseUpTwist() { // twists downwards
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].y<=-(1.5*scaler-1))||(squareMatrix[i][j][1].y<=-(1.5*scaler-1))||(squareMatrix[i][j][2].y<=-(1.5*scaler-1))||(squareMatrix[i][j][3].y<=-(1.5*scaler))) {
          rTransform(squareMatrix[i][j][0], 2, 1);
          rTransform(squareMatrix[i][j][1], 2, 1);
          rTransform(squareMatrix[i][j][2], 2, 1);
          rTransform(squareMatrix[i][j][3], 2, 1);
        }
  }
  void frontTwist() {// truns front
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].z>=1.5*scaler-1)||(squareMatrix[i][j][1].z>=1.5*scaler-1)||(squareMatrix[i][j][2].z>=1.5*scaler-1)||(squareMatrix[i][j][3].z>=1.5*scaler-1)) {
          rTransform(squareMatrix[i][j][0], 3, -1);
          rTransform(squareMatrix[i][j][1], 3, -1);
          rTransform(squareMatrix[i][j][2], 3, -1);
          rTransform(squareMatrix[i][j][3], 3, -1);
        }
  }  
  void reverseFrontTwist() { // turns front backwards
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].z>=1.5*scaler-1)||(squareMatrix[i][j][1].z>=1.5*scaler-1)||(squareMatrix[i][j][2].z>=1.5*scaler-1)||(squareMatrix[i][j][3].z>=1.5*scaler-1)) {
          rTransform(squareMatrix[i][j][0], 3, 1);
          rTransform(squareMatrix[i][j][1], 3, 1);
          rTransform(squareMatrix[i][j][2], 3, 1);
          rTransform(squareMatrix[i][j][3], 3, 1);
        }
  }
  void backTwist() { // tins back side
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].z<=-(1.5*scaler-1))||(squareMatrix[i][j][1].z<=-(1.5*scaler-1))||(squareMatrix[i][j][2].z<=-(1.5*scaler-1))||(squareMatrix[i][j][3].z<=-(1.5*scaler-1))) {
          rTransform(squareMatrix[i][j][0], 3, -1);
          rTransform(squareMatrix[i][j][1], 3, -1);
          rTransform(squareMatrix[i][j][2], 3, -1);
          rTransform(squareMatrix[i][j][3], 3, -1);
        }
  }
  void reverseBackTwist() {// turns backside backwards
    for (int i=0; i<6; i++)
      for (int j=0; j<9; j++)
        if ((squareMatrix[i][j][0].z<=-(1.5*scaler-1))||(squareMatrix[i][j][1].z<=-(1.5*scaler-1))||(squareMatrix[i][j][2].z<=-(1.5*scaler-1))||(squareMatrix[i][j][3].z<=-(1.5*scaler-1))) {
          rTransform(squareMatrix[i][j][0], 3, 1);
          rTransform(squareMatrix[i][j][1], 3, 1);
          rTransform(squareMatrix[i][j][2], 3, 1);
          rTransform(squareMatrix[i][j][3], 3, 1);
        }
  }
  /*-----------------------------------------------------------------------------------End of Twists-----------------------------------------------------------------------------------*/

  void singleTwist() {// select Turn Case
    if (clock<45) {
      switch(faceTurn) {
      case 1:
        upTwist();
        clock++;
        break;
      case 2:
        bottomTwist();
        clock++;
        break;
      case 3:
        frontTwist();
        clock++;
        break;
      case 4:
        backTwist();
        clock++;
        break;
      case 5:
        leftTwist();
        clock++;
        break;
      case 6:
        rightTwist();
        clock++;
        break;
      case 7:
        reverseUpTwist();
        clock++;
        break;
      case 8:
        reverseBottomTwist();
        clock++;
        break;
      case 9:
        reverseFrontTwist();
        clock++;
        break;
      case 10:
        reverseBackTwist();
        clock++;
        break;
      case 11:
        reverseLeftTwist();
        clock++;
        break;
      case 12:
        reverseRightTwist();
        clock++;
        break;
      case 13:
        middleTwist();
        clock++;
        break;
      }
    } else {
      clock=0;
      faceTurn=0;
    }
  }
  void setButtons() {// create UI buttons and interactions
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    fill(0);
    if (isSolving) {
      rect(width/4.2, height/1.3, width/15, width/15);// next button
    }
    rect(width/2, height/8, width/10, width/15);//solve button
    if (mousePressed) {
      if (isSolving) {
        if (mouseX>width/4.2-width/30 && mouseX<width/4.2+width/30 && mouseY>height/1.3-width/30 && mouseY<height/1.3+width/30) {//solve button
          show3D=true;
        }
      }
      if (mouseX>width/2-width/20 && mouseX<width/20+width/2 && mouseY>height/8-width/30 && mouseY<height/8+width/30) {//next  button
        isSolving=true;
      }
    }
    textSize(20);
    fill(255);
    text("SOLVE", width/2, height/8);
    if (isSolving) {
      text("NEXT", width/4.2, height/1.3);
    }
    rectMode(CORNER);
  }
}