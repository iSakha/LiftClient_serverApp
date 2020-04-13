import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MovingLift_server extends PApplet {


Lift lift_0, lift_1, lift_2;
Lift[] lift = {lift_0, lift_1, lift_2};

int stageLevel;
int stageColor = color(72, 4, 22);
String commandString;

boolean[] commandUpState = {false, false, false};
boolean[] commandDownState = {false, false, false};

public void setup() {
  
  
  lift_0 = new Lift(150, 320, 100, 15, "#1");
  lift_1 = new Lift(350, 320, 100, 15, "#2");
  lift_2 = new Lift(550, 320, 100, 15, "#3");

lift[0] = lift_0;
lift[1] = lift_1;
lift[2] = lift_2;

}

public void draw() {
  background(200);
for (int i = 0; i < 3; i++) {
  lift[i].render();
}
//  Drawing stage
  fill(stageColor,100);
  rect(0, 320, 150, 15);
  rect(250, 320, 100, 15);
  rect(450, 320, 100, 15);
  rect(650, 320, 150, 15); 
  text("Stage", 20, 310);

 for (int i = 0; i < 3; i++) {
if(commandUpState[i]) {
  lift[i].movingUp();
}
 if(commandDownState[i]) {
  lift[i].movingDown();
}     
}
}

public void decodeCommand(String _commandString) {

  String[] command = splitTokens(_commandString, "_,");
 
  for (int i = 0;i < 3; i++) {
switch(command[ i * 2 + 1]) {
  case "UP":
  commandUpState[i] = true;
  commandDownState[i] = false;
  break;
  case "DOWN":
  commandUpState[i] = false;
  commandDownState[i] = true;
  break;
    case "STOP":
  commandUpState[i] = false;
  commandDownState[i] = false;
  break;

}

  }
}

public void keyPressed() {
  
if(key == 'a') {
  commandString = "L1_UP,L2_STOP,L3_UP";  
}

if(key == 's') {
  commandString = "L1_DOWN,L2_UP,L3_DOWN";  
}

if(key == 'd') {
  commandString = "L1_STOP,L2_STOP,L3_STOP";  
}
decodeCommand(commandString);
}
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

  float speed = 0.25f;
 
  int liftColor = color(160);
  
  int baseColor = color(20);

  int springColor = color(18, 18, 135);

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
  public boolean isEven(int n) {
    return n % 2 == 0;
  }

  //==================================================

  public void render() {

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

  public void movingUp() {
    Pos.y = Pos.y - 5 * speed;

    for (int i = 0; i <= 9; i++) {
      if (isEven(i)) {
        Rspring_X2[i] = Rspring_X2[i] - 0.5f * speed;
        Lspring_X2[i] = Lspring_X2[i] + 0.5f * speed;
      } else {
      }

      Rspring_Y2[i] = Rspring_Y2[i] - (5 - (i + 1) * 0.5f) * speed;
      Lspring_Y2[i] = Lspring_Y2[i] - (5 - (i + 1) * 0.5f) * speed;
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

  public void movingDown() {
    Pos.y = Pos.y + 5 * speed;

    for (int i = 0; i <= 9; i++) {
      if (isEven(i)) {
        Rspring_X2[i] = Rspring_X2[i] + 0.5f * speed;
        Lspring_X2[i] = Lspring_X2[i] - 0.5f * speed;
      } else {
      }

      Rspring_Y2[i] = Rspring_Y2[i] + (5 - (i + 1) * 0.5f) * speed;
      Lspring_Y2[i] = Lspring_Y2[i] + (5 - (i + 1) * 0.5f) * speed;
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
  public void settings() {  size(800, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MovingLift_server" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
