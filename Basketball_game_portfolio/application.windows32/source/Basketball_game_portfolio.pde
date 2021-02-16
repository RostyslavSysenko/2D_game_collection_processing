void setup() {
  size(500,500);
}

void draw() {
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
