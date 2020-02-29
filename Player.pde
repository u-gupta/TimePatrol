class Player{
  
  int wave;
  PVector vel,acc;
  PVector position;
  int[][] level;
  boolean flag=true;
  Player_Projectile bullets[];
  Physics p1;
  float cx;
  int hp;
  Enemies[] enemies;
  float gun_pointer;
  
  Player(int wave,int[][] level, Physics p1, int x){
    this.p1=new Physics(p1);
    this.wave=wave;
    this.level=level;
    int a=0;
    for(int i=0;i<level.length;i++){
      if(level[i][x]==1 || level[i][x+74]==1 ){
        a=i-90;
        break;
      }
    }
    create(x,a-90);
    bullets=new Player_Projectile[0];
    hp=90;
    gun_pointer=0.1;
  }
  
  void hit(int attack){
    player_hit.rewind();
    player_hit.play(800);
    hp-=attack;
    
    
  }
  
  boolean check_alive(){
    if(hp<=0)
      return false;
    return true;
  }
  
  void create(int x,int y){
    position=new PVector(x,y);
    vel=new PVector(0,0);
    acc=new PVector();
    acc=p1.gravity.copy();
  }
  
  void move(int a){
    //System.out.println("Before move"+acc.x);
    acc.x=p1.gravity.x+a*(height/45);
    //System.out.println("After move"+acc.x);
    
  }
  
  void jump(){
    if(flag){
      vel.y=-height/3;
      flag=false;
    }
  }
  
  void resolve(){
    int velx=(int)vel.x, vely=(int)vel.y;
    
    while((int)velx>0){
      if((position.x+75+1)<level[0].length && level[(int)(position.y)][(int)(position.x+75+1)]!=1 && level[(int)(position.y+73)][(int)(position.x+75+1)]!=1){
        if(!check_collision(position.x+1,position.y))
          position.x+=1;
      }
        velx--;
    }
    
    while((int)vely>0){
      if((position.y+75+1)<level.length && level[(int)(position.y+75)][(int)(position.x+73)]!=1 && level[(int)(position.y+75)][(int)(position.x)]!=1){
        if(!check_collision(position.x,position.y+1))
          position.y+=1;
      }
        vely--;
    }
    
    while((int)velx<0){
      if((position.x-1)>=cx && (position.x-1)<level[0].length && level[(int)(position.y)][(int)(position.x-1)]!=1 && level[(int)(position.y+73)][(int)(position.x-1)]!=1){
        if(!check_collision(position.x-1,position.y))
          position.x-=1;
      }
        velx++;
    }
    
    while((int)vely<0){
      if((position.y-1)>=0 && (position.y-1)<level.length && level[(int)(position.y-1)][(int)(position.x)]!=1 && level[(int)(position.y-1)][(int)(position.x+73)]!=1){
        if(!check_collision(position.x,position.y-1))
          position.y-=1;
      }
        vely++;
    }
    
    if(position.y+75+1>=900)
      hp=0;
    
    if(position.y+75+1<900 &&( level[(int)position.y+75+1][(int)position.x+1]==1 || level[(int)position.y+75+1][(int)position.x+75-1]==1))
      flag=true;
      
    if((int)position.x+76<level[0].length && level[(int)position.y][(int)position.x+76]==1)
      vel.x=0;
    
    if(position.x-1<=0 || (vel.x<0 && level[(int)position.y][(int)position.x-1]==1))
      vel.x=0;
    
    //System.out.println("Before updation"+vel.x);    
    vel.x=(vel.x+acc.x)>20?20:(vel.x+acc.x)<0?(vel.x+acc.x)<-20?-20:(vel.x+acc.x):(vel.x+acc.x); 
    vel.y=(vel.y+acc.y)>180?180:(vel.y+acc.y);
    //System.out.println("After updation"+vel.x);
    acc=p1.gravity.copy();
    vel.y=(int)vel.y*p1.drag;
    vel.x=(int)vel.x*p1.friction;
  }
  
  boolean check_collision(float x, float y){
    for(int i=0;i<enemies.length;i++){
      if(abs(enemies[i].position.x-x)<=75 && abs(enemies[i].position.y-y)<=75)
        return true;
    }
    return false;
  }
  
  void shoot(float x, float y, int currentx){
    Player_Projectile temp[]=bullets;
    bullets=new Player_Projectile[temp.length+1];
    for(int i=0;i<temp.length;i++)
      bullets[i]=temp[i];
    bullets[temp.length]=new Player_Projectile(position.x, position.y, x, y, level, p1, currentx, gun_pointer);
  }
  
  void removeBullets(){
    for(int i=0;i<bullets.length;i++){
      if(bullets[i].isAlive==false){
        //System.out.println("Removing bullet");
        Player_Projectile[] temp=bullets;
        bullets=new Player_Projectile[temp.length-1];
        for(int j=0;j<i;j++)
          bullets[j]=temp[j];
        for(int j=i;j<bullets.length;j++)
          bullets[j]=temp[j+1];
        i--;
      }
    }
  }
  
  void drawBullets(int currentx, Boss b1, FinalBoss b2){
    //System.out.println("Number of bullets alive: "+bullets.length);
    removeBullets();
    for(int i=0;i<bullets.length;i++)
      bullets[i].drawProjectile(currentx, enemies, null, b1, b2);
  }
  
  void draw_player(float currentx, Enemies[] e, Boss b1, FinalBoss b2){
    enemies=e;
    cx=currentx;
    resolve();
    ellipseMode(CENTER);
    fill(0,145,255);
    ellipse(position.x-currentx+37.5,position.y+37.5,75,75);
    drawBullets((int)currentx, b1, b2);
  }
  
  void new_gun(){
    new_gun.rewind();
    new_gun.play(1500);
    gun_pointer=0.001;
  }
  
}
