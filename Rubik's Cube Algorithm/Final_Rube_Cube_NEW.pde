ArrayList<Turn> alg = new ArrayList();//will store the algorithm: an array List of turns

int scaler = 50;
int turnRate = 2;
int clock = 0;
int faceTurn = 0;
int n = 0;
int k = 0;
int xpos = 0;
int ypos = 0;
int[] tempCol = {222, 222, 222};

square a1 = new square(0, 0, 0);//left most
square a2 = new square(0, 1, 0);
square a3 = new square(0, 2, 0);
square a4 = new square(1, 0, 0);
square a5 = new square(1, 1, 0);
square a6 = new square(1, 2, 0);
square a7 = new square(2, 0, 0);
square a8 = new square(2, 1, 0);
square a9 = new square(2, 2, 0);

square b1 = new square(0, 0, 1);//mid
square b2 = new square(0, 1, 1);
square b3 = new square(0, 2, 1);
square b4 = new square(1, 0, 1);
square b5 = new square(1, 1, 1);
square b6 = new square(1, 2, 1);
square b7 = new square(2, 0, 1);
square b8 = new square(2, 1, 1);
square b9 = new square(2, 2, 1);


square c1 = new square(0, 0, 2);//right
square c2 = new square(0, 1, 2);
square c3 = new square(0, 2, 2);
square c4 = new square(1, 0, 2);
square c5 = new square(1, 1, 2);
square c6 = new square(1, 2, 2);
square c7 = new square(2, 0, 2);
square c8 = new square(2, 1, 2);
square c9 = new square(2, 2, 2);


square d1 = new square(0, 0, 3);//right most
square d2 = new square(0, 1, 3);
square d3 = new square(0, 2, 3);
square d4 = new square(1, 0, 3);
square d5 = new square(1, 1, 3);
square d6 = new square(1, 2, 3);
square d7 = new square(2, 0, 3);
square d8 = new square(2, 1, 3);
square d9 = new square(2, 2, 3);

square e1 = new square(0, 0, 4);//up
square e2 = new square(0, 1, 4);
square e3 = new square(0, 2, 4);
square e4 = new square(1, 0, 4);
square e5 = new square(1, 1, 4);
square e6 = new square(1, 2, 4);
square e7 = new square(2, 0, 4);
square e8 = new square(2, 1, 4);
square e9 = new square(2, 2, 4);

square f1 = new square(0, 0, 5);//down
square f2 = new square(0, 1, 5);
square f3 = new square(0, 2, 5);
square f4 = new square(1, 0, 5);
square f5 = new square(1, 1, 5);
square f6 = new square(1, 2, 5);
square f7 = new square(2, 0, 5);
square f8 = new square(2, 1, 5);
square f9 = new square(2, 2, 5);

square[] cords = {  b1, b2, b3, b4, b5, b6, b7, b8, b9, 
  d7, d8, d9, d4, d5, d6, d1, d2, d3, 
  f3, f2, f1, f6, f5, f4, f9, f8, f7, 
  e1, e2, e3, e4, e5, e6, e7, e8, e9, 
  c7, c4, c1, c8, c5, c2, c9, c6, c3, 
  a1, a4, a7, a2, a5, a8, a3, a6, a9}; 
currentCol s1 = new currentCol();
boolean show3D=false;
int i = 0;
CubeGraph theCubeGraph;
boolean isSolving = false;

void setup() {
  size(500, 500, P3D);
  theCubeGraph = new CubeGraph();
}

