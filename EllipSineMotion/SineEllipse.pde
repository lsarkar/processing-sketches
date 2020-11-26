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

  private float dx = 1.0;

  /* THRESHOLD for which after effect is applied when above this number. RANGE: 0.0 -> 1.0 */
  private float AFTER_EFFECT_THRESHOLD = 0.001;

  private float YZERO = height/2;

  private int numItems;
  private int index;
  
  private boolean yFlip;

  SineEllipse(SineParams yParams, int numItems, int idx) {
    this(yParams, numItems, idx, false);
  }
  
  SineEllipse(SineParams yParams, int numItems, int idx, boolean yFlip) {
    this.yAmplitude = yParams.getAmplitude();
    this.YZERO = yParams.getYZero();
    this.numItems = numItems;
    this.index = idx;
    this.yFlip = yFlip;
    this.xPos = index * getXStepSize();
    this.theta = getAngleInRad();
    this.yPos = setYPos();
    
  }
  
  // TODO: consider delegating x and ystart positions outside of the class
  SineEllipse(int numItems, int idx) {
    this(new SineParams(50, width/2), numItems, idx);
  }

  private float setYPos() {
    return sin(theta) * yAmplitude;
  }

  private float getXStepSize() {
    return width / numItems;
  }

  private float getAngleInRad() {
    return radians((index / getXStepSize()) * 360.0); // NOTE: aiming to replace index without count
  }

  void draw() {
    yPos = setYPos();
    if (yFlip) {
     yPos *= -1; 
    }
    
    float colorMappedXPos = getColorMappingFromXPos();
    stroke(getActiveColor(colorMappedXPos));
    noFill();
    strokeWeight(1+abs(sin(theta)));
    ellipseMode(CENTER);
    int multiplier = 3; // originally 2
    this.shapeEnlargeFactor = abs((yPos*multiplier)/shapeScale);
    ellipse(xPos, YZERO + yPos, size + shapeEnlargeFactor, size + shapeEnlargeFactor);

    if (isAboveThreshold()) {
      afterTouch(getColorMappingFromXPos(), sin(theta));
    }

    addMotion();
  }

  PVector position() {
    return new PVector(xPos, YZERO + yPos);
  }
  
  float getColorMappingFromXPos() {
   return map(xPos, 0, width, 0, 255); 
  }

  float currentSize() {
    return (size + shapeEnlargeFactor);
  }

  private void addMotion() {
    // motion from right to left
    xPos-=dx;
    theta-=thetaIncrement;

    resetXPos();
  }

  boolean isAboveThreshold() {
    return abs(sin(theta)) >= AFTER_EFFECT_THRESHOLD ? true : false;
  }

  private void resetXPos() {
    if (xPos <= 0) {
      xPos = width;
      theta = 0.0;
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
    float enlargeFactor = abs(yPos/shapeScale);
    int sizeOffsetAgainstMainEllipse = -5; // negative padding so that the aftertouch is smaller than the sineellipse draw

    return size + enlargeFactor + sizeOffsetAgainstMainEllipse;
  }
}
