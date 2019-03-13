
// Developed in Processing 3.4

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

  rotatingPoints1 = new RotatingPoints();
  rotatingPoints2 = new RotatingPoints(50.0, 20);
  rotatingPoints3 = new RotatingPoints(displayHeight/2.4, 250);
  rotatingPoints2.setClockwise(false);
  rotatingPoints3.setClockwise(false);


  colorShade = new Shades();
}

void draw()
{
  background(33, 35, 38);
  smooth();

  audioLibWrapper.forward();

  translate(width/2, height/2);
  stroke(colorShade.getPrimary());
  fill(colorShade.getFourth());
  box(8);
  translate(-width/2, -height/2);

  e.setColorScheme(2);

  c.draw();
  d.draw();
  e.draw();

  rotatingPoints1.display();
  rotatingPoints2.display();
  rotatingPoints3.display();

  e.update(300 + multiBand.getBandAvg(7)*16);
  d.update(500 + multiBand.getBandAvg(5)*8);
  c.update(multiBand.getBandAvg(1)*4);
  e.setFadePercentage(80);
  d.setFadePercentage(80);
  c.setFadePercentage(99);

  rotatingPoints1.setSpeedOfRotation(0.001 + (multiBand.getBandAvg(5)/100));
  rotatingPoints2.setSpeedOfRotation(0.001);

  // extra points
  new RandomPoints().drawRandomPoints(multiBand.getBandAvg(6)/50);

  multiBand.getAllBandInfo(6);
}
