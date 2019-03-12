class RandomPoints {

  RandomPoints()
  {
  }

  void  drawRandomPoints(float addWeight)
  {
    for (int i=0; i<=200+(addWeight*50); i++)
    {
      strokeWeight(1 + int((addWeight/5)+0.5));
      noFill();
      stroke(255, 127);
      point(random(0, width), random(0, height), 0);
    }
  }
}
