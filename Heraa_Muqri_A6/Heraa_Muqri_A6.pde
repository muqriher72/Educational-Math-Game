/**************************
 * Heraa Muqri             *
 *                         *
 * Heraa_Muqri_A6.pde      *
 *                         *
 * ICS 3U1 - Assignment 6  *
 *                         *
 *    Educational Game     *
 * A program that runs a   *
 * math game using various *
 * methods, if statements, *
 * PImages, and arrays.    *
 *                         *
 * February 3rd, 2021      *
 **************************/

// General Variables
int gameState = 1;
boolean gameOver = false;
PFont font, font1, font2;
PImage [] backgroundImages = new PImage [3];
int gameStopwatch = 0;
int score = 0;
int timer = 0;

// User Input Mechanism Variables
int userInput = 0; // The current value typed in by the user which is displayed on the screen.

// Boy Variables
PImage [] boyImages = new PImage [15];
PVector BoyPosition = new PVector (400, 515);
PVector BoyVelocity = new PVector (0, -11); 
PVector BoyGravity = new PVector (0, 0.5);
float boyAirResistance = 0.99; 
int boyImageState = 0;
int boyState = 0;
boolean boyJumping = false; 

// Zombie Variables
PImage [] zombieImages = new PImage [10];
PVector ZombiePosition = new PVector (100, 485);
PVector ZombieVelocity = new PVector (0, -11); 
PVector ZombieGravity = new PVector (0, 0.5);
float zombieAirResistance = 0.99; 
int zombieImageState = 0;
int zombieState = 0;
boolean zombieJumping = false; 

// Questions Variables
PImage [] questionsImages = new PImage [15];
int [] answers = {1716, 308, 444, 1862, 1056, 2394, 3080, 456, 120, 2272, 407, 210, 2340, 1458, 836};
boolean wrongAnswer = false;
int questionImageState = 0;
int numberOfQuestionsAnswered = 0;

// Rock Obstacle Variables 
PImage rock;
PVector RockPositions = new PVector (400, 560);

