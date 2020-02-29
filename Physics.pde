class Physics{
  float gravityMul;
  float dragMul;
  float lightSpeedMul;
  float frictionMul;
  float drag, friction, lightspeed;
  PVector gravity;
  float mass;
  float randomness;
  Physics(float randomness){
    this.randomness=randomness;
    set_multipliers();
    
    
    
    //gravityMul=1-gravityMul;
    //dragMul=1-dragMul;
    //lightSpeedMul=1-lightSpeedMul;
    //frictionMul=1-frictionMul;
  }
  
  Physics(Physics p1){
    this.randomness=p1.randomness;
    set_multipliers();
  }
  Physics(){
    gravityMul=1;
    dragMul=1;
    lightSpeedMul=1;
    frictionMul=1;
    set_constants();
  }
  void set_multipliers(){
    gravityMul=random(randomness,1);
    dragMul=random(randomness,1);
    lightSpeedMul=random(randomness,1);
    frictionMul=random(randomness,1);
    mass=1;
    set_constants();    
  }
  
  void set_constants(){
    gravity=new PVector(0,height/25);
    gravity.mult(mass);
    drag=0.9;
    lightspeed=height/24;
    friction=0.9;
    
    gravity.mult(gravityMul);
    if(gravity.y<height/150 && mass==1)
      gravity.y=height/150;
    drag*=dragMul;
    if(drag<0.2)
      drag=0.2;
    lightspeed*=lightSpeedMul;
    //friction+=(1-frictionMul);
    if(mass==0){
      drag=1;
      gravity.mult(0);
    }
  }
  
  void add_mass(float mass){
    this.mass=mass;
    set_constants();
  }
  
}
