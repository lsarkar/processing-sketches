/*
Created by Lawrence Sarkar 31 MAY 2017

Draws a static image of rectangles that following a number of randomly generated sine wave patterns

*/

void setup()
{
  smooth();
  noCursor();
  size(1170, 660);

  background(34, 35, 38);

  for (float i = 0.1; i <=1; i+=0.1)
  {
    RandomSine randSine = new RandomSine(random(0, 100), (height/2));
    randSine.draw();
  }
  
}


void mousePressed() {
  // save sketch upon a mouse click
  save("sketch_output.png");
}

void draw() {

}