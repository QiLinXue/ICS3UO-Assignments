void settings() {
    size(300, 300);
}

//Data
int capitalLettersCount = 0;
int vowelCount = 0;
int letterCount = 0;
int words = 1;
int punctuationCount = 0;
int[] frequency = new int[26];
int mostFrequentLetterFrequency = 0;
String sentence;
char c;

void othello(){
    String[] text = loadStrings("othello.txt");
    String sentence = String.join(",",text);
    println("Othello - Character Count: " + sentence.length());
}

void illiad(){
    String[] text = loadStrings("illiad.txt");
    String sentence = String.join(",",text);
    letterCount = sentence.length();
    for(int i = 0;i<letterCount;i++){
        c = sentence.charAt(i);
        iterateUpperCase(c);
    }
    println("Illiad - Capital Letter Count: " + capitalLettersCount);
}

void romeoAndJuliet(){
    String[] text = loadStrings("romeoAndJuliet.txt");
    String sentence = String.join(",",text);
    letterCount = sentence.length();
    for(int i = 0;i<letterCount;i++){
        c = sentence.charAt(i);
        iterateVowels(c);
    }
    println("Romeo and Juliet - Vowel Count: " + vowelCount);
}

void theOdyssey(){
    String[] text = loadStrings("theOdyssey.txt");
    String sentence = String.join(",",text);
    letterCount = sentence.length();
    for(int i = 0;i<letterCount;i++){
        c = sentence.charAt(i);
        iterateWords(c);
    }
    println("The Odyssey - Word Count: " + words);
}

void hamlet(){
    String[] text = loadStrings("hamlet.txt");
    String sentence = String.join(",",text);
    letterCount = sentence.length();
    for(int i = 0;i<letterCount;i++){
        c = sentence.charAt(i);
        iteratePunctuations(c);
    }
    println("Hamlet - Punctuation Count: " + punctuationCount);
}

void macbeth(){
    String[] text = loadStrings("macbeth.txt");
    String sentence = String.join(",",text);
    letterCount = sentence.length();
    for(int i = 0;i<letterCount;i++){
        c = sentence.charAt(i);
        iterateSequence(c);
    }
    println("Macbeth - Most Frequent Letter: " + punctuationCount);
}

void setup() {
    long startTime = System.nanoTime(); //Start Time

    othello();
    illiad();
    romeoAndJuliet();
    theOdyssey();
    hamlet();
    macbeth();

    long endTime = System.nanoTime();
    long totalTime = endTime - startTime;
    println("total time in ms: " + totalTime/1000000);
}

void draw() {
  noLoop(); //draw doesn't need to happen for this exercise
}

void iterateUpperCase(char character){
    if(Character.isUpperCase(character)) capitalLettersCount++;
}

void iterateVowels(char character){
    if(character == 'a' || character == 'e' || character == 'i' || character == 'o' || character == 'u' ||
       character == 'A' || character == 'E' || character == 'I' || character == 'O' || character == 'U') vowelCount++;
}

void iterateWords(char character){
    if(character == ' ') words++;
}

void iteratePunctuations(char character){
    if(character == '\'' || character == ':' || character == ';' || character == ',' || character == '.' || character == '!' || character == '?') punctuationCount++;
}

void iterateSequence(char character){
    if(Character.isLetter(character)){
        frequency[positionOfLetter(character)]++;
    }
}

int positionOfLetter(char c){
    String index1 = "abcdefghijklmnopqrstuvwxyz";
    String index2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int position = 0;
    for(int i=0; i<26; i++){
        if(index1.charAt(i) == c){
            position = i;
            break;
        } else if(index2.charAt(i) == c){
            position = i;
            break;
        }
    }
    return position;
}

char mostFrequentLetter(int[] letterFrequency){
    String index = "abcdefghijklmnopqrstuvwxyz";

    int highestFrequency = 0;
    int highestFrequencyIndex = 0;

    //Find highest index
    for(int i=0;i<26;i++){
        if(letterFrequency[i] > highestFrequency){
            highestFrequency = letterFrequency[i];
            highestFrequencyIndex = i;
        }
    }

    //Return letter associated with index
    char highestCharacter = index.charAt(highestFrequencyIndex);
    mostFrequentLetterFrequency = highestFrequency;
    return highestCharacter;
}
