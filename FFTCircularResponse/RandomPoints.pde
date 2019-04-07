


class RandomPoints implements IDrawable {

  RandomPoints()
  {
  }

  void  draw(float addWeight)
  {
    for (int i=0; i<=200+(addWeight*50); i++)
    {
      strokeWeight(1 + int((addWeight/5)+0.5));
      noFill();
      stroke(255, 127);
      point(random(0, width), random(0, height), 0);
    }
  }
  
  void draw()
  {
    for (int i=0; i<=200+(1*50); i++)
    {
      strokeWeight(1 + int((1/5)+0.5));
      noFill();
      stroke(255, 127);
      point(random(0, width), random(0, height), 0);
    }
  }
  
}
