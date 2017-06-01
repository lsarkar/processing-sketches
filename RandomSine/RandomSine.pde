public class RandomSine {

  float a = 0.0;
  float inc = TWO_PI/random(10, 40.0);
  float yCenter, xStart;

  public RandomSine(float xStart, float yCenter)
  {  
    this.xStart = xStart;
    this.yCenter = yCenter;
  }

  public void draw()
  {

    for (int xStart = 0; xStart < width; xStart+=4)
    {
      strokeWeight(1);
      stroke(255, 100); 
      fill(random(255), random(190), random(220), random(200));

      float sizeRand = random(1, 20);
      float yRand = random(100, 300);
      // draw a rectangle that follows a random sine wave pattern
      rect(xStart, yCenter + sin(a) * yRand, sizeRand, sizeRand);

      a+=inc;
    }
  }
}