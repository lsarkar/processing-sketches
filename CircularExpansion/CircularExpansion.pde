
// Developed in Processing 3.4

// Library dependencies:
// Minim (2.2.2)

// royalty free music source
// https://www.bensound.com/royalty-free-music/electronica

AudioLibWrapper audioLibWrapper;

MultibandAnalyzer multiBand;

RotatingPoints spinModulator;
RotatingPoints rotatingPoints2;
RotatingPoints outerRing;
RotatingPoints rotatingPoints4;
RotatingPoints rotatingPoints4Duplicate;
RotatingPoints rotatingPoints4Inner;

int circleMiddle = 160;
int alphaInnerCircles = 130;
int alphaRotatingBlade = 200;
int alphaRot2 = 200;

Circle c;

Modulator modu = new Modulator();

UpdateRate updateRate = new UpdateRate();
Shades colorShade;
RandomPoints randPoints = new RandomPoints();

int FRAME_RATE = 30;

GlobalFader gFader = new GlobalFader();

ArrayList<ExpandingCircle> circles = new ArrayList<ExpandingCircle>();

int NUM_EXPANDING_CIRCLES = 8;

boolean randomBool()
{
   return random(1) > 0.5; 
}

void setup()
{
  // audio track must exist inside the 'data' folder, otherwise Minim cannot load the file
  // assumes test.mp3 is in 'data' folder
  String songTitle = "bensound-endlessmotion.mp3";

  size(displayWidth, displayHeight, P3D);
  rectMode(CORNERS);
  noCursor();

  // set Frame Rate
  frameRate(FRAME_RATE);
  
  // add expanding circles
  int circleSpacing = 50;
  int baseRadius = 200;
  
  for (int i = 0; i<NUM_EXPANDING_CIRCLES; i++)
  {   
      LinearRotationStrategy lin = new LinearRotationStrategy();
      lin.setSpeed(random(1,5));
      lin.setIsClockwise(randomBool());
      
      ExpandingCircle expandCircle = new ExpandingCircle(baseRadius+ (i*circleSpacing), 360 / (i+1));
      expandCircle.setRotationStrategy(lin);
      circles.add(expandCircle);
  }
  
  // audio configuration
  audioLibWrapper = new AudioLibWrapper(songTitle, this);
  multiBand = audioLibWrapper.getAnalyzer();



  colorShade = new Shades();
  
  
}

void draw()
{
  background(0);
  smooth();
  
  audioLibWrapper.forward();
  
  int i = NUM_EXPANDING_CIRCLES;
  
  
  for(int j = 0; j < circles.size(); j++)
  {  
      
      
      //float updater = 0.0;
      if (j == 1)
     {
        //updater = gFader.updater(multiBand.getBandAvg(i)*i); 
        //c.draw();
        //c.updateCircleSize(updater);
     }
     
     circles.get(j).updateCircleSize(multiBand.getBandAvg(j)*(j*1.5));
     
     // return the color from the color wheel (8 colors in visual, 16 in wheel)
     color currentColor = colorShade.getFromList(j*2);
     
     circles.get(j).setColor(currentColor);
     circles.get(j).draw();
     
    
  }
  
}
