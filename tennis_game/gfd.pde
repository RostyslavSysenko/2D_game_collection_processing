//ball phsyics
  void ballPhysics(){
    //total wins
    if (time >= 30){totalWins++;
    timeFrames = 0;
  ballX = random(0, width- sizeOfRectangle);
    ballY = random(0, height- sizeOfRectangle);
    angle = random(20, 60);
    serve = true;
    if (speed == 0) { 
    speed = 2;
    level = "easy" ;
    }
    totalPlayed += 1;
      speedX = directionX * speed*abs(cos(angle));
  speedY = directionY * speed*abs(sin(angle));
}
    
  if (serve) {
 //<>//
    ballX = ballX + speedX; //<>//
    ballY = ballY + speedY;
    
    //level difficulty increasing
    
    timeFrames++;
    time = timeFrames/60;
    if (timeFrames%10==0){
      speedX*=1.01;
      speedY*=1.01;
    }
    
    
    
    //ball reflection sides
    if ((ballX > width - sizeOfRectangle) || (ballX < 0)) { //<>//
      if (directionX == 1){ directionX = -1; ballX -= 3;    randomFill();} else {directionX = 1; ballX += 3;    randomFill();};
      speedX = speedX * directionX;
    }
    //ball reflection top and bet
    if ((ballY <= 0) || ((ballX - sizeOfRectangle >= positionBatX) && (ballX <= (positionBatX + lengthBat)) && (ballY + sizeOfRectangle >= (height - 2* widthBat)) && (ballY <= (height - (2* widthBat)+widthBat)))) {
      if (directionY == 1){ directionY = -1;  ballY -= 3;  randomFill();} else {directionY = 1; ballY += 3;   randomFill();} ;
      speedY = speedY * directionY;
    }
    
    //ball out
    if (ballY > height) {
      serve = false;
      lossCount = lossCount +1;
    }
    rect(ballX, ballY, sizeOfRectangle, sizeOfRectangle);
  }}
