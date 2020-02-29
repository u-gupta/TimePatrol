import ddf.minim.*;

Level l1;
int timer;
int wave=1;
boolean shootFlag=true;
int randomnessMult=1;
int spawn_timer;
boolean start_flag;
RefreshLevel r1;
int refresh_counter=0;
int escapeTimer;
boolean win_flag;
Minim minim;


AudioPlayer background;
AudioPlayer shoot1, shoot2,player_dead,player_hit,enemy_hit;
AudioPlayer boss_kill, Win;
AudioPlayer new_gun,Lightspeed;

void setup(){
  
  size(1350,975);
  
  minim=new Minim(this);
  background=minim.loadFile("Background.mp3");
  shoot1=minim.loadFile("Gunshot.wav");
  shoot2=minim.loadFile("Gunshot.wav");
  boss_kill=minim.loadFile("boss-kill.mp3");
  new_gun=minim.loadFile("new_gun.mp3");
  Lightspeed=minim.loadFile("Lightspeed.mp3");
  player_dead=minim.loadFile("player_dead.mp3");
  player_hit=minim.loadFile("player_hit.mp3");
  enemy_hit=minim.loadFile("enemy_hit.mp3");
  Win=minim.loadFile("Win.mp3");
  reset();
  
}

void draw(){
  if(start_flag){
    
    background(25);
    draw_menu();
  }
  else{
    check_win();
    if(!win_flag){
      background.setGain(-13);
      if(wave<=10)
        background(135,206,235);
      else if(wave<=20)
        background(232,213,153);
      else if(wave>20)
        background(169,169,169);
        
      if(escapeTimer>0){
        textAlign(CENTER);
        textSize(50);
        fill(25);
        text("Press 'Q' Again to Quit",width/2,height/2);
        escapeTimer--;
      }
      if(spawn_timer>0){
        spawn_timer--;
        textAlign(CENTER);
        textSize(100);
        fill(25);
        text("Level :"+wave,width/2,height/2);
        textSize(28);
        text("Randomness: "+(float)randomnessMult*100/30+"%",width/2,height/2+35);
      }
      draw_dock();
      l1.draw_level();
      if(abs(l1.p1.vel.x)>l1.p1.p1.lightspeed){
        timer=(int)(abs(l1.p1.vel.x)/l1.p1.p1.lightspeed)*(int)frameRate;
      }
      //if(l1.p1.vel.y>l1.p1.lightspeed){
      //  timer=(int)(l1.p1.vel.y/l1.p1.lightspeed);
      //}
      if(timer>0){
        background(0);
        timer--;
      }
      //line(width/2,0,width/2,height);
      next_level();
    }
    else{
      background.pause();
      background(255,123,152);
      fill(25);
      textAlign(CENTER);
      textSize(100);
      text("Congratulations!!\nYou Won!!!", width/2, 300);
      fill(25);
      textAlign(CENTER);
      textSize(50);
      text("Press Spacebar to continue...", width/2, 600);
      
    }
  }
}

void draw_menu(){
  
  fill(200);
  textAlign(CENTER);
  textSize(100);
  text("Time Patrol",width/2,175);
  fill(0);
  strokeWeight(4);
  stroke(200);
  rect(width/2-175,height/2-227.5,350,55);
  fill(200);
  strokeWeight(1);
  noStroke();
  textAlign(CENTER);
  textSize(45);
  text("New Game",width/2,height/2-185);
  fill(0);
  strokeWeight(4);
  stroke(200);
  rect(width/2-175,height/2-127.5,350,55);
  fill(200);
  strokeWeight(1);
  noStroke();
  textAlign(CENTER);
  textSize(45);
  text("Continue",width/2,height/2-85);
  fill(0);
  strokeWeight(4);
  stroke(200);
  rect(width/2-175,height/2-27.5,350,55);
  fill(200);
  strokeWeight(1);
  noStroke();
  textAlign(CENTER);
  textSize(45);
  text("Refresh Levels",width/2,height/2+15);
  if(refresh_counter>0){
    
    textAlign(CENTER);
    fill(200);
    text("Levels Refreshed!", width/2, height-20);
    refresh_counter--;
    
  }
}

