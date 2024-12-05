let words = []; // Array to store word positions and strings
let boxSize = 150; // Size of the interactive box
let smallBoxSize = 10; // Size of the small boxes
let font; // Variable to hold the custom font

function preload() {
  // Load your custom font from the correct URL (ensure the path is correct)
  font = loadFont('https://blybtwk.github.io/markup/fonts/donknow%20yet-serif.otf'); 
}

function setup() {
  createCanvas(windowWidth, windowHeight);

  // Set the custom font
  textFont(font);
  textSize(200);
  textAlign(CENTER, CENTER);

  // Create random words and their positions
  for (let i = 0; i < 20; i++) {
    let x = random(width);
    let y = random(height);
    words.push({ text: "Hello", x: x, y: y });
  }
}

function draw() {
  background('#6600FF');

  // Draw all words
  for (let word of words) {
    // Check if the word is inside the box
    if (
      mouseX - boxSize / 2 < word.x + textWidth(word.text) / 2 &&
      mouseX + boxSize / 2 > word.x - textWidth(word.text) / 2 &&
      mouseY - boxSize / 2 < word.y + textSize() / 2 &&
      mouseY + boxSize / 2 > word.y - textSize() / 2
    ) {
      // Change the appearance of the text when inside the box
      noFill();
      stroke('#C5C5C5');
      strokeWeight(1); // Change the stroke weight for emphasis
      text(word.text, word.x, word.y);
    } else {
      // Normal appearance when outside the box
      noStroke();
      fill('#C5C5C5');
      text(word.text, word.x, word.y);
    }
  }

  // Call the function to draw the rectangle with corner boxes
  drawBox(mouseX, mouseY, boxSize, smallBoxSize);
}

// Function to draw the main rectangle and its 4 corner boxes
function drawBox(x, y, mainBoxSize, cornerBoxSize) {
  // Draw the main rectangle
  noFill();
  stroke('#C5C5C5');
  strokeWeight(1);
  rect(x - mainBoxSize / 2, y - mainBoxSize / 2, mainBoxSize, mainBoxSize);

  // Draw the 4 small boxes at the corners
  noFill();
  stroke('#C5C5C5');
  strokeWeight(1);

  // Top-left corner
  rect(x - mainBoxSize / 2 - cornerBoxSize / 2, y - mainBoxSize / 2 - cornerBoxSize / 2, cornerBoxSize, cornerBoxSize);

  // Top-right corner
  rect(x + mainBoxSize / 2 - cornerBoxSize / 2, y - mainBoxSize / 2 - cornerBoxSize / 2, cornerBoxSize, cornerBoxSize);

  // Bottom-left corner
  rect(x - mainBoxSize / 2 - cornerBoxSize / 2, y + mainBoxSize / 2 - cornerBoxSize / 2, cornerBoxSize, cornerBoxSize);

  // Bottom-right corner
  rect(x + mainBoxSize / 2 - cornerBoxSize / 2, y + mainBoxSize / 2 - cornerBoxSize / 2, cornerBoxSize, cornerBoxSize);
}