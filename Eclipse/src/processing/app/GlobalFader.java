package processing.app;
class GlobalFader
{
  float fade = 5.5f;
  float  maxValue = 0.0f;
  
  GlobalFader()
  {
    
  }
  
  float updater(float liveValue)
  {
     
      if (liveValue >= maxValue)
      {
          maxValue = liveValue;
      }
      
      maxValue-=fade;
      
      if (maxValue <= 4.5)
      {
         maxValue = 4.5f; 
      }
      
      
      return maxValue;
      
  }
  
}
