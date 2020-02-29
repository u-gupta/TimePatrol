class Level_Generator{
  int wave;
  int[][] level;
  int[][] flevel;
  Level_Generator(int wave){
    
    this.wave=wave;
    level=new int[10][150+((int)(Math.pow((31-wave),2)))];
    flevel=new int[10][150+((int)(Math.pow((31-wave),2)))];
  }
  
  double probabilities(int altitude){
    
    double pass=100/(wave*(altitude+1));
    
    switch(altitude){
      case 0:{
        pass=pass>=66.67?pass:66.67;
        pass=pass<=95?pass:95;
      }break;
      case 1:
        pass=pass<=50?pass:50;      
      break;
      case 2:
        pass=pass<=40?pass:40;      
      break;
      case 3:
        pass=pass<=30?pass:30; 
      break;
      case 4:{
        pass=pass<=10?pass:10;    
      }break;
      case 9:
        pass=pass>=95?pass:95;    
      break;
      default:
        pass=0;    
      
    }
    return pass;
  }
  
  void levelIterator(){
    
    double[] probability_list=new double[level.length];
    
    for(int i=0;i<level.length;i++){
      probability_list[i]=probabilities(i);
      probability_list[i]*=100;
    }
    int[][] list=new int[level.length][10000];
    
    for(int i=0;i<probability_list.length;i++){
      for(int j=0;j<(int)probability_list[i];j++){
        list[i][j]=0;
      }
      //System.out.println("Test: "+probability_list[i]+ " : "+list[i].length);
      for(int j=(int)probability_list[i];j<list[i].length;j++){
        list[i][j]=1;
      }
      
    }
    
    for(int i=0;i<level.length;i++){
      for(int j=0;j<level[i].length;j++){
        int rand=(int)random(0,list[i].length);
        level[i][j]=list[i][rand];
        flevel[i][j]=0;
      }
    }
  }
  
  void draw_level(){
    levelIterator();
    
    for(int i=0;i<level.length;i++){
      for(int j=0;j<level[i].length;j++){
        if(level[i][j]==1){
          if(i-1>=0 && level[i-1][j]==1){
            level[i][j]=1;
            continue;
          }
          flevel[i][j]=1;
          //text(i+"-"+j , (j*height/10), (height-((i+1)*height/10)));
        }
        else{
          //System.out.println("Checking: "+level[i][j]);
        }
      }
    }
  }
  
}
