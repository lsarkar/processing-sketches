
/* production vs development flag */
boolean production = false;

ArrayList<SineEllipse> ellipseList = new ArrayList<SineEllipse>();

/* the number of the sine ellipse objects to create */
int NUM_SHAPES = 80;

void setup() {
  smooth();
  size(800, 600);

  if (production) {
    noCursor();
  }

  for (int idx = 0; idx<=NUM_SHAPES; idx++) {
    // set the Y range of the SineEllipse is set to just slightly less than the height of the sketch
    final SineEllipse si = new SineEllipse(height/2.25, NUM_SHAPES, idx);
    si.setYIntersect(height/2);
    ellipseList.add(si);
  }
}

void draw() {
  background(23, 25, 28, 200);
  
  // iterate and draw all SineEllipses
  for (int i = 0; i<ellipseList.size(); i++) {
    final SineEllipse si = ellipseList.get(i);
    si.draw();
  }

}
