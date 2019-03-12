/*
11.2  12.5  14.1
 14.1  16  17.8
 17.8  20  22.4
 22.4  25  28.2
 28.2  31.5  35.5
 35.5  40  44.7
 44.7  50  56.2
 56.2  63  70.8
 70.8  80  89.1
 89.1  100  112
 112  125  141
 141  160  178
 178  200  224
 224  250  282
 282  315  355
 355  400  447
 447  500  562
 562  630  708
 708  800  891
 891  1000  1122
 1122  1250  1413
 1413  1600  1778
 1778  2000  2239
 2239  2500  2818
 2818  3150  3548
 3548  4000  4467
 4467  5000  5623
 5623  6300  7079
 7079  8000  8913
 8913  10000  11220
 11220  12500  14130
 14130  16000  17780
 17780  20000  22390

 */


// TODO: MultibandAnalyzer can inherit from FFT

class MultibandAnalyzer
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
   }
   
   // get band 0 - 10 (0 is <20Hz, not considered useful for analysis of audio tracks)
   public float getBandAvg(int i)
   { 
     OctaveCalculator bCalc = new OctaveCalculator(this.fftLog, i);
     
     final int firstBand = bCalc.getFirstBandNum();
     final int secondBand = 1 + bCalc.getSecondBandNum();
     final int thirdBand = 2 + bCalc.getThirdBandNum();
     
     println("first band", firstBand);
     println("second band", secondBand);
     println("third band", thirdBand);
      
     return (this.fftLog.getAvg(firstBand) + this.fftLog.getAvg(secondBand) + this.fftLog.getAvg(thirdBand)) / bCalc.getTotalBands();
   }
}
