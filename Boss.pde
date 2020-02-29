class Boss{
  
  int wave;
  int hp;
  int[][] level;
  PVector position;
  boolean isAlive;
  int direction;
  Physics p1;
  Player_Projectile[] bullets;
  int counter=(int)frameRate*2;
  boolean isVisible=true;
  int vel=5;
  Boss(int wave, int level[][], Physics p1){
    this.wave=wave;
    isAlive=true;
    direction=1;
    this.level=level;
    hp=((wave/10)*10)+10;
    position=new PVector();
    position.x=level[0].length-125;
    position.y=0;
    bullets=new Player_Projectile[0];
    this.p1=new Physics(p1);
  }
  
  void move(){
    //System.out.println("Trying to move");
    if(position.y+direction<=0 || level[(int)position.y+120+direction][(int)position.x]==1){
      //System.out.println("Changing direction");
      direction*=-1;
    }
    position.y+=direction;
  }
  
  void shoot(float x, float y, int currentx){
    //System.out.println("Trying to shoot");
    Player_Projectile temp[]=bullets;
    bullets=new Player_Projectile[temp.length+1];
    for(int i=0;i<temp.length;i++)
      bullets[i]=temp[i];
    bullets[temp.length]=new Player_Projectile(position.x, position.y, x, y, level, p1, currentx, 0);
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
  
  void drawBullets(int currentx,Player p1){
    //System.out.println("Number of bullets alive: "+bullets.length);
    removeBullets();
    for(int i=0;i<bullets.length;i++)
      bullets[i].drawProjectile(currentx, new Enemies[0], p1, null, null);
  }
  
  void draw_boss(int currentx, Player p1){
    //for(int i=0;i<p1.bullets.length;i++){
    //  if(p1.bullets[i].position.x-(position.x-currentx)>=0 && p1.bullets[i].position.x-(position.x-currentx)<=71 && p1.bullets[i].position.y-position.y>=0 && p1.bullets[i].position.y-position.y<=71){
    //    //System.out.println("Doing!!");
    //    hp--;
    //    p1.bullets[i].isAlive=false;
    //  }
    //}
    if(hp<=0)
      isAlive=false;
    drawBullets(currentx,p1);
    //System.out.println("Before updation: "+position.y);
    for(int i=0;i<vel;i++)
      move();
    //System.out.println("After updation: "+position.y);
    
    if(detect(p1.position.x+37.5-currentx, p1.position.y+37.5, currentx)){
      if(counter==0){
        counter=(int)frameRate*2;
        shoot(p1.position.x+37.5, p1.position.y+37.5, currentx);
      }
      else counter--;
    }
    
    //for(int i=0;i<bullets.length;i++){
    //  if(abs(bullets[i].position.x-(p1.position.x+37.5))<=39 && abs(bullets[i].position.y-(p1.position.y+37.5))<=39)
    //    p1.hit(15*((wave+9)/10));
    //}
    
    if(position.x+120>=currentx && position.x<=currentx +width ){
      isVisible=true;
      fill(255,63,52);
      rect(position.x-currentx,position.y,120,120);
    }
    else
      isVisible=false;
  }
  
  boolean detect(float x, float y, int currentx){
    
    if(isVisible){
      int tempx=(int)(position.x-currentx+60), tempy= (int)position.y;
      
      PVector tpath=new PVector(x-tempx,y-tempy);
      //line(x,y,tempx,tempy);
      float distance=(float)Math.sqrt(Math.pow(tpath.x,2)+Math.pow(tpath.y,2));
      //System.out.println(" Line Length = "+distance);
      //System.out.println("Points : "+ x+" "+y+" "+tempx+" "+tempy);
      float tdirectionx,tdirectiony;
      
      if(tempx>x)
        tdirectionx=-1;
      else if(tempx==x)
        tdirectionx=0;
      else
        tdirectionx=1;
        
      if(tempy>y)
        tdirectiony=-1;
      else if(tempy==y)
        tdirectiony=0;
      else
        tdirectiony=1;
        
      float updation_x=abs(tpath.x) / distance;
      
      float updation_y=abs(tpath.y) / distance;
      
      updation_x*=tdirectionx*40;
      updation_y*=tdirectiony*40;
      
      
      while(tempx>0 && tempx+updation_x<width && tempy+updation_y<900 && tempx+updation_x>=0 && tempy+updation_y>=0
        && !check_valid((int)tempy,(int)updation_y,(int)tempx,(int)updation_x,40, currentx)
        && (float)Math.sqrt(Math.pow((position.x-currentx-tempx),2)+Math.pow((position.y-tempy),2))<=distance){
        
        
        if(abs(tempx-x)<=75 && abs(tempy-y)<=75)
          return true;

        tempx+=updation_x;
        tempy+=updation_y;
        
      }
    }
    return false;
  }
  
  boolean check_valid(int x1,int x2, int y1,int y2, int size, int currentx){
    for(int i=0;i<size;i++){
      if(level[x1 +(i*x2/size) ][y1+(i*y2/size)+currentx]==1)
        return true;
    }
    return false;
  }
  
}
