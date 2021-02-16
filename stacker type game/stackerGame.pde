float dir = 1;
int stackNum =0;
boolean gameLost = false;
PVector [] stackInfo = new PVector [16];
int [] stackDispl = new int[16];
boolean upDebug = false;

void setup() {
  size(1280, 720);

  for (int i=0; i<stackInfo.length; i++) {
    stackInfo[i] = new PVector(i*90, 0, 3);  //represents x-value,y-value and count of squares left (z) in a stack
  }
}

void draw() {
  background(240, 240, 240);
  fill(255, 147, 79); 

  //Has the player lost?
  if ((stackInfo[stackNum].z < 0) || (stackNum >= 15) || (gameLost == true)) {
    stackNum =0;
    dir = 1;
    for (int i=0; i<stackInfo.length; i++) {
      stackInfo[i] = new PVector(i*90, 0, 3);
    }
    gameLost = false;
  }



  for (int j=0; j<=stackNum; j++) {  
    stackDispl[j] = (int)(stackInfo[j].y /(height/8)+0.5)*height/8;

    if (upDebug) {
      stackInfo[stackNum].y = stackInfo[stackNum-1].y ;
      upDebug = false;
    }
    for (int k = 0; k<=stackInfo[j].z; k++) {
      rect(stackInfo[j].x, stackDispl[j] + k*90, width/14.222, height/8);
    }
  }


  for (int i=0; i<=1280; i+=90) {
    stroke(0);
    line(0, i, width, i);
    line(i, 0, i, height);
  }

  stackInfo[stackNum].y +=  dir;
  if ((stackInfo[stackNum].y + stackInfo[stackNum].z * 90 + 90 >= height) || (stackInfo[stackNum].y <= 0) ) {
    dir *= -1;
  }
}


void keyPressed() {
  if (key == ' ') {
    //place the first stack
    if (stackNum == 0) { 
      stackNum ++;
      stackInfo[stackNum].y = stackInfo[stackNum - 1].y;

      //place sencond stack and beyond
    } else if (stackNum >=1) {
      
      dir = dir*1.3;
      
      if (stackDispl[stackNum-1] > stackDispl[stackNum]) {   //Up
        if (stackDispl[stackNum-1] >= stackDispl[stackNum] + stackInfo[stackNum].z*90+height/8) { //completely out of sync
          gameLost = true;
        } else if (stackDispl[stackNum-1] < stackDispl[stackNum] + stackInfo[stackNum].z*90+height/8) { //somewhat in sync
          stackInfo[stackNum].z = int(stackInfo[stackNum].z - (stackDispl[stackNum -1] - stackDispl[stackNum] )/90);
          stackInfo[stackNum + 1].z = stackInfo[stackNum].z;
          stackInfo[stackNum].y = stackInfo[stackNum-1].y;
          upDebug = true;
        }
      } else if (stackDispl[stackNum-1] == stackDispl[stackNum]) { //Equal
        stackInfo[stackNum].y = stackInfo[stackNum-1].y;
        stackInfo[stackNum+1].y = stackInfo[stackNum].y;
        stackInfo[stackNum +1].z = stackInfo[stackNum].z;
      } else if (stackDispl[stackNum-1] < stackDispl[stackNum]) { //Down
        if (stackDispl[stackNum] >= stackDispl[stackNum-1] + stackInfo[stackNum-1].z*90+height/8) { //completely out of sync
          gameLost = true;
        } else if (stackDispl[stackNum]+ stackInfo[stackNum].z <= stackDispl[stackNum - 1] + stackInfo[stackNum-1].z) {//untoched
          stackInfo[stackNum+1].y = stackInfo[stackNum].y;
        } else if ((stackDispl[stackNum-1] + stackInfo[stackNum-1].z)  <(stackDispl[stackNum] + stackInfo[stackNum].z)) { //somewhat in sync
          stackInfo[stackNum].z = int(stackInfo[stackNum].z - (stackDispl[stackNum] - stackDispl[stackNum-1] )/90);
          stackInfo[stackNum +1].z = stackInfo[stackNum].z;
          stackInfo[stackNum+1].y = stackDispl[stackNum];
        }
      }
      stackNum ++;
    }
  }
}
