Ball ball;
Paddle p1;
Paddle p2;

boolean p1up, p1down, p2up, p2down;
int score1;
int score2;
PImage soccerField;

void keyPressed() {
  if (key != CODED) {
    if (key == 'w') {
      p1up = true;
    } else if (key == 's') {
      p1down = true;
    }
  } else {
    if (keyCode == UP) {
      p2up = true;
    } else if (keyCode == DOWN) {
      p2down = true;
    }
  }
}

void keyReleased() {
  if (key != CODED) {
    if (key == 'w') {
      p1up = false;
    } else if (key == 's') {
      p1down = false;
    }
  } else {
    if (keyCode == UP) {
      p2up = false;
    } else if (keyCode == DOWN) {
      p2down = false;
    }
  }
}

void setup() {
  size(1000, 600);
  ball = new Ball();
  p1 = new Paddle(1);
  p2 = new Paddle(2);
  soccerField = loadImage("soccerfield.jpeg");
}

void draw() {
  //background(0);
  image(soccerField, 0, 0, width, height);

  ball.update();
  ball.display();

  p1.update(p1up, p1down);
  p1.display();

  p2.update(p2up, p2down);
  p2.display();

  ball.checkCollision(p1);
  ball.checkCollision(p2);   

  fill(255);
  textSize(64);
  textAlign(CENTER, CENTER);
  text(score1, width/4, height/8);
  text(score2, 3*width/4, height/8);
  
  drawCenterLine();
}

void drawCenterLine() {
  rectMode(CENTER);
  fill(255);
  for (int i = 0; i < height; i+=30) {
    rect(width/2, i, 15, 15);
  }
}

class Ball {
  PImage soccerBall;
  PVector pos, vel;

  Ball() {
    restart(int(random(1,2)));
   soccerBall = loadImage("soccerball.png");
  }

  void restart(int whichPlayer) {
    float angle = 0;
    if (whichPlayer == 1) {
      angle = random(-45, 45);  
    } else if (whichPlayer == 2) {
      angle = random(135, 225);
    }
    pos = new PVector(width/2, height/2);
    vel = new PVector();
    vel.x = cos(radians(angle));
    vel.y = sin(radians(angle));
    float speed = 5;
    vel.mult(speed);
  }

  void checkCollision(Paddle p) {
    if (ball.pos.x < (p.pos.x + p.w) && 
      ball.pos.x > (p.pos.x) &&
      ball.pos.y > (p.pos.y) && 
      ball.pos.y < (p.pos.y + p.h)) {
      ball.vel.x = -ball.vel.x;
    }
  }

  void update() {
    if (pos.y > height || pos.y < 0) {
      vel.y = -vel.y;
    }

    pos.add(vel);

    if (pos.x < 0) {
      restart(2);
      score2++;
    }
    if (pos.x > width) {
      restart(1);
      score1++;
    }
  }

  void display() {
    rectMode(CENTER);
    fill(255);
    //rect(pos.x, pos.y, 25, 25);
    image(soccerBall, pos.x, pos.y, 25, 25);
  }
}




class Paddle { 
  PVector pos;
  int w, h;
  PImage crisRonaldo;

  Paddle(int whichPlayer) {
    w = 25;
    h = 100;
    if (whichPlayer == 1) {
      pos = new PVector(50, height/2 - h/2);
    } else if (whichPlayer == 2) {
      pos = new PVector(width-50-w, height/2-h/2);
    }
    crisRonaldo = loadImage("Cristiano-Ronaldo.png");
  }

  void update(boolean up, boolean down) {
    if (up && pos.y > 5) {
      pos.y -= 5;
    }
    if (down && pos.y + h < height - 5) {
      pos.y += 5;
    }
  }

  void display() {
    rectMode(CORNER);
    fill(255);
    image(crisRonaldo, pos.x, pos.y, 100, 100);
  }
}
