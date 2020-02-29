class Level{
  
  int level[][];
  Player p1;
  Physics ph1;
  float currentx;
  Enemies[] enemies;
  int wave;
  Table table;
  Boss b1=null;
  FinalBoss b2=null;
  boolean bossflag=false;
  Pickups g1,l1;
  Level(int wave, int rand){
    
    table= loadTable("data/new"+wave+".csv","header");
    int[][] level=new int[table.getColumnCount()][table.getRowCount()];
    
    for(int i=0;i<level[0].length;i++){
      TableRow row=table.getRow(i);
      for(int j=0;j<level.length;j++){
        level[j][i]=row.getInt(""+j);
      }
    }
    
    //int[][] level={{0,1,1,0,0,0,0,1,0,0,0,1,0,0,0,1,1,0,0,0,0,1,0,1,1,0,0,0,1,0,1,0,0,1,0,1,0,1,1,0,1,0,1,1,0,0,1,0,0,1,0,1,0,1,1,1,0,0,0,0,0,1,0,0,0,0,1,1,0,0,1,0,1,0,0,1,0,0,1,0,1,0,0,1,0,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,1,0,1,0,1,1,1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1,1,0,1,0,0,0,1,1,1,1,0,0,0,1,0},{1,0,0,1,1,1,1,0,1,1,1,0,1,1,1,0,0,1,1,1,1,0,1,0,0,1,1,1,0,1,0,1,1,0,1,0,1,0,0,1,0,1,0,0,1,1,0,1,1,0,1,0,1,0,0,0,1,1,1,1,1,0,1,1,1,1,0,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1,0,1,0,0,0,1,1,1,1,1,0,0,0,0,1,1,1,0,1,0,1,0,0,0,1,1,1,0,1,0,1,1,1,0,1,0,1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,0,0,1,0,1,1,1,0,0,0,0,1,1,1,0,1},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
    this.level=new int[level.length*90][level[0].length*90];
    //for(int i=0;i<level.length;i++)
    //  for(int j=0;j<level[i].length;j++)
    //    for(int k=0;k<90;k++)
    //      this.level[i][j+k]=level[level.length-i-1][j];
    
    
    for(int i=0;i<this.level.length;i++){
      for(int j=0;j<this.level[i].length;j++){
        this.level[i][j]=0;  
      }
    }
    
    for(int i=0;i<level.length;i++){
      for(int j=0;j<level[i].length;j++){
        if(level[i][j]==1)
          add_level_point(level.length-1-i,j);
      }
    }
    //System.out.println(ph1.gravity.y);
    spawn(rand, 0);
    currentx=0;
    this.wave=wave;
    enemies=new Enemies[(level[0].length/15)*(wave+9)/10];
    add_enemies();
    g1=null;
    l1=null;
  }
  
  void spawn(int rand, int x){
    
    rand=rand<=30?rand:30;
    ph1=new Physics(0.99-(rand*0.03));
    p1=new Player(wave,this.level, ph1, x);
    move_camera();
  }
  
  void add_level_point(int a, int b){
    a*=90;
    b*=90;
    for(int i=a;i<a+90;i++)
      for(int j=b;j<b+90;j++)
        this.level[i][j]=1;
  }
  void add_enemies(){
    for(int i=0;i<enemies.length;i++)
      enemies[i]=new Enemies(level,ph1,wave,i,enemies.length);
    
  }
  void draw_enemies(){
    remove_enemies();
    for(int i=0;i<enemies.length;i++)      
        enemies[i].drawEnemy((int)currentx, p1);
  }
  void remove_enemies(){
    for(int i=0;i<enemies.length;i++){
      if(enemies[i].isAlive==false){
        if(enemies[i].index==enemies[i].total/3 && g1==null){
          g1=new Pickups((int)enemies[i].position.x,(int)enemies[i].position.y,'g');
        }
        if(enemies[i].index==enemies[i].total-1 && l1==null){
          l1=new Pickups((int)enemies[i].position.x,(int)enemies[i].position.y,'l');
        }
        System.out.println("Removing Enemy");
        Enemies[] temp=enemies;
        enemies=new Enemies[temp.length-1];
        for(int j=0;j<i;j++)
          enemies[j]=temp[j];
        for(int j=i;j<enemies.length;j++)
          enemies[j]=temp[j+1];
        i--;
      }
    }
  }
  void draw_level(){
    //System.out.println(level[0].length);
    //System.out.println("Testing"+level[level.length-1][1]);
    for(int i=0;i<level.length;i++){
      float size=currentx+width<level[i].length?(currentx+width):level[i].length;
      for(int j=(int)currentx;j<size;j++){
        if(level[i][j]==1){
          //System.out.println("Testing 2 : "+i+" - "+j);
          if(wave<=10)
            fill(44,82,15);
          else if(wave<=20)
            fill(117,50,33);
          else if(wave>20)
            fill(31,38,42);
          noStroke();
          if(i%90==0 || (i+1)%90==0 ||j%90==0 || (j+1)%90==0){
            if(wave<=10)
              stroke(4,23,15);
            else
              stroke(0);  
          }
          rect(j-currentx,i,1,1);
        }
      }
    }
    p1.draw_player(currentx,enemies,b1,b2);
    move_camera();
    draw_enemies();
    if(enemies.length==0 && b1==null)
      b1=new Boss(wave,level,ph1);
    draw_boss();
    draw_final_boss();
    if(g1!=null){
      check_powerup();
      g1.draw_pickup((int)currentx);
      }
    if(l1!=null){
      check_powerup();
      l1.draw_pickup((int)currentx);
      }
  }
  void check_powerup(){
    if(g1!=null && g1.check((int)p1.position.x,(int)p1.position.y))
      p1.new_gun();
    if(l1!=null && l1.check((int)p1.position.x,(int)p1.position.y)){
      Lightspeed.rewind();
      Lightspeed.play(500);
      ph1.lightspeed=height/24;
      p1.p1.lightspeed=height/24;
    }
  }
  void create_boss(){
    if(b2==null){
      boss_kill.rewind();
      boss_kill.play(500);
      
      p1.hp=90;
      p1.p1.lightspeed=height/24;
      p1.new_gun();
      
      b2=new FinalBoss(level, ph1);
    }
  }
  void draw_boss(){
    if(b1!=null && b1.isAlive){
      b1.draw_boss((int)currentx,p1);
    }
  }
  void draw_final_boss(){
    if(b2!=null && b2.isAlive){
      b2.draw_boss((int)currentx,p1);
    }
  }
  
  void move_camera(){
    if(p1.position.x-(width/2)+(75/2)>=0 && p1.position.x-(width/2)+(75/2) +width<=level[0].length)
      currentx=(p1.position.x-(width/2)+(75/2));
    if(p1.position.x-(width/2)+(75/2) +width>=level[0].length)
      bossflag=true;
    if(b1!=null && b1.isAlive && bossflag){
      currentx=level[0].length-width;
    }
  }
}
