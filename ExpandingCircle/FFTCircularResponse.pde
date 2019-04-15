
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

void setup()
{
  // audio track must exist inside the 'data' folder, otherwise Minim cannot load the file
  // assumes test.mp3 is in 'data' folder
  String songTitle = "bensound-moose.mp3";

  size(displayWidth, displayHeight, P3D);
  rectMode(CORNERS);
  noCursor();

  // set Frame Rate
  frameRate(FRAME_RATE);

  // audio configuration
  audioLibWrapper = new AudioLibWrapper(songTitle, this);
  multiBand = audioLibWrapper.getAnalyzer();

  /* CUSTOM CLASS SETUP */
  spinModulator = new RotatingPoints(350, 3);
  rotatingPoints2 = new RotatingPoints(60.0, 45);
  outerRing = new RotatingPoints(displayHeight/2.6, 400);
  rotatingPoints2.setClockwise(false);
  outerRing.setClockwise(false);
  rotatingPoints2.setDrawLine(true);
  spinModulator.setExpandOffset(1);
  rotatingPoints4 = new RotatingPoints(circleMiddle, 200);
  rotatingPoints4.setSpeedOfRotation(0.0);
  rotatingPoints4.setExpandOffset(5);
  rotatingPoints4Duplicate = new RotatingPoints(circleMiddle, 180);
  rotatingPoints4Duplicate.setExpandOffset(8);
  rotatingPoints4Inner = new RotatingPoints(circleMiddle, 150);
  rotatingPoints4Inner.setExpandOffset(7);

  rotatingPoints4Duplicate.setAlpha(alphaInnerCircles);
  rotatingPoints4Inner.setAlpha(alphaInnerCircles);
  rotatingPoints4.setAlpha(alphaInnerCircles);
  spinModulator.setAlpha(alphaRotatingBlade);
  rotatingPoints2.setAlpha(alphaRot2);

  spinModulator.setStrokeWeight(15);

  colorShade = new Shades();
  
  c = new Circle(300);
}

void drawCenterBox()
{
  int boxSize = 20;
  translate(width/2, height/2);
  strokeWeight(2);
  stroke(colorShade.getPrimary());
  fill(colorShade.getFourth());
  box(boxSize);
  translate(-width/2, -height/2);
}

void drawBorder()
{
  strokeWeight(45);
  stroke(255);
  noFill();
  rect(2, 2, displayWidth-2, displayHeight-2);
}

void draw()
{
  background(0);
  smooth();
  
  c.draw();

  audioLibWrapper.forward();

  drawCenterBox();

  // draw all
  spinModulator.draw();
  rotatingPoints2.draw();
  outerRing.draw();

  if (updateRate.isUpdateable(2))
  {
    rotatingPoints4.draw();
    rotatingPoints4Duplicate.draw();
    rotatingPoints4Inner.draw();
  }

  // modulator update
  modu.run();

  // update all
  rotatingPoints2.expand(multiBand.getBandAvg(1)*1.2);
  outerRing.expand(multiBand.getBandAvg(3));
  rotatingPoints4.expand(multiBand.getBandAvg(5));
  rotatingPoints4.setRadius(circleMiddle + multiBand.getBandAvg(5)*8);

  rotatingPoints4Duplicate.expand(multiBand.getBandAvg(6));
  rotatingPoints4Duplicate.setRadius(circleMiddle + 5 + multiBand.getBandAvg(6)*8);

  rotatingPoints4Inner.expand(multiBand.getBandAvg(7));
  rotatingPoints4Inner.setRadius(circleMiddle + multiBand.getBandAvg(7)*8);

  rotatingPoints4.addRadiusModulation(modu.getSize());
  rotatingPoints4Duplicate.addRadiusModulation(modu.getSize());
  rotatingPoints4Inner.addRadiusModulation(modu.getSize());
  outerRing.addRadiusModulation(modu.getSize());

  spinModulator.setSpeedOfRotation(0.001 + (multiBand.getBandAvg(5)/120));
  spinModulator.setStrokeWeight(15+ int(multiBand.getBandAvg(8)));
  rotatingPoints2.setSpeedOfRotation(0.001);
  rotatingPoints4Duplicate.setSpeedOfRotation(0.001 + (multiBand.getBandAvg(6)/110));
  rotatingPoints4Inner.setSpeedOfRotation(0.001 + (multiBand.getBandAvg(6)/110));
  rotatingPoints4.setSpeedOfRotation(0.001 + (multiBand.getBandAvg(6)/110));

  outerRing.setStrokeWeight(5+int(multiBand.getBandAvg(8)));

  // extra points
  randPoints.draw(multiBand.getBandAvg(6)/8);

  drawBorder();
}
