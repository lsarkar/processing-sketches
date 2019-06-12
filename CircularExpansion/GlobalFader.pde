class GlobalFader
{
  float fade = 5.5;
  float  maxValue = 0.0;
  
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
         maxValue = 4.5; 
      }
      
      
      return maxValue;
      
  }
  
}
