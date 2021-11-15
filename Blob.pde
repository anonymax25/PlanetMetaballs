class Blob {

  float radius;
  PVector pos;
  PVector vel;
  
  Blob(float x, float y){
    radius = random(15,35);
    pos = new PVector(x,y);
    vel = new PVector(random(-5,5),random(-5,5));
  }

  void update() {
    this.pos.x += this.vel.x;
    this.pos.y += this.vel.y;

    if(pos.x > width/2 || pos.x < -width/2) 
      this.vel.x *= -1;
    if(pos.y > height/2 || pos.y < -height/2) 
      this.vel.y *= -1;
  }
}
