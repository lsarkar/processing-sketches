interface IFadeStrategy {
   
    float fade(float value);
  
}

class NormalFadeStrategy implements IFadeStrategy {
 
    float fade(float value)
    {
        return value;
    }
  
}

class SlowFadeStrategy implements IFadeStrategy {
    
    float fade(float value)
    {
        return 10.0;
    }
    
  
}
