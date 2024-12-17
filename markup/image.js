const images = []; // 图片数组
let currentIndex = 0; // 当前显示的图片索引
let img; // 当前显示的图片

function preload() {
  // 加载所有图片（假设图片路径是 `image/1.jpg` 到 `image/12.jpg`）
  for (let i = 1; i <= 12; i++) {
    images.push(loadImage(`../image/${i}.jpg`)); // 修改路径指向根目录的 image 文件夹
  }
}

function setup() {
  const canvas = createCanvas(windowWidth, windowHeight); // 创建 canvas
  canvas.parent('image-canvas'); // 将 canvas 放到 Section 4 内
  imageMode(CENTER); // 图片居中显示
  setInterval(changeImage, 2000); // 每 2 秒切换一次图片
}

function draw() {
  background(255, 255, 255, 0); // 背景透明，确保文字能看到
  img = images[currentIndex]; // 获取当前索引的图片
  if (img) {
    image(img, width / 2, height / 2); // 居中显示图片，保持原始大小
  }
}

function changeImage() {
  currentIndex = (currentIndex + 1) % images.length; // 切换到下一张图片
}