package processing.app;

import ddf.minim.analysis.FFT;

class SingleBand
{
  /*
   Helper class to get band frequency information
   */

  float averageWidth;
  float centerFrequency;
  float lowFreq;
  float highFreq;
  float freqWidth;
  FFT fftLog;

  public SingleBand(FFT fftLog, int band)
  {
    this.fftLog = fftLog;
    this.averageWidth = this.fftLog.getAverageBandWidth(band);
    this.centerFrequency = this.fftLog.getAverageCenterFrequency(band);
    this.lowFreq  = centerFrequency - averageWidth/2;
    this.highFreq = centerFrequency + averageWidth/2;
    this.freqWidth = highFreq - lowFreq;
  }

  public float getLowFreq()
  {
    return this.lowFreq;
  }

  public float getHighFreq()
  {
    return this.highFreq;
  }

  public float getCenterFreq()
  {
    return this.centerFrequency;
  }

  public float getFreqWidth()
  {
    return this.freqWidth;
  }
  
}
