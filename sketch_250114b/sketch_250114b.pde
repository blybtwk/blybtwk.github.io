// 声明全局变量
int nbPart = 50; // 粒子数量
float clockwise = 10; // 顺时针旋转角度
float anticlockwise = -clockwise; // 逆时针旋转角度
int fps = 25; // 每秒帧数
int nbIteration = 10; // 每帧的迭代次数
boolean drawPoint = false; // 是否绘制点
Ant[] ants; // 蚂蚁数组
PImage[] images; // 存储图片

void setup() {
  size(800, 800); // 设置全屏幕大小
  frameRate(fps); // 设置帧率
  smooth(); // 平滑处理
  background(0); // 设置背景为黑色

  // 加载图片数组
  images = new PImage[10]; // 加载10张图片
  for (int i = 0; i < images.length; i++) {
    images[i] = loadImage("image" + (i + 1) + ".jpg"); // 替换为实际图片路径
  }

  ants = new Ant[nbPart]; // 初始化蚂蚁数组
  for (int i = 0; i < nbPart; i++) {
    ants[i] = new Ant();
  }
}

void draw() {
  for (int i = 0; i < nbIteration; i++) {
    background(0, 5); // 添加透明度用于形成拖尾效果
    updateAngles(); // 更新蚂蚁的角度
    updatePositions(); // 更新蚂蚁的位置
    drawConnections(); // 绘制连接线
  }
}

// 蚂蚁类
class Ant {
  PVector pos, oldPos; // 当前位置与上一次的位置
  float angle; // 当前角度
  float vitesse; // 速度
  float rota; // 旋转变化量
  float r; // 半径
  color antColor; // 蚂蚁的颜色

  Ant() {
    pos = new PVector(width / 2, height / 2); // 初始化位置在屏幕中心
    oldPos = pos.copy();
    angle = random(360); // 随机角度
    vitesse = 1; // 固定速度
    rota = random(-2, 2); // 随机旋转量
    r = random(1, 10); // 随机半径
    antColor = color(random(255), random(255),random(255)); // 随机颜色（HSV模式）
  }

  void updatePosition() {
    oldPos.set(pos); // 更新旧位置
    angle += rota; // 更新角度
    pos.x += cos(radians(angle)) * vitesse; // 根据角度更新X坐标
    pos.y += sin(radians(angle)) * vitesse; // 根据角度更新Y坐标

    // 保持蚂蚁在屏幕内移动
    pos.x = (pos.x + width) % width;
    pos.y = (pos.y + height) % height;
  }
}

// 更新所有蚂蚁的角度
void updateAngles() {
  for (Ant a : ants) {
    if (random(1) < 0.005) {
      a.rota += random(-2 - a.rota, 2 - a.rota); // 随机调整旋转量
    }
  }
}

// 更新所有蚂蚁的位置
void updatePositions() {
  for (Ant a : ants) {
    a.updatePosition();
  }
}

// 绘制蚂蚁之间的连接线
void drawConnections() {
  for (int i = 0; i < ants.length - 1; i += 2) {
    Ant a1 = ants[i];
    Ant a2 = ants[i + 1];

    // 随机选择两张图片
    PImage img1 = images[int(random(images.length))];
    PImage img2 = images[int(random(images.length))];
    float imgSize = random(10, 50); // 图片大小随机范围

    // 绘制图片
    imageMode(CENTER);
    image(img1, a1.pos.x, a1.pos.y, imgSize, imgSize); // 第一张图片
    image(img2, a2.pos.x, a2.pos.y, imgSize, imgSize); // 第二张图片

    // 绘制连接线
    stroke(a1.antColor); // 设置线条颜色
    strokeWeight(random(1, 5)); // 线条宽度随机范围
    line(a1.pos.x, a1.pos.y, a2.pos.x, a2.pos.y); // 绘制连接线
  }

  if (drawPoint) {
    for (Ant a : ants) {
      stroke(a.antColor);
      strokeWeight(a.r);
      line(a.pos.x, a.pos.y, a.oldPos.x, a.oldPos.y); // 绘制点
    }
  }
}

// 鼠标拖拽交互
void mouseDragged() {
  for (Ant a : ants) {
    if (dist(mouseX, mouseY, a.pos.x, a.pos.y) < 100) {
      a.pos.set(mouseX, mouseY); // 将蚂蚁位置设置为鼠标位置
    }
  }
}

// 调整窗口大小时重新初始化
void windowResized() {
  surface.setSize(displayWidth, displayHeight);
  background(0);
  for (int i = 0; i < nbPart; i++) {
    ants[i] = new Ant();
  }
}