void draw_dock(){
  //noStroke();
  float hp=(l1.p1.hp);
  hp/=90;
  hp*=100;
  if(hp<=0){
    player_dead.rewind();
    player_dead.play(775);
    respawn((int)l1.currentx);
  }
  fill(25);
  rect(0,900,width,75);
  textAlign(LEFT);
  textSize(45);
  fill(200);
  text("HP: "+hp+"%",5,945);
  textAlign(CENTER);
  if(l1.enemies.length>0)
    text("Enemies Left: "+l1.enemies.length, width/2, 945);
  else if(l1.b1!=null && l1.b1.isAlive)
    text("Boss HP: "+(float)(l1.b1.hp)/(((wave/10)*10)+10)*100+"%", width/2, 945);
  else if(l1.b2!=null && l1.b2.isAlive)
    text("Boss HP: "+(float)(l1.b2.hp)*2+"%", width/2, 945);
  if(spawn_timer<=0){
    textAlign(RIGHT);
    text("Level: "+wave,width-5, 945);
  }
  //text()
}

void respawn(int x){
  spawn_timer=(int)frameRate;
  l1.spawn(++randomnessMult,x);
  saveData();
}

void next_level(){
  if(l1.bossflag && l1.b1.isAlive==false){
    if(wave<30){
      boss_kill.rewind();
      boss_kill.play(500);
      l1=new Level(++wave,++randomnessMult);
      saveData();
      spawn_timer=(int)frameRate;
    }
    if(wave==30){
      l1.create_boss();
    }
  }
}

void saveData(){
  Table t1= new Table();
  t1.addColumn("wave");
  t1.addColumn("randomnessMult");
  TableRow r1=t1.addRow();
  r1.setInt("wave",wave);
  r1.setInt("randomnessMult",randomnessMult);
  saveTable(t1, "data/saveData.csv");
}

void clearData(){
  Table t1= new Table();
  t1.addColumn("wave");
  t1.addColumn("randomnessMult");
  TableRow r1=t1.addRow();
  r1.setInt("wave",1);
  r1.setInt("randomnessMult",1);
  saveTable(t1, "data/saveData.csv");  
}

void keyPressed(){
  
  if(!start_flag){
    if(keyCode==RIGHT || key=='d' || key=='D')
      l1.p1.move(1);
    if(keyCode==LEFT || key=='a'|| key=='A')
      l1.p1.move(-1);
    if(keyCode==UP || key=='w'|| key=='W')
      l1.p1.jump();
    if(key=='q' || key=='Q'){
      if(escapeTimer==0)
        escapeTimer=(int)frameRate*2;
      else{
        reset();
      }        
    }
    if(key==' ' && win_flag)
      reset();
  }
  
  
}
void check_win(){
  if(l1.b2!=null && !l1.b2.isAlive && !win_flag){
    Win.loop();
    win_flag=true;
  }
}
void reset(){
  Win.pause();
  background.loop();
  escapeTimer=0;
  start_flag=true;
  win_flag=false;
}

void mousePressed(){
  if(start_flag){
    if(mouseX>=(width/2-175) && mouseX<=(width/2+175) && mouseY>=height/2-227.5 && mouseY<=height/2-172.5){
      saveData();
      spawn_timer=(int)frameRate;
      l1=new Level(wave,randomnessMult);
      start_flag=false;
    }
    if(mouseX>=(width/2-175) && mouseX<=(width/2+175) && mouseY>=height/2-127.5 && mouseY<=height/2-72.5){
      Table t1=loadTable("data/saveData.csv","header");
      wave=t1!=null?t1.getRow(0).getInt("wave"):1;
      randomnessMult=t1!=null?t1.getRow(0).getInt("randomnessMult"):1;
      l1=new Level(wave,randomnessMult);
      start_flag=false;
    }
    if(mouseX>=(width/2-175) && mouseX<=(width/2+175) && mouseY>=height/2-27.5 && mouseY<=height/2+27.5){
      clearData();
      r1=new RefreshLevel();
      refresh_counter=(int)frameRate;
    }
  }
  else{
    if(shootFlag){
      shoot1.rewind();
      shoot1.setGain(-13);
      shoot1.play(300);
      l1.p1.shoot(mouseX, mouseY, (int)l1.currentx);
      shootFlag=false;
    }
  }
}

void mouseReleased(){
  if(!start_flag)
    shootFlag=true;
}
