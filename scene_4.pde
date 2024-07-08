class SceneFour{
int numFish = 10;
int numSeaweed = 20;
Fish[] fishArray = new Fish[numFish];
Seaweed[] seaweedArray = new Seaweed[numSeaweed];
float sharkOffset = 0;
float fishOffset = 0; // Offset for fish vertical movement

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

  drawCharacter(width / 2, height / 2 + 100); // Menggambar tokoh lebih ke bawah

  // Calculate vertical oscillation for shark
  float sharkY = height / 2 + sin(sharkOffset) * 20;

  drawShark(width / 2 + 300, sharkY - 100, 0.5); // Menggambar hiu di atas
  drawShark(width / 2 + 300, sharkY, 0.5); // Menggambar hiu di tengah
  drawShark(width / 2 + 300, sharkY + 100, 0.5); // Menggambar hiu di bawah

  drawBlueFish(width / 2 - 250, height / 2 + 150 + sin(fishOffset) * 20); // Menggambar ikan biru di sebelah kiri tokoh dengan skala 0.5
  fishOffset += 0.05; // Update offset for vertical movement

  // Update offset to create the oscillation effect
  sharkOffset += 0.05;
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

  // Lengan kiri
  fill(255, 224, 189); // Warna kulit
  rect(posX - 60, posY - 50, 20, 70, 10); // Lengan kiri

  // Lengan kanan
  fill(255, 224, 189); // Warna kulit
  rect(posX + 40, posY - 50, 20, 70, 10); // Lengan kanan
  
  // Menggambar peta di tangan kanan
  drawTreasureMap(posX + 55, posY - 20);

  // Celana
  fill(0); // Warna hitam
  rect(posX - 40, posY + 50, 30, 100); // Kaki kiri
  rect(posX + 10, posY + 50, 30, 100); // Kaki kanan

  // Sepatu
  fill(128, 128, 128); // Warna abu-abu
  ellipse(posX - 25, posY + 160, 40, 20); // Sepatu kiri
  ellipse(posX + 25, posY + 160, 40, 20); // Sepatu kanan
}

void drawBlueFish(float x, float y) {
  float scaleFactor = 0.5; // Scale up the fish to slightly larger size
  fill(135, 206, 235); // Warna tubuh biru muda
  stroke(0); // Warna garis tepi

  // Tubuh ikan
  beginShape();
  vertex(x + 150 * scaleFactor, y);
  bezierVertex(x + 200 * scaleFactor, y - 100 * scaleFactor, x - 200 * scaleFactor, y - 100 * scaleFactor, x - 150 * scaleFactor, y);
  bezierVertex(x - 200 * scaleFactor, y + 100 * scaleFactor, x + 200 * scaleFactor, y + 100 * scaleFactor, x + 150 * scaleFactor, y);
  endShape(CLOSE);

  // Perut putih
  fill(255);
  beginShape();
  vertex(x + 140 * scaleFactor, y + 30 * scaleFactor);
  bezierVertex(x + 160 * scaleFactor, y + 60 * scaleFactor, x - 160 * scaleFactor, y + 60 * scaleFactor, x - 140 * scaleFactor, y + 30 * scaleFactor);
  bezierVertex(x - 160 * scaleFactor, y + 80 * scaleFactor, x + 160 * scaleFactor, y + 80 * scaleFactor, x + 140 * scaleFactor, y + 30 * scaleFactor);
  endShape(CLOSE);

  // Ekor
  fill(174, 214, 241);
  beginShape();
  vertex(x - 150 * scaleFactor, y);
  vertex(x - 200 * scaleFactor, y - 50 * scaleFactor);
  vertex(x - 200 * scaleFactor, y + 50 * scaleFactor);
  endShape(CLOSE);

  // Sirip atas
  fill(174, 214, 241);
  beginShape();
  vertex(x + 50 * scaleFactor, y - 70 * scaleFactor);
  vertex(x + 30 * scaleFactor, y - 150 * scaleFactor);
  vertex(x + 10 * scaleFactor, y - 70 * scaleFactor);
  endShape(CLOSE);

  // Sirip samping dimundurkan
  fill(174, 214, 241);
  beginShape();
  vertex(x + 60 * scaleFactor, y + 30 * scaleFactor);
  vertex(x + 100 * scaleFactor, y + 70 * scaleFactor);
  vertex(x + 60 * scaleFactor, y + 50 * scaleFactor);
  endShape(CLOSE);

  // Mata
  fill(0);
  ellipse(x + 80 * scaleFactor, y - 30 * scaleFactor, 20 * scaleFactor, 20 * scaleFactor);
  fill(255);
  ellipse(x + 82 * scaleFactor, y - 32 * scaleFactor, 10 * scaleFactor, 10 * scaleFactor);

  // Mulut senyum berwarna pink
  fill(255, 105, 180);
  arc(x + 120 * scaleFactor, y + 20 * scaleFactor, 40 * scaleFactor, 20 * scaleFactor, 0, PI, CHORD);
}

void drawShark(float x, float y, float scale) {
  pushMatrix();
  translate(x, y);
  scale(scale);
  fill(169, 169, 169); // Warna tubuh abu-abu
  stroke(0); // Warna garis tepi

  // Tubuh hiu
  beginShape();
  vertex(-200, 0);
  bezierVertex(-250, -75, 150, -75, 200, 0);
  bezierVertex(150, 75, -250, 75, -200, 0);
  endShape(CLOSE);

  // Ekor
  fill(105, 105, 105);
  beginShape();
  vertex(200, 0);
  vertex(250, -50);
  vertex(250, 50);
  endShape(CLOSE);

  // Sirip atas
  fill(105, 105, 105);
  beginShape();
  vertex(-100, -50);
  vertex(-80, -100);
  vertex(-60, -50);
  endShape(CLOSE);

  // Sirip samping
  fill(105, 105, 105);
  beginShape();
  vertex(-120, 25);
  vertex(-160, 60);
  vertex(-120, 40);
  endShape(CLOSE);

  // Mata
  fill(0);
  ellipse(-120, -15, 15, 15);
  fill(255);
  ellipse(-125, -17, 5, 5);

  // Mulut
  fill(0);
  beginShape();
  vertex(-160, 25);
  vertex(-200, 25);
  vertex(-180, 40);
  endShape(CLOSE);
  popMatrix();
}

void drawTreasureMap(float x, float y) {
  float mapWidth = 60;
  float mapHeight = 40;

  // Gambar peta
  fill(222, 184, 135); // Warna kertas peta
  rect(x, y, mapWidth, mapHeight);

  // Gambar detail peta sederhana (garis-garis dan X sebagai tanda harta karun)
  stroke(0);
  line(x + 10, y + 10, x + 50, y + 30); // Garis jalan
  line(x + 20, y + 30, x + 40, y + 10); // Garis jalan

  // Gambar tanda X harta karun
  line(x + 45, y + 5, x + 55, y + 15);
  line(x + 45, y + 15, x + 55, y + 5);
}
}
