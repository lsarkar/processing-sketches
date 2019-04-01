
// Developed in Processing 3.4

// Library dependencies:
// Minim (2.2.2)

// royalty free music source
// https://www.bensound.com/royalty-free-music/electronica

AudioLibWrapper audioLibWrapper;

MultibandAnalyzer multiBand;

RotatingPoints rotatingPoints1;
RotatingPoints rotatingPoints2;
RotatingPoints rotatingPoints3;
RotatingPoints rotatingPoints4;

int circleInner = 100;
int circleMiddle = 200;
int circleOuter = 600;

Modulator modu = new Modulator();

UpdateRate updateRate = new UpdateRate();

Shades colorShade;

RandomPoints randPoints = new RandomPoints();

int FRAME_RATE = 30;

void setup()
{
  // audio track must exist inside the 'data' folder, otherwise Minim cannot load the file
  // assumes test.mp3 is in 'data' folder
  String songTitle = "bensound-dubstep.mp3";

  size(displayWidth, displayHeight, P3D);
  rectMode(CORNERS);

  // set Frame Rate
  frameRate(FRAME_RATE);

  // audio configuration
  audioLibWrapper = new AudioLibWrapper(songTitle, this);
  multiBand = audioLibWrapper.getAnalyzer();

  /* CUSTOM CLASS SETUP */

  rotatingPoints1 = new RotatingPoints(350, 3);
  rotatingPoints2 = new RotatingPoints(60.0, 45);
  //rotatingPoints3 = new RotatingPoints(displayHeight/2.4, 250);
  rotatingPoints3 = new RotatingPoints(displayHeight/2.5, 400);
  rotatingPoints2.setClockwise(false);
  rotatingPoints3.setClockwise(false);
  rotatingPoints2.setDrawLine(true);
  
  rotatingPoints4 = new RotatingPoints(circleMiddle, 300);
  rotatingPoints4.setSpeedOfRotation(0.0);
  rotatingPoints4.setExpandOffset(0);

  colorShade = new Shades();
}

void drawCenterBox()
{
  int boxSize = 20;
  translate(width/2, height/2);
  stroke(colorShade.getPrimary());
  fill(colorShade.getFourth());
  box(boxSize);
  translate(-width/2, -height/2);
}

void draw()
{
  background(33, 35, 38);
  smooth();

  audioLibWrapper.forward();

  drawCenterBox();
  
  // draw all
  rotatingPoints1.draw();
  rotatingPoints2.draw();
  rotatingPoints3.draw();
  
  if (updateRate.isUpdateable(17))
  {
    rotatingPoints4.draw();
  }
  
  // update all
  rotatingPoints2.expand(multiBand.getBandAvg(1)*1.2);
  rotatingPoints3.expand(multiBand.getBandAvg(3));
  
  rotatingPoints4.expand(multiBand.getBandAvg(5));
  rotatingPoints4.setRadius(circleMiddle + multiBand.getBandAvg(5)*8);
  
  modu.run();
  
  rotatingPoints4.addRadiusModulation(modu.getSize());
  rotatingPoints3.addRadiusModulation(modu.getSize());
  
  rotatingPoints1.setSpeedOfRotation(0.001 + (multiBand.getBandAvg(5)/120));
  rotatingPoints2.setSpeedOfRotation(0.001);

  // extra points
  randPoints.draw(multiBand.getBandAvg(6)/50);
}
