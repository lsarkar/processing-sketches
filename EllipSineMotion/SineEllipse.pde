/**
 SineEllipse - Draws an ellipse that travels upon a sine wave path motioning from right to left
 */

class SineEllipse {

  private float thetaIncrement = 0.02;

  /* x and y positions of shape */
  private float xPos;
  private float yPos;

  /* angle in radians for sine wave positioning */
  private float theta;

  /* baseline shape size */
  private int size = 5;

  /* y axis amplitude */
  private float yAmplitude;
  private int shapeScale = 8;

  private float shapeEnlargeFactor = 0;

  /* wave repeat period */
  private int period = 32;

  private int xSpacing = 4;

  private float dx;

  /* THRESHOLD for which after effect is applied when above this number. RANGE: 0.0 -> 1.0 */
  private float AFTER_EFFECT_THRESHOLD = 0.001;

  private float YZERO = height/2;

  private int numItems;
  private int index;

  SineEllipse(final float yAmplitude, int numItems, int idx) {
    this.yAmplitude = yAmplitude;
    this.numItems = numItems;
    this.index = idx;

    this.xPos = index * getXStepSize();
    this.yPos = sin(xPos) * yAmplitude;
    this.theta = xPos; // start the angle at 0
    this.dx = (TWO_PI / period) * xSpacing;
  }

  SineEllipse(int numItems, int idx) {
    this(50, numItems, idx);
  }

  private void setYIntersect(float yIntersect) {
    YZERO = yIntersect;
  }

  private float getXStepSize() {
    return width / this.numItems;
  }

  void draw() {
    yPos = sin(theta) * yAmplitude;
    float colorMappedXPos = map(xPos, 0, width, 0, 255);
    stroke(getActiveColor(colorMappedXPos));
    noFill();
    strokeWeight(1);
    ellipseMode(CENTER);
    this.shapeEnlargeFactor = abs(yPos/shapeScale);
    ellipse(xPos, YZERO + yPos, size + shapeEnlargeFactor, size + shapeEnlargeFactor);

    if (isAboveThreshold()) {
      afterTouch(colorMappedXPos, sin(theta));
    }

    addMotion();
  }

  PVector position() {
    return new PVector(xPos, YZERO + yPos);
  }

  float currentSize() {
    return (size + shapeEnlargeFactor);
  }

  private void addMotion() {
    xPos-=dx;
    theta+=thetaIncrement;

    resetXPos();
  }

  boolean isAboveThreshold() {
    return abs(sin(theta)) >= AFTER_EFFECT_THRESHOLD ? true : false;
  }

  private void resetXPos() {
    if (xPos <=0) {
      xPos = width;
    }
  }

  private color getActiveColor(float mappedVal) {
    return color(255-mappedVal, (255-mappedVal)/2, mappedVal);
  }

  /*
   Create an aftertouch effect using a new shape
   @param colorMappedVal - value mapped between 0 and 255
   @param sineVal - value between 0 and 1
   */
  private void afterTouch(float colorMappedVal, float sineVal) {
    final float alphaFactor = abs(sineVal) * 100;
    final int baseAlpha = 80;

    fill(getActiveColor(colorMappedVal), baseAlpha + alphaFactor);
    noStroke();
    ellipseMode(CENTER);
    final float size = getAfterTouchShapeSize();
    ellipse(xPos, YZERO + yPos, size, size);
  }

  private float getAfterTouchShapeSize() {
    float shapeEnlargeFactor = abs(yPos/shapeScale);
    int padding = -10; // negative padding so that the aftertouch is smaller than the sineellipse draw

    return size + shapeEnlargeFactor + padding;
  }
}
