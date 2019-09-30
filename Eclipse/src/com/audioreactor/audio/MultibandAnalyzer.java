package com.audioreactor.audio;
/*
BAND LOOKUP TABLE
 
 0
 Index 0 Center Freq 7.1777344 Low: 0.0 High: 14.355469 Width: 14.355469
 Index 1 Center Freq 21.533203 Low: 14.355469 High: 28.710938 Width: 14.355469
 Index 2 Center Freq 35.88867 Low: 28.710938 High: 43.066406 Width: 14.355469
 
 1
 Index 3 Center Freq 50.24414 Low: 43.066406 High: 57.421875 Width: 14.355469
 Index 4 Center Freq 64.59961 Low: 57.421875 High: 71.77734 Width: 14.355469
 Index 5 Center Freq 78.95508 Low: 71.77734 High: 86.13281 Width: 14.355469
 
 2
 Index 6 Center Freq 100.48828 Low: 86.13281 High: 114.84375 Width: 28.710938
 Index 7 Center Freq 129.19922 Low: 114.84375 High: 143.55469 Width: 28.710938
 Index 8 Center Freq 157.91016 Low: 143.55469 High: 172.26562 Width: 28.710938
 
 3
 Index 9 Center Freq 200.97656 Low: 172.26562 High: 229.6875 Width: 57.421875
 Index 10 Center Freq 258.39844 Low: 229.6875 High: 287.10938 Width: 57.421875
 Index 11 Center Freq 315.8203 Low: 287.10938 High: 344.53125 Width: 57.421875
 
 4
 Index 12 Center Freq 401.95312 Low: 344.53125 High: 459.375 Width: 114.84375
 Index 13 Center Freq 516.7969 Low: 459.375 High: 574.21875 Width: 114.84375
 Index 14 Center Freq 631.6406 Low: 574.21875 High: 689.0625 Width: 114.84375
 
 5
 Index 15 Center Freq 803.90625 Low: 689.0625 High: 918.75 Width: 229.6875
 Index 16 Center Freq 1033.5938 Low: 918.75 High: 1148.4375 Width: 229.6875
 Index 17 Center Freq 1263.2812 Low: 1148.4375 High: 1378.125 Width: 229.6875
 
 6
 Index 18 Center Freq 1607.8125 Low: 1378.125 High: 1837.5 Width: 459.375
 Index 19 Center Freq 2067.1875 Low: 1837.5 High: 2296.875 Width: 459.375
 Index 20 Center Freq 2526.5625 Low: 2296.875 High: 2756.25 Width: 459.375
 
 7
 Index 21 Center Freq 3215.625 Low: 2756.25 High: 3675.0 Width: 918.75
 Index 22 Center Freq 4134.375 Low: 3675.0 High: 4593.75 Width: 918.75
 Index 23 Center Freq 5053.125 Low: 4593.75 High: 5512.5 Width: 918.75
 
 8
 Index 24 Center Freq 6431.25 Low: 5512.5 High: 7350.0 Width: 1837.5
 Index 25 Center Freq 8268.75 Low: 7350.0 High: 9187.5 Width: 1837.5
 Index 26 Center Freq 10106.25 Low: 9187.5 High: 11025.0 Width: 1837.5
 
 9
 Index 27 Center Freq 12862.5 Low: 11025.0 High: 14700.0 Width: 3675.0
 Index 28 Center Freq 16537.5 Low: 14700.0 High: 18375.0 Width: 3675.0
 Index 29 Center Freq 20212.5 Low: 18375.0 High: 22050.0 Width: 3675.0
 */

import ddf.minim.analysis.FFT;

// TODO: MultibandAnalyzer can inherit from FFT

public class MultibandAnalyzer
{
  FFT fftLog;
  int NUMBER_OF_BANDS = 10; 
  int NUM_BANDS_IN_OCTAVE = 3;

  public MultibandAnalyzer(FFT fftLog)
  {
    this.fftLog = fftLog;
    // expecting fftLog of 30 averages
    this.fftLog.logAverages(22, NUM_BANDS_IN_OCTAVE);
  }

  public void setFFTLog(FFT fftLog)
  {
    this.fftLog = fftLog;
  }

  public void getAllBandInfo(int i)
  {      
    OctaveCalculator bCalc = new OctaveCalculator(this.fftLog, i);
    bCalc.toString();
  }

  // get band 0 - 10 (0 is <45Hz, not considered useful for analysis of audio tracks)
  public float getBandAvg(int i)
  { 
    OctaveCalculator bCalc = new OctaveCalculator(this.fftLog, i);

    final int firstBand = bCalc.getFirstBandNum();
    final int secondBand = 1 + bCalc.getSecondBandNum();
    final int thirdBand = 2 + bCalc.getThirdBandNum();

    return (this.fftLog.getAvg(firstBand) + this.fftLog.getAvg(secondBand) + this.fftLog.getAvg(thirdBand)) / bCalc.getTotalBands();
  }
}
