PImage imagen;

boolean tampeque = false;
boolean moverCirculos = false;

final float TAM_ORIG = 60;
float tamPequeno = TAM_ORIG;
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
  background(0);
  image(imagen, 0, 0, 400, 400);


  for (int col = 0; col < columnas; col++) {
    if (col == 0)       fill(240, 193,  22);
    else if (col == 1)  fill(173, 196, 245);
    else                fill(247,  61,  40);
    rect(zonaX + col * anchoCelda, 0, anchoCelda, height);
  }

  if (moverCirculos) {
    movc = calcularMovimientoCirculos(movc, zonaX, anchoCelda);
  } else {
    movc = 0;
  }


  dibujarNueveCirculos(columnas, filas, zonaX, anchoCelda, altoCelda, movc, tamPequeno);


  fill(255);
  textSize(16);

  if (tampeque) {
    text("Modo edición (E): ACTIVO", 410, 20);
  } else {
    text("Modo edición (E): INACTIVO", 410, 20);
  }

  text("Cambiar tamaño: flechas ARRIBA y ABAJO", 410, 40);

  if (moverCirculos) {
    text("Mover (ENTER): ON", 410, 60);
  } else {
    text("Mover (ENTER): OFF", 410, 60);
  }
  text("Reiniciar (R)", 410, 80);
}


//  Dibujar los 9 círculos grandes y pequeños.
void dibujarNueveCirculos(int numColumnas, int numFilas, float zonaX, float anchoCelda, float altoCelda, float offsetMovimiento, float tamPequenoCirculo) {
  for (int col = 0; col < numColumnas; col++) {
    for (int fila = 0; fila < numFilas; fila++) {
      float baseX = zonaX + col * anchoCelda + anchoCelda / 2;
      float baseY = fila * altoCelda + altoCelda / 2;
      float x = baseX + offsetMovimiento;
      float y = baseY;

      if (col == 0)       fill(0);
      else if (col == 1)  fill(247, 171, 5);
      else                fill(128, 149, 109);
      ellipse(x, y, anchoCelda, altoCelda);

      if (col == 0)       fill(240, 193, 22);
      else if (col == 1)  fill(173, 196, 245);
      else                fill(247,  61, 40);
      ellipse(x, y, tamPequenoCirculo, tamPequenoCirculo);
    }
  }
}

float calcularMovimientoCirculos(float movimientoActual, float limiteX, float anchoMinimoCelda) {

  float movi = movimientoActual + random(-1, 1);

  if (movi < 0) {
    movi = 0;
  }
  else if (movi > (limiteX - anchoMinimoCelda)) {
    movi = limiteX - anchoMinimoCelda;
  }

  return movi;
}


// Restaurar todas las variables globales a sus valores iniciales.
void reiniciarPrograma() {
  tampeque = false;
  moverCirculos = false;
  tamPequeno = TAM_ORIG;
  movc = 0;
}

void keyPressed() {
  if (key == 'e' || key == 'E') {
    tampeque = !tampeque;

    if (!tampeque) {
      tamPequeno = TAM_ORIG;
    }
  }

  if (keyCode == ENTER) {
    moverCirculos = !moverCirculos;
  }

  if (key == 'r' || key == 'R') {
    reiniciarPrograma();
  }

  if (tampeque) {
    if (keyCode == UP) {
      tamPequeno += 2;
      if (tamPequeno > 150) {
        tamPequeno = 150;
      }
    }
    if (keyCode == DOWN) {
      tamPequeno -= 2;
      if (tamPequeno < 5) {
        tamPequeno = 5;
      }
    }
  }
}
