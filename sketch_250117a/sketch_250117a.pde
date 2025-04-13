PImage[] textures; // 存储多张图片的数组
PGraphics refractedCanvas; // 用于存储折射效果的画布
int numTextures = 12; // 图片数量
float refractionRatio = 0.98; // 折射率
float reflectivity = 0.3; // 反射率
float rotationSpeed = 0.015; // 初始旋转速度
float phase = 1.0; // 动态变化的相位
float zoomFactor = 2.0; // 缩放因子，默认为1

float dragRotationSpeed = 0.0; // 鼠标拖拽影响的旋转速度
PVector lastMousePos; // 上一次鼠标位置

void setup() {
  size(800, 800, P3D); // 使用3D渲染
  textures = new PImage[numTextures];
  noCursor(); // 隐藏鼠标光标
  
  // 加载图片
  for (int i = 0; i < numTextures; i++) {
    textures[i] = loadImage("0" + (i + 1) + ".jpg"); // 假设图片命名为 img01.png 至 img06.png
  }
  
  refractedCanvas = createGraphics(width, height, P3D);
  lastMousePos = new PVector(mouseX, mouseY); // 初始化鼠标位置
}

void draw() {
  background(0); // 黑色背景
  
  // 绘制折射效果
  refractedCanvas.beginDraw();
  refractedCanvas.background(0, 0); // 透明背景
  refractedCanvas.lights();
  
  // 动态调整旋转速度
  float adjustedRotationSpeed = rotationSpeed + dragRotationSpeed;
  
  refractedCanvas.translate(width / 2, height / 2, -200);
  refractedCanvas.scale(zoomFactor); // 根据缩放因子缩放
  
  float timer = millis() * 0.0001;
  
  // 动态生成晶体
  for (int i = 0; i < numTextures; i++) {
    PImage texture = textures[i];
    refractedCanvas.pushMatrix();
    refractedCanvas.rotateY(timer + i * adjustedRotationSpeed);
    drawCrystal(refractedCanvas, texture, i);
    refractedCanvas.popMatrix();
  }
  refractedCanvas.endDraw();
  
  // 显示生成的画布
  image(refractedCanvas, 0, 0);
}

void drawCrystal(PGraphics pg, PImage texture, int index) {
  float height = 150; // 晶体的高度
  float radiusTop = 50 + sin(phase + index) * 25; // 顶部半径
  float radiusBottom = 70; // 底部半径
  int segments = 6 + index; // 分段数

  pg.beginShape(QUAD_STRIP);
  pg.texture(texture);
  for (int i = 0; i <= segments; i++) {
    float angle = TWO_PI / segments * i;
    float xTop = cos(angle) * radiusTop;
    float zTop = sin(angle) * radiusTop;
    float xBottom = cos(angle) * radiusBottom;
    float zBottom = sin(angle) * radiusBottom;

    float u = map(i, 0, segments, 0, texture.width);
    pg.vertex(xTop, -height / 2, zTop, u, 0);
    pg.vertex(xBottom, height / 2, zBottom, u, texture.height);
  }
  pg.endShape(CLOSE);
}

// 鼠标移动触发相位变化
void mouseMoved() {
  phase += 0.05;
}

// 鼠标滚轮调整缩放因子
void mouseWheel(MouseEvent event) {
  float e = event.getCount(); // 滚轮事件
  zoomFactor += e * -0.05; // 调整缩放因子
  zoomFactor = constrain(zoomFactor, 0.5, 3.0); // 限制缩放范围
}

// 鼠标拖动调整旋转速度
void mouseDragged() {
  PVector currentMousePos = new PVector(mouseX, mouseY);
  PVector mouseDelta = PVector.sub(currentMousePos, lastMousePos); // 计算鼠标拖动的位移
  dragRotationSpeed = map(mouseDelta.x, -50, 100, -0.01, 0.5); // 根据水平拖动距离调整旋转速度
  dragRotationSpeed = constrain(dragRotationSpeed, -0.02, 3); // 限制旋转速度范围
  lastMousePos.set(currentMousePos); // 更新鼠标位置
}

// 鼠标释放后减缓旋转速度
void mouseReleased() {
  dragRotationSpeed = 0; // 停止拖拽时复位拖拽速度
}
