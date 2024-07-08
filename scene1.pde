class SceneOne {
  float shipSize = 50; // Ukuran awal kapal
  boolean growing = true; // Mengendalikan apakah kapal sedang bertambah besar atau mengecil

  void setup() {
    size(1920, 1080);
  }

  void draw() {
    background(200, 220, 255); // Latar belakang biru muda (langit di luar jendela)

    drawRoom();
    drawFurniture();
    drawShip(width / 2 - 400, height / 2 + 300, shipSize); // Menggambar kapal di depan ruangan, lebih ke kiri, dengan ukuran yang dianimasikan
    drawCharacter(width / 2+350, height / 2 + 200); // Menggambar tokoh di tengah ruangan, lebih rendah lagi

    // Animasi perbesaran dan pengecilan kapal dari 50 hingga 200
    if (growing) {
      shipSize += 2;
      if (shipSize >= 200) {
        growing = false;
      }
    } else {
      shipSize -= 2;
      if (shipSize <= 50) {
        growing = true;
      }
    }
  }

  void drawRoom() {
    // Dinding
    fill(139, 69, 19); // Coklat gelap
    rectMode(CENTER);
    rect(width / 2, height / 2, 900, 600);

    // Langit-langit
    fill(160, 82, 45); // Coklat medium
    quad(width / 2 - 450, height / 2 - 300, width / 2 + 450, height / 2 - 300, width / 2 + 350, height / 2 - 350, width / 2 - 350, height / 2 - 350);

    // Lantai
    fill(210, 105, 30); // Coklat terang
    quad(width / 2 - 450, height / 2 + 300, width / 2 + 450, height / 2 + 300, width / 2 + 350, height / 2 + 250, width / 2 - 350, height / 2 + 250);

    // Jendela
    fill(135, 206, 235); // Biru langit untuk jendela
    rect(width / 2, height / 2 - 150, 400, 300);

    // Garis jendela
    stroke(0); // Hitam untuk garis
    strokeWeight(4); // Ketebalan garis
    line(width / 2 - 200, height / 2 - 150, width / 2 + 200, height / 2 - 150); // Garis horizontal
    line(width / 2, height / 2 - 300, width / 2, height / 2); // Garis vertikal
  }

  void drawFurniture() {
    // Lemari di sebelah kanan
    fill(101, 67, 33); // Coklat tua untuk lemari
    rectMode(CORNER);
    rect(width / 2 + 150, height / 2 - 100, 250, 400);
  }

  void drawShip(float x, float y, float size) {
    pushMatrix(); // Simpan transformasi saat ini
    translate(x, y); // Pindahkan ke posisi (x, y)
    scale(size / 100.0); // Skala kapal sesuai ukuran

    // Menggambar kapal di depan ruangan
    fill(222, 184, 135); // Coklat muda untuk badan kapal
    beginShape();
    vertex(-50, 0);
    vertex(50, 0);
    vertex(25, 50);
    vertex(-25, 50);
    endShape(CLOSE);
    
    // Layar kapal
    fill(255); // Putih untuk layar kapal
    noStroke();
    triangle(-25, 0, 0, -50, 25, 0);

    popMatrix(); // Kembalikan transformasi
  }

  void drawCharacter(float posX, float posY) {
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

  void mousePressed() {
    // Reset background color to simulate closing the room view
    background(200, 220, 255); 
    noLoop(); // Stop drawing
  }
}
