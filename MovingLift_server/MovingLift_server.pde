
Lift lift_0, lift_1, lift_2;
Lift[] lift = {lift_0, lift_1, lift_2};

int stageLevel;
color stageColor = color(72, 4, 22);

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
  background(200);
for (int i = 0; i < 3; i++) {
  lift[i].render();
}
  fill(stageColor,100);
  rect(0, 320, 150, 15);
  rect(250, 320, 100, 15);
  rect(450, 320, 100, 15);
  rect(650, 320, 150, 15);

  
  
  text("Stage", 20, 310);
}
