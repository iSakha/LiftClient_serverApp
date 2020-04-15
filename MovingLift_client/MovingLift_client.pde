import processing.net.*;

Client c;

Button btnUP_1 = new Button(50, 60, 60, 20, 6, "UP", 255, 219, 196);
Button btnUP_2 = new Button(170, 60, 60, 20, 6, "UP", 255, 219, 196);
Button btnUP_3 = new Button(290, 60, 60, 20, 6, "UP", 255, 219, 196);
Button btnDOWN_1 = new Button(50, 120, 60, 20, 6, "DOWN", 255, 219, 196);
Button btnDOWN_2 = new Button(170, 120, 60, 20, 6, "DOWN", 255, 219, 196);
Button btnDOWN_3 = new Button(290, 120, 60, 20, 6, "DOWN", 255, 219, 196);

Button[] btnUP = new Button[] {btnUP_1, btnUP_2, btnUP_3};
Button[] btnDOWN = new Button[] {btnDOWN_1, btnDOWN_2, btnDOWN_3};

Button btnStart;
Button btnSave;

Button pos_0 = new Button(20, 235, 60, 15, 5, "Home", 72, 4, 22);
Button pos_1 = new Button(20, 255, 60, 15, 5, "pos_1", 255, 255, 125);
Button pos_2 = new Button(20, 275, 60, 15, 5, "pos_2", 60, 247, 105);
Button pos_3 = new Button(20, 295, 60, 15, 5, "pos_3", 103, 250, 229);
Button pos_4 = new Button(20, 315, 60, 15, 5, "pos_4", 242, 103, 250);
Button pos_5 = new Button(20, 335, 60, 15, 5, "pos_5", 255, 255, 255);

Button pos_0_L1 = new Button(130, 235, 40, 15, 5, "Home", 72, 4, 22);
Button pos_1_L1 = new Button(130, 255, 40, 15, 5, "pos_1", 255, 255, 125);
Button pos_2_L1 = new Button(130, 275, 40, 15, 5, "pos_2", 60, 247, 105);
Button pos_3_L1 = new Button(130, 295, 40, 15, 5, "pos_3", 103, 250, 229);
Button pos_4_L1 = new Button(130, 315, 40, 15, 5, "pos_4", 242, 103, 250);
Button pos_5_L1 = new Button(130, 335, 40, 15, 5, "pos_5", 255, 255, 255);

Button pos_0_L2 = new Button(200, 235, 40, 15, 5, "Home", 72, 4, 22);
Button pos_1_L2 = new Button(200, 255, 40, 15, 5, "pos_1", 255, 255, 125);
Button pos_2_L2 = new Button(200, 275, 40, 15, 5, "pos_2", 60, 247, 105);
Button pos_3_L2 = new Button(200, 295, 40, 15, 5, "pos_3", 103, 250, 229);
Button pos_4_L2 = new Button(200, 315, 40, 15, 5, "pos_4", 242, 103, 250);
Button pos_5_L2 = new Button(200, 335, 40, 15, 5, "pos_5", 255, 255, 255);

Button pos_0_L3 = new Button(270, 235, 40, 15, 5, "Home", 72, 4, 22);
Button pos_1_L3 = new Button(270, 255, 40, 15, 5, "pos_1", 255, 255, 125);
Button pos_2_L3 = new Button(270, 275, 40, 15, 5, "pos_2", 60, 247, 105);
Button pos_3_L3 = new Button(270, 295, 40, 15, 5, "pos_3", 103, 250, 229);
Button pos_4_L3 = new Button(270, 315, 40, 15, 5, "pos_4", 242, 103, 250);
Button pos_5_L3 = new Button(270, 335, 40, 15, 5, "pos_5", 255, 255, 255);

Button[][] pos = new Button[][] {
  {pos_0, pos_0_L1, pos_0_L2, pos_0_L3}, 
  {pos_1, pos_1_L1, pos_1_L2, pos_1_L3}, 
  {pos_2, pos_2_L1, pos_2_L2, pos_2_L3}, 
  {pos_3, pos_3_L1, pos_3_L2, pos_3_L3}, 
  {pos_4, pos_4_L1, pos_4_L2, pos_4_L3}, 
  {pos_5, pos_5_L1, pos_5_L2, pos_5_L3}};

int posCounter = 0;  

String[][] posValue = new String[][] {
  {"0", "0", "0"}, 
  {"", "", ""}, 
  {"", "", ""}, 
  {"", "", ""}, 
  {"", "", ""}, 
  {"", "", ""}};


String commandString = "";
String position = "";

String liftPos_1 = "0";
String liftPos_2 = "0";
String liftPos_3 = "0";
String[] liftPosition = new String[] {liftPos_1, liftPos_2, liftPos_3};

String com_L1 = "";
String com_L2 = "";
String com_L3 = "";
String[] liftCommands = {com_L1, com_L2, com_L3};

void setup() {

  size(400, 400); 

  btnStart = new Button(20, 180, 360, 40, 6, "Start", 255, 113, 100);
  btnSave = new Button(20, 360, 360, 30, 6, "Save", 100, 255, 125);

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
  btnSave.render();

  for (int i = 0; i <= posCounter; i++) {
    for ( int j = 0; j < 4; j++) {
      if (i == 0) {
        pos[i][j].textColor = 255;
      }
      if (j > 0) {
        pos[i][j].btnCaption = posValue[i][j -1];
      }
      pos[i][j].render();
    }
  }

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
    input = input.substring(0, input.indexOf("\n"));
    position = input;
    decodePosition(position);
  }
  fill(0);
  textSize(16);
  text(liftPosition[0], 75, 100);
  text(liftPosition[1], 195, 100);
  text(liftPosition[2], 315, 100);
  //==================================================
  //==================================================
  textSize(12);
  text(str(mouseX), 350, 10);
  text(str(mouseY), 350, 30);
  //==================================================
  //==================================================
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
  //==================================================    
  if (btnSave.mouseOverBtn()) {
    posCounter++;
    if (posCounter >=5) {
      posCounter = 5;
    }
    for (int i = 0; i < 3; i++) {
      posValue[posCounter][i] = liftPosition[i];
    }
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