void draw() {
  //create an ArrayList to fill with the algorithm
  println("Algorithm...");
  ArrayList<Integer> ray = new ArrayList<Integer>();//the alg arrayList of the algorithm that uses integers instead of Turn objects
  //add the moves to the arrayList
  for (int i = 0; i < alg.size(); i++) {//copy the alg arratList to ray
    ray.add(alg.get(i).getID());
    println(alg.get(i).getID());
  }
  println("Print Complete");

  for (int i = ray.size()-4; i >= 0; i--) {  //if there are four of the same turn in a row, delete them all
    int a = ray.get(i);
    int b = ray.get(i+1);
    int c = ray.get(i+2);
    int d = ray.get(i+3);
    if (a == b && b == c && c == d) {
      for (int j = 0; j < 4; j++) ray.remove(i);
      i -= 3;
    }
  }

  for (int i = ray.size()-2; i >= 0; i--) {//if a turn in one direction is followed by an opposite turn, delete both
    int a = ray.get(i);
    int b = ray.get(i+1);
    if (a == 7 && b == 1 || a == 1 && b == 7 || a == 9 && b == 3 || a == 3 && b == 9 ||
      a == 2 && b == 8 || a == 8 && b == 2 || a == 4 && b == 10 || a == 10 && b == 4 ||
      a == 5 && b == 11 || a == 11 && b == 5 || a == 6 && b == 12 || a == 12 && b == 6) {
      for (int j = 0; j < 2; j++) ray.remove(i);
      i = ray.size()-1;
    }
  }

  for (int i = ray.size()-3; i >= 0; i--) {//if three of the same turn are in a row, replace them with a single turn of the opposite direction
    boolean hasChanged = false;
    int a = ray.get(i);
    int b = ray.get(i+1);
    int c = ray.get(i+2);
    if (a == b && a == c) {
      if (a == 7) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 1);
        hasChanged = true;
      } else if (a == 1) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 7);
        hasChanged = true;
      } else if (a == 9) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 3);
        hasChanged = true;
      } else if (a == 3) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 9);
        hasChanged = true;
      } else if (a == 2) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 8);
        hasChanged = true;
      } else if (a == 8) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 2);
        hasChanged = true;
      } else if (a == 4) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 10);
        hasChanged = true;
      } else if (a == 10) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 4);
        hasChanged = true;
      } else if (a == 5) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 11);
        hasChanged = true;
      } else if (a == 11) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 5);
        hasChanged = true;
      } else if (a == 6) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 12);
        hasChanged = true;
      } else if (a == 12) {
        for (int j = 0; j < 3; j++) ray.remove(i);
        ray.add(i, 6);
        hasChanged = true;
      }
      if (hasChanged) i = ray.size()-2;
    }
  }

  println("\n\nOPTIMIZED ALGORITHM...\n\n");
  for (int i = ray.size()-1; i >=0; i--) {
    println(ray.get(i));
  }

  ArrayList<String> colrs = new ArrayList<String>(); //array that references each square's color
  colrs.add(e1.colr);// top face
  colrs.add(e4.colr);
  colrs.add(e7.colr);
  colrs.add(e2.colr);
  colrs.add(e5.colr);
  colrs.add(e8.colr);
  colrs.add(e3.colr);
  colrs.add(e6.colr);
  colrs.add(e9.colr);

  colrs.add(b1.colr);// middle face
  colrs.add(b4.colr);
  colrs.add(b7.colr);
  colrs.add(b2.colr);
  colrs.add(b5.colr);
  colrs.add(b8.colr);
  colrs.add(b3.colr);
  colrs.add(b6.colr);
  colrs.add(b9.colr);


  colrs.add(f1.colr);// bottom face
  colrs.add(f4.colr);  
  colrs.add(f7.colr);
  colrs.add(f2.colr);
  colrs.add(f5.colr);
  colrs.add(f8.colr);
  colrs.add(f3.colr);
  colrs.add(f6.colr);
  colrs.add(f9.colr);

  colrs.add(d1.colr);// back face
  colrs.add(d4.colr);
  colrs.add(d7.colr);
  colrs.add(d2.colr);
  colrs.add(d5.colr);
  colrs.add(d8.colr);
  colrs.add(d3.colr);
  colrs.add(d6.colr);
  colrs.add(d9.colr);

  colrs.add(a1.colr);// left face
  colrs.add(a4.colr);
  colrs.add(a7.colr);
  colrs.add(a2.colr);
  colrs.add(a5.colr);
  colrs.add(a8.colr);
  colrs.add(a3.colr);
  colrs.add(a6.colr);
  colrs.add(a9.colr);

  colrs.add(c1.colr);// right face
  colrs.add(c4.colr);
  colrs.add(c7.colr);
  colrs.add(c2.colr);
  colrs.add(c5.colr);
  colrs.add(c8.colr);
  colrs.add(c3.colr);
  colrs.add(c6.colr);
  colrs.add(c9.colr);



  CubeGraph2D flat = new CubeGraph2D();
  background(222);
  theCubeGraph.setButtons();

  if (isSolving)// if cube Solve button pressed
    if (show3D) {//turn Cube when solve is pressed
      if (clock==0) {
        createAndSolve(colrs);  
        if (i<ray.size()) {
          selectTurn(ray.get(i));
          println(ray.get(i));
          i++;
          //print(colrs);
        }
      }
    }

  show3D = false;

  flat.display();
  flat.interactions();


  float Tymag= -0.5;
  float Txmag= 0.5;
  float ymag= -0.5;
  float xmag= -.35;



  translate(width/4, height/2);//orientate the cube
  Tymag= -pmouseY*PI/100 -.05;
  Txmag= pmouseX*PI/100 +.05;

  if (mousePressed&&(mouseButton == RIGHT)) {//rotate cube with mouse
    ymag = Tymag;
    xmag = Txmag;
  }
  rotateX(ymag);
  rotateY(xmag);
  theCubeGraph.singleTwist();
  theCubeGraph.display();
}


public void selectTurn(Integer i) {// assigns int to a faceturn value
  if (clock==0) {
    if (i==1) {
      faceTurn=1;
    }
    if (i==2) {
      faceTurn=2;
    }
    if (i==3) {
      faceTurn=3;
    }
    if (i==4) {
      faceTurn=4;
    }
    if (i==5) {
      faceTurn=5;
    }
    if (i==6) {
      faceTurn=6;
    }
    if (i==7) {
      faceTurn=7;
    }
    if (i==8) {
      faceTurn=8;
    }
    if (i==9) {
      faceTurn=9;
    }
    if (i==10) {
      faceTurn=10;
    }
    if (i==11) {
      faceTurn=11;
    }
    if (i==12) {
      faceTurn=12;
    }
    if (i==13) {
      faceTurn=13;
    }
  }
}

public void createAndSolve(ArrayList<String> inputCube) {
  Piece[][] top = new Piece[3][3];
  Piece[][] front = new Piece[3][3];
  Piece[][] bottom = new Piece[3][3];
  Piece[][] back = new Piece[3][3];
  Piece[][] left = new Piece[3][3];
  Piece[][] right = new Piece[3][3];
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      top[i][j] = new Piece(inputCube.get(i*3+j));
      front[i][j] = new Piece(inputCube.get(i*3+j+9));
      bottom[i][j] = new Piece(inputCube.get(i*3+j+18));
      back[i][j] = new Piece(inputCube.get(i*3+j+27));
      left[i][j] = new Piece(inputCube.get(i*3+j+36));
      right[i][j] = new Piece(inputCube.get(i*3+j+45));
    }
  }

  Cube cube = new Cube(top, front, bottom, back, left, right);
  print("\n" + cube.printPart() + "\n");
  println("About to call");
  Algorithm solve = new Algorithm(cube);
  alg = solve.getAlgorithm();
  print("\n" + cube.printPart() + "\n");
  println("The Algorithm Solved This Cube In: 0.000" + solve.codeTime + " seconds");
  println("How Fast Can You Solve It?");
}