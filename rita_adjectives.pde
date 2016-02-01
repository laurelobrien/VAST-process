//create grids in the rough proportion of a paragraph
//(~12 words long) indicating if the words are or are not
//an adjective or adverb

import rita.*;

String inputText = "They did nothing to advance the cause of life! They burnt up time and matter and thought on this solipsistic, onanistic pursuit of safety, insulating themselves from death, making a regressive pocket of useless stability. When they could have helped whittle the universe towards its final, perfect form!";
String mobyText = RiTa.stripPunctuation("I pondered some time without fully comprehending the reason for this. Father Mapple enjoyed such a wide reputation for sincerity and sanctity, that I could not suspect him of courting notoriety by any mere tricks of the stage. No, thought I, there must be some sober reason for this thing; furthermore, it must symbolize something unseen. Can it be, then, that by that act of physical isolation, he signifies his spiritual withdrawal for the time, from all outward worldly ties and connexions? Yes, for replenished with the meat and wine of the word, to the faithful man of God, this pulpit, I see, is a self-containing stronghold- a lofty Ehrenbreitstein, with a perennial well of water within the walls.");
String twilightText = RiTa.stripPunctuation("“The blush on your cheeks is lovely,” he murmured. He gently freed his other hand. My hands fell limply into my lap. Softly he brushed my cheek, then held my face between his marble hands. “Be very still,” he whispered, as if I wasn’t already frozen. Slowly, never moving his eyes from mine, he leaned toward me. Then, abruptly, but very gently, he rested his cold cheek against the hollow at the base of my throat. I was quite unable to move, even if I’d wanted to. I listened to the sound of his even breathing, watching the sun and wind play in his bronze hair, more human than any other part of him.”");
RiLexicon lexicon = new RiLexicon(); //create new RiLexicon object


void setup() {
  size(560, 550);
  background(255);
  
  textSize(14);
  fill(0);
  text("Passage from Moby Dick (adjectives)", 25, 30);
  text("Passage from Twilight (adjectives)", 295, 30);
  text("Passage from Moby Dick (adverbs)", 25, 325);
  text("Passage from Twilight (adverbs)", 295, 325);
  
  strokeWeight(2);
  
  //adjective functions
  mapAdjectives(mobyText, 30, 50);
  mapAdjectives(twilightText, 300, 50);
  
  //adverb functions
  mapAdverbs(mobyText, 30, 350);
  mapAdverbs(twilightText, 300, 350);
  
} //end of setup()


//split a string into a list of words, create a list of booleans
//corresponding to each word indicating if it is an adjective,
//and draw circles filled or unfilled for true or false in a grid.
void mapAdjectives(String input, int x, int y) {
  String[] wordList = input.split(" "); //String separated by spaces into list of words
  boolean[] adjList = new boolean[wordList.length]; //boolean array same length as wordList
  
  for (int i = 0; i < wordList.length; i ++) {
    if (lexicon.isAdjective(wordList[i])) {
      adjList[i] = true;
    } else {
      adjList[i] = false;
    } //end of if(isAdjective)
  } //end of for(wordList.length)
  
  //2d array to store adjList in a grid
  int rows = 12;
  int columns = int(adjList.length/rows);
  boolean adjGrid[][] = new boolean[rows][columns];
  
  //initialize adjGrid
  for (int i = 0; i < rows; i ++) {
    for (int j = 0; j < columns; j ++) {
      adjGrid[i][j] = adjList[i + j * columns];
    }
  }
  
  for (int i = 0; i < rows; i ++) {
    for (int j = 0; j < columns; j ++) {
      if (adjGrid[i][j] == true) {
        fill(0);
      } else {
        noFill();
      }
      ellipse(x+i*20, y+j*20, 10, 10);
    }
  }
}


//same as mapAdjectives but with adverbs
void mapAdverbs(String input, int x, int y) {
  String[] wordList = input.split(" "); //String separated by spaces into list of words
  boolean[] advList = new boolean[wordList.length]; //boolean array same length as wordList
  
  for (int i = 0; i < wordList.length; i ++) {
    if (lexicon.isAdverb(wordList[i])) {
      advList[i] = true;
    } else {
      advList[i] = false;
    } //end of if(isAdjective)
  } //end of for(wordList.length)
  
  //2d array to store adjList in a grid
  int rows = 12;
  int columns = int(advList.length/rows);
  boolean advGrid[][] = new boolean[rows][columns];
  
  //initialize adjGrid
  for (int i = 0; i < rows; i ++) {
    for (int j = 0; j < columns; j ++) {
      advGrid[i][j] = advList[i + j * columns];
    }
  }
  
  //draw grid of empty or filled circles,
  //where filled circles are adjectives
  for (int i = 0; i < rows; i ++) {
    for (int j = 0; j < columns; j ++) {
      if (advGrid[i][j] == true) {
        fill(0);
      } else {
        noFill();
      }
      ellipse(x+i*20, y+j*20, 10, 10);
    }
  }
}


