class DrawingBoard {
  ArrayList<Integer> xPos;
  ArrayList<Integer> yPos;
  float alpha;
  int target;
  int count;
  boolean fadeInFlag, fadeOutFlag,matchFlag;
  String[] targets={"Mountain", "House", "Wind", "Tree", "Moon","Star"};

  DrawingBoard(int _target) {
    alpha=0;
    target=_target;
    fadeInFlag=true;
    fadeOutFlag=false;
    matchFlag=false;
    count=0;
    xPos=new ArrayList<Integer>();
    yPos=new ArrayList<Integer>();
    textAlign(CENTER);
  }
  void fadeIn() {
    alpha+=2;
    if (alpha>=150) {
      alpha=150;
      fadeInFlag=false;
    }
  }
  boolean fadeOut() {
    alpha-=2;
    if (alpha<=0) {
      alpha=0;
      fadeOutFlag=false;
      return true;
    }
    return false;
  }

  void drawOn() {
    // for drawboard fade in fade o
    if (fadeInFlag)
      fadeIn();
    if (fadeOutFlag)
      fadeOut();
      
    if(matchFlag) count++;

    fill(0, alpha);
    noStroke();
    rect(0, 0, width, height);

    fill(255, 200);
    text("Draw "+targets[target], width/2, 50);

    // save user mouse drawing information
    if (mousePressed) {
      xPos.add(mouseX);
      yPos.add(mouseY);

      //Send the OSC message    
      sendOsc();
    }
    
    // user drawing
    stroke(255, 200);
    strokeWeight(5);
    for (int i=0; i<xPos.size(); i++) {
      point(xPos.get(i), yPos.get(i));
    }
  }

  void checkRightDrawing(int input) {
    if (input==target) {
      matchFlag=true;
      fadeOutFlag=true;
    }
  }

  void sendOsc() {
    OscMessage msg = new OscMessage("/wek/inputs");
    msg.add((float)mouseX); 
    msg.add((float)mouseY);
    oscP5.send(msg, dest);
  }
}
