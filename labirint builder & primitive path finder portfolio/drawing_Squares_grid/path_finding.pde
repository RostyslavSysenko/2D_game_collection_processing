int currentSquareNumX;
int currentSquareNumY;
int countTemp;
int squareDisplacementX;
int squareDisplacementY;

void pathfinding() {
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

void NumberOfPossibleMoves() {
  if ((currentSquareNumY >= 0) && (currentSquareNumY < squareNumber) && (currentSquareNumX < squareNumber)  && (currentSquareNumX  >= 0 )) { //only continue while finish is not reached
    if (squares[currentSquareNumX][currentSquareNumY][6] != 3) {
      isTheMovePossible(0, 1);
      isTheMovePossible(1, 0);
      isTheMovePossible(0, -1);
      isTheMovePossible(-1, 0);
    }
  }
}

void isTheMovePossible( int dispX, int dispY ) {
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

void isTheMovePossibleIncr(int dispX, int dispY) {
  countTemp++;
  squareDisplacementX = dispX;
  squareDisplacementY = dispY;
}
