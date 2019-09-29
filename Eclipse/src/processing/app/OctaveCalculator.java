package processing.app;

import ddf.minim.analysis.FFT;

class OctaveCalculator
{
  int NUM_BANDS_IN_OCTAVE = 3;
  int firstBand;
  int secondBand;
  int thirdBand;
  float averageWidth;
  float centerFrequency;
  float lowFreq;
  float highFreq;
  float freqWidth;
  int index;

  FFT fftLog;

  public OctaveCalculator(FFT fftLog, int idx)
  {
    // idx - index of the band (set of 3). Refer to BAND LOOKUP TABLE for frequency info
    this.fftLog = fftLog;
    this.index = idx;
    this.initialize();
  }

  private void initialize()
  {
    this.firstBand = (NUM_BANDS_IN_OCTAVE * this.index);
    this.secondBand = 1 + (NUM_BANDS_IN_OCTAVE * this.index);
    this.thirdBand = 2 + (NUM_BANDS_IN_OCTAVE * this.index);
  }

  public float getLowestFreq()
  {
    final SingleBand b = new SingleBand(this.fftLog, this.firstBand);
    return b.getLowFreq();
  }

  public float getHighestFreq()
  {
    final SingleBand b = new SingleBand(this.fftLog, this.thirdBand);
    return b.getHighFreq();
  }

  public float getFreqWidth()
  {
    return this.getHighestFreq() - this.getLowestFreq();
  }

  public int getTotalBands()
  {
    return NUM_BANDS_IN_OCTAVE;
  }

  public int getFirstBandNum()
  {
    return this.firstBand;
  }

  public int getSecondBandNum()
  {
    return this.secondBand;
  }

  public int getThirdBandNum()
  {
    return this.thirdBand;
  }

  @Override
    public String toString()
  {
    return "Index" + this.index + "\tLow:" + this.getLowestFreq() + "\tHigh:" + this.getHighestFreq() + "\tWidth:" + this.getFreqWidth();
  }
}
