import processing.sound.*;

SoundFile sceneOneSound;
SoundFile sceneTwoSound;
SoundFile sceneThreeSound;
SoundFile sceneFourSound;
SoundFile sceneFiveSound;

int currentScene = 1;
SceneOne sceneOne;
SceneTwo sceneTwo;
SceneThree sceneThree;
SceneFour sceneFour;
SceneFive sceneFive;

int transitionDuration = 60; // Number of frames for transition
int transitionCounter = 0;
boolean transitioning = false;
int nextScene = 1;

void setup() {
  size(1920, 1080);
  sceneOne = new SceneOne();
  sceneTwo = new SceneTwo();
  sceneThree = new SceneThree();
  sceneFour = new SceneFour();
  sceneFive = new SceneFive();
  
  sceneOne.setup();
  sceneTwo.setup();
  sceneThree.setup();
  sceneFour.setup();
  sceneFive.setup();
  
  sceneOneSound = new SoundFile(this, "N1.mp3");
  sceneTwoSound = new SoundFile(this, "N2.mp3");
  sceneThreeSound = new SoundFile(this, "N3.mp3");
  sceneFourSound = new SoundFile(this, "N4.mp3");
  sceneFiveSound = new SoundFile(this, "N5.mp3");
  
  sceneOneSound.play();
}

void draw() {
  if (transitioning) {
    transition();
  } else {
    drawCurrentScene();
    checkSoundStatus();
  }
}

void checkSoundStatus() {
  SoundFile currentSound = getCurrentSound();
  if (currentSound != null && !currentSound.isPlaying()) {
    initiateTransition(currentScene + 1);
  }
}

SoundFile getCurrentSound() {
  switch (currentScene) {
    case 1:
      return sceneOneSound;
    case 2:
      return sceneTwoSound;
    case 3:
      return sceneThreeSound;
    case 4:
      return sceneFourSound;
    case 5:
      return sceneFiveSound;
    default:
      return null;
  }
}

void initiateTransition(int targetScene) {
  transitioning = true;
  transitionCounter = 0;
  nextScene = targetScene > 8 ? 1 : targetScene; // Loop back to scene 1 if exceeding 8
  
  // Stop all sounds
  sceneOneSound.stop();
  sceneTwoSound.stop();
  sceneThreeSound.stop();
  sceneFourSound.stop();
  sceneFiveSound.stop();
}

void transition() {
  float alpha = map(transitionCounter, 0, transitionDuration, 0, 255);

  if (transitionCounter <= transitionDuration / 2) {
    drawCurrentScene();
  } else {
    drawNextScene();
  }

  fill(0, alpha);
  noStroke();
  rect(0, 0, width, height);

  transitionCounter++;

  if (transitionCounter > transitionDuration) {
    transitioning = false;
    currentScene = nextScene;
    
    // Play the appropriate sound for the next scene after transition
    switch (nextScene) {
      case 1:
        sceneOneSound.play();
        break;
      case 2:
        sceneTwoSound.play();
        break;
      case 3:
        sceneThreeSound.play();
        break;  
      case 4:
        sceneFourSound.play();
        break; 
      case 5:
        sceneFiveSound.play();
        break; 
    }
  }
}

void drawCurrentScene() {
  switch (currentScene) {
    case 1:
      sceneOne.draw();
      break;
    case 2:
      sceneTwo.draw();
      break;
    case 3:
      sceneThree.draw();
      break;
    case 4:
      sceneFour.draw();
      break;
    case 5:
      sceneFive.draw();
      break;
  }
}

void drawNextScene() {
  switch (nextScene) {
    case 1:
      sceneOne.draw();
      break;
    case 2:
      sceneTwo.draw();
      break;
    case 3:
      sceneThree.draw();
      break;
    case 4:
      sceneFour.draw();
      break;
    case 5:
      sceneFive.draw();
      break;
  }
}
