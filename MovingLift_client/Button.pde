class Button {

  PVector Pos = new PVector(0, 0);
  float btnWidth = 0;
  float btnHeight = 0;
  float btnCorners = 0;
  color btnBackColor;
  color btnHighLightColor;
  String btnCaption;
  boolean btnPressed = false;
  
  //==================================================

  //    constructor

  Button(int _x, int _y, int _w, int _h,float _roundCorners, String _caption, int _r, int _g, int _b) {

    Pos.x = _x;
    Pos.y = _y;
    btnWidth = _w;
    btnHeight = _h;
    btnCorners = _roundCorners;
    btnBackColor = color(_r, _g, _b);
    btnHighLightColor = color(_b, _r, _g);
    btnCaption = _caption;
  }

  //==================================================
boolean mouseOverBtn() {
  if (mouseX >= Pos.x && mouseX <= Pos.x + btnWidth && mouseY >= Pos.y && mouseY <= Pos.y + btnHeight) {
  return true;
  } else {
    return false;
  }
}
  //================================================== 
    void render() {
      if (mouseX >= Pos.x && mouseX <= Pos.x + btnWidth && mouseY >= Pos.y && mouseY <= Pos.y + btnHeight) {
    fill(btnHighLightColor);
      } else {fill(btnBackColor);}
    rect(Pos.x, Pos.y, btnWidth, btnHeight,btnCorners);
    
    fill(0);
    //textSize(12);
    textAlign(CENTER, CENTER);
    text(btnCaption, Pos.x + btnWidth/2, Pos.y + btnHeight/2);
  }
}
