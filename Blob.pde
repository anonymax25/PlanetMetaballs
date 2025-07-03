int init_vel = 2;
float init_acc = 1.000;
int init_radius = 50;
int init_radius_range = 20;

class Blob {

  float radius;
  PVector pos;
  PVector vel;
  PVector acc;
  
  Blob(float x, float y){
    radius = random(init_radius, init_radius + init_radius_range);
    pos = new PVector(x,y);
    vel = new PVector(random(-init_vel, init_vel),random(-init_vel, init_vel));
    acc = new PVector(init_acc, init_acc);
  }

  void update() {
    this.pos.x += this.vel.x;
    this.pos.y += this.vel.y;

    this.vel.x *= this.acc.x;
    this.vel.y *= this.acc.y;

    if(pos.x > width/2 || pos.x < -width/2) 
      this.vel.x *= -1;
    if(pos.y > height/2 || pos.y < -height/2) 
      this.vel.y *= -1;
  }
}
