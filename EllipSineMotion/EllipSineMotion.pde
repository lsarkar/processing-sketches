PFont font;

/* production vs development flag */
boolean production = true;

// use number of shapes as a proportion of width / number of shapes to achieve an integer. This will ensure a continuous sine wave
// i.e 800 / 160
int NUM_SHAPES = 90;
int NUM_SYSTEMS = 2;
int NUM_SINE_CYCLES = 2;

ArrayList<SineEllipseSystem> sineSystems = new ArrayList<SineEllipseSystem>();

void setup() {
  frameRate(25);
  smooth();
  size(400, 400);

  if (production) {
    noCursor();
  } else {
    font = createFont("Arial Bold", 48);
    textFont(font, 36);
  }
  
  // TODO remove hardcoded y amplitude set
  AmplitudeHelper helper = new AmplitudeHelper(NUM_SYSTEMS);

  for (int i = 0; i<NUM_SYSTEMS; i++) {
    boolean yFlip = false;
    
    if (i % 2 == 0) {
     yFlip = true; 
    }
    
    sineSystems.add(new SineEllipseSystem(helper.getYMax(), NUM_SHAPES, helper.getYZeroBySystemIndex(i), yFlip, NUM_SINE_CYCLES));
  }
}

class AmplitudeHelper {
  
 private int numSystems; 
  
 AmplitudeHelper(int numSystems) {
   this.numSystems = numSystems;
 }
 
 float getYMax() {
   return height/numSystems;
 }
 
 // the y zero point based off the number of systems
 float getYMaxHalf() {
   return getYMax() / 2;
 }
 
 /**
 Get the y zero point based off the sine ellipse system index
 Expects an index start of 0
 */
 float getYZeroBySystemIndex(int systemIndex) {
   final float y = getYMax() * (systemIndex + 1);
   return y - getYMaxHalf();
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
