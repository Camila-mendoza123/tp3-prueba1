// https://youtu.be/YSOULbObgnI
PImage imagen;

boolean animar = false;
boolean congelado = false;

final float TAM_ORIG = 60;
float movc = 0;

int columnas = 3, filas = 3;
float zonaX = 400;

float anchoCelda, altoCelda;

void setup() {
  size(800, 400);
  imagen = loadImage("imagen.png");

  anchoCelda = zonaX / columnas;
  altoCelda = height / filas;
  noStroke();
}

void draw() {
  background(255);
  image(imagen, 0, 0, zonaX, height);

  // Activa la animación si  el mouse entra a la derecha
  if (!animar && mouseX > zonaX && mouseX < width) {
    animar = true;
  }

  // Actualiza movc si está animando y no está congelado
  if (animar && !congelado) {
    movc += random(-1, 1);

    // Limita el movimiento 
    if (movc < 0) {
      movc = 0;
    } else if (movc > zonaX - anchoCelda) {
      movc = zonaX - anchoCelda;
    }
  }

  dibujarRectangulos(zonaX, anchoCelda, height);
  dibujarCirculos(zonaX, anchoCelda, altoCelda, animar && !congelado, movc, mouseX, mouseY);
}

void dibujarRectangulos(float zonaX, float anchoCelda, float altoVentana) {
  fill(240, 193, 22);
  rect(zonaX + 0 * anchoCelda, 0, anchoCelda, altoVentana);

  fill(173, 196, 245);
  rect(zonaX + 1 * anchoCelda, 0, anchoCelda, altoVentana);

  fill(247, 61, 40);
  rect(zonaX + 2 * anchoCelda, 0, anchoCelda, altoVentana);
}

void dibujarCirculos(float zonaX, float anchoCelda, float altoCelda, boolean animar, float movc, float mouseX, float mouseY) {
  //dibuja los 9 circulos
  for (int col = 0; col < columnas; col++) {
    for (int fila = 0; fila < filas; fila++) {
      float posX = zonaX + col * anchoCelda + anchoCelda / 2;
      float posY = fila * altoCelda + altoCelda / 2;
      float x = posX + (animar ? movc : 0);
      float y = posY;

     
      if (col == 0) fill(0);
      else if (col == 1) fill(247, 171, 5);
      else fill(128, 149, 109);
      ellipse(x, y, anchoCelda, altoCelda);

      // Círculo pequeño que cambia de tamaño
      float tamPeque = calcularTamPeque(x, y, animar, mouseX, mouseY);

      if (col == 0) fill(240, 193, 22);
      else if (col == 1) fill(173, 196, 245);
      else fill(247, 61, 40);

      ellipse(x, y, tamPeque, tamPeque);
    }
  }
}

float calcularTamPeque(float x, float y, boolean animar, float mouseX, float mouseY) {
    //cambiar el tamaño de los círculos pequeños según la distancia al mouse.
  if (!animar) {
    return TAM_ORIG;
  }
  float d = dist(mouseX, mouseY, x, y);
  return map(d, 0, 300, 80, 10);

}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    congelado = true;
    movc = 0;
  // se congela
  } else if (key == 'c' || key == 'C') {
    congelado = false;
    //se descongela 
  }
}
