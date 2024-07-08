class SceneThree{
int numFish = 10;
int numSeaweed = 20;
Fish[] fishArray = new Fish[numFish];
Seaweed[] seaweedArray = new Seaweed[numSeaweed];
float turtleOffset = 0;
float fishOffset = 0;

void setup() {
  size(1920, 1080);
  for (int i = 0; i < numFish; i++) {
    fishArray[i] = new Fish(random(width), random(height));
  }
  for (int i = 0; i < numSeaweed; i++) {
    seaweedArray[i] = new Seaweed(random(width), height, random(50, 100));
  }
}

void draw() {
  background(0, 0, 128); // Warna biru laut
  
  // Gambar rumput laut
  for (int i = 0; i < numSeaweed; i++) {
    seaweedArray[i].display();
  }
  
  // Gambar ikan
  for (int i = 0; i < numFish; i++) {
    fishArray[i].move();
    fishArray[i].display();
  }
  
  drawCharacter(width / 2, height / 2); // Menggambar tokoh di tengah

  // Calculate vertical oscillation for turtle and fish
  float turtleY = height / 2 + sin(turtleOffset) * 20;
  float fishY = height / 2 + sin(fishOffset) * 20;
  
  drawTurtle(width / 2 + 250, turtleY, 0.6); // Menggambar kura-kura di samping kanan tokoh dengan skala 0.6
  drawFish(width / 2 - 250, fishY, 0.6); // Menggambar ikan di sebelah kiri tokoh dengan skala 0.6
  
  // Update offsets to create the oscillation effect
  turtleOffset += 0.05;
  fishOffset += 0.05;
}

class Fish {
  float x, y;
  float speedX, speedY;
  float fishSize;

  Fish(float startX, float startY) {
    x = startX;
    y = startY;
    speedX = random(1, 3);
    speedY = random(-1, 1);
    fishSize = random(20, 50);
  }

  void move() {
    x += speedX;
    y += speedY;
    if (x > width) {
      x = 0;
    }
    if (y > height || y < 0) {
      speedY *= -1;
    }
  }

  void display() {
    fill(255, 165, 0); // Warna oranye
    ellipse(x, y, fishSize, fishSize / 2);
    triangle(x - fishSize / 2, y, x - fishSize / 2 - 10, y - 5, x - fishSize / 2 - 10, y + 5);
    fill(0);
    ellipse(x + fishSize / 4, y - fishSize / 8, fishSize / 10, fishSize / 10);
  }
}

class Seaweed {
  float x, y;
  float height;

  Seaweed(float startX, float startY, float h) {
    x = startX;
    y = startY;
    height = h;
  }

  void display() {
    stroke(34, 139, 34); // Warna hijau
    strokeWeight(4);
    noFill();
    beginShape();
    for (int i = 0; i < height; i++) {
      float sway = sin(i * 0.1 + frameCount * 0.05) * 10;
      vertex(x + sway, y - i);
    }
    endShape();
  }
}

void drawCharacter(float posX, float posY) {
  // Disable stroke for the character's face
  noStroke();
  
  // Kepala
  fill(255, 224, 189); // Warna kulit
  ellipse(posX, posY - 150, 120, 140);
  
  // Telinga
  fill(255, 224, 189); // Warna kulit
  ellipse(posX - 60, posY - 150, 30, 40); // Telinga kiri
  ellipse(posX + 60, posY - 150, 30, 40); // Telinga kanan
  
  // Rambut
  fill(0); // Warna hitam
  beginShape();
  vertex(posX - 50, posY - 200);
  bezierVertex(posX - 70, posY - 230, posX - 40, posY - 250, posX, posY - 250);
  bezierVertex(posX + 40, posY - 250, posX + 70, posY - 230, posX + 50, posY - 200);
  bezierVertex(posX + 70, posY - 210, posX + 50, posY - 170, posX, posY - 180);
  bezierVertex(posX - 50, posY - 170, posX - 30, posY - 210, posX - 50, posY - 200);
  endShape(CLOSE);
  
  // Ekstra rambut di kiri
  beginShape();
  vertex(posX - 60, posY - 170);
  bezierVertex(posX - 70, posY - 180, posX - 60, posY - 210, posX - 40, posY - 190);
  endShape(CLOSE);
  
  // Ekstra rambut di kanan
  beginShape();
  vertex(posX + 60, posY - 170);
  bezierVertex(posX + 70, posY - 180, posX + 60, posY - 210, posX + 40, posY - 190);
  endShape(CLOSE);
  
  // Mata
  fill(255); // Putih mata
  ellipse(posX - 20, posY - 150, 30, 40);
  ellipse(posX + 20, posY - 150, 30, 40);
  fill(0); // Iris
  ellipse(posX - 20, posY - 150, 15, 20);
  ellipse(posX + 20, posY - 150, 15, 20);
  fill(255); // Cahaya mata
  ellipse(posX - 25, posY - 155, 5, 10);
  ellipse(posX + 15, posY - 155, 5, 10);
  
  // Hidung
  fill(255, 160, 122); // Warna hidung
  ellipse(posX, posY - 120, 10, 8);
  
  // Mulut
  noFill();
  stroke(0);
  strokeWeight(3);
  arc(posX, posY - 100, 30, 20, 0, PI);
  
  // Pipi
  noStroke();
  fill(255, 192, 203); // Warna merah muda pipi
  ellipse(posX - 30, posY - 110, 20, 20);
  ellipse(posX + 30, posY - 110, 20, 20);
  
  // Leher
  fill(255, 224, 189); // Warna kulit
  rect(posX - 15, posY - 80, 30, 30); // Leher
  
  // Tubuh
  fill(139, 69, 19); // Warna baju coklat
  rect(posX - 40, posY - 50, 80, 100, 10); // Baju
  
  // Lengan
  fill(255, 224, 189); // Warna kulit
  rect(posX - 60, posY - 50, 20, 70, 10); // Lengan kiri
  rect(posX + 40, posY - 50, 20, 70, 10); // Lengan kanan
  
  // Celana
  fill(0); // Warna hitam
  rect(posX - 40, posY + 50, 30, 100); // Kaki kiri
  rect(posX + 10, posY + 50, 30, 100); // Kaki kanan
  
  // Sepatu
  fill(128, 128, 128); // Warna abu-abu
  ellipse(posX - 25, posY + 160, 40, 20); // Sepatu kiri
  ellipse(posX + 25, posY + 160, 40, 20); // Sepatu kanan
}

void drawFish(float x, float y, float scale) {
  pushMatrix();
  translate(x, y);
  scale(scale);
  fill(135, 206, 235); // Warna tubuh biru muda
  stroke(0); // Warna garis tepi

  // Tubuh ikan
  beginShape();
  vertex(150, 0);
  bezierVertex(200, -100, -200, -100, -150, 0);
  bezierVertex(-200, 100, 200, 100, 150, 0);
  endShape(CLOSE);

  // Perut putih
  fill(255);
  beginShape();
  vertex(140, 30);
  bezierVertex(160, 60, -160, 60, -140, 30);
  bezierVertex(-160, 80, 160, 80, 140, 30);
  endShape(CLOSE);

  // Ekor
  fill(174, 214, 241);
  beginShape();
  vertex(-150, 0);
  vertex(-200, -50);
  vertex(-200, 50);
  endShape(CLOSE);

  // Sirip atas
  fill(174, 214, 241);
  beginShape();
  vertex(50, -70);
  vertex(30, -150);
  vertex(10, -70);
  endShape(CLOSE);

  // Sirip samping dimundurkan
  fill(174, 214, 241);
  beginShape();
  vertex(60, 30);
  vertex(100, 70);
  vertex(60, 50);
  endShape(CLOSE);

  // Mata
  fill(0);
  ellipse(80, -30, 20, 20);
  fill(255);
  ellipse(82, -32, 10, 10);

  // Mulut senyum berwarna pink
  fill(255, 105, 180);
  arc(120, 20, 40, 20, 0, PI, CHORD);
  popMatrix();
}

void drawTurtle(float x, float y, float scale) {
  pushMatrix();
  translate(x, y);
  scale(scale);
  noStroke(); // Remove the stroke
  fill(144, 238, 144); // Light green color
  ellipse(-80, 90, 60, 80); // Front left leg
  ellipse(80, 90, 60, 80); // Front right leg
  ellipse(-80, -90, 60, 80); // Back left leg
  ellipse(80, -90, 60, 80); // Back right leg
  ellipse(160, 0, 40, 30); // Tail

  // Turtle shell
  fill(34, 139, 34); // Dark green color
  ellipse(0, 0, 300, 200);

  // Shell patterns (three larger circles with black outlines, spaced out)
  stroke(0); // Black outline
  strokeWeight(2);
  fill(60, 179, 113); // Lighter green color
  ellipse(-60, -40, 80, 70);
  ellipse(60, -40, 80, 70);
  ellipse(0, 40, 80, 70);
  noStroke(); // Remove the stroke

  // Turtle head
  fill(144, 238, 144); // Light green color
  ellipse(-150, 0, 120, 100); // Head

  // Eyes
  fill(255); // White color
  ellipse(-170, -20, 30, 40); // Left eye
  ellipse(-130, -20, 30, 40); // Right eye
  fill(0); // Black color
  ellipse(-170, -20, 15, 20); // Left pupil
  ellipse(-130, -20, 15, 20); // Right pupil
  fill(255); // White color for eye shine
  ellipse(-175, -25, 5, 10); // Left eye shine
  ellipse(-125, -25, 5, 10); // Right eye shine

  // Mouth
  noFill();
  stroke(0);
  strokeWeight(3);
  arc(-150, 10, 50, 20, 0, PI); // Smiling mouth
  noStroke(); // Remove the stroke

  // Gambar peta harta karun
  drawTreasureMap(-100, -130); // Peta dinaikkan lebih jauh
  popMatrix();
}

void drawTreasureMap(float x, float y) {
  // Posisi peta relatif terhadap kaki belakang kiri kura-kura
  float mapX = x;
  float mapY = y;
  float mapWidth = 60;
  float mapHeight = 40;

  // Gambar peta
  fill(222, 184, 135); // Warna kertas peta
  rect(mapX, mapY, mapWidth, mapHeight);

  // Gambar detail peta sederhana (garis-garis dan X sebagai tanda harta karun)
  stroke(0);
  line(mapX + 10, mapY + 10, mapX + 50, mapY + 30); // Garis jalan
  line(mapX + 20, mapY + 30, mapX + 40, mapY + 10); // Garis jalan

  // Gambar tanda X harta karun
  line(mapX + 45, mapY + 5, mapX + 55, mapY + 15);
  line(mapX + 45, mapY + 15, mapX + 55, mapY + 5);
}
}
