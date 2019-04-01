class UpdateRate {
  
  UpdateRate()  {
    println(frameRate);
  }
  
  boolean isUpdateable(int frameInterval)
  {
      if (frameCount % frameInterval == 0)
        return true;
      else
        return false;
  }
  
  
}
