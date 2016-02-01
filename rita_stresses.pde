import rita.*; //import language analysis library

String inputText = "A STORMJOY. A stormjoy is a living cloud. When it passes over our continent, it lowers its feeding tentacles. On each tentacle are the BAIT STARS. Although light makes you happy, you must avoid it. You will be eaten.";
String inputStresses = RiTa.getStresses(inputText); //string of 1s and 0s showing stress
char[] stressArray = inputStresses.toCharArray(); //char array of stress characters

void setup() {
  size(625, 450);
  fill(0); //black fill
  textSize(16);
  text(inputText, 10, 10, 600, 100); //print original text
  text(inputStresses, 10, 120, 600, 50); //print stress coding in 1/0
  noFill(); //remove fill
  
  //draw line graph
  beginShape();
  //for every character in array stressArray
  for (int i = 0; i < stressArray.length; i ++) {
    //if character is 0, unstressed
    if (stressArray[i] == '0') {
      vertex(i*5, height/2); //draw low vertex
      //else if character is 1, stressed
    } else if (stressArray[i] == '1') {
      vertex(i*5, height/2 - 10); //draw high vertex
    }
  }
  endShape();
  
  //draw line graph with curves
  beginShape();
  strokeWeight(3);
  //for every character in array stressArray
  for (int i = 0; i < stressArray.length; i ++) {
    //if character is 0, unstressed
    if (stressArray[i] == '0') {
      curveVertex(i*5, height/2+50); //draw low vertex
      //else if character is 1, stressed
    } else if (stressArray[i] == '1') {
      curveVertex(i*5, height/2+40); //draw high vertex
    }
  }
  endShape();
  
  //draw triangles for stressed syllables and circles for unstressed
  //for every character in array stressArray
  for (int i = 0; i < stressArray.length; i ++) {
    //if character is 0, unstressed
    if (stressArray[i] == '0') {
      stroke(255);
      ellipse(i*5, height/2+100, 16, 16); //draw circle
      //else if character is 1, stressed
    } else if (stressArray[i] == '1') {
      stroke(0);
      triangle(i*5+8, height/2+100-8, i*5+16, height/2+100+8, i*5, height/2+100+8); //draw triangle
    }
  }
  
} //end of setup()

