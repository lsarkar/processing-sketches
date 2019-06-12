abstract class AbstractCircularPoints extends Shape
{
    float radius;
  
    AbstractCircularPoints(float radius)
    {
       super();
       this.radius = radius;
    }
    
    void setRadius(float radius)
    {
      this.radius = radius;
    }
    
    float getRadius()
    {
      return this.radius;
    }
  
}
