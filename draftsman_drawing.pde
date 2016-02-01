//create grids in the rough proportion of a paragraph
//(~12 words long) indicating if the words are or are not
//an adjective or adverb

import rita.*;

String mobyText = "I pondered some time without fully comprehending the reason for this. Father Mapple enjoyed such a wide reputation for sincerity and sanctity, that I could not suspect him of courting notoriety by any mere tricks of the stage. No, thought I, there must be some sober reason for this thing; furthermore, it must symbolize something unseen. Can it be, then, that by that act of physical isolation, he signifies his spiritual withdrawal for the time, from all outward worldly ties and connexions?";
String twilightText = "“The blush on your cheeks is lovely,” he murmured. He gently freed his other hand. My hands fell limply into my lap. Softly he brushed my cheek, then held my face between his marble hands. “Be very still,” he whispered, as if I wasn’t already frozen. Slowly, never moving his eyes from mine, he leaned toward me. Then, abruptly, but very gently, he rested his cold cheek against the hollow at the base of my throat. I was quite unable to move, even if I’d wanted to. I listened to the sound of his even breathing";
String kingText = "Ullman stood five-five, and when he moved, it was with the prissy speed that seems to be the exclusive domain of all small plump men. The part in his hair was exact, and his dark suit was sober but comforting. I am a man you can bring your problems to, that suit said to the paying customer. To the hired help it spoke more curtly: This had better be good, you. There was a red carnation in the lapel, perhaps so that no one on the street would mistake Stuart Ullman for the local undertaker.";
RiLexicon lexicon = new RiLexicon(); //create new RiLexicon object


void setup() {
  size(800, 400);
  background(255);
  noFill();
  
  Draftsman testDraft = new Draftsman(mobyText, 0);
  Draftsman secondDraft = new Draftsman(twilightText, 100);
  Draftsman thirdDraft = new Draftsman(kingText, -100);
  
  //moby dick
  testDraft.curves(testDraft.isAdjective, color(255, 255, 0));
  testDraft.lineGraph(testDraft.isVerb, -1, color(0, 255, 255));
  testDraft.dots(testDraft.isNoun, color(255, 0, 255));
  
  //twilight
  secondDraft.curves(secondDraft.isAdjective, color(255, 255, 0));
  secondDraft.lineGraph(secondDraft.isVerb, -1, color(0, 255, 255));
  secondDraft.dots(secondDraft.isNoun, color(255, 0, 255));
  
  //the shining
  thirdDraft.curves(thirdDraft.isAdjective, color(255, 255, 0));
  thirdDraft.lineGraph(thirdDraft.isVerb, -1, color(0, 255, 255));
  thirdDraft.dots(thirdDraft.isNoun, color(255, 0, 255));
} //end of setup()

class Draftsman {
  //attributes:
  //declare boolean arrays storing true/false for each word
  //in a given string
  boolean[] isAdjective;
  boolean[] isAdverb;
  boolean[] isNoun;
  boolean[] isVerb;
  
  //array of separated words in the given string
  String[] wordList;
  
  float pointDist;
  int offset;
  
  //constructor
  Draftsman(String input, int tempOffset) {
    //initialize wordList by removing punctuation, splitting
    //string at any spaces
    wordList = RiTa.stripPunctuation(input).split(" ");
    
    //distance between points so as to fit 
    //the width of the canvas
    pointDist = width/wordList.length + 1;
    offset = tempOffset;
    
    //initialize length of bool arrays
    isAdjective = new boolean[wordList.length];
    isAdverb = new boolean[wordList.length];
    isVerb = new boolean[wordList.length];
    isNoun = new boolean[wordList.length];
    
    
    //initialize isAdjective bool array
    for (int i = 0; i < wordList.length; i ++) {
      if (lexicon.isAdjective(wordList[i])) {
        isAdjective[i] = true;
      } else {
        isAdjective[i] = false;
      }
    }
    
    //initialize isAdverb bool array
    for (int i = 0; i < wordList.length; i ++) {
      if (lexicon.isAdverb(wordList[i]) == true) {
        isAdverb[i] = true;
      } else {
        isAdverb[i] = false;
      }
    }
    
    //initialize isVerb bool array
    for (int i = 0; i < wordList.length; i ++) {
      if (lexicon.isVerb(wordList[i]) == true) {
        isVerb[i] = true;
      } else {
        isVerb[i] = false;
      }
    }
    
    //initialize isNoun bool array
    for (int i = 0; i < wordList.length; i ++) {
      if (lexicon.isNoun(wordList[i]) == true) {
        isNoun[i] = true;
      } else {
        isNoun[i] = false;
      }
    }
    
    //ensure no word considered a noun is doubly considered
    //an adjective depending on context
    for (int i = 0; i < wordList.length; i ++) {
      if (isAdjective[i] == isNoun[i]) {
        isAdjective[i] = false;
      }
    }
  } //end of constructor
  
  
  
  
  //methods
  //
  void lineGraph(boolean[] boolArray, int modifier, color strokeCol) {
    strokeWeight(3);
    stroke(strokeCol);
    
    //draw a line graph with true booleans (word matches)
    //ascending or descending from the center-line
    beginShape();
      for (int i = 0; i < boolArray.length; i ++) {
        if (!boolArray[i]) {
          vertex(i*pointDist, height/2-offset);
        } else {
          vertex(i*pointDist, height/2 + 20*modifier-offset);
        }
      }
    endShape();
    
  } //end of render()
  
  void dots(boolean[] boolArray, color strokeCol) {
    strokeWeight(5);
    stroke(strokeCol);
    
    //draw a line graph with true booleans (word matches)
    //ascending or descending from the center-line
    for (int i = 0; i < boolArray.length; i ++) {
      if (boolArray[i]) {
        point(i*pointDist, height/2+10-offset);
      }
    }
    
  } //end of dots()
  
  void curves(boolean[] boolArray, color strokeCol) {
    strokeWeight(5);
    stroke(strokeCol);
    
    //draw a line graph with true booleans (word matches)
    //ascending or descending from the center-line
    beginShape();
    for (int i = 0; i < boolArray.length; i ++) {
      if (boolArray[i]) {
        curveVertex(i*pointDist, height/2+30-offset);
      } else {
        curveVertex(i*pointDist, height/2-offset);
      }
    }
    endShape();
    
  } //end of curves()
} //end of Draftsman class definition

