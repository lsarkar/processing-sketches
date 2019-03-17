
// Developed in Processing 3.4

// Library dependencies:
// Minim (2.2.2)

AudioLibWrapper audioLibWrapper;

MultibandAnalyzer multiBand;

RotatingPoints rotatingPoints1;
RotatingPoints rotatingPoints2;
RotatingPoints rotatingPoints3;

int circleInner = 100;
int circleMiddle = 200;
int circleOuter = 600;

Circle c = new Circle(circleMiddle);
Circle d = new Circle(circleOuter);
Circle e = new Circle(circleInner); 

Shades colorShade;

void setup()
{
  // audio track must exist inside the 'data' folder, otherwise Minim cannot load the file
  // assumes test.mp3 is in 'data' folder
  String songTitle = "Crush.mp3";

  size(displayWidth, displayHeight, P3D);
  rectMode(CORNERS);

  // audio configuration
  audioLibWrapper = new AudioLibWrapper(songTitle, this);
  multiBand = audioLibWrapper.getAnalyzer();

  /* CUSTOM CLASS SETUP */
  d.setFadePercentage(5);

  rotatingPoints1 = new RotatingPoints(350, 3);
  rotatingPoints2 = new RotatingPoints(60.0, 45);
  rotatingPoints3 = new RotatingPoints(displayHeight/2.4, 250);
  rotatingPoints2.setClockwise(false);
  rotatingPoints3.setClockwise(false);
  
  rotatingPoints2.setDrawLine(true);
  


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

  e.setColorScheme(2);
  //c.draw();
  //d.draw();
  e.draw();

  rotatingPoints1.draw();
  rotatingPoints2.draw();
  rotatingPoints3.draw();
  rotatingPoints2.expand(multiBand.getBandAvg(1));
  rotatingPoints3.expand(multiBand.getBandAvg(3));

  e.update(300 + multiBand.getBandAvg(7)*16);
  d.update(500 + multiBand.getBandAvg(5)*8);
  c.update(multiBand.getBandAvg(1)*4);
  e.setFadePercentage(80);
  d.setFadePercentage(80);
  c.setFadePercentage(99);

  rotatingPoints1.setSpeedOfRotation(0.001 + (multiBand.getBandAvg(5)/120));
  rotatingPoints2.setSpeedOfRotation(0.001);

  // extra points
  new RandomPoints().draw(multiBand.getBandAvg(6)/50);

  multiBand.getAllBandInfo(6);
}
