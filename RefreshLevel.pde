
class RefreshLevel{
  boolean flag;
  int wave;
  
  RefreshLevel(){
    flag=true;
    wave=1;
    generate();
  }
  
  void generate(){
    
    while(wave<=30){
      
      Level_Generator g1=new Level_Generator(31-wave);
      g1.draw_level();
      saveLevel(g1.flevel,wave);
      
      //System.out.println("Wave: "+wave);
      wave++;
      
    }
    
  }
  void saveLevel(int level[][], int w){
    Table t1= new Table();
    t1.addColumn("0");
    t1.addColumn("1");
    t1.addColumn("2");
    t1.addColumn("3");
    t1.addColumn("4");
    t1.addColumn("5");
    t1.addColumn("6");
    t1.addColumn("7");
    t1.addColumn("8");
    t1.addColumn("9");
    for(int i=0;i<level[0].length;i++){
      TableRow n1=t1.addRow();
      for(int j=0;j<level.length;j++){
        n1.setInt(""+j, level[j][i]);
      }
    }
    saveTable(t1, "data/new"+w+".csv");
  }
}
