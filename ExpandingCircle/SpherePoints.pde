// code reference: https://forum.processing.org/one/topic/sphere-of-points.html
class Sphere {

  int size;
  float increment;
  float x1, z1, y1;
  Sphere(int qual, int se) {
    size = se;
    increment = TWO_PI/qual;
  }
  void update(int x, int y, int z) {
    for (float theta =-PI/2; theta< PI/2; theta = theta+increment) {//only 1 roTATE
      //0,0,-1 to;
      //0,0,1
      float sinz=sin(theta);
      float cosz=cos(theta);
      //define sin and cosine early

      for (float phi=0; phi<TWO_PI; phi = phi+(increment)) {//making x,y rotation

        stroke(255-(theta+PI/2.0/PI)*255, 0, (theta*PI/2.0/PI)*255);

        //  fill(255-(theta+PI/2.0/PI)*255,0,(theta*PI/2.0/PI)*255);
        float sin = sin(phi);//sine of x,y angle
        float cos = cos(phi);//cosine of x,y angle 
        float sin1 = sinz;//redeclare
        float cos1 = cosz;
        x1 = cos1*cos*size;//scale x to z position
        y1 = cos1*sin*size;//repeat
        z1 = sin1*size;//z
        noFill();
        stroke(255, 0, 0);
        strokeWeight(1);
        point(x1+x, y1+y, z1+z);
      }
    }
  }
}
