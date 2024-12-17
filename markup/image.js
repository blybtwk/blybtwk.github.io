const images = []; // 存储所有图片
let currentIndex = 0; // 当前显示的图片索引

function preload() {
  // 正确的相对路径是 "image/1.jpg" 到 "image/12.jpg"
  for (let i = 1; i <= 12; i++) {
    images.push(loadImage(`image/${i}.jpg`)); // 以当前文件夹为基准，加载图片
  }
}

function setup() {
  const canvas = createCanvas(windowWidth, windowHeight); // 创建 canvas
  canvas.parent('image-canvas'); // 放在 Section 4 内的正确容器中
  imageMode(CENTER); // 设置图片模式为中心显示
}

function draw() {
  background(0); // 设置背景颜色为黑色
  const img = images[currentIndex]; // 当前图片
  if (img) {
    image(img, width / 2, height / 2, width, height); // 居中显示图片，铺满整个画布
  }
}

function changeImage() {
  currentIndex = (currentIndex + 1) % images.length; // 切换到下一张图片
  redraw(); // 重新绘制画布
}

setInterval(changeImage, 2000); // 每 2 秒切换图片