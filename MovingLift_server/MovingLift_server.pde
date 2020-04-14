
Lift lift_0, lift_1, lift_2;
Lift[] lift = {lift_0, lift_1, lift_2};

int stageLevel;
color stageColor = color(72, 4, 22);
String commandString;

boolean[] commandUpState = {false, false, false};
boolean[] commandDownState = {false, false, false};

void setup() {
  size(800, 400);

  lift_0 = new Lift(150, 320, 100, 15, "#1");
  lift_1 = new Lift(350, 320, 100, 15, "#2");
  lift_2 = new Lift(550, 320, 100, 15, "#3");

  lift[0] = lift_0;
  lift[1] = lift_1;
  lift[2] = lift_2;
}

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

  for (int i = 0; i < 3; i++) {
    if (commandUpState[i]) {
      lift[i].movingUp();
    }
    if (commandDownState[i]) {
      lift[i].movingDown();
    }
  }
}

void decodeCommand(String _commandString) {

  String[] command = splitTokens(_commandString, "_,");

  for (int i = 0; i < 3; i++) {
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

void keyPressed() {

  if (key == 'a') {
    commandString = "L1_UP,L2_STOP,L3_UP";
  }

  if (key == 's') {
    commandString = "L1_DOWN,L2_UP,L3_DOWN";
  }

  if (key == 'd') {
    commandString = "L1_STOP,L2_STOP,L3_STOP";
  }
  decodeCommand(commandString);
}
