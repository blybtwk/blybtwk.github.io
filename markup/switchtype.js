// 确保代码在 DOM 加载后执行
document.addEventListener("DOMContentLoaded", () => {
  // 定义字母数组
  const letters = ["L", "f", "g", "a", "T", "M", "W", "X", "y", "K", "Q", "I", "J", "k", "h", "z"];

  // 获取目标元素
  const fontDisplay = document.querySelector(".font-display");

  // 确保元素存在
  if (fontDisplay) {
    console.log("font-display found! Starting letter switch...");
    // 每 500 毫秒随机替换字母
    setInterval(() => {
      const randomIndex = Math.floor(Math.random() * letters.length);
      fontDisplay.textContent = letters[randomIndex];
    }, 500); // 每 500 毫秒更新一次
  } else {
    console.error("Error: Element .font-display not found.");
  }
});