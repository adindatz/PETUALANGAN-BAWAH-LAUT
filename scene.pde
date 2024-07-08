class SceneFive{
PImage bgImage;
float fishY = 300; // Posisi awal ikan
float amplitude = 20; // Amplitudo gerakan vertikal
float angle = 0; // Sudut untuk mengontrol gerakan vertikal

void setup() {
  size(1920, 1080);  // Ukuran window, sesuaikan dengan kebutuhan
  bgImage = loadImage("data/laut.jpg");  // Memuat gambar "laut.jpg" dari folder data
  
  if (bgImage == null) {
    println("Gambar tidak berhasil dimuat. Pastikan file 'laut.jpg' ada di folder 'data'.");
  } else {
    println("Gambar berhasil dimuat.");
  }
}

void draw() {
  if (bgImage != null) {
    image(bgImage, 0, 0, width, height);  // Menampilkan gambar sebagai latar belakang
  }
  
  // Gambar karakter
  drawCharacter(width / 2, height / 2 + 100); // Menggambar tokoh agak dibawah
  
  // Gambar kotak harta karun di sebelah kiri dan kanan
  drawTreasureChest(width / 2 - 300, height / 2 + 100);
  drawTreasureChest(width / 2 + 300, height / 2 + 100);
  
  // Gambar tumpukan buku di atas kotak harta karun
  drawBookStack(width / 2 - 300, height / 2 - 40);
  drawBookStack(width / 2 + 300, height / 2 - 40);
  
  // Gerakan ikan vertikal
  fishY = height / 2 + 100 + sin(angle) * amplitude;
  drawFish(width / 2 - 200, fishY, 0.6); // Menggambar ikan di sebelah kiri tokoh dengan skala 0.6
  angle += 0.05;
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

void drawBookStack(float x, float y) {
  float bookWidth = 120;
  float bookHeight = 20;
  float spacing = 5; // Space between books

  // Earth tone colors for books
  color[] colors = {
    color(139, 69, 19),    // SaddleBrown
    color(160, 82, 45),    // Sienna
    color(210, 105, 30),   // Chocolate
    color(244, 164, 96),   // SandyBrown
    color(205, 133, 63),   // Peru
    color(222, 184, 135),  // BurlyWood
    color(188, 143, 143),  // RosyBrown
    color(169, 169, 169),  // DarkGray
    color(128, 128, 0),    // Olive
    color(107, 142, 35)    // OliveDrab
  };

  // Draw each book in the stack with a zigzag pattern
  for (int i = 0; i < 10; i++) {
    float xOffset = (i % 2 == 0) ? 20 : -20; // Zigzag pattern
    drawBook(x + xOffset, y - i * (bookHeight + spacing), bookWidth, bookHeight, colors[i]);
  }
}

void drawBook(float x, float y, float w, float h, color c) {
  fill(c);
  stroke(0);
  rect(x - w / 2, y - h, w, h); // Draw book cover
  fill(255);
  noStroke();
  for (int i = 1; i < 6; i++) {
    rect(x - w / 2 + 2, y - h + i * 3, w - 4, 1); // Draw book pages
  }
}

void drawFish(float x, float y, float scale) {
  pushMatrix();
  translate(x, y);
  scale(scale);
  fill(135, 206, 235); // Warna tubuh biru muda
  noStroke(); // Menghilangkan garis tepi

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

  // Sirip samping
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

void drawTreasureChest(float x, float y) {
  float chestWidth = 200;
  float chestHeight = 120;
  float lidHeight = 40;
  float lockWidth = 20;
  float lockHeight = 40;

  // Gambar badan kotak harta karun
  fill(139, 69, 19); // Warna coklat kayu
  rect(x - chestWidth / 2, y - chestHeight / 2, chestWidth, chestHeight); // Badan kotak

  // Gambar tutup kotak
  fill(160, 82, 45); // Warna lebih terang untuk tutup
  rect(x - chestWidth / 2, y - chestHeight / 2 - lidHeight, chestWidth, lidHeight); // Tutup kotak

  // Gambar kunci
  fill(255, 215, 0); // Warna emas untuk kunci
  rect(x - lockWidth / 2, y - lockHeight / 2, lockWidth, lockHeight); // Kunci kotak

  // Tambahan detail untuk tekstur kayu
  stroke(160, 82, 45);
  for (int i = -int(chestWidth / 2) + 10; i <= int(chestWidth / 2) - 10; i += 20) {
    line(x + i, y - chestHeight / 2, x + i, y + chestHeight / 2);
  }

  // Tambahan detail untuk kunci
  fill(255, 215, 0); // Warna emas untuk detail kunci
  ellipse(x, y, 20, 20); // Lubang kunci
}
}
