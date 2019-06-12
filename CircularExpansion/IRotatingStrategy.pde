interface IRotatingStrategy {

  float getRotation(float initial);
}

class NoRotation implements IRotatingStrategy {
  
   float getRotation(float initial) {
      return initial; 
   }
}


class BeatCalculator {
  
  // FPM = Frames Per Beat
  // BPM = Beats Per Minute
  // FPS = Frames Per Seconds
   int fps;
   int bpm;
   int fpb;
  
   BeatCalculator(int fps, int bpm)
   {
     this.fps = fps;
     this.bpm = bpm;
     
     this.fpb = getFPB();
   }
   
   int getFPB()
   {
      return this.fps / (this.bpm / 60);
   }
   
   int getBPM()
   {
     return this.bpm;
   }
  
}

class LinearRotationStrategy implements IRotatingStrategy {
  
  float start = 0;
  float MAX_LIMIT = 360;
  float increment = 10;
  boolean isClockwise;
  int direction = 1;
  
  LinearRotationStrategy()
  {
    // defaults
    setIsClockwise(false);
  }
  
  void setRotationsPerMinute(int BPM)
  {
     // set rotation based on BPM
     // reference: https://www.deviantart.com/inferno988/art/FPS-to-FPB-to-BPM-Calculator-424778748
    
     // framerate of 30 = 30 frames per second
     
  }
  
  void setSpeed(float increment)
  {
     this.increment = increment; 
  }
  
  void setIsClockwise(boolean isClockwise)
  {
      if (isClockwise)
        direction = 1;
      else
        direction = -1;
  }  
  
  float getRotation(float initialPosition)
  {
    float summedPos = start + initialPosition;
    
    if (summedPos == MAX_LIMIT*direction)
    {
       start = 0; 
    }
    
    start+=increment*direction;
    return summedPos;
  }
  
}
