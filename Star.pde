class Star {
  int id;
  float alpha;
  float speed;
  boolean increaseFlag; // whether to increase alpha or not
  PImage myStar;

  Star(int _id) {
    id=_id;
    speed=random(0.5, 0.7)*3; // the speed of blinking star
    myStar=loadImage("img/star"+id+".png");

    int tmp=(int)random(0, 2);

    if (tmp==1) {
      increaseFlag=true;
      alpha=0;
    } else { 
      increaseFlag=false;
      alpha=255;
    }
  }
  void starDraw() {
    blinking();
    tint(255, alpha);
    imageMode(CORNER);
    image(myStar,0,0);
    noTint();
  //  tint(255, 0); // prevent affecting other pictures
  }
  void blinking() {
    if (increaseFlag) {
      alpha+=speed;
      if (alpha>255) {
        alpha=255;
        increaseFlag=false;
      }
    } else {
      alpha-=speed;
      if (alpha<=0) {
        alpha=0;
        increaseFlag=true;
      }
    }
  }
}
