import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class drawing_Squares_grid extends PApplet {

int squareScale = 50;
int squareNumber = 500/squareScale;

int [][][] squares = new int [squareNumber][squareNumber][7];//0-x pos; 1-y pos; 2-state; 3-colorR; 4-colorG; 5- colorB, 6 - type(0-none,1-lab, 2-start, 3-end)

public void setup() {
  
  labInit();
}


public void draw() {
  labDisplay();
  pathfinding();
}

public void mouseDragged() {
chooseSquarePhased();
}

public void mousePressed() {
chooseSquarePhased();
}

public void keyPressed() {
  phaseIncrement();
  labirintDrawerSupport();
}
int startPosition;
int endPosition;
int phase =1;
boolean upwall =false;
boolean downwall =false;
boolean rightwall =false;
boolean leftwall =false;


public void labInit() {
  noFill();
  for (int i =0; i<squareNumber; i++) {
    for (int j =0; j<squareNumber; j++) {
      squares[i][j][0] = i * squareScale;
      squares[i][j][1]= j * squareScale;
      squares[i][j][2] = 0;
      squares[i][j][6] = 0;
    }
  }
}


public void labDisplay() {
  background(255);
  for (int i =0; i<squareNumber; i++) {
    for (int j =0; j<squareNumber; j++) {
      line(squares[i][j][0], 0, squares[i][j][0], height);
      line(0, squares[i][j][1], height, squares[i][j][1]);
      if (squares[i][j][2] == 1) {
        fill(squares[i][j][3], squares[i][j][4], squares[i][j][5]);
        rect(squares[i][j][0], squares[i][j][1], squareScale, squareScale);
      }
    }
  }
}

public void chooseSquare(int r, int g, int b) {
  for (int i =0; i<squareNumber; i++) {
    for (int j =0; j<squareNumber; j++) {
      if ((squares[i][j][2] == 0 || squares[i][j][2] == 1) && mouseX>=squares[i][j][0] && mouseX<squares[i][j][0]+squareScale && mouseY>=squares[i][j][1] && mouseY<squares[i][j][1]+squareScale ) {
        squares[i][j][2] =1;
        squares[i][j][3] = r;
        squares[i][j][4] = g;
        squares[i][j][5] = b;

        if (phase == 1) {
          if (downwall == true) {
            labDrawerSupportValueAssign(0, 2, i, j, r, b, g);
          }
          if (upwall == true) {
            labDrawerSupportValueAssign(0, -2, i, j, r, b, g);
          }
          if (leftwall == true) {
            labDrawerSupportValueAssign(-2, 0, i, j, r, b, g);
          }
          if (rightwall == true && i+2<squareNumber) {
            labDrawerSupportValueAssign(2, 0, i, j, r, b, g);
          }
          squares[i][j][6] = phase;
        } else if (phase == 2) {
          squares[i][j][6] = phase;
          currentSquareNumX = i;
          currentSquareNumY = j;
        } else if (phase == 3) {
          squares[i][j][6] = phase;
        }
      }
    }
  }
}

public void labDrawerSupportValueAssign(int dispX, int dispY, int i, int j, int r, int b, int g) {
  squares[i+dispX][j+dispY][2] =1;
  squares[i+dispX][j+dispY][3] = r;
  squares[i+dispX][j+dispY][4] = g;
  squares[i+dispX][j+dispY][5] = b;
  squares[i+dispX][j+dispY][6] = phase;
}

public void labRebuild () {
  for (int i =0; i<squareNumber; i++) {
    for (int j =0; j<squareNumber; j++) {
      squares[i][j][2] = 0;
      squares[i][j][6] = 0;
    }
  }
}

public void chooseSquarePhased() {
  if (phase == 1) {
    chooseSquare(50, 50, 255);
  }
  if (phase == 2) {
    chooseSquare(255, 50, 50);
  }
  if (phase == 3) {
    chooseSquare(255, 50, 50);
  }
}

public void phaseIncrement() {

  if (key == ENTER) {
    if (phase < 4) {
      phase ++;
    } else { 
      labRebuild(); 
      phase = 1;
    }
  }
}

public void labirintDrawerSupport() {
  if (key == TAB) {
    labirintDrawerSupportValueHolder(false, false, false, false);
  } else if (keyCode == DOWN) {
    labirintDrawerSupportValueHolder(true, false, false, false);
  } else if ( keyCode == UP) {
    labirintDrawerSupportValueHolder(false, true, false, false);
  } else if (keyCode == LEFT) {
    labirintDrawerSupportValueHolder(false, false, true, false);
  } else if (keyCode == RIGHT) {
    labirintDrawerSupportValueHolder(false, false, false, true);
  }
}

public void labirintDrawerSupportValueHolder(boolean down, boolean up, boolean left, boolean right) {
  downwall =down;
  upwall = up;
  leftwall = left;
  rightwall = right;
}
int currentSquareNumX;
int currentSquareNumY;
int countTemp;
int squareDisplacementX;
int squareDisplacementY;

public void pathfinding() {
  if (phase ==4) {
    countTemp = 0;
    NumberOfPossibleMoves();
    if (countTemp == 1 || squares[currentSquareNumX][currentSquareNumY][6]== 3) {
      squares[currentSquareNumX][currentSquareNumY][2] = 1;
      squares[currentSquareNumX][currentSquareNumY][3] = 50;
      squares[currentSquareNumX][currentSquareNumY][4] =250;
      squares[currentSquareNumX][currentSquareNumY][5] = 50;
      squares[currentSquareNumX][currentSquareNumY][6] = 1;
      if ((currentSquareNumX<squareNumber-1 && squareDisplacementX == 1) || (currentSquareNumX>0 && squareDisplacementX == -1)) {
        currentSquareNumX +=squareDisplacementX;
      }
      if ((currentSquareNumY<squareNumber-1 && squareDisplacementY == 1) || (currentSquareNumY>0 && squareDisplacementY == -1)) {
        currentSquareNumY +=squareDisplacementY;
      }
    }
  }
}

public void NumberOfPossibleMoves() {
  if ((currentSquareNumY >= 0) && (currentSquareNumY < squareNumber) && (currentSquareNumX < squareNumber)  && (currentSquareNumX  >= 0 )) { //only continue while finish is not reached
    if (squares[currentSquareNumX][currentSquareNumY][6] != 3) {
      isTheMovePossible(0, 1);
      isTheMovePossible(1, 0);
      isTheMovePossible(0, -1);
      isTheMovePossible(-1, 0);
    }
  }
}

public void isTheMovePossible( int dispX, int dispY ) {
  if (dispX == -1 && currentSquareNumX + dispX >= 0 ) {
    if ((squares[currentSquareNumX+ dispX ][currentSquareNumY + dispY][6] == 0 ) || (squares[currentSquareNumX +dispX][currentSquareNumY +dispY][6] == 3 )) {
      isTheMovePossibleIncr(dispX, dispY);
    }
  } else if (dispY == -1 && currentSquareNumY + dispY >= 0 ) {
    if ((squares[currentSquareNumX+ dispX ][currentSquareNumY + dispY][6] == 0 ) || (squares[currentSquareNumX +dispX][currentSquareNumY+dispY][6] == 3 )) {
      isTheMovePossibleIncr(dispX, dispY);
    }
  } else if (dispX == 1 && currentSquareNumX + dispX < squareNumber) {
    if ((squares[currentSquareNumX+ dispX ][currentSquareNumY + dispY][6] == 0 ) || (squares[currentSquareNumX +dispX][currentSquareNumY +dispY][6] == 3 )) {
      isTheMovePossibleIncr(dispX, dispY);
    }
  } else if (dispY == 1 && currentSquareNumY + dispY < squareNumber) {
    if ((squares[currentSquareNumX+ dispX ][currentSquareNumY + dispY][6] == 0 ) || (squares[currentSquareNumX +dispX][currentSquareNumY +dispY][6] == 3 )) {
      isTheMovePossibleIncr(dispX, dispY);
    }
  }
}

public void isTheMovePossibleIncr(int dispX, int dispY) {
  countTemp++;
  squareDisplacementX = dispX;
  squareDisplacementY = dispY;
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#FFFFFF", "--stop-color=#cccccc", "drawing_Squares_grid" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
