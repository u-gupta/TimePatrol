class Player_Projectile{
  PVector position,direction,orientation;
  int[][] l;
  boolean isAlive;
  int speed=100;
  Physics p1;
  int currentx;
  Player_Projectile( float originX, float originY, float destX, float destY, int[][] level, Physics p1, int c, float mass){
    //System.out.println("For Bullet: "+destX);
    position=new PVector(originX-c,originY);
    direction=new PVector((destX-c)-(originX-c),destY-originY);
    if(mass==0.1 || mass==0.001)
      direction.x=(destX)-(originX-c);
    mass=mass==0.001?0:mass;
    orientation=new PVector(direction.x/abs(direction.x),direction.y/abs(direction.y));    
    //System.out.println("For Bullet 2: "+position.x);
    isAlive=true;
    l=level;
    this.p1=new Physics(p1);
    this.p1.add_mass(mass);
    currentx=c;
  }
  void move(){
    float direction_percent_x= abs(direction.x) / ( abs(direction.x) + abs(direction.y));
    float direction_percent_y= abs(direction.y) / ( abs(direction.x) + abs(direction.y));
    
    float updation_x= 1/(float)Math.sqrt(1+(Math.pow((direction_percent_y/direction_percent_x),2)));
    float updation_y= 1/(float)Math.sqrt(1+(Math.pow((direction_percent_x/direction_percent_y),2)));
    
    updation_x*=orientation.x;
    updation_y*=orientation.y;
    
    if(position.y+updation_y<900 && position.y+updation_y>=0 && position.x+updation_x>=0 && position.x+updation_x<l[0].length && l[(int)(position.y+updation_y)][(int)(position.x+updation_x+currentx)]==0){
      //System.out.println("Moving Bullet: X: " + position.x+ " Y: "+position.y);
      position.y=(position.y+ updation_y);//*p1.drag;
      position.x=(position.x + updation_x);//*p1.drag;
    }
    check_alive(updation_y, updation_x);
    //System.out.println("Testing for bullet"+l[0].length);
    //System.out.println("Testing for bullet 2 "+(l[(int)(position.y+updation_y)][(int)(position.x+updation_x)]==0));
  }
  
  void check_alive(float updation_y, float updation_x){
    if(isAlive)
      //System.out.println("(position.y+updation_y) : "+(position.y+updation_y)+" (position.x+updation_x) : "+(position.x+updation_x)+" L : "+l[(int)(position.y+updation_y)][(int)(position.x+updation_x)]);
    if(position.y+updation_y>=900 || position.y+updation_y<0 || position.x+updation_x<0 || position.x+updation_x>width || position.x+updation_x+currentx>=l[0].length ||l[(int)(position.y+updation_y)][(int)(position.x+updation_x+currentx)]==1){
      isAlive=false;  
    }
  }
  void resolute(){
    position.add(p1.gravity.mult(0.9));
  }
  
  void drawProjectile(int c, Enemies[] e, Player p, Boss b1, FinalBoss b2){
    currentx=c;
    for(int i=0;i<speed && isAlive;i++){
      move();
      check_hit(e,p,b1,b2);
      resolute();
      
    }
    
    if(speed==0){
      for(int i=0;i<100;i++){
        check_alive(1,0);
        check_hit(e,p,b1,b2);
        position.y+=1;
      }
    }
    speed*=p1.drag;
    noStroke();
    if(speed/4<=p1.lightspeed){
      fill(85,65,6);
      rect(position.x-1.5,position.y-1.5,3,3);
    }
    stroke(0);
  }
  
  void check_hit(Enemies[] e, Player p, Boss b1, FinalBoss b2){
    if(isAlive){
      if(b2==null && b1==null && e.length==0 && p!=null && abs(position.x+currentx-(p.position.x+37.5))<=39 && abs(position.y-(p.position.y+37.5))<=39){
        p.hit(15*((wave+9)/10));
        isAlive=false;
        return;
      }
      if(b2!=null && b1==null && e.length==0 && p!=null && abs(position.x+currentx-(p.position.x+37.5))<=39 && abs(position.y-(p.position.y+37.5))<=39){
        p.hit(9);
        isAlive=false;
        return;
      }
      
      if(b2==null && b1==null && p==null && e.length>0){
        for(int i=0;i<e.length;i++){
          if(position.x-(e[i].position.x-currentx)>=0 && position.x-(e[i].position.x-currentx)<=71 && position.y-e[i].position.y>=0 && position.y-e[i].position.y<=71){
            enemy_hit.rewind();
            enemy_hit.play(800);
            e[i].isAlive=false;
            isAlive=false;
            return;
          }
        }
      }
      if(b1!=null && b2==null && p==null && e.length<=0 && position.x-(b1.position.x-currentx)>=0 && position.x-(b1.position.x-currentx)<=121 && position.y-b1.position.y>=0 && position.y-b1.position.y<=121){
        enemy_hit.rewind();
        enemy_hit.play(800);
        b1.hp--;
        isAlive=false;
        return;
      }
      if(b2!=null &&  p==null && e.length<=0 && position.x-(b2.position.x-currentx)>=0 && position.x-(b2.position.x-currentx)<=121 && position.y-b2.position.y>=0 && position.y-b2.position.y<=121){
        enemy_hit.rewind();
        enemy_hit.play(800);
        b2.hp--;
        isAlive=false;
        return;
      }
    }
  }
}
