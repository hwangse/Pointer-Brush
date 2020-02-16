class DrawingBackground {
  PImage[] images; // array of images
  PImage whole;

  // star array
  ArrayList<Star> stars;

  // the position of each drawings
  ArrayList<Integer>posX;
  ArrayList<Integer>posY;

  // the variable for mouse interation
  int preX, preY;

  float alpha=0;
  int count=0;
  boolean finishFlag=false;

  DrawingBackground() {
    // load images
    images=new PImage[7]; 
    for (int i=0; i<images.length; i++) 
      images[i]=loadImage("img/"+i+".png");

    // load star images
    stars=new ArrayList<Star>(6);
    for (int i=0; i<6; i++)
      stars.add(new Star(i+1));

    whole=loadImage("img/complete.png");

    // generate position array
    posX=new ArrayList<Integer>();
    posY=new ArrayList<Integer>();
  }
  // the user can place each drawing where they want
  boolean placeDrawing(int target, boolean mouseClick) {
    preX=mouseX;
    preY=mouseY;
    imageMode(CENTER);
    image(images[target+1], mouseX, mouseY);
    if (mouseClick) {
      posX.add(preX);
      posY.add(preY);
      return true;
    }
    return false;
  }

  // drawing whole images
  void drawBackground(int complete) {
    // very basic background
    imageMode(CORNER);
    image(images[0], 0, 0);
    imageMode(CENTER);
    for (int i=1; i<complete+1; i++) {
      image(images[i], posX.get(i-1), posY.get(i-1));
    }
    /////////////test code here////////////////////
    //for(int i=0;i<stars.size();i++)
    //     stars.get(i).starDraw();
    //////////////////////////////////////////
    if (complete==6) { // after the user complete his/her drawing
      if (!finishFlag && screenChangeEffect()) {
        finishFlag=true;
      }
      if (finishFlag) {
        bgm.play();
        imageMode(CORNER);
        image(whole, 0, 0);
        fill(255, 150);
        text("Starry Night", 100, height-30);

        // draw blinking stars
        for (int i=0; i<stars.size(); i++)
          stars.get(i).starDraw();
      }
    }
  }

  boolean screenChangeEffect() {

    count++;

    if (count<150) {
      alpha+=2;
    } else if (count<320) {
      imageMode(CORNER);
      image(whole, 0, 0);
      //tint(255,alpha*-1);
      alpha-=2;
    }

    fill(255, alpha);
    noStroke();
    rect(0, 0, width, height);


    if (count==320) return true;
    return false;
  }
}
