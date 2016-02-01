//sample the mouse position every 8 frames, and when 3 are stored,
//average the pixel colour in an image of the earliest 2 positions
//and fill a triangle made of the 3 positions with that colour.

//laurel obrien


//pre-load the image for online/javascript use
/* @pjs preload="scarlet.jpg"; */

boolean init = false; //check if program started
PImage loadedImg; //store an image
int frames = 0; //manually count and reset count of frames

//arrays storing mouse X and Y positions
//and their pixel colours in relation to loadedImg
int[] xPos = new int[0];
int[] yPos = new int[0];
color[] cols = new color[0];

//colour of previous pixel positions
color colA;
color colB;

color tweenCol; //averaged colour
boolean positionValid; //check if mouse position is valid for sampling
 
int sampleRate = 8; //frame frequency points are sampled
int shapePoints = 3; //maximum number of points in a shape
 
//set up canvas, stroke and colour modes, etc
void setup() {
  size(625, 625);
  frameRate(60);
  colorMode(RGB,255);
  background(0);
  noStroke();
 
  //store image from sketch folder as loadedImg
  loadedImg = loadImage("scarlet.jpg");
}
 
 
 
void draw() {
  //if program isn't started, start it
  if(!init) {
     init = true;
  }
 
  frames++; //increment manual frame count
  
  //if frame count >= rate the mouse pos is sampled
  if (frames >= sampleRate) {
    //reset frame count
    frames = 0;
 
    //if mouse is inside the canvas
    if ((mouseX > 0) && (mouseY > 0)) {
 
      positionValid = true; //mouse pos is valid for sampling
 
      //if array of X positions has any values stored,
      if(xPos.length > 0) {
        //and if mouse position is the same as the last stored position
        if ((mouseX == xPos[xPos.length-1]) && (mouseY == yPos[yPos.length-1])) {
           positionValid = false; //position is not valid for sampling
        }
      }
 
      //if position is valid for sampling
      if (positionValid) {
        //sample point
        xPos = append(xPos, mouseX);
        yPos = append(yPos, mouseY);
 
        //draw shape
        if (xPos.length >= shapePoints) {
 
          //set colour a and b as the colour of the img's pixel
          //at the last 2 sampled points
          colA = getCol(pixelID(xPos[xPos.length-1], yPos[yPos.length-1]), 150);
          colB = getCol(pixelID(xPos[xPos.length-2], yPos[yPos.length-2]), 150);
          
          //set fill to an average of colour a and b
          tweenCol = lerpColor(colA, colB, .5);
          fill(tweenCol);
           
          //begin drawing shape
          beginShape();
          noStroke();
          //create a vertex at the last 3 sampled mouse positions
          for(int i = 0; i < 3; i ++) {
            int arrayPos = xPos.length-1 - i;
            vertex(xPos[arrayPos],yPos[arrayPos]);
          }
          //close shape
          endShape(CLOSE);
 
        } //end of if(xPos.length >= shapePoints)
      } //end of if(positionValid)
    } //end of if(mouseX [...] > 0)
  } //end of if(frames >= sampleRate)
 
} //end of draw()



//return rgba colour of a pixel 
color getCol(int loc, int a) {
  // Get the R,G,B values from image
  float r = red   (loadedImg.pixels[loc]);
  float g = green (loadedImg.pixels[loc]);
  float b = blue  (loadedImg.pixels[loc]);
  return color(r,g,b,a);
}
 
 

//return 2d pixel location in a 1d space
int pixelID(int x, int y) {
 int xpx = int((float(x)/float(width))*loadedImg.width);
 int ypx = int((float(y)/float(height))*loadedImg.height);
 
 return int((ypx*loadedImg.width)+xpx);
}
