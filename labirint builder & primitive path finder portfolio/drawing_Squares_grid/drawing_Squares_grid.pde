int squareScale = 50;
int squareNumber = 500/squareScale;

int [][][] squares = new int [squareNumber][squareNumber][7];//0-x pos; 1-y pos; 2-state; 3-colorR; 4-colorG; 5- colorB, 6 - type(0-none,1-lab, 2-start, 3-end)

void setup() {
  size(500, 500);
  labInit();
}


void draw() {
  labDisplay();
  pathfinding();
}

void mouseDragged() {
chooseSquarePhased();
}

void mousePressed() {
chooseSquarePhased();
}

void keyPressed() {
  phaseIncrement();
  labirintDrawerSupport();
}
