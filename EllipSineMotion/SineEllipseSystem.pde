
class SineEllipseSystem {

  ArrayList<SineEllipse> sineEllipses;
  float yStart;
  int numItems;
  float yAmpli;
  boolean yInvert;

  SineEllipseSystem(float yAmplitude, int numItems, float yStart, boolean yInvert) {
    this.yAmpli = yAmplitude;
    this.numItems = numItems;
    this.yStart = yStart;
    this.yInvert = yInvert;

    this.sineEllipses = new ArrayList<SineEllipse>(); 

    init();
  }

  private void init() {
    for (int i = 0; i < this.numItems; i++) {
      
      // TODO: remove hard coded height divider and calculate yAmplitude for a sine ellipse system dynamically
      float yAmplitude = height/4.8; 
      SineParams s = new SineParams(yAmplitude, yStart);

      final SineEllipse si = new SineEllipse(s, this.numItems, i, yInvert);
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
