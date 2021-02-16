boolean serve;
float speed;
float ballX ;
float ballY ;
float sizeOfRectangle = 20;
float speedX;
float speedY;
float lengthBat = 100;
float widthBat = 20;
float positionBatX;
float angle;
float directionX = 1;
float directionY = 1;
int lossCount = 0;
int totalPlayed = 0;
int totalWins = 0;
String level = "not selected";
int timeFrames = 0;
int time = 0;



void setup() {
  size(500, 500);
  
  //for (int i =0; i< stackInfo.length; i++){
  ////1 - colour
  ////2 - positionX
  ////3 - positionY
  ////4 - existanceState
  //if(i<10){
  //stackInfo[i][1] = stackLength * i ;
  //stackInfo[i][2] = stackWidth + displacementBlockY;
  //stackInfo[i][0] = 255;
  //} else if(i>=10 && i<20){
  //stackInfo[i][1] = stackLength * (i-10);
  //stackInfo[i][2] = stackWidth * 2 + displacementBlockY;
  //stackInfo[i][0] = 200;
  //}else if(i>=20 && i<30){
  //stackInfo[i][1] = stackLength * (i-20);
  //stackInfo[i][2] = stackWidth * 3 + displacementBlockY;
  //stackInfo[i][0] = 150;
  //}else if(i>=30 && i<40){
  //  stackInfo[i][1] = stackLength * (i-30);
  //  stackInfo[i][2] = stackWidth * 4 + displacementBlockY;
  //  stackInfo[i][0] = 100;
  //}
  //stackInfo[i][3] = 1; //they exist
  //}
  


}

void draw() {
  background(29);
  strokeWeight(10);
  line(0,0,width,0);
  line(0,0,0,height);
  line(width,0,width,height);
  strokeWeight(1);
  counting();
  //stacks();
  
  //bat display
  if (mouseX <= lengthBat/2) { 
    positionBatX = 0 ;
  } else if (mouseX >= width - lengthBat/2) {
    positionBatX = width - lengthBat;
  } else {
    positionBatX = mouseX-(lengthBat/2);
  }

  rect(positionBatX, height - 2* widthBat, lengthBat, widthBat);



  //generating a new serve ball
  if (ballY > height) { 
    ballX = random(0, width);
    ballY = random(0, height/2);
    serve = false;
  }

  ballPhysics(); //<>//


}



//button functionality
void keyPressed() {
  if (key == 's') {
    ballX = random(0, width- sizeOfRectangle);
    ballY = random(0, height- sizeOfRectangle);
    angle = random(20, 60);
    serve = true;
    if (speed == 0) { 
    speed = 2;
    level = "easy" ;
    }
    totalPlayed += 1;
    time = 30;
  }
  
  if (key == '1') {
    speed=2;
    level = "easy";
  } else if (key == '2') {
    speed= 4;
    level = "medium";
  } else if (key == '3') {
    speed= 6;
    level = "difficult";
  }
  speedX = directionX * speed*abs(cos(angle));
  speedY = directionY * speed*abs(sin(angle));
}
