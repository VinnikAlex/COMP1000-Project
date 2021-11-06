//starfield
int Loop1;
int NumStars = 100;
float[][] Star = new float[NumStars][5];

//moon/end game count
int count;
int round;

//moons
int iLoop2;
int numOfMoons;
float[][] iMoons;

float moonDia = 60;

//Ship/Missile
float y1 = 0;
float y2 = 25;
float y3 = 50;

boolean turningRight;
boolean turningLeft;

float missileY = 25; //y2
float missileX = 90; //y3
float missileDia = 10;
boolean firing;



//Draw Missile
void drawMissile() {
  fill(255, 0, 0);
  circle(missileX, missileY, missileDia);
}

//Draw Ship States
void drawPlayer(float x, float y) {
  fill(255);
  if (turningRight) {
    triangle(x, y1, 95, y2, y, y3 - 15);
  } else if (turningLeft) {
    triangle(x, y1 + 15, 95, y2, y, y3);
  } else {
    triangle(x, y1, 95, y2, y, y3);
  }
}
//Moon Array
void drawMoons() {
  fill(255, 0, 0);
  circle(iMoons[iLoop2][0], iMoons[iLoop2][1], moonDia);
  iMoons[iLoop2][0] -= iMoons[iLoop2][2]; 
  
  if (count == 0 && round == 1) { // reset
    round = 2;
    count = 4;
    numOfMoons = count;
    iMoons = new float[numOfMoons][4];
    for (iLoop2=0; iLoop2<numOfMoons; iLoop2++) {
      iMoons[iLoop2][0] = width-60; // x-cord
      iMoons[iLoop2][1] = int(random(30, height-30)); // random height
      iMoons[iLoop2][2] = random(0.1, 0.2); //speed of moons
      iMoons[iLoop2][3] = width*3;
    }
  } else if (round == 2 && count == 0) {
    round = 3;
    count = 5;
    numOfMoons = count;
    iMoons = new float[numOfMoons][4];
    for (iLoop2=0; iLoop2<numOfMoons; iLoop2++) {
      iMoons[iLoop2][0] = width-60; // x-cord
      iMoons[iLoop2][1] = int(random(30, height-30)); // random height
      iMoons[iLoop2][2] = random(0.1, 0.2); //speed of moons
      iMoons[iLoop2][3] = width*3;
    }
  } else if (round == 3 && count == 0) {
    //You Win!!
    noLoop();
    fill(255);
    textAlign(CENTER);
    text("You Win!!!", width/2, height/2);
  } else if (dist(iMoons[iLoop2][0], iMoons[iLoop2][1], 95, y2) <= moonDia/2 || iMoons[iLoop2][0] <= moonDia/2) { //dist between player and moon
    //You Lose!!
    noLoop();
    fill(255);
    textAlign(CENTER);
    text("You lose!!!", width/2, height/2);
  }
}
// Starfield Array
void updatestars() {
  for (Loop1=0; Loop1<NumStars; Loop1++) {
    //speed
    Star[Loop1][0] -= Star[Loop1][4];
    //off-screen - reset
    if (Star[Loop1][0] < 0) {
      Star[Loop1][0] = width; // reset to end of screen
      Star[Loop1][1] = int(random(height)); // reset to random y value
      Star[Loop1][2] = int(random(1, 7)); // reset to random size
      Star[Loop1][3] = int(128 + random(127)); //random colour
      Star[Loop1][4] = int(random(1.0, 3.0)); // reset asteroid speed
    }
  }
}


void setup() {
  size(500, 500);
  textSize(48);
  textAlign(CENTER, CENTER);

  round = 1; // == 2 == 3
  count = 3; // == 4 == 5
  numOfMoons = count;
  iMoons = new float[numOfMoons][4];


  turningRight = false;
  turningLeft = false;
  firing = false;

  //init array starfield
  for (Loop1=0; Loop1<NumStars; Loop1++) {   
    Star[Loop1][0]=int(random(width));
    Star[Loop1][1]=int(random(height));
    Star[Loop1][2]=int(random(1, 7)); // asteroid size
    Star[Loop1][3]=int(128 + random(127)); 
    Star[Loop1][4] = int(random(1.0, 3.0)); // asteroid speed
  }

  //init array moons
  for (iLoop2=0; iLoop2<numOfMoons; iLoop2++) {
    iMoons[iLoop2][0] = width-60; // x-cord
    iMoons[iLoop2][1] = int(random(30, height-30)); // random height
    iMoons[iLoop2][2] = random(0.1, 0.2); //speed of moons
    iMoons[iLoop2][3] = width*10;
  }
}


void draw() {
  background(0);
  drawPlayer(50, 50);

  //update all stars
  updatestars();
  for (Loop1=0; Loop1<NumStars; Loop1++) {
    fill(Star[Loop1][3]);
    circle(Star[Loop1][0], Star[Loop1][1], Star[Loop1][2]);
  }

  //update moons  
  for (iLoop2=0; iLoop2<numOfMoons; iLoop2++) {
    // if missile reaches moon edge or screen edge - reset missile
    if (dist(iMoons[iLoop2][0], iMoons[iLoop2][1], missileX, missileY) < moonDia/2) {
      firing = false;
      missileY = y2;
      missileX += 0;
      missileX = 90;
      iMoons[iLoop2][0]+=iMoons[iLoop2][3]; //pushes moon off screen
      count--;
    } else if ((missileX >= width && missileY >= 0) && (missileY <= height)) {
      firing = false;
      missileY = y2;
      missileX += 0;
      missileX = 90;
    } else if (firing == true) {
      drawMissile();
      missileX+=1.5;
    }
    drawMoons();
    println(count);
  }
}


void keyPressed() {

  if (keyCode == 'S') {
    turningRight = true;
    y1 += 5;
    y2 += 5;
    y3 += 5;
    missileY += 5;
  }
  if (keyCode == 'W') {
    turningLeft = true;
    y1 -= 5;
    y2 -= 5;
    y3 -= 5;
    missileY -= 5;
  }
  if (keyCode == ' ') {
    firing = true;
  }
}

void keyReleased() {
  if (keyCode == 'S') {
    turningRight = false;
  } else if (keyCode == 'W') {
    turningLeft = false;
  }
}
