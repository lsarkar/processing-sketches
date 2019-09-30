package com.audioreactor.audio;
// Reference: http://code.compartmental.net/tools/minim/
import ddf.minim.analysis.*;
import processing.core.PApplet;
import ddf.minim.*;

/*
Wrapper class to handle all audio function playback and analysis calls

*/

public class AudioLibWrapper
{

  private Minim minim;  
  private AudioPlayer player;
  private FFT fftLin;
  private MultibandAnalyzer analyzer;

  private PApplet pApplet;
  private FFT fftLog;
  private String songPath;

  public AudioLibWrapper(String songPath, PApplet pApplet)
  {
    this.songPath = songPath;
    
    this.pApplet = pApplet;
    this.minim = new Minim(this.pApplet);
    
    this.init();
    this.getAllBands();
  }

  public void init()
  {
    this.player = this.minim.loadFile(this.songPath, 1024);
    
    // loop the file if it exists
    this.player.loop();

    // create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
    // note that this needs to be a power of two 
    // and that it means the size of the spectrum will be 1024. 
    // see the online tutorial for more info.
    this.fftLin = new FFT( this.player.bufferSize(), this.player.sampleRate() );

    // calculate the averages by grouping frequency bands linearly. use 30 averages.
    this.fftLin.linAverages( 30 );

    // create an FFT object for calculating logarithmically spaced averages
    this.fftLog = new FFT( this.player.bufferSize(), this.player.sampleRate() );

    // calculate averages based on a miminum octave width of 22 Hz
    // split each octave into three bands
    // this should result in 30 averages
    this.fftLog.logAverages( 22, 3 );
    
    // configure multiband analyzer
    this.analyzer = new MultibandAnalyzer(this.fftLog);
    
  }
  
  public void forward()
  {
     this.fftLin.forward( this.player.mix );
     this.fftLog.forward( this.player.mix ); 
  }
  
  public AudioPlayer getPlayer()
  {
     return this.player; 
  }
  
  public MultibandAnalyzer getAnalyzer()
  {
      return this.analyzer;
  }
  
  private void getAllBands()
  {
    //println("-----LOG-----");
    
      for(int i = 0; i < this.fftLog.avgSize(); i++)
    {
      // how wide is this average in Hz
      float averageWidth = fftLog.getAverageBandWidth(i);
      float centerFrequency    = fftLog.getAverageCenterFrequency(i);
      float lowFreq  = centerFrequency - averageWidth/2;
      float highFreq = centerFrequency + averageWidth/2;
      float freqWidth = highFreq - lowFreq;
      
      //println("Index", i, "Center Freq", centerFrequency, "Low:", lowFreq, "High:", highFreq, "Width:", freqWidth);
    }
    
    //println("-----LINEAR-----");
    
    for(int i = 0; i < this.fftLin.avgSize(); i++)
    {
      // how wide is this average in Hz
      float averageWidth = fftLin.getAverageBandWidth(i);
      float centerFrequency    = fftLin.getAverageCenterFrequency(i);
      float lowFreq  = centerFrequency - averageWidth/2;
      float highFreq = centerFrequency + averageWidth/2;
      float freqWidth = highFreq - lowFreq;
      
      //println("Index", i, "Center Freq", centerFrequency, "Low:", lowFreq, "High:", highFreq, "Width:", freqWidth);
    }
    
  }
}
