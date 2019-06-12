


class ExpandingCircle implements IDrawable {
  
  IColorStrategy colorStrategy;
  float size = 200;
  float i;
  float startPos = 90;
  float circleSize = 180;
  float initialStartPos = 0;
  color col = color(255,0,0);
  
  IRotatingStrategy rotation;
  
  ExpandingCircle(float size)
  {
      this.size = size;
      this.colorStrategy = new LightColorStrategy();
      this.rotation = new LinearRotationStrategy();
  }
  
  ExpandingCircle(float size, float initialStartPos)
  {
      this(size);
      this.initialStartPos = initialStartPos;
  }
  
  void setRotationStrategy(IRotatingStrategy rotation)
  {
      this.rotation = rotation;
  }
  
  void updateCircleSize(float size)
  {
     this.circleSize = size; 
  }
  
  void setColor(color col) {
    this.col = col;
  }
  
  void draw()
  {
    
    startPos = this.rotation.getRotation(this.initialStartPos);
    dualArc(width/2,height/2, size, size, startPos, circleSize, col);

  }
  
  void dualArc(float x, float y, float width , float height, float start, float circleSize, color col)
{
     
     float splitSize = circleSize /2;
         
     float arc1End = radians(start + splitSize);
     float arc1Start = radians(start);
     
     float arc2Start = radians(start - splitSize);
     float arc2End = arc1Start;
 
     noFill();
     strokeWeight(10);
     strokeCap(SQUARE);
     ellipseMode(CENTER);
     
     // Form: arc(x, y, width, height, start, stop)
     stroke(col);
     arc(x, y, width, height, arc1Start, arc1End);
     arc(x, y, width, height, arc2Start, arc2End);
    
}
}