void setup () {
  size (550, 600);
  imageMode (CENTER);

  // The following code loads a picture of a rock into the rock variable.
  rock = loadImage ("rock.png"); // rock obstacle

  // The following code loads 3 different fonts and stores them in their appropriate font variables.
  font = loadFont ("Impact-48.vlw");
  font1 = loadFont ("Calibri-BoldItalic-48.vlw");
  font2 = loadFont ("LucidaConsole-48.vlw");

  // The following code loads 3 background images and stores them in their appropriate variables.
  backgroundImages [0] = loadImage ("backdrop1.jpg"); // game screen background
  backgroundImages [1] = loadImage ("backdrop2.png"); // welcome screen background
  backgroundImages [2] = loadImage ("backdrop3.png"); // game over screen background

  // The following code loads 15 boy images and stores them in their appropriate variables.
  boyImages [0] = loadImage ("boySprites/Run (1).png"); 
  boyImages [1] = loadImage ("boySprites/Run (2).png"); 
  boyImages [2] = loadImage ("boySprites/Run (3).png"); 
  boyImages [3] = loadImage ("boySprites/Run (4).png"); 
  boyImages [4] = loadImage ("boySprites/Run (5).png"); 
  boyImages [5] = loadImage ("boySprites/Run (6).png"); 
  boyImages [6] = loadImage ("boySprites/Run (7).png"); 
  boyImages [7] = loadImage ("boySprites/Run (8).png"); 
  boyImages [8] = loadImage ("boySprites/Run (9).png");
  boyImages [9] = loadImage ("boySprites/Run (10).png"); 
  boyImages [10] = loadImage ("boySprites/Run (11).png"); 
  boyImages [11] = loadImage ("boySprites/Run (12).png"); 
  boyImages [12] = loadImage ("boySprites/Run (13).png"); 
  boyImages [13] = loadImage ("boySprites/Run (14).png"); 
  boyImages [14] = loadImage ("boySprites/Run (15).png");

  // The following code loads 15 question images and stores them in their appropriate variables.
  questionsImages [0] = loadImage ("questionSprites/question1.png"); 
  questionsImages [1] = loadImage ("questionSprites/question2.png"); 
  questionsImages [2] = loadImage ("questionSprites/question3.png"); 
  questionsImages [3] = loadImage ("questionSprites/question4.png"); 
  questionsImages [4] = loadImage ("questionSprites/question5.png"); 
  questionsImages [5] = loadImage ("questionSprites/question6.png"); 
  questionsImages [6] = loadImage ("questionSprites/question7.png"); 
  questionsImages [7] = loadImage ("questionSprites/question8.png"); 
  questionsImages [8] = loadImage ("questionSprites/question9.png"); 
  questionsImages [9] = loadImage ("questionSprites/question10.png"); 
  questionsImages [10] = loadImage ("questionSprites/question11.png"); 
  questionsImages [11] = loadImage ("questionSprites/question12.png"); 
  questionsImages [12] = loadImage ("questionSprites/question13.png"); 
  questionsImages [13] = loadImage ("questionSprites/question14.png"); 
  questionsImages [14] = loadImage ("questionSprites/question15.png"); 

  // The following code loads 10 zombie images and stores them in their appropriate variables.
  zombieImages [0] = loadImage ("zombieSprites/Walk (1).png"); 
  zombieImages [1] = loadImage ("zombieSprites/Walk (2).png"); 
  zombieImages [2] = loadImage ("zombieSprites/Walk (3).png"); 
  zombieImages [3] = loadImage ("zombieSprites/Walk (4).png"); 
  zombieImages [4] = loadImage ("zombieSprites/Walk (5).png"); 
  zombieImages [5] = loadImage ("zombieSprites/Walk (6).png"); 
  zombieImages [6] = loadImage ("zombieSprites/Walk (7).png"); 
  zombieImages [7] = loadImage ("zombieSprites/Walk (8).png"); 
  zombieImages [8] = loadImage ("zombieSprites/Walk (9).png"); 
  zombieImages [9] = loadImage ("zombieSprites/Walk (10).png");
}

void draw () {
  if (gameState == 1) { // Welcome Screen
    welcomeScreen ();
  } else if (gameState == 2) { // Game Context Screen
    gameContextScreen ();
  } else if (gameState == 3) { // Instructions Screen
    instructionsScreen ();
  } else if (gameState == 4) { // Game Screen
    drawBoy ();
    moveBoy ();
    drawRock ();
    moveRock ();
    checkRockHitScreenEdge ();
    checkRockHitBoy ();
    boyGravity ();
    drawZombie ();
    moveZombie ();
    makeZombieJump ();
    zombieGravity ();
    checkRockHitZombie ();
    checkIfGameOver ();
    drawQuestionBoard ();
    displayQuestions () ;
    increaseTime ();
    timerDisplay ();
    displayScore ();
    userInput ();
  } else if (gameState == 5) { // Game Over Screen
    gameOverScreen ();
    displayScore ();
    timerDisplay ();
    noLoop (); // stops the code in the draw loop from executing.
  }
}

void setVariables () { // method that sets the variables/boolean switches to their initial values or states.
  score = 0;
  timer = 0;
  ZombiePosition.x = 100;
  ZombiePosition.y = 485;
  BoyPosition.y = 515;
  boyJumping = false;
  zombieJumping = false;
  userInput = 0;
  gameOver = false;
  wrongAnswer = false;
  questionImageState = 0;
  numberOfQuestionsAnswered = 0;
}

