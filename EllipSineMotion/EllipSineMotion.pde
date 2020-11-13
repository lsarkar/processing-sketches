
/* production vs development flag */
boolean production = false;

/* the number of the sine ellipse objects to create */
int NUM_SHAPES = 80;

SineEllipseSystem s;
SineEllipseSystem t;

void setup() {
  smooth();
  size(800, 600);

  if (production) {
    noCursor();
  }
  
  s = new SineEllipseSystem(NUM_SHAPES, height/4);
  t = new SineEllipseSystem(NUM_SHAPES/2, (height/4)*3);
}

void draw() {
  background(23, 25, 28, 200);
      
  s.draw();
  t.draw();
}

class SineEllipseSystem {
  
  ArrayList<SineEllipse> sineEllipses;
  float yStart;
  int numItems;
  
  SineEllipseSystem(int numItems, float yStart) {
    this.numItems = numItems;
    this.yStart = yStart;
    
   sineEllipses = new ArrayList<SineEllipse>(); 
   
   for (int i = 0; i < this.numItems; i++) {
     final SineEllipse si = new SineEllipse(height/4.8, this.numItems, i);
      si.setYIntersect(yStart);
      sineEllipses.add(si);
   }
   
  }
  
  void draw() {
    // iterate and draw all SineEllipses
    for (int i = 0; i<sineEllipses.size(); i++) {
    final SineEllipse si = sineEllipses.get(i);
    si.draw();
  }
  }
  
}
