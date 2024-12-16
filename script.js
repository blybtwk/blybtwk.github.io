const toggleButton = document.getElementById("toggle-mode");

// Toggle dark mode class on body and button
toggleButton.addEventListener("click", () => {
    document.body.classList.toggle("dark-mode");
    toggleButton.classList.toggle("dark-mode");
});