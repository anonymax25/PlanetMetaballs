float scale = 0.0001;
int resolustion = 3;
boolean debug = false;
Blob[] blobs = new Blob[4];

void setup() {
  size(640, 360);
  noStroke();
  for (int i=0; i < 4; i++) {         
    blobs[i] = new Blob(width/4*i-width/2, 0);
  }
}

void draw() {
  background(100);
  translate(width/2, height/2);
  blobs[0].coord.x = mouseX-width/2;
  blobs[0].coord.y = mouseY-height/2;
  marchingSquares(resolustion);
  
  
  
}

void mousePressed() {
  blobs[0].coord.x = mouseX;
  blobs[0].coord.y = mouseY;
}

//heart
/*
float f(float x, float y, float scale) {
 return scale*pow(x,2) + scale*pow(y-sqrt(abs(100*x)), 2); 
}
*/

float f(float x1, float y1, float scale) {
  float res = 0;
  for (int k=0; k < 4; k++) {   
    res += 20 / sqrt(pow(x1 - blobs[k].coord.x,2) + pow(y1 - blobs[k].coord.y,2));
  }
  return 1/res;
}

/*
//circle
float f(float x, float y, float scale) {
 return scale*pow(x,2) + scale*pow(y, 2); 
}
*/

void marchingSquares(int res) {
  noFill();
  stroke(0);
  
  for(int i=-width/2; i<=width/2; i+= res) {
    for(int j=-height/2; j<=height/2; j+= res) {
      
      
      boolean tl = f(i,j,scale) <= 1;
      boolean tr = f(i+res,j,scale) <= 1;
      boolean bl = f(i,j+res,scale) <= 1;
      boolean br = f(i+res,j+res,scale) <= 1;
      
      if(f(i,j,scale) <= 1){
          stroke(0,255,0);
      } else {
          stroke(255,0,0);
      }
      if(debug) ellipse(i,j,1,1);
      stroke(0);
       
      PVector first = new PVector();
      PVector second = new PVector();
      
      //top left in or others in
      if((tl && !tr && !br && !bl) || (!tl && tr && br && bl)){
        first = lerp(i,j,i+res,j);
        second = lerp(i,j,i,j+res);
        line(first.x, first.y, second.x, second.y);
      }
      
      //top right in or others in
      if((!tl && tr && !br && !bl) || (tl && !tr && br && bl)){  
        first = lerp(i,j,i+res,j);
        second = lerp(i+res,j,i+res,j+res);
        line(first.x, first.y, second.x, second.y);
      }
      
      //bottom right in or others in 
      if((!tl && !tr && br && !bl) || (tl && tr && !br && bl)){  
        first = lerp(i+res,j,i+res,j+res);
        second = lerp(i,j+res,i+res,j+res);
        line(first.x, first.y, second.x, second.y);
      }
      
      //bottom left in or others in
      if((!tl && !tr && !br && bl) || (tl && tr && br && !bl)){
        first = lerp(i,j,i,j+res);
        second = lerp(i,j+res,i+res,j+res);
        line(first.x, first.y, second.x, second.y);
      }
      
      //side left in or side right in
      if((tl && !tr && !br && bl) || (!tl && tr && br && !bl)){
        first = lerp(i,j,i+res,j);
        second = lerp(i,j+res,i+res,j+res);
        line(first.x, first.y, second.x, second.y);
      }
      
      //side top in or side bottom in
      if((tl && tr && !br && !bl) || (!tl && !tr && br && bl)){  
        first = lerp(i,j,i,j+res);
        second = lerp(i+res,j,i+res,j+res);
        line(first.x, first.y, second.x, second.y);
      }
      
      // two lines intersect
      if((tl && !tr && br && !bl) || (!tl && tr && !br && bl)){
        if(f(i+res/2,j+res/2,scale) < 1){
          first = lerp(i,j,i+res,j);
          second = lerp(i,j,i,j+res);
          line(first.x, first.y, second.x, second.y);
          
          first = lerp(i+res,j,i+res,j+res);
          second = lerp(i,j+res,i+res,j+res);
          line(first.x, first.y, second.x, second.y);        
        }else{
          first = lerp(i,j,i+res,j);
          second = lerp(i+res,j,i+res,j+res);
          line(first.x, first.y, second.x, second.y);
          
          first = lerp(i,j,i,j+res);
          second = lerp(i,j+res,i+res,j+res);
          line(first.x, first.y, second.x, second.y);
        }
      }         
    }
  }
}

PVector lerp(float x1, float y1, float x2, float y2){

  
  float v1 = f(x1, y1, scale);
  float v2 = f(x2, y2, scale);
    
  float x = x1 != x2 ? x1 + ((1-v1)/(v2-v1)*(x2-x1)) : x1;
  float y = x1 == x2 ? y1 + ((1-v1)/(v2-v1)*(y2-y1)) : y1;
  return new PVector(x,y);
  /*
  if(rounds <= 1){
    return new PVector((x1+x2)/2,(y1+y2)/2);
  }else{
    float val = f((x1+x2)/2,(y1+y2)/2, scale);
    
    float v1 = f(x1, y1, scale);
    float v2 = f(x2, y2, scale);
    
    float estimate = x1 + ((1-v1)/(v2-v1)*(x2
    
    if(val <= 1){
      stroke(255,0,0);
      ellipse((x1+x2)/2, (y1+y2)/2, 2, 2);
      stroke(0);
      return lerp(x1, y1, (x1+x2)/2, (y1+y2)/2, rounds-1);
    }else{
      stroke(0,255,0);
      ellipse((x1+x2)/2, (y1+y2)/2, 2, 2);
      stroke(0);
      return lerp((x1+x2)/2, (y1+y2)/2, x2,y2, rounds-1);
    }
    
  }
  */
}
