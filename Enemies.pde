class Enemies{
  int[][] level;
  Physics p1;
  int wave;
  int vel;
  int direction;
  PVector position;
  int index, total;
  boolean isVisible=false,isAlive;
  int counter=(int)frameRate/2;
  Player_Projectile[] bullets;
  Enemies(int [][]level, Physics p1, int wave, int index, int total){
    this.level=level;
    this.p1=new Physics(p1);
    this.wave=wave;
    this.index=index;
    this.total=total;
    create();
    bullets=new Player_Projectile[0];
    isAlive=true;
  }
  
  void create(){
    float range=level[0].length-width;
    range/=total;
    int positionY=level.length-1,positionX;
    positionX=width+(int)random(range*index,index*(1+range));
    if(positionX==0)
      positionX+=200;
    for(int i=0;i<level.length;i++){
      if(level[i][positionX]==1 || level[i][positionX+69]==1 ){
        positionY=i-1;
        break;
      }
    }
    position=new PVector(positionX,positionY-70);
    vel=5;
    direction=1;
  }
  
  void move(){
    if(position.x+direction < 0 || position.x+71>=level[0].length || level[(int)position.y][(int)(position.x+35 +(direction*36))]==1 || level[(int)position.y+71][(int)(position.x+35 +(direction*36))]==0){
      direction*=-1;
    }
      
    position.x+=1* direction;
  }
  
  void shoot(float x, float y, int currentx){
    //System.out.println("Trying to shoot");
    Player_Projectile temp[]=bullets;
    bullets=new Player_Projectile[temp.length+1];
    for(int i=0;i<temp.length;i++)
      bullets[i]=temp[i];
    bullets[temp.length]=new Player_Projectile(position.x+35, position.y, x, y, level, p1, currentx, 0);
    shoot2.rewind();
    shoot2.setGain(-18);
    shoot2.play(400);
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
  
  void drawBullets(int currentx, Player p1){
    //System.out.println("Number of bullets alive: "+bullets.length);
    removeBullets();
    for(int i=0;i<bullets.length;i++)
      bullets[i].drawProjectile(currentx,new Enemies[0], p1, null, null);
  }
  
  void drawEnemy(int currentx, Player p1){
    
    //for(int i=0;i<p1.bullets.length;i++){
    //  if(p1.bullets[i].position.x-(position.x-currentx)>=0 && p1.bullets[i].position.x-(position.x-currentx)<=71 && p1.bullets[i].position.y-position.y>=0 && p1.bullets[i].position.y-position.y<=71){
    //    //System.out.println("Doing!!");
    //    isAlive=false;
    //    p1.bullets[i].isAlive=false;
    //  }
    //}
    
    drawBullets(currentx,p1);
    if(!detect(p1.position.x+37.5-currentx, p1.position.y+37.5, currentx)){
      for(int i=0;i<vel;i++)
        move();
      counter=(int)frameRate/2;
    }
    else{
      if(counter==0){
        counter=(int)frameRate*2;
        shoot(p1.position.x+37.5, p1.position.y+37.5, currentx);
      }
      else counter--;
    }
    
    //for(int i=0;i<bullets.length;i++){
    //  //System.out.println("Checking for bullet : "+i);
    //  //System.out.println("LOCATIONS: "+bullets[i].position.x+" and :"+p1.position.x+37.5);
    //  if(abs(bullets[i].position.x+currentx-(p1.position.x+37.5))<=39 && abs(bullets[i].position.y-(p1.position.y+37.5))<=39){
    //    System.out.println("Hitting"+(15*((wave+9)/10)));
    //    p1.hit(15*((wave+9)/10));
    //    bullets[i].isAlive=false;
    //  }
    //}
    //if(index==1)
      //System.out.println("testing about index 1: "+isVisible);
    
    if(position.x+70>=currentx && position.x<=currentx +width){
      isVisible=true;
      fill(255,123,152);
      rect(position.x-currentx,position.y,70,70);
    }
    else
      isVisible=false;
  }
  
  
  boolean detect(float x, float y, int currentx){
    
    if(isVisible){
      int tempx=(int)(position.x-currentx+35), tempy= (int)position.y;
      
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
        
      //float direction_percent_x= abs(tpath.x) / distance;
      //float direction_percent_y= abs(tpath.y) / distance;
      
      float updation_x=abs(tpath.x) / distance;
      
      //updation_x= 2/(float)Math.sqrt(1+(Math.pow((direction_percent_y/direction_percent_x),2)));
      
      float updation_y=abs(tpath.y) / distance;
      
      //updation_y= 2/(float)Math.sqrt(1+(Math.pow((direction_percent_x/direction_percent_y),2)));
      //System.out.println();
      updation_x*=tdirectionx*40;
      updation_y*=tdirectiony*40;
      
      
      while(tempx>0 && tempx+updation_x<width && tempy+updation_y<900 && tempx+updation_x>=0 && tempy+updation_y>=0
        //&& level[tempy+(int)(updation_y/80)][tempx+(int)(updation_x/80)]!=1
        //&& level[tempy+(int)(updation_y/70)][tempx+(int)(updation_x/70)]!=1
        //&& level[tempy+(int)(updation_y/60)][tempx+(int)(updation_x/60)]!=1
        //&& level[tempy+(int)(updation_y/50)][tempx+(int)(updation_x/50)]!=1
        //&& level[tempy+(int)(updation_y/40)][tempx+(int)(updation_x/40)]!=1
        //&& level[tempy+(int)(updation_y/30)][tempx+(int)(updation_x/30)]!=1
        //&& level[tempy+(int)(updation_y/20)][tempx+(int)(updation_x/20)]!=1
        //&& level[tempy+(int)(updation_y/10)][tempx+(int)(updation_x/10)]!=1
        //&& level[tempy+(int)(updation_y)][tempx+(int)(updation_x)]!=1
        && !check_valid((int)tempy,(int)updation_y,(int)tempx,(int)updation_x,40, currentx)
        && (float)Math.sqrt(Math.pow((position.x-currentx-tempx),2)+Math.pow((position.y-tempy),2))<=distance){
        
        
        if(abs(tempx-x)<=75 && abs(tempy-y)<=75)
          return true;
        
        //ellipse(tempx,tempy,1,1);
        //System.out.println("tempx: "+tempx + "tempy: "+tempy);
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
