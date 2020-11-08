
/* production vs development flag */
boolean production = false;

ArrayList<SineEllipse> ellipseList = new ArrayList<SineEllipse>();

/* the number of the sine ellipse objects to create */
int NUM_SHAPES = 50;

void setup() {
  smooth();
  size(800, 600);

  if (production) {
    noCursor();
  }
  
  for (int i = 0; i<=NUM_SHAPES; i++) {
    // set the Y range of the SineEllipse is set to just slightly less than the height of the sketch
    ellipseList.add(new SineEllipse(height/2.25));
  }
}

void draw() {
  background(23, 25, 28, 200);

  for (final SineEllipse sineEllipse : ellipseList) {
    sineEllipse.draw();
  }
}