void welcomeScreen () { // method to display the welcome screen and appropriate text.
  background (#ffffff);
  image (backgroundImages [0], 280, 400);
  fill (#000000);
  textFont (font1, 78);
  text ("MATH", 180, 100);
  textFont (font, 70);
  text ("APOCALYPSE", 110, 200);
  textFont (font2, 20);
  text ("Press the spacebar key to continue!", 60, 585);
}

void gameContextScreen () { // method to display the game context screen and appropriate text.
  background (#ffffff);
  textFont (font, 60);
  text ("CONTEXT", 180, 95);
  textFont (font2, 20);
  text ("It was a normal school day until 3 pm.", 50, 165);
  text ("You were walking home when you noticed", 45, 240);
  text ("a large ZOMBIE chasing you!", 110, 265);
  text ("To your surprise, the zombie hates math.", 35, 340);
  text ("It's up to you to save yourself from it!", 35, 410);
  text ("Show off your 2-digit multiplication skills!", 10, 485);
  textSize (20);
  text ("Press the enter key to load the instructions!", 5, 560);
}

void instructionsScreen () { // method to display the instructions screen and appropriate text.
  background (#ffffff);
  textFont (font, 60);
  text ("HOW TO PLAY", 125, 95);
  textFont (font2, 20);
  text ("Keep the boy running without getting", 50, 165);
  text ("caught by the zombie teacher.", 80, 205);
  text ("Answer 15 2-digit multiplication questions", 20, 275);
  text ("quickly and correctly using the number keys.", 13, 310);
  text ("Every wrong answer, the zombie comes closer!", 10, 370);
  text ("Every right answer, the zombie doesn't move.", 10, 435);
  text ("Each question is worth 10 points!", 65, 495);
  textSize (20);
  text ("Press the right arrow key to load the game!", 15, 560);
}

void gameOverScreen () { // method to display the game over screen and appropriate text.
  image (backgroundImages [2], 280, 300);
  textFont (font, 90);
  fill (#ffffff);
  text ("GAME OVER", 80, 250); 
  textFont (font2, 20);
  text ("Press the backspace key to restart the game!", 10, 455);
}

void drawBoy () { // method to draw and animate a RUNNING boy character using sprites.
  background (#46cbff);
  image (backgroundImages [1], 280, 365);
  // The following code creates a RUNNING animation of the boy.
  if (boyState < 10) {
    boyImageState = 1;
  } else if (boyState < 20) {
    boyImageState = 2;
  } else if (boyState < 30) {
    boyImageState = 3;
  } else if (boyState < 40) {
    boyImageState = 4;
  } else if (boyState < 50) {
    boyImageState = 5;
  } else if (boyState < 60) {
    boyImageState = 6;
  } else if (boyState < 70) {
    boyImageState = 7;
  } else if (boyState < 80) {
    boyImageState = 0;
    boyState = 1;
  } 
  boyState++;
  image (boyImages [boyImageState], BoyPosition.x, BoyPosition.y);
}

void boyGravity () { // method that allows the boy's velocity to be affected by gravity so it accelerates realistically.
  BoyVelocity = BoyVelocity.add(BoyGravity);
}

void moveBoy () { // method to make the boy jump, land and keep him within the game screen.
  if (boyJumping == true) {
    BoyVelocity = BoyVelocity.mult(boyAirResistance);
    BoyPosition = BoyPosition.add(BoyVelocity);
  }
  if (BoyPosition.y > 515) { // makes the boy land on the ground once it jumps.
    BoyPosition.y = 515;
    boyJumping = false;
  }
  if (boyJumping == false) { // makes the boy land on the ground if he is not jumping.
    BoyPosition.y = 515;
  }
}

void drawRock () { // method to draw the rock obstacle.
  image (rock, RockPositions.x, RockPositions.y);
}

void moveRock () { // method to move the rock obstacle horizontally.
  RockPositions.x -= 3;
}

void checkRockHitScreenEdge () { // method to check if the rock hits the edges of the screen horizontally.
  if (RockPositions.x < 0) {
    RockPositions.x = 500;
  }
} 

void checkRockHitBoy () { // method to check if the rock obstacle hit the boy.
  // The following are dummy variables used to represent different sides of the rock and boy for collision detection.
  float rockRightSide = RockPositions.x + 16;
  float rockLeftSide = RockPositions.x - 10;
  float boyRightSide = BoyPosition.x + 10;
  float boyLeftSide = BoyPosition.x - 85;
  if (rockLeftSide < boyRightSide && rockRightSide > boyRightSide && boyJumping == false) { // sets the velocity of the boy to - 11 ONCE EVERYTIME the rock hits the boy.
    BoyVelocity.y = -11;
  } else {
    boyJumping = false;
  }
  if (rockLeftSide < boyRightSide && rockRightSide > boyLeftSide && boyJumping == false) { // makes the boy jump as long as the rock is within his x-position range.
    boyJumping = true;
  }
}

void drawZombie () { // method to draw and animate a RUNNING zombie character using sprites. 
  if (zombieState < 10) {
    zombieImageState = 1;
  } else if (zombieState < 20) {
    zombieImageState = 2;
  } else if (zombieState < 30) {
    zombieImageState = 3;
  } else if (zombieState < 40) {
    zombieImageState = 4;
  } else if (zombieState < 50) {
    zombieImageState = 5;
  } else if (zombieState < 60) {
    zombieImageState = 6;
  } else if (zombieState < 70) {
    zombieImageState = 7;
  } else if (zombieState < 80) {
    zombieImageState = 0;
    zombieState = 1;
  }
  zombieState++;
  image (zombieImages [zombieImageState], ZombiePosition.x, ZombiePosition.y);
}

void moveZombie () { // method to move the zombie IF a wrong answer is given by user.
  if (wrongAnswer == true) {
    ZombiePosition.x += 12;
    wrongAnswer = false;
  }
}

void checkRockHitZombie () { // method to check if the rock obstacle hit the zombie and create appropriate results.
  // The following are dummy variables used to represent different sides of the rock and zombie for collision detection.
  float rockRightSide = RockPositions.x + 16;
  float rockLeftSide = RockPositions.x - 10;
  float zombieRightSide = ZombiePosition.x + 60;
  float zombieLeftSide = ZombiePosition.x - 45;
  if (rockLeftSide < zombieRightSide && rockRightSide > zombieRightSide && zombieJumping == false) { // sets the velocity of the zombie to - 11 ONCE EVERYTIME the rock hits the zombie.
    ZombieVelocity.y = -11;
  } else {
    zombieJumping = false;
  }
  if (rockLeftSide < zombieRightSide && rockRightSide > zombieLeftSide && zombieJumping == false) { // makes the zombie jump as long as the rock is within his x-position range.
    zombieJumping = true;
  }
}

void makeZombieJump () { // method to make the zombie jump, land and stay within the bounds of the game screen.
  if (zombieJumping == true) {
    ZombieVelocity = ZombieVelocity.mult(zombieAirResistance);
    ZombiePosition = ZombiePosition.add(ZombieVelocity);
  }
  if (ZombiePosition.y > 515) { // makes the zombie land on the ground once it jumps.
    ZombiePosition.y = 485;
    zombieJumping = false;
  }
  if (zombieJumping == false) { // keeps the zombie on the ground if it is not jumping.
    ZombiePosition.y = 485;
  }
}

void zombieGravity () { // method that allows the zombie's velocity to be affected by gravity so it accelerates realistically.
  ZombieVelocity = ZombieVelocity.add(ZombieGravity);
}

void checkIfGameOver () { // method to check if the game over condition has been met.
  if (numberOfQuestionsAnswered == 15) { // makes the game over if all questions have been answered.
    questionImageState = 14;
    gameOver = true;
    gameState = 5;
  }
}

void drawQuestionBoard () { // method to draw a white rectangle shape for the question board on the game screen.
  fill (#ffffff);
  strokeWeight (0);
  rect (50, 70, 450, 300);
}

void displayQuestions () { // method to display questions from the questions pictures array on the screen.
  image (questionsImages [questionImageState], 250, 200);
}

void checkAnswer () { // method to check the answers provided by the user, determine if they are correct or wrong and give appropriate results. 
  if (userInput == answers [questionImageState]) { // Runs the code IF ANSWERS are RIGHT.
    questionImageState++;
    score += 10;
    userInput = 0;
    numberOfQuestionsAnswered++;
  } else if (userInput != answers [questionImageState]) { // Runs the code IF ANSWERS are WRONG.
    questionImageState++;
    wrongAnswer = true;
    numberOfQuestionsAnswered++;
    userInput = 0;
  }
}

void userInput () { // method to display the user input and appropriate text.
  fill (#000000);
  textSize (50);
  text (userInput, 350, 275);
  textSize (17);
  text ("Press the enter key to check your answer!", 65, 335);
  text ("Press the backspace key to delete a number.", 58, 360);
}

void increaseTime () { // method to increase the timer every second.
  if (millis() - gameStopwatch > 1000) {
    gameStopwatch = millis();
    timer++;
  }
}

void timerDisplay () { // method to display the timer and/or total time using appropriate text at appropriate times.
  textSize (30);
  fill (#000000);
  if (gameOver == false) {
    text ("TIME:" + timer, 100, 40);
  }
  if (gameOver == true) {
    text ("YOUR TOTAL TIME: " + timer, 105, 375);
  }
}

void displayScore () { // method to display the score and/or total score using appropriate text at appropriate times.
  textSize (30);
  fill (#000000);
  if (gameOver == false) {
    text ("SCORE:" + score, 325, 40);
  }
  if (gameOver == true) {
    text ("YOUR TOTAL SCORE: " + score, 90, 315);
  }
}

void keyPressed () { // runs code inside IF A SPECIFIC KEY IS PRESSED.
  if (gameState == 1) { // WELCOME SCREEN
    if (keyCode == 32) { // SPACEBAR KEY launches a screen with context for the game for the user.
      gameState = 2;
    }
  } else if (gameState == 2) { // GAME CONTEXT SCREEN
    if (keyCode == 10) { // ENTER KEY launches instructions selection screen.
      gameState = 3;
    }
  } else if (gameState == 3) { // INSTRUCTIONS SCREEN
    if (keyCode == 39) { // RIGHT ARROW KEY launches game screen.
      gameState = 4;
    }
  } else if (gameState == 4) { // GAME SCREEN
    // KEYCODE RANGE FOR CALCULATOR KEYBOARD NUMBER KEYS: 0 = 96, 1 = 97, ..., 9 = 105.
    // KEYCODE RANGE FOR KEYBOARD NUMBER KEYS ABOVE ALPHABETS: 0 = 48, 1 = 49, ... 9 = 57.
    if (keyCode > 95 && keyCode < 106 && userInput < 1000) { // allows calculator number keys on keyboard to be pressed and provide numerical user input on screen.
      int currentValue = keyCode - 96; // dummy variable that determines the digit that was just typed.
      userInput = userInput*10 + currentValue; // moves the previous number typed by user to one greater place value and displays the new number.
    } else if (keyCode > 47 && keyCode < 58 && userInput < 1000) { // allows the number keys above the letter keys on keyboard to be pressed and provide numerical user input on screen.
      int currentValue = keyCode - 48; // dummy variable that determines the digit that was just typed.
      userInput = userInput*10 + currentValue; // moves the previous number typed by user to one greater place value and displays the new number.
    } else if (keyCode == 8) { // Allows user to delete a number/digit when the BACKSPACE KEY is pressed.
      userInput = userInput / 10; // This uses integer division to cut off the decimal place, removing the last digit.
    } else if (keyCode == 10) { // Allows user to check if their answer is correct WHEN they press the ENTER KEY.
      checkAnswer();
    }
  } else if (gameState == 5) { // GAME OVER SCREEN
    if (gameOver == true && keyCode == 8) { // BACKSPACE KEY restarts the game.
      loop (); // starts executing the code in the draw loop.
      gameState = 3; // changes the game state to the instructions page.
      setVariables (); // resets the game variables to their initial settings.
    }
  }
}
