import processing.net.*;

Server s; 
Client c;

Lift lift_0, lift_1, lift_2;
Lift[] lift = {lift_0, lift_1, lift_2};

int stageLevel;
color stageColor = color(72, 4, 22);
String commandString;
String sendPosition = "";

boolean[] commandUpState = {false, false, false};
boolean[] commandDownState = {false, false, false};

String mode = "man";
int numLiftSingle = 111;
int numPosSingle = 111;
int numPosAuto = 111;
String posLiftSingle = "";

String[] posLiftAuto = new String[] {"","",""};

color[] posColor = new color[] {color(72, 4, 22),color(255, 255, 125),color(60, 247, 105),
color(103, 250, 229),color(242, 103, 250),color(255, 255, 255)};
//==================================================
void setup() {
  size(800, 400);
  //frameRate(25);
  lift_0 = new Lift(150, 320, 100, 15, "#1");
  lift_1 = new Lift(350, 320, 100, 15, "#2");
  lift_2 = new Lift(550, 320, 100, 15, "#3");

  lift[0] = lift_0;
  lift[1] = lift_1;
  lift[2] = lift_2;

  s = new Server(this, 12345);  // Start a simple server on a port
}
//==================================================
void draw() {
  background(220);
  for (int i = 0; i < 3; i++) {
    lift[i].render();
  }
  //  Drawing stage
  fill(stageColor, 200);
  rect(0, 320, 150, 15);
  rect(250, 320, 100, 15);
  rect(450, 320, 100, 15);
  rect(650, 320, 150, 15); 
  text("Stage", 20, 310);


  switch(mode) {
  case "man":
    for (int i = 0; i < 3; i++) {
      if (commandUpState[i]) {
        lift[i].movingUp();
      }
      if (commandDownState[i]) {
        lift[i].movingDown();
      }
    }
    break;

  case "auto":
for (int i = 0; i < 3; i++) {
  lift[i].goToPos(posLiftAuto[i], numPosAuto);
}
    break;
  case "single":
    lift[numLiftSingle].goToPos(posLiftSingle, numPosSingle);
    break;
  } 


  sendPosition = lift[0].position() + " , " + lift[1].position() + " , " + lift[2].position() + "\n";
  s.write(sendPosition);
  //println(sendPosition);
  c = s.available();
  if (c != null) { 
    String input = c.readString();
    decodeCommand(input);
  }
}
//==================================================

void decodeCommand(String _commandString) {

  String[] command = splitTokens(_commandString, ",");

  switch(command[3]) {
  case "man":
    mode = "man";
    for (int i = 0; i < 3; i++) {
      switch(command[i]) {
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
    break;
  case "auto":
    mode = "auto";
    for (int i = 0; i < 3; i++) {
    posLiftAuto[i] = command[i];
    numPosAuto = int(command[4]);
    }
    break;

  case "single":
    mode = "single";
    numLiftSingle = int(command[0]);
    posLiftSingle = command[1];
    numPosSingle = int(command[4]);
    break;
  }
}
//==================================================
void keyPressed() {

  if (key == 'a') {
  }

  if (key == 's') {
    commandString = "L1_STOP,L2_STOP,L3_STOP,single";

    println(mode);
  }

  if (key == 'd') {
    commandString = "L1_STOP,L2_STOP,L3_STOP";
    println(commandString);
  }
  decodeCommand(commandString);
}
