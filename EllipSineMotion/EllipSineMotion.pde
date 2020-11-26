PFont font;

/* production vs development flag */
boolean production = false;

// use number of shapes as a proportion of width / number of shapes to achieve an integer. This will ensure a continuous sine wave
// i.e 800 / 160
int NUM_SHAPES = 160;
int NUM_SYSTEMS = 2;

ArrayList<SineEllipseSystem> sineSystems = new ArrayList<SineEllipseSystem>();

void setup() {
  frameRate(60);
  smooth();
  size(800, 600);

  if (production) {
    noCursor();
  } else {
    font = createFont("Arial Bold", 48);
    textFont(font, 36);
  }

  float yAmplitude = height/NUM_SYSTEMS;

  for (int i = 0; i<NUM_SYSTEMS; i++) {
    float y = (i+1) * yAmplitude;
    float baseHeight = yAmplitude/2; // the y mid point based on the number of systems
    
    boolean yFlip = false;
    
    if (i % 2 == 0) {
     yFlip = true; 
    }
    
    sineSystems.add(new SineEllipseSystem(yAmplitude, NUM_SHAPES, y-baseHeight, yFlip));
  }

}

void draw() {
  background(23, 25, 28, 200);
  
  for (int i = 0; i<sineSystems.size(); i++) {
    sineSystems.get(i).draw();
  }
  
  if (!production) {
    fill(255);
    text(frameRate, 20, 20);
  }
}
