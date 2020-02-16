import oscP5.*;
import netP5.*;
import ddf.minim.*;

OscP5 oscP5;
NetAddress dest;

DrawingBoard drawingBoard;
DrawingBackground drawingBackground;
int userDrawing=-1;
int target=0;
int cnt=0;
boolean startBtnClicked=false;
boolean waitingFlag;
boolean mouseClickFlag=false;

// Music setting
Minim minim;
AudioPlayer bgm, wind, magic;
AudioPlayer ambience, murmur, moon;

// Text and Font
PFont font;

// startPage
StartPage startPage;

void setup() {
  background(255);
  size(600, 400); 
  //fullScreen();
  noStroke();

  oscP5 = new OscP5(this, 12000); // input port number
  dest = new NetAddress("127.0.0.1", 6448); // output port number

  // prepare drawing board
  drawingBoard=new DrawingBoard(target);
  drawingBackground=new DrawingBackground();

  // text & font settings
  textSize(20);
  font=createFont("font/Playball.ttf", 32);
  textFont(font);

  // Load sounds
  minim = new Minim(this);
  bgm = minim.loadFile("sound/bgm.mp3");
  wind=minim.loadFile("sound/wind.mp3"); 
  wind.setGain(-10);
  magic=minim.loadFile("sound/magic.wav");
  ambience=minim.loadFile("sound/ambience.wav");
  moon=minim.loadFile("sound/moon.wav");
  moon.setGain(-10);

  // make startPage
  startPage=new StartPage();
}

boolean res=false;
int x, y;

void draw() {
  if (!startBtnClicked) {
    if (startPage.drawStart()) {
      magic.rewind();
      magic.play();
      startBtnClicked=true;
    }
  } else {
    drawingBackground.drawBackground(target);

    // draw board ON
    if (target<=5 && !waitingFlag) { 
      drawingBoard.drawOn();
      drawingBoard.checkRightDrawing(userDrawing);

      if (drawingBoard.matchFlag && drawingBoard.count>=100) { // if the user draw correctly
        magic.rewind();
        magic.play();
        waitingFlag=true;
      }
    } else if (waitingFlag) { // drawboard OFF (wait for drawings to complete)

      if (drawingBackground.placeDrawing(target, mouseClickFlag)) {
        if (target<5) {
          if (target==0) ambience.play();
          //if(target==1) murmur.play();
          if (target==2) wind.play(); // wind Sound 
          if (target==4) moon.loop(); // moon sound (blinking)
          drawingBoard=new DrawingBoard(++target);
        } else if (target==5) { // if the user matches last drawing element
          target=6;

          // modify music settings
          ambience.pause();
          moon.setGain(-20);
        }
        waitingFlag=false;
        mouseClickFlag=false;
      }
    }
  }
}

void mouseClicked() {
  mouseClickFlag=true;
}

// automatically called whenever osc message is received
void oscEvent(OscMessage m) {
  //m.print();
  /* check if theOscMessage has the address pattern we are looking for. */
  if (m.checkAddrPattern("/output_1")==true) {
    userDrawing=0;
  } else if (m.checkAddrPattern("/output_2")==true) {
    userDrawing=1;
  } else if (m.checkAddrPattern("/output_3")==true) {
    userDrawing=2;
  } else if (m.checkAddrPattern("/output_4")==true) {
    userDrawing=3;
  } else if (m.checkAddrPattern("/output_5")==true) {
    userDrawing=4;
  } else if (m.checkAddrPattern("/output_6")==true) {
    userDrawing=5;
  }
}
