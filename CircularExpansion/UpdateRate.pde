class UpdateRate {
  
  UpdateRate()  {

  }
  
  boolean isUpdateable(int frameInterval)
  {
      if (frameCount % frameInterval == 0)
        return true;
      else
        return false;
  }
  
  
}
