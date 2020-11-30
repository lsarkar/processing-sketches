
// REF: http://www.java2s.com/Tutorials/Java/Graphics/Shape/Draw_Sine_curve_in_Java.htm
// referenced to set number of sine wave cycles

class SineEllipseSystem {

  ArrayList<SineEllipse> sineEllipses;
  float yStart;
  int numItems;
  float yAmpli;
  boolean yInvert;
  int numSineCycles;
  
  float DX = 3.0;
  
  // TODO: remove hard coded height divider and calculate yAmplitude for a sine ellipse system dynamically
  float YAMPLITUDE = height/4.8; 

  SineEllipseSystem(float yAmplitude, int numItems, float yZero, boolean yInvert, int numSineCycles) {
    this.yAmpli = yAmplitude;
    this.numItems = numItems;
    this.yStart = yZero;
    this.yInvert = yInvert;
    this.numSineCycles = numSineCycles;

    this.sineEllipses = new ArrayList<SineEllipse>(); 

    init();
  }

  private void init() {
    
    for (int i = 0; i < this.numItems; i++) {
      
      // calculate an xstart position based on the number of sine ellipses
      //Coords c = new Coords(i * getXStepSize(), getAngleInRad(i)); // ORIGINAL, stretches the whole screen
      float incPos = i*DX;
      float x = width-incPos;

      Coords c = new Coords(x, getTheta(i)); 
      SineParams s = new SineParams(YAMPLITUDE, yStart);

      final SineEllipse si = new SineEllipse(s, c, yInvert, getThetaScaleFactor(), DX);
      sineEllipses.add(si);
    }
  }
  
  private float getScaleFactor() {
   return numItems / (numSineCycles * 2);
  }
  
  private float getTheta(int i) {
   return 0 - (PI / getScaleFactor() * i);
  }
  
  private float getThetaScaleFactor() {
   return (PI / getScaleFactor()); 
  }

  void draw() {
    // iterate and draw all SineEllipses
    for (int i = 0; i<sineEllipses.size(); i++) {
      final SineEllipse si = sineEllipses.get(i);
      si.draw();
    }
  }
}
