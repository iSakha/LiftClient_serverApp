class Lift {

  PVector Pos = new PVector(width/2, height - 40);

  int lftWidth = 100;
  int lftHeight = 15;

  float Rspring_X1[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  float Rspring_X2[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  float Rspring_Y1[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  float Rspring_Y2[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

  float Lspring_X1[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  float Lspring_X2[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  float Lspring_Y1[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  float Lspring_Y2[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

  float speed = 0.25;
 
  color liftColor = color(160);
  
  color baseColor = color(20);

  color springColor = color(18, 18, 135);

  boolean stagePos;
  
  String id;

  //==================================================

  //    constructor

  Lift(int _x, int _y, int _w, int _h, String _id) {

    Pos.x = _x;
    Pos.y = _y;
    lftWidth = _w;
    lftHeight = _h;
    for (int i = 0; i <= 9; i++) {
      if (isEven(i)) {

        Rspring_X1[i] = Pos.x + _w/2;
        Rspring_X2[i] = Pos.x + _w;
        Lspring_X1[i] = Rspring_X1[i];
        Lspring_X2[i] = Pos.x;
      } else {
        Rspring_X1[i] = Pos.x + _w;
        Rspring_X2[i] = Pos.x + _w/2;
        Lspring_X1[i] = Pos.x;
        Lspring_X2[i] = Rspring_X2[i];
      }

      Rspring_Y1[i] = Pos.y + _h + i*5;
      Rspring_Y2[i] = Rspring_Y1[i] + 5;
      Lspring_Y1[i] = Rspring_Y1[i];
      Lspring_Y2[i] = Rspring_Y2[i];
    }
    
      stageLevel = _y;
      id = _id;
  }
  //==================================================
  boolean isEven(int n) {
    return n % 2 == 0;
  }

  //==================================================

  void render() {

    noStroke();
    
    if (Pos.y == stageLevel) {
    fill(stageColor);
    } else {fill(liftColor);}
    rect(Pos.x, Pos.y, lftWidth, lftHeight);
    for (int i = 0; i <= 9; i++) {
      stroke(springColor);
      strokeWeight(3);
      line(Rspring_X1[i], Rspring_Y1[i], Rspring_X2[i], Rspring_Y2[i]);
      line(Lspring_X1[i], Lspring_Y1[i], Lspring_X2[i], Lspring_Y2[i]);
    }
    noStroke();
    fill(baseColor);
    rect(Pos.x, height - lftHeight, lftWidth, lftHeight);
    
    textSize(12);
    text("id " + id,Pos.x + 10,Pos.y - 10);
    
    if (Pos.y == stageLevel) {
      fill(255);
    } else {fill(0);}
    
    textSize(10);
    textAlign(CENTER, CENTER);
    text(str(round(stageLevel - Pos.y)),Pos.x, Pos.y, lftWidth, lftHeight);
    
    
  }

  //================================================== 

  void movingUp() {
    Pos.y = Pos.y - 5 * speed;

    for (int i = 0; i <= 9; i++) {
      if (isEven(i)) {
        Rspring_X2[i] = Rspring_X2[i] - 0.5 * speed;
        Lspring_X2[i] = Lspring_X2[i] + 0.5 * speed;
      } else {
      }

      Rspring_Y2[i] = Rspring_Y2[i] - (5 - (i + 1) * 0.5) * speed;
      Lspring_Y2[i] = Lspring_Y2[i] - (5 - (i + 1) * 0.5) * speed;
      if (i > 0) {
        Rspring_Y1[i] = Rspring_Y2[i - 1];
        Lspring_Y1[i] = Lspring_Y2[i - 1];
        Rspring_X1[i] = Rspring_X2[i - 1];
        Lspring_X1[i] = Lspring_X2[i - 1];
      } else {
        Rspring_Y1[i] = Pos.y + lftHeight;
        Lspring_Y1[i] = Pos.y + lftHeight;
      }
    }
  }

  //================================================== 

  void movingDown() {
    Pos.y = Pos.y + 5 * speed;

    for (int i = 0; i <= 9; i++) {
      if (isEven(i)) {
        Rspring_X2[i] = Rspring_X2[i] + 0.5 * speed;
        Lspring_X2[i] = Lspring_X2[i] - 0.5 * speed;
      } else {
      }

      Rspring_Y2[i] = Rspring_Y2[i] + (5 - (i + 1) * 0.5) * speed;
      Lspring_Y2[i] = Lspring_Y2[i] + (5 - (i + 1) * 0.5) * speed;
      if (i > 0) {
        Rspring_Y1[i] = Rspring_Y2[i - 1];
        Lspring_Y1[i] = Lspring_Y2[i - 1];
        Rspring_X1[i] = Rspring_X2[i - 1];
        Lspring_X1[i] = Lspring_X2[i - 1];
      } else {
        Rspring_Y1[i] = Pos.y + lftHeight;
        Lspring_Y1[i] = Pos.y + lftHeight;
      }
    }
  }
}
