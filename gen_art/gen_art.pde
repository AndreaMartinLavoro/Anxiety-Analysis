Table table;
int gridSize = 100;
int iterations = 12;
int rotation = 10;
String stx = "";
void setup() {
   size(600, 600);
   background(255);
   stroke(0, 80);
   rectMode(CENTER);
   noLoop();
  table = loadTable("dataset_for_genart.csv", "header");

}
void draw() {
  for (int x = gridSize/2; x < width; x+=gridSize) {
    for (int y = gridSize/2; y < height; y+=gridSize) {
float rectSize = gridSize-10;
pushMatrix();
translate(x, y);
for (TableRow row : table.rows()) {
    stx = row.getString("x");
    if(stx == "assistance"){
for (int i = 0; i < iterations; i++) {
// set rect size 10px smaller than grid
          fill (0,random(20));
          rect(0, 0, rectSize, rectSize);
          rectSize = rectSize / (sin(radians(rotation)) + cos(radians(rotation)));
          rotate(radians(rotation));
}
    }
    
    if(stx == "relationships"){
for (int i = 0; i < iterations; i++) {
// set rect size 10px smaller than grid
          fill (0,random(30));
          rect(1, 5, rectSize, rectSize);
          rectSize = rectSize / (sin(radians(rotation)) + cos(radians(rotation)));
          rotate(radians(rotation));
}
    }
    
    
    else{
for (int i = 0; i < iterations; i++) {
// set rect size 10px smaller than grid
          fill (0,random(10));
          rect(3, 7, rectSize, rectSize);
          rectSize = rectSize / (sin(radians(rotation)) + cos(radians(rotation)));
          rotate(radians(rotation));
}
    }
    
}
        popMatrix();
      }
}
for (TableRow row : table.rows()) {
    stx = row.getString("x");
    if (stx == "ptsd"){
    for (int x = gridSize; x < width; x += gridSize) {
    for (int y = gridSize; y < height; y += gridSize) {
      float circleSize = random(gridSize*0.3, gridSize);
      fill(random(255));
      ellipse(x, y, circleSize, circleSize);
} }
    }
    if (stx == "survivorsofabuse"){
    for (int x = gridSize; x < width; x += gridSize) {
    for (int y = gridSize; y < height; y += gridSize) {
      float circleSize = random(gridSize*0.3, gridSize);
      fill(random(144));
      ellipse(y, x, circleSize, circleSize);
} }
    }
    else{
    for (int x = gridSize; x < width; x += gridSize) {
    for (int y = gridSize; y < height; y += gridSize) {
      float circleSize = random(gridSize*0.3, gridSize);
      fill(random(221));
      ellipse(y+1, x, circleSize, circleSize);
} }
    }
  }

}
