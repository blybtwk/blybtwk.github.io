// 导入Processing库
PFont font;
String text1 = "复苏视觉\nRecover Vision\n2024\n06.15 – 07.06\n动态图像语言\nMoving Image Language\nShenzhen China\nProcessing";
String text2 = "MINED\nGraduation 205\nDesign Academy\nEindhoven\n21-29 Oct 2024";
String[] textArray1;
String[] textArray2;
int rectSize = 50;  // 矩形的大小
int cols, rows;
boolean[][] revealed;  // 记录哪些矩形已经被揭开

// 同心圆参数
int numGroups = 25; // 同心圆的组数
int numRings = 25; // 每组的同心圆数量
float[][] ringSizes; // 存储每个同心圆大小的二维数组
float maxRingSize; // 最大圆圈大小
PVector[] groupCenters; // 每组同心圆的中心位置

void setup() {
  size(800, 800);
  font = createFont("HarmonyOS_Sans_SC_Black.ttf", 68);
  textArray1 = text1.split("\n");  // 根据换行符拆分文本
  textArray2 = text2.split("\n");  // 根据换行符拆分文本
  cols = width / rectSize;
  rows = height / rectSize;
  revealed = new boolean[cols][rows];  // 初始化记录数组
  textFont(font);  // 设置字体
  
  // 初始化同心圆参数
  colorMode(HSB, 255, 255, 255); // 设置颜色模式为HSB
  smooth(); // 平滑边缘
  noFill(); // 不填充圆环内部
  ringSizes = new float[numGroups][numRings]; // 初始化同心圆大小数组
  groupCenters = new PVector[numGroups]; // 初始化每组圆心位置数组
  maxRingSize = width / 7.0; // 设置最大圆圈大小

  // 初始化每组同心圆的中心位置
  for (int i = 0; i < numGroups; i++) {
    groupCenters[i] = new PVector(random(width), random(height));
  }
}

void draw() {
  background(255);  // 背景颜色为白色
  fill(255, 0, 0);  // 填充颜色为红色
  textAlign(CENTER, CENTER);  // 文本对齐方式
  float x = width / 2;  // 文本的x坐标
  float y1 = height / 2 - (textArray1.length * rectSize) / 2-150;  // text1的y坐标
  float y2 = y1 + textArray1.length * rectSize + 60;  // text2的y坐标

  for (int i = 0; i < textArray1.length; i++) {
    text(textArray1[i], x, y1 + i * rectSize);  // 绘制text1
  }
  for (int i = 0; i < textArray2.length; i++) {
    text(textArray2[i], x, y2 + i * rectSize);  // 绘制text2
  }
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (!revealed[i][j]) {
        fill(0);  // 如果未被揭开，填充颜色为黑色
        stroke(0);  // 添加黑色描边
        rect(i * rectSize, j * rectSize, rectSize, rectSize);  // 绘制矩形
      } else {
        stroke(0);  // 添加黑色描边
        noFill();  // 不填充
        rect(i * rectSize, j * rectSize, rectSize, rectSize);  // 只绘制描边矩形
      }
    }
  }
  
  // 绘制同心圆效果
  for (int j = 0; j < numGroups; j++) {
    PVector center = groupCenters[j];
    for (int i = 0; i < numRings; i++) {
      float mouseDist = dist(mouseX, mouseY, center.x, center.y);
      float targetSize = maxRingSize - i * (maxRingSize / numRings) - mouseDist / 2;
      targetSize = max(targetSize, 0);
      ringSizes[j][i] = lerp(ringSizes[j][i], targetSize, 0.1);
      stroke((j * 50 + i * 25) % 255, 200, 255);
      strokeWeight(1);
      ellipse(center.x, center.y, ringSizes[j][i], ringSizes[j][i]);
    }
  }
  
  // 检查鼠标位置并揭开矩形
  int col = mouseX / rectSize;
  int row = mouseY / rectSize;
  if (col >= 0 && col < cols && row >= 0 && row < rows) {
    revealed[col][row] = true;
  }
}

void mousePressed() {
  int col = mouseX / rectSize;
  int row = mouseY / rectSize;
  if (col >= 0 && col < cols && row >= 0 && row < rows) {
    revealed[col][row] = true;  // 鼠标点击后揭开矩形
  }
}
