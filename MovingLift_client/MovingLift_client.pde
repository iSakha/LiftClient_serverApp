import processing.net.*;

Client c;

Button btnUP_1, btnUP_2, btnUP_3;
Button btnDOWN_1, btnDOWN_2, btnDOWN_3;
Button[] btnUP = {btnUP_1, btnUP_2, btnUP_3};
Button[] btnDOWN = {btnDOWN_1, btnDOWN_2, btnDOWN_3};
Button btnStart;
Button btnSave;

Button pos_0, pos_0_L1, pos_0_L2, pos_0_L3;
Button pos_1, pos_1_L1, pos_1_L2, pos_1_L3;
Button pos_2, pos_2_L1, pos_2_L2, pos_2_L3;
Button pos_3, pos_3_L1, pos_3_L2, pos_3_L3;
Button pos_4, pos_4_L1, pos_4_L2, pos_4_L3;
Button pos_5, pos_5_L1, pos_5_L2, pos_5_L3;

Button[][] pos = {  {pos_0_L1, pos_0_L2, pos_0_L3}, 
                    {pos_1_L1, pos_1_L2, pos_1_L3}, 
                    {pos_2_L1, pos_2_L2, pos_2_L3}, 
                    {pos_3_L1, pos_3_L2, pos_3_L3}, 
                    {pos_4_L1, pos_4_L2, pos_4_L3}, 
                    {pos_5_L1, pos_5_L2, pos_5_L3}  };

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
  btnSave = new Button(20, 360, 360, 30, 6, "Save", 100, 255, 125);

pos_0 = new Button(20, 235, 60, 15, 5, "pos_0", 72, 4, 22);
pos_1 = new Button(20, 255, 60, 15, 5, "pos_1", 255, 255, 125);
pos_2 = new Button(20, 275, 60, 15, 5, "pos_2", 255, 255, 125);
pos_3 = new Button(20, 295, 60, 15, 5, "pos_3", 255, 255, 125);
pos_4 = new Button(20, 315, 60, 15, 5, "pos_4", 255, 255, 125);
pos_5 = new Button(20, 335, 60, 15, 5, "pos_5", 255, 255, 125);

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
  textSize(12);

  btnStart.btnHighLightColor = btnStart.btnBackColor;
  btnStart.render();
  btnSave.render();
  textSize(10);

  pos_0.render();

  pos_1.render();
  pos_2.render();
  pos_3.render();
  pos_4.render();
  pos_5.render();

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

  textSize(16);
  text(liftPosition[0], 75, 100);
  text(liftPosition[1], 195, 100);
  text(liftPosition[2], 315, 100);
  //==================================================
  //==================================================
  textSize(12);
  text(str(mouseX),350,10);
  text(str(mouseY),350,30);
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
