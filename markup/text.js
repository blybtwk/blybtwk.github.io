let words = []; // Array to store word positions and strings
let boxSize = 150; // Size of the interactive box
let font; // Variable to hold the custom font

function preload() {
  // Load your custom font from the correct URL (ensure the path is correct)
  font = loadFont('https://blybtwk.github.io/markup/fonts/donknow%20yet-serif.otf'); 
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  
  // Set the custom font
  textFont('donknow yet-serif'); 
  
  textSize(32);
  textAlign(CENTER, CENTER);

  // Create random words and their positions
  for (let i = 0; i < 20; i++) {
    let x = random(width);
    let y = random(height);
    words.push({ text: "Hello", x: x, y: y });
  }
}

function draw() {
  background(186,186,186);

  // Draw all words
  for (let word of words) {
    // Check if the word is inside the box
    if (
      mouseX - boxSize / 2 < word.x + textWidth(word.text) / 2 &&
      mouseX + boxSize / 2 > word.x - textWidth(word.text) / 2 &&
      mouseY - boxSize / 2 < word.y + textSize() / 2 &&
      mouseY + boxSize / 2 > word.y - textSize() / 2
    ) {
      // Draw wireframe
      noFill();
      stroke(0);
      strokeWeight(1);
      text(word.text, word.x, word.y);
    } else {
      // Draw solid text
      noStroke();
      fill(0);
      text(word.text, word.x, word.y);
    }
  }

  // Draw the interactive box
  noFill();
  stroke(64,64,64);
  strokeWeight(2);
  rect(mouseX - boxSize / 2, mouseY - boxSize / 2, boxSize, boxSize);
}