class Pickups{
  int x;
  int y;
  boolean isAlive;
  char type;
  //int currentx;
  Pickups(int x, int y, char type){
    this.x=x-5;
    this.y=y-10;
    isAlive=true;
    this.type=type;
    //this.currentx=currentx;
  }
  
  void draw_pickup(int currentx){
    if(isAlive){
      if(type=='g'){
        fill(42,52,57);
        quad(x+37.5-currentx, y, x+75-currentx, y+37.5, x+37.5-currentx, y+75, x-currentx, y+37.5);
        fill(200);
        textAlign(CENTER);
        text("G",x+37.5-currentx, y+50);
      }
      else if(type=='l'){
        fill(184,134,11);
        quad(x+37.5-currentx, y, x+75-currentx, y+37.5, x+37.5-currentx, y+75, x-currentx, y+37.5);
        fill(200);
        textAlign(CENTER);
        text("L",x+37.5-currentx, y+50);
      }
    }
  }
  
  boolean check(int px, int py){
    if(abs(px-x)<75 && abs(py-y)<75 && isAlive){
      isAlive=false;
      return true;
    }
    return false;
  }
}
