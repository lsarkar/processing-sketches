class BaseModulator
{
  float modMin;
  float modMax;
  float modIncrRate;

  BaseModulator()
  {
    this.modIncrRate = 1;
  }

  float getModMin()
  {
    return modMin;
  }

  float getModMax()
  {
    return modMax;
  }

  void setModMin(float modMin)
  {
    this.modMin = modMin;
  }

  void setModMax(float modMax)
  {
    this.modMax = modMax;
  }
}

class Modulator extends BaseModulator
{

  boolean modAddition;
  float modCounter;

  Modulator()
  {
    this.modAddition = true;

    this.modMax = 1.0;
    this.modMin = -1.0;
    this.modCounter = 0;
    this.modIncrRate = 0.3;
  }

  void calculateFr()
  {
    // frames per second
    int fRate = FRAME_RATE;
    
    
    
  }

  void run()
  {
    if (modCounter >= modMax)
    {
      modAddition = false;
    }

    if (modCounter <= modMin)
    {
      modAddition = true;
    }

    if (modAddition)
    {
      modCounter+=modIncrRate;
    } else if (!modAddition)
    {
      modCounter-=modIncrRate;
    }
  }

  float getSize()
  {
    println(this.modCounter);
    return this.modCounter;
  }
}
