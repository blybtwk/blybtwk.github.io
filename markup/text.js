let words = []; // Array to store word positions and strings
let boxSize = 150; // Size of the interactive box
let font;

function preload() {
  font = loadFont('https://blybtwk.github.io/markup/fonts/donknow%20yet-serif.otf'); // 使用绝对路径
}

function setup() {
  createCanvas(windowWidth, windowHeight); // 创建画布
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
  stroke(255, 0, 0);
  strokeWeight(2);
  rect(mouseX - boxSize / 2, mouseY - boxSize / 2, boxSize, boxSize);
}