int stackLength = 500/10;
int stackWidth = 20;
int numberOfRaws = 4;
int displacementBlockY = 60;
int colourTempq;
int colourTempw;
int colourTempe;

int [][] stackInfo = new int [stackLength* numberOfRaws][4];

  


void stacks(){
  for (int i =0; i< stackInfo.length; i++){
    fill(stackInfo[i][0],stackInfo[i][0],stackInfo[i][0]);
    if (stackInfo[i][3]==1){
    rect(stackInfo[i][1],stackInfo[i][2], stackLength, stackWidth);
    }

}
}
