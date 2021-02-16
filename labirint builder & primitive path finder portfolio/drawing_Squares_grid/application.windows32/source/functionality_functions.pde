int startPosition;
int endPosition;
int phase =1;
boolean upwall =false;
boolean downwall =false;
boolean rightwall =false;
boolean leftwall =false;


void labInit() {
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


void labDisplay() {
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

void chooseSquare(int r, int g, int b) {
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

void labDrawerSupportValueAssign(int dispX, int dispY, int i, int j, int r, int b, int g) {
  squares[i+dispX][j+dispY][2] =1;
  squares[i+dispX][j+dispY][3] = r;
  squares[i+dispX][j+dispY][4] = g;
  squares[i+dispX][j+dispY][5] = b;
  squares[i+dispX][j+dispY][6] = phase;
}

void labRebuild () {
  for (int i =0; i<squareNumber; i++) {
    for (int j =0; j<squareNumber; j++) {
      squares[i][j][2] = 0;
      squares[i][j][6] = 0;
    }
  }
}

void chooseSquarePhased() {
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

void phaseIncrement() {

  if (key == ENTER) {
    if (phase < 4) {
      phase ++;
    } else { 
      labRebuild(); 
      phase = 1;
    }
  }
}

void labirintDrawerSupport() {
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

void labirintDrawerSupportValueHolder(boolean down, boolean up, boolean left, boolean right) {
  downwall =down;
  upwall = up;
  leftwall = left;
  rightwall = right;
}
