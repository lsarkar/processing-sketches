/**
SineEllipse - Draws an ellipse that travels upon a sine wave path motioning from right to left
*/

class SineEllipse {
  
  /* speed at which the shape moves through the sketch in x direction */
  private float xSpeed = 2;
  
  private float angleSpeed = 0.05;
  
  /* x and y positions of shape */
  private float xPos;
  private float yPos;
  
  /* angle in radians for sine wave positioning */
  private float angle;
  
  /* baseline shape size */
  private int size = 2;
  private float ySize;
  private int shapeScale = 8;
  
  /* THRESHOLD for which after effect is applied when above this number. RANGE: 0.0 -> 1.0 */
  private float AFTER_EFFECT_THRESHOLD = 0.20;
  
  private float YZERO = height/2;

  SineEllipse(final float ySize) {
    this.ySize = ySize;
    this.xPos = random(1, width);
    this.yPos = YZERO;
    this.angle = TWO_PI / random(1, TWO_PI);
  }

  SineEllipse() {
    this(50);
  }

  void draw() {
    yPos = sin(angle) * ySize;
    float mappedXPos = map(xPos, 0, width, 0, 255);
    stroke(getActiveColor(mappedXPos));
    noFill();
    strokeWeight(4);
    ellipseMode(CENTER);
    float shapeEnlargeFactor = abs(yPos/shapeScale);
    ellipse(xPos, YZERO + yPos, size + shapeEnlargeFactor, size + shapeEnlargeFactor);
        
    if (isAboveThreshold()) {
      afterTouch(mappedXPos, abs(sin(angle)));
    }
    
    addMotion();
  }
  
  private void addMotion() {
    xPos-=xSpeed;
    angle+=angleSpeed;
    
    resetXPos();
  }
  
  private boolean isAboveThreshold() {
   return abs(sin(angle)) >= AFTER_EFFECT_THRESHOLD ? true : false;
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
  */
  private void afterTouch(float mappedVal, float sineVal) {
    float alphaFactor = sineVal * 100;
    float shapeEnlargeFactor = abs(yPos/shapeScale);
    int padding = 5;
    
    fill(getActiveColor(mappedVal), 40 + alphaFactor);
    strokeWeight(1);
    stroke(getActiveColor(mappedVal), 60 + alphaFactor);
    ellipseMode(CENTER);
    ellipse(xPos, YZERO + yPos, size + shapeEnlargeFactor + padding, size + shapeEnlargeFactor + padding);
  }
}
