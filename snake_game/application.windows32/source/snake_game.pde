int gridCount = 25;
int gridScale = 20;

int dirX;
int dirY;

boolean foodDisplayed = false;
int foodX =100;
int foodY =100;

int snakeSize = 1;
int [][] snakeTail = new int [gridCount * gridCount][2];
int dif = 5;



void setup() {
  size(500, 500);
  stroke(255);
  for (int i = 0; i < gridCount * gridCount; i++) {
    for (int j = 0; j<2; j++) {
      snakeTail[i][j] = -5;
    }
  }
}

void draw() {
  frameRate(dif);
  println(dif);
  background(255);
  food();
  snake();
  gameReset();
  graphicsDisplay();
  difficulty();
  stroke(200);
  noFill();
  rect(0,0,499,499);
}

void keyPressed() {
  if (snakeSize > 1) {
    if ((keyCode == UP) && (dirY == 0)) {
      dirY = -1;
      dirX = 0;
    }
    if ((keyCode == DOWN && (dirY == 0))) {
      dirY = 1;
      dirX = 0;
    }
    if ((keyCode == LEFT && (dirX == 0))) {
      dirY = 0;
      dirX = -1;
    }
    if ((keyCode == RIGHT)&& (dirX == 0)) {
      dirY = 0;
      dirX = 1;
    }
  } else if (snakeSize == 1) {
    if (keyCode == UP) {
      dirY = -1;
      dirX = 0;
    }
    if (keyCode == DOWN) {
      dirY = 1;
      dirX = 0;
    }
    if (keyCode == LEFT) {
      dirY = 0;
      dirX = -1;
    }
    if (keyCode == RIGHT) {
      dirY = 0;
      dirX = 1;
    }
  }
}

void difficulty() {
  if (snakeSize%3==0) {
    dif = 5 + snakeSize/3;
  }
}

void snake() {

  for (int i = snakeSize -1; i> 0; i--) {
    for (int j =0; j< 2; j++) {
      snakeTail[i][j] = snakeTail[i -1][j];
    }
  }

  snakeTail[0][0] = snakeTail[0][0] + dirX*gridScale;
  snakeTail[0][1] =  snakeTail[0][1] + dirY*gridScale;

  for (int i = 0; i < snakeSize; i++) {
    for (int j = 0; (j < snakeSize) && (j != i); j++) {
      if ((snakeTail[i][0] == snakeTail[j][0]) && (snakeTail[i][1] == snakeTail[j][1])) {
        snakeSize = 0;
      }
    }
  }


  fill(255, 120, 0);

  for (int i =0; i< gridCount*gridCount; i++) {
    rect(snakeTail[i][0], snakeTail[i][1], gridScale, gridScale);
  }
}

void graphicsDisplay() {
  text(snakeSize, width -40, 20 );
}

void gameReset() {
  if ((snakeSize == gridCount * gridScale)|| (snakeSize == 0) || (snakeTail[0][0] < 0)|| (snakeTail[0][0] > gridCount*gridScale)||(snakeTail[0][1] < 0)|| (snakeTail[0][1] > gridCount*gridScale)) {
    for (int i = 0; i < gridCount * gridCount; i++) {
      for (int j = 0; j<2; j++) {
        snakeTail[i][j] = -50;
      }

      snakeTail[0][0] = (int)(random(0, 25))*gridScale;
      snakeTail[0][1] = (int)(random(0, 25))*gridScale;

      dirX = 0;
      dirY = 0;

      dif = 5;

      snakeSize = 1;
    }
  }
}

void food() {
  if ((snakeTail[0][0] == foodX) && (snakeTail[0][1] == foodY)) {
    snakeSize ++;
    foodDisplayed = false;
  }
  fill(250, 0, 120);
  if (foodDisplayed == false) { 
    foodX = (int)random(0, gridCount)*gridScale;
    foodY = (int)random(0, gridCount)*gridScale;
    foodDisplayed = true;
    fill(120, 0, 250);
  }

  rect(foodX, foodY, gridScale, gridScale);
}
