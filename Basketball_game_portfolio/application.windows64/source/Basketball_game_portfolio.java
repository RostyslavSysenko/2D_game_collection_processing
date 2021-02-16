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

public class Basketball_game_portfolio extends PApplet {

public void setup() {
  
}

public void draw() {
  background(255);
  ballTrajectory();
  gameSeparation();
  objectHoop(hoopX, hoopY, hoopDif);
  gameDifficultyAdd(2);
  ballGraphics();
  ballPhysics();
  wallReflectionPhysics();
  objectReflectionPhysics();
  gameplay();
  fanyGraphics();
  scoreRelated();
      stroke(200);
  noFill();
  rect(0,0,499,499);
}
float ballX;
float ballY;
float dia = 30;
float ringSizeDifficulty;
float lineEnd = width*2;
float launchInitX;
float launchInitY;
float launchFinalX;
float launchFinalY;
float speedX;
float speedY;
float screenPositionX;
float screenPositionY;
float screenWidth = 10;
float screenLength = 100;
boolean stretch;
float gravityConstant = 0.2f;
float frictionConstant = 0.7f;
float WallReflectionDisplacementConstant = 3;
int trajectoryLength = 500;
float[][] balltrajectory = new float [trajectoryLength][3];
int counter =0;
int scoreWins = 0;
int scoreTotal = 0;
boolean gameOn = false;
boolean ballScoreStatus;
int hoopX = 4* width;
int hoopY =  height;
int hoopDif = 2;
int time =0;
int x = 1;
int y = 1;


public void Ybounce() {
  speedY = speedY * -frictionConstant;
}

public void Xbounce() {
  speedX = speedX * -frictionConstant;
}

public void wallReflectionPhysics() {
  if (ballX >= width) {  
    Xbounce();
    ballX -=WallReflectionDisplacementConstant;
  }

  if (ballX <= 0) {
    Xbounce();
    ballX +=WallReflectionDisplacementConstant;
  }

  if (ballY >= height) {
    Ybounce();
    ballY -= WallReflectionDisplacementConstant;
  }

  if (ballY <= 0) { 
    Ybounce();
    ballY += WallReflectionDisplacementConstant;
  }
}

public void gameDifficultyAdd(int dif){
  time+= 1;
  hoopDif = 2;
  hoopX += x;
  hoopY += y;
  if (time%50==0){
  x = x*-1;
  y = y*-1;
  }
  println(hoopX, hoopY, x, y, time );
}


public void objectHoop(float locscreenPositionX, float locscreenPositionY, float locringSizeDifficulty) {
  screenPositionX = locscreenPositionX;
  screenPositionY = locscreenPositionY;
  ringSizeDifficulty = locringSizeDifficulty;
  noStroke();
  colours("grey");
  rect(screenPositionX, screenPositionY, screenWidth, screenLength);
  noStroke();
  colours("orange");
  rect(screenPositionX-dia*ringSizeDifficulty, screenPositionY + screenLength - screenLength/5, dia*ringSizeDifficulty, screenWidth);
  colours("lightOrange");
  noStroke();
  rect(screenPositionX-dia*ringSizeDifficulty, screenPositionY + screenLength - screenLength/5, screenWidth, screenWidth);
}

public void gameplay() {
  if (counter == trajectoryLength) {
    gameOn = false;
  }
}
public void gameSeparation() {
  stroke(255, 127, 0);
  line(lineEnd, 0, lineEnd, height);
}

public void ballGraphics() {
  if (stretch) {
    stroke(255, 127, 0);
    line(launchInitX, launchInitY, mouseX, mouseY);
    noStroke();
    fill(255, 127, 0);
    ellipse(mouseX, mouseY, dia, dia);
  }
  if (gameOn) {
    fill(255, 127, 0);
    ellipse(ballX, ballY, dia, dia);
  }
}

public void fanyGraphics(){
  stroke(255, 127, 0);
  text(scoreWins + " / " + scoreTotal, width - 60  , 20 );
}

public void ballPhysics() {
  if (gameOn) {
    ballX = ballX + speedX;
    ballY = ballY + speedY;
    speedY += gravityConstant;
  }
}

public void objectReflectionPhysics() {
  //screen
  if ( (speedX > 0) && (ballX +dia /2> screenPositionX) && (ballX< screenPositionX + screenWidth) && (ballY +dia/2 > screenPositionY) && (ballY -dia/2 < screenPositionY + screenLength)) {
    Xbounce();
    ballX -= WallReflectionDisplacementConstant;
  } else if ( (speedX < 0) && (ballX > screenPositionX) && (ballX - dia/2< screenPositionX + screenWidth) && (ballY + dia/2 > screenPositionY) && (ballY - dia/2 < screenPositionY + screenLength)) {
    Xbounce();
    ballX += WallReflectionDisplacementConstant;
  }

  //hoop
  //horizontal
  if ((speedX > 0) && (ballX + dia/2 > screenPositionX-dia*ringSizeDifficulty) && (ballX + dia/2 < screenPositionX-dia*ringSizeDifficulty+screenWidth) && (ballY + dia/2 > screenPositionY + screenLength - screenLength/5) && (ballY - dia/2 < screenPositionY + screenLength - screenLength/5 + screenWidth)) {
    Xbounce();
    ballX -= WallReflectionDisplacementConstant;
  } else if (((speedX < 0) && (ballX - dia/2 < screenPositionX-dia*ringSizeDifficulty+screenWidth) && (ballX - dia/2 > screenPositionX-dia*ringSizeDifficulty) && (ballY + dia/2 > screenPositionY + screenLength - screenLength/5) && (ballY - dia/2 < screenPositionY + screenLength - screenLength/5 + screenWidth))) {
    Xbounce();
    ballX += WallReflectionDisplacementConstant;
  }
}


public void mousePressed() {
  if (mouseX <= lineEnd) {
    launchInitX = mouseX;
    launchInitY = mouseY;
    ellipse(mouseX, mouseY, dia, dia);
    stretch = true;
    counter =0;
  }
}



public void mouseReleased() {
  gameOn = true;
  ballScoreStatus = true;
  launchFinalX = mouseX;
  launchFinalY = mouseY;
  speedX = (launchInitX - launchFinalX)/7;
  speedY = (launchInitY - launchFinalY)/7;
  stretch = false;
  ballX = mouseX;
  ballY = mouseY;
  scoreTotal ++;
}

public void colours(String colour) {
  if (colour == "orange") {
    fill(255, 127, 0);
  }
  if (colour == "grey") {
    fill(0, 200);
  }
  if (colour == "lightOrange") {
    fill(255, 200, 0);
  }
}


public void ballTrajectory() {
  if (counter == trajectoryLength) {
    counter =0;
    gameOn = false;
  }
  for (int i = 0; i<3; i++) {
    if (i == 0) {
      //Xcoordinate
      balltrajectory[counter][0] = ballX;
    } else if (i ==1) {
      //Ycoordinate
      balltrajectory[counter][1] = ballY;
    } else if ((i ==2) && (counter%2==0)) {
      //transparency
      balltrajectory[counter][2] = 0+counter/5;
    }
  }
  for (int j = 0; j<balltrajectory.length; j++) {
    fill(255, 127, 0, balltrajectory[j][2]);
    noStroke();
    ellipse(balltrajectory[j][0], balltrajectory[j][1], dia, dia);
  }
  if (gameOn) {
    counter ++;
  }
}


public void scoreRelated() {
    if ((speedY > 0) && (ballX - dia/2 >= screenPositionX-dia*ringSizeDifficulty) && (ballX + dia/2 <= screenPositionX)&&(ballY>= screenPositionY + screenLength - screenLength/5)&&(ballY <= screenPositionY + screenLength - screenLength/5 + screenWidth))
      scoreWins++;
    ballScoreStatus = false;
}
  public void settings() {  size(500,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#FFFFFF", "--stop-color=#cccccc", "Basketball_game_portfolio" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
