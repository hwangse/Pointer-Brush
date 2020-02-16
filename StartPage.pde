class StartPage{
  float btnX,btnY;
  int btnWidth,btnHeight;
  PImage main;
  float txtAlpha;
  float speed;
  boolean flag;
  
  StartPage(){
   btnX=width/2;
   btnY=height/1.2;
   btnWidth=70;
   btnHeight=50;
   txtAlpha=255;
   speed=5;
   flag=false;
   
   main=loadImage("img/main.png");
  }
 
  boolean drawStart(){
    //draw main image
    image(main,0,0);
    
    txtBlinking();
    fill(255,txtAlpha);
    text("Go !",btnX,btnY);
    rectMode(CORNER);
    
    if(btnClicked()) return true;
    return false;
  }
  
  boolean btnClicked(){
    if(mouseClickFlag &&btnX-btnWidth/2<=mouseX && mouseX <=btnX+btnWidth/2 && btnY-btnHeight/2<=mouseY && mouseY<=btnY+btnHeight/2){
      mouseClickFlag=false;
      return true;
    }
    return false;
  }
  void txtBlinking(){
   if(!flag){ // alpha goes down
     txtAlpha-=speed;
     if(txtAlpha<=0){
       txtAlpha=0;
       flag=true;
     }
   }else{
    txtAlpha+=speed;
    if(txtAlpha>=255){
      txtAlpha=255;
      flag=false; 
    }
   }
  }
  
}
