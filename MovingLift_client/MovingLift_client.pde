Button btnUP_1, btnUP_2, btnUP_3;
Button btnDOWN_1, btnDOWN_2, btnDOWN_3;
Button[] btnUP = {btnUP_1, btnUP_2, btnUP_3};
Button[] btnDOWN = {btnDOWN_1, btnDOWN_2, btnDOWN_3};
Button btnStart;

String commandString = "";
String com_L1, com_L2, com_L3;
String[] liftCommands = {com_L1, com_L2, com_L3};

void setup() {

  size(640, 400); 
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
  liftCommands[1] = com_L1;
  liftCommands[2] = com_L1;
  
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
  textAlign(LEFT);
  text(commandString, 20, 240);
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
    if(!btnUP[i].btnPressed && !btnDOWN[i].btnPressed) {
      liftCommands[i] = "L" + (i + 1) + "_" + "STOP";
    }
  }
  //==================================================

  if (btnStart.mouseOverBtn()) {
    btnStart.btnBackColor = color(100, 255, 113);
    commandString = liftCommands[0] + "," + liftCommands[1] + "," + liftCommands[2];
  }
}
//==================================================

void mouseReleased() {
  if (btnStart.mouseOverBtn()) {
    btnStart.btnBackColor = color(255, 113, 100);
    commandString = "L1_STOP,L2_STOP,L3_STOP";
  }
}
