//Circle Grid + Square Grid
int gridSize = 100;
  int iterations = 12;
  int rotation = 14;
  void setup() {
    size(600, 600);
    background(255);
    stroke(0, 80);
    rectMode(CENTER);
    noLoop();
}
// number of times loop runs
// rotation in degree
// set stroke transparency to 80%
// set rect drawmode to center
void draw() {
  for (int x = gridSize/2; x < width; x+=gridSize) {
    for (int y = gridSize/2; y < height; y+=gridSize) {
float rectSize = gridSize-10;
pushMatrix();
translate(x, y);
for (int i = 0; i < iterations; i++) {
// set rect size 10px smaller than grid
          fill (0,random(20));
          rect(0, 0, rectSize, rectSize);
          rectSize = rectSize / (sin(radians(rotation)) + cos(radians(rotation)));
          rotate(radians(rotation));
}
        popMatrix();
      }
}
for (int x = gridSize; x < width; x += gridSize) {
// first loop in x-direction
// second loop in y-direction
// set random circle size
// set random gray value
// draw circle at each x,y position
    for (int y = gridSize; y < height; y += gridSize) {
      float circleSize = random(gridSize*0.3, gridSize);
      fill(random(255));
      ellipse(x, y, circleSize, circleSize);
} }
}
