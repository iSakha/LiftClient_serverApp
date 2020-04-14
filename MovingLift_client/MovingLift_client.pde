import processing.net.*;

Client c;

Button btnUP_1, btnUP_2, btnUP_3;
Button btnDOWN_1, btnDOWN_2, btnDOWN_3;
Button[] btnUP = {btnUP_1, btnUP_2, btnUP_3};
Button[] btnDOWN = {btnDOWN_1, btnDOWN_2, btnDOWN_3};
Button btnStart;

String commandString = "";
String position = "";
String liftPos_1, liftPos_2, liftPos_3;
String[] liftPosition = {liftPos_1, liftPos_2, liftPos_3};
String com_L1, com_L2, com_L3;
String[] liftCommands = {com_L1, com_L2, com_L3};

void setup() {

  size(400, 400); 
  btnUP_1 = new Button(50, 60, 60, 20, 6, "UP", 255, 219, 196);
  btnUP_2 = new Button(170, 60, 60, 20, 6, "UP", 255, 219, 196);
  btnUP_3 = new Button(290, 60, 60, 20, 6, "UP", 255, 219, 196);
  btnDOWN_1 = new Button(50, 120, 60, 20, 6, "DOWN", 255, 219, 196);
  btnDOWN_2 = new Button(170, 120, 60, 20, 6, "DOWN", 255, 219, 196);
  btnDOWN_3 = new Button(290, 120, 60, 20, 6, "DOWN", 255, 219, 196);
  btnUP[0] = btnUP_1;
  btnUP[1] = btnUP_2;
  btnUP[2] = btnUP_3;
  btnDOWN[0] = btnDOWN_1;
  btnDOWN[1] = btnDOWN_2;
  btnDOWN[2] = btnDOWN_3;
  btnStart = new Button(20, 180, 360, 40, 6, "Start", 255, 113, 100);

  com_L1 = "";
  com_L2 = "";
  com_L3 = "";
  liftCommands[0] = com_L1;
  liftCommands[1] = com_L2;
  liftCommands[2] = com_L3;
  
  liftPos_1 = "0";
  liftPos_2 = "0";
  liftPos_3 = "0";
  liftPosition[0] = liftPos_1;
  liftPosition[1] = liftPos_2;
  liftPosition[2] = liftPos_3;

  c = new Client(this, "127.0.0.1", 12345);
}

void draw() {
  background(200);
  fill(219, 234, 255);
  rect(20, 40, 120, 120, 10);
  rect(140, 40, 120, 120, 10);
  rect(260, 40, 120, 120, 10);

  for (int i = 0; i< 3; i++) {
    btnUP[i].render();
    btnDOWN[i].render();
  }
  btnStart.btnHighLightColor = btnStart.btnBackColor;
  btnStart.render();

  for (int i = 0; i < 3; i++) {
    if (btnUP[i].btnPressed) {
      btnUP[i].btnBackColor = color(255, 255, 0);
      btnUP[i].btnHighLightColor = color(255, 255, 0);
    } else {
      btnUP[i].btnBackColor = color(255, 219, 196);
      btnUP[i].btnHighLightColor = color(196, 255, 219);
    }

    if (btnDOWN[i].btnPressed) {
      btnDOWN[i].btnBackColor = color(255, 255, 0);
      btnDOWN[i].btnHighLightColor = color(255, 255, 0);
    } else {
      btnDOWN[i].btnBackColor = color(255, 219, 196);
      btnDOWN[i].btnHighLightColor = color(196, 255, 219);
    }

    if (btnUP[i].btnPressed) {
      btnDOWN[i].btnBackColor = color(150);
      btnDOWN[i].btnHighLightColor = color(150);
    }

    if (btnDOWN[i].btnPressed) {
      btnUP[i].btnBackColor = color(150);
      btnUP[i].btnHighLightColor = color(150);
    }
  }
  
      if (c.available() > 0) { 

    String input = c.readString(); 
    input = input.substring(0,input.indexOf("\n"));
    position = input;
    decodePosition(position);
  }
  //textAlign(LEFT);
  //text(commandString, 20, 240);
  
  textSize(16);
  text(liftPosition[0], 75, 100);
  text(liftPosition[1], 195, 100);
  text(liftPosition[2], 315, 100);

}
void mousePressed() {
  //==================================================
  for (int i = 0; i< 3; i++) {
    if (btnUP[i].mouseOverBtn()) {
      btnUP[i].btnPressed = !btnUP[i].btnPressed;
      if (btnUP[i].btnPressed) {
        btnDOWN[i].btnPressed = false;
        liftCommands[i] = "L" + (i + 1) + "_" + "UP";
      }
    }
    //==================================================
    if (btnDOWN[i].mouseOverBtn()) {
      btnDOWN[i].btnPressed = !btnDOWN[i].btnPressed;
      if (btnDOWN[i].btnPressed) {
        btnUP[i].btnPressed = false;
        liftCommands[i] = "L" + (i + 1) + "_" + "DOWN";
      }
    }
    if (!btnUP[i].btnPressed && !btnDOWN[i].btnPressed) {
      liftCommands[i] = "L" + (i + 1) + "_" + "STOP";
    }
  }
  //==================================================

  if (btnStart.mouseOverBtn()) {
    btnStart.btnBackColor = color(100, 255, 113);
    commandString = liftCommands[0] + "," + liftCommands[1] + "," + liftCommands[2];
    c.write(commandString);
  }

}
//==================================================

void mouseReleased() {
  if (btnStart.mouseOverBtn()) {
    btnStart.btnBackColor = color(255, 113, 100);
    commandString = "L1_STOP,L2_STOP,L3_STOP";
    c.write(commandString);
  }
}
void decodePosition(String _position) {
  String[] pos = splitTokens(_position, " , ");
  for (int i = 0; i < 3; i++) {
    liftPosition[i] = pos[i];
  }
  
}
