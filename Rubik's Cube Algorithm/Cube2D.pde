class CubeGraph2D extends CubeGraph {


  int n = 0;
  int scaler = width/30;// variable for scaling UI with screen size


  void display() {
    stroke(0);
    fill(222);

// display Color pallete
    for (int i = 0; i<=2; i++) {
      for (int j = 0; j<=2; j++) {
        rect(width/2+(i*scaler), height/2+(j*scaler), scaler, scaler);//center Cube
        rect(scaler*3+width/2+(i*scaler), height/2+(j*scaler), scaler, scaler);//right Cube
        rect(scaler*6+width/2+(i*scaler), height/2+(j*scaler), scaler, scaler);//far right Cube
        rect(-(scaler*3)+width/2+(i*scaler), height/2+(j*scaler), scaler, scaler);//left Cube
        rect(width/2+(i*scaler), (scaler*3)+height/2+(j*scaler), scaler, scaler);//bottom Cube
        rect(width/2+(i*scaler), -(scaler*3)+height/2+(j*scaler), scaler, scaler);//top Cube
      }
    }
// displays 2D cube with correct selected color    
    for (int i = 0; i<=2; i++) {
      for (int j = 0; j<=1; j++) {
        rectMode(CORNER);
        stroke(0);
        fill(colorTable[n][0], colorTable[n][1], colorTable[n][2]);// selects color from color table
        n++;
        rect((i*scaler), (j*scaler), scaler, scaler);//color pallete
      }
    }
  }

  void interactions() {
    if (!isSolving)
      if (mousePressed==true) {  
        if (mouseX<(1*scaler)&&mouseY<(1*scaler)) {//pick red from pallete
          s1.col = colorTable[0];
        }  
        if (mouseX>(1*scaler)&& mouseX<(2*scaler)&&mouseY<(1*scaler)) {//pick blue from pallete
          s1.col = colorTable[2];
        }  
        if (mouseX>(2*scaler)&& mouseX<(3*scaler)&&mouseY<(1*scaler)) {//pick yellow from pallete
          s1.col = colorTable[4];
        }  
        if (mouseX<(1*scaler)&&mouseY>(1*scaler)&&mouseY<(2*scaler)) {//pick orange from pallete
          s1.col = colorTable[1];
        }  
        if (mouseX>(1*scaler)&&mouseX<(2*scaler)&&mouseY>(1*scaler)&&mouseY<(2*scaler)) {//pick green from pallete
          s1.col = colorTable[3];
        }  
        if (mouseX>(2*scaler)&& mouseX<(3*scaler)&&mouseY>(1*scaler)&&mouseY<(2*scaler)) {//pick white from pallete
          s1.col = colorTable[5];
        }  

    //
        for (int i = 0; i<cords.length; i++) {// for loop that sets the cubes color
          xpos = cords[i].x;
          ypos = cords[i].y;

          if (cords[i].face==0) {
            if (mouseX > -(scaler*3)+width/2+(xpos*scaler) && mouseX < -(scaler*3)+width/2+(xpos*scaler)+scaler && mouseY>height/2+(ypos*scaler)&& mouseY<height/2+(ypos*scaler)+scaler) {
              cords[i].col = s1.col;
            }
          }
          if (cords[i].face==1) {
            if (mouseX > width/2+(xpos*scaler) && mouseX <width/2+(xpos*scaler) +scaler &&   mouseY > height/2+(ypos*scaler) && mouseY< height/2+(ypos*scaler)+scaler) {
              cords[i].col = s1.col;
            }
          }
          if (cords[i].face==2) {
            if (mouseX > scaler*3+width/2+(xpos*scaler) && mouseX <scaler*3+width/2+xpos*scaler+scaler &&   mouseY > height/2+(ypos*scaler) && mouseY< height/2+(ypos*scaler)+scaler) {
              cords[i].col = s1.col;
            }
          }
          if (cords[i].face==3) {
            if (mouseX > scaler*6+width/2+(xpos*scaler) && mouseX <scaler*6+width/2+(xpos*scaler)+scaler &&   mouseY > height/2+(ypos*scaler) && mouseY< height/2+(ypos*scaler)+scaler) {
              cords[i].col = s1.col;
            }
          }
          if (cords[i].face==4) {
            if (mouseX > width/2+(xpos*scaler) && mouseX <width/2+(xpos*scaler)+scaler &&   mouseY > -(scaler*3)+height/2+(ypos*scaler) && mouseY< -(scaler*3)+height/2+(ypos*scaler)+scaler) {
              cords[i].col = s1.col;
            }
          }
          if (cords[i].face==5) {
            if (mouseX > width/2+(xpos*scaler) && mouseX <width/2+(xpos*scaler)+scaler &&   mouseY > (scaler*3)+height/2+(ypos*scaler) && mouseY< (scaler*3)+height/2+(ypos*scaler)+scaler) {
              cords[i].col = s1.col;
            }
          }
        }
      }
    for (int i = 0; i<cords.length; i++) {// display colored CubeGraphs
      xpos = cords[i].x;
      ypos = cords[i].y;
      fill(cords[i].col[0], cords[i].col[1], cords[i].col[2]);
      if (cords[i].face==0)
        rect(-(scaler*3)+width/2+(xpos*scaler), height/2+(ypos*scaler), scaler, scaler);

      if (cords[i].face==1)
        rect(width/2+(xpos*scaler), height/2+(ypos*scaler), scaler, scaler);// mid CubeGraph

      if (cords[i].face==2)
        rect(scaler*3+width/2+(xpos*scaler), height/2+(ypos*scaler), scaler, scaler);// right CubeGraph

      if (cords[i].face==3)
        rect(scaler*6+width/2+(xpos*scaler), height/2+(ypos*scaler), scaler, scaler);

      if (cords[i].face==4)
        rect(width/2+(xpos*scaler), -(scaler*3)+height/2+(ypos*scaler), scaler, scaler);
      if (cords[i].face==5)
        rect(width/2+(xpos*scaler), (scaler*3)+height/2+(ypos*scaler), scaler, scaler);
    }
    rectMode(CENTER);
    if (!isSolving) {
      fill(s1.col[0], s1.col[1], s1.col[2]);
      rect(mouseX, mouseY, width/50, width/50);
    }
    rectMode(CORNER);
  }
}