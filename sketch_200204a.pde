  import ddf.minim.*;
  
  float vx=6;
  int vy=3;
  int y=200;
  float x=10;
  PImage img1;
  boolean game;
  int ganador=0;
  String max="";
  int max2=10;
  jugador jug2;
  jugador jug1;
  boolean back=true;
  int back2=0;
  int resetea=0;
  boolean music;
  boolean flag=true;
  Minim sonido;
  AudioSample sound;
  AudioSample sound2;
  AudioSample sound3;
  AudioSample sound4;
  AudioSample sound5;
  int bonus=0;
  boolean bonusplus=false;
  float rand1;
  float rand2;
  int count=0;
  
void setup(){
  size(450,450);
  textAlign(CENTER);

  music=true;
  sonido = new Minim(this);
  game=false;
  jug1=new jugador(int(width*0.96),height/2);
  jug2=new jugador(0,height/2);
  img1=loadImage("cesped.jpg");
  sound= sonido.loadSample("main.mp3",1024);
  sound3= sonido.loadSample("golpe.mp3",1024);
  sound4= sonido.loadSample("win.mp3",1024);
  sound5= sonido.loadSample("point.mp3",1024);
  sound.trigger();
}

void draw(){

  back2++;
  if(back2>40){
    back2=0;
    back= !back;
  }
  
  
  if(game){
    if(music){     
      sound2= sonido.loadSample("best.mp3",850);
      sound.stop();
      sound2.trigger();
      music=false;
      if(max.length()>0)max2=Integer.valueOf(max);
    }
    background(img1);
    fill(255);
    rect(jug2.get()[0],jug2.get()[1],20,50);
    rect(jug1.get()[0],mouseY,20,50);
    fill(0);
    ellipse(x,y,20,20);
    textAlign(CENTER);
    textSize(30);
    fill(255);
    strokeWeight(2);
    stroke(0);
    /*fill(100,149,237);
    if(bonusplus)ellipse(rand1,rand2,20,20);
    fill(255);*/
    rect(width/2-70,10,140,40);
    line(width/2,20,width/2,40);
    fill(254,0,0);
    text(jug2.getScore(),width/2+30,40);
    text(jug1.getScore(),width/2-30,40);
         x=x+vx;
  
      if(x<0 || x>width){
        vx=-vx;
      }
      y=y+vy;
      if(y>height || y<0){
        vy=-vy;
      }
      
      if( vx>0 && mouseY+50 > y && mouseY <= y+20 && x+10 >= jug1.get()[0] && jug1.get()[0]+10 > x  ){
            sound2.mute();
            sound3.trigger();
            sound2.unmute();
            vx=-vx;
            vy= (int) random(-5,5);          
      }
      
      if( vx<0 && x+20 >=jug2.get()[0] && jug2.get()[0]+20 > x && jug2.get()[1] <= y+20 && jug2.get()[1]+50 > y ){
          sound2.mute();
          sound3.trigger();
          sound2.unmute();
          vx=-vx;
          vy= (int) random(-5,5);
      }
    
    if(keyPressed){
      if(key=='w')jug2.subir();
      if(key=='s')jug2.bajar();
    }
    if(x>=width)if(jug2.win())end(2) ;
    if(x<=0)if(jug1.win())end(1);
    bonus++;
    if(bonus==600){
      rand1=random(0,width);
      rand2=random(0,height);
      bonusplus=true;
      
    }else if(bonus>1200){
      bonus=0;
      bonusplus=false;
      rand1=0;
      rand2=0;
      }
      
      
      /*AUMENTO DE VELOCIDAD*/
      /*if(rand1 !=0 && rand2 != 0 && ( ( abs(x-rand1)<20 ) && ( abs(y-rand2)<20 ) ) ){
        vx=vx*1.25;
        bonus=601;
        count=7000;
        bonus=0;
        bonusplus=false;
        rand1=0;
        rand2=0;
        
      }
      
      if(count>0){
        count--;
        if(count==0){
          vx=vx*0.8;
        }
      }*/
    
  }else{
    /*if(ganador>0){
       background(255);
       fill(0);
       textSize(40);
       text("FINAL",width/2,height/2);
       text("Gana el jugador "+ganador,width/2,height/2+70);
       delay(4000);
       sound.trigger();
       ganador=0;
    }*/
    
  if(back){
    
    background(0);
    fill(255);
    textSize(40);
    text("PONG 2020",width/2,70);
    textSize(15);
    text("Creado por Ruben Garcia Quintana",width/2,height-30);
    text("Introduzca el numero de puntos para la victoria",width/2,height/2-40);
    rect(width/4,height/2,230,40);
    fill(0);
    text(max,width/2,height/2+25);
    fill(255);
    textSize(25);
    text("Pulsa enter para empezar",width/2,height-100);
  }else{
    

    background(255);
    fill(0);
    textSize(40);
    text("PONG 2020",width/2,70);
    textSize(15);
    text("Creado por Ruben Garcia Quintana",width/2,height-30);
    text("Introduzca el numero de puntos para la victoria",width/2,height/2-40);
    rect(width/4,height/2,230,40);
    fill(255);
    text(max,width/2,height/2+25);
    fill(0);
    textSize(25);
    text("Pulsa enter para empezar",width/2,height-100);
  }
  
  
  
  }
  


}

void reset(){
  
  }
  
  
  class jugador{
      public int[] coord= new int[2];
      public int score;
      jugador(int a, int b){
          coord[0]=a;
          coord[1]=b;
          score=0;
      }
      

      public boolean win(){
        score++;
        sound5.trigger();
        if(score>=max2)return true;
        return false;
      }
      public void subir(){
        if(coord[1]>0)coord[1]=coord[1]-10;
      }
      public void bajar(){
        if(coord[1]<=height-50)coord[1]=coord[1]+10;
      }
      public int[] get(){
        return coord;
      }
      public int getScore(){
          return score;
      }
      
      public void resetScore(){
        score=0;
      }
      
  }
  
 void keyPressed(){
    if(key==ENTER)game=true;
    if(Character.isDigit(key)){
      max= max+key;
    }
    if(key==BACKSPACE && max.length()>0){
    max=max.substring(0,max.length()-1);
    }
  }
  
 void end(int n){
   game=false;
   sound2.stop();
   sound4.trigger();
   jug1.resetScore();
   jug2.resetScore();
   ganador=n;
   music=true;
   sound.trigger();

 }
   
