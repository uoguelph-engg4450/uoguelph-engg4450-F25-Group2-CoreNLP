(function () {
  const THEME_KEY = "corenlp_theme";

  function applyTheme(theme) {
    if (theme === "dark") {
      document.body.classList.add("dark-mode");
    } else {
      document.body.classList.remove("dark-mode");
    }
  }

  function loadTheme() {
    const saved = localStorage.getItem(THEME_KEY) || "light";
    applyTheme(saved);

    // Update toggle state
    const toggle = document.getElementById("themeToggle");
    if (toggle) toggle.checked = saved === "dark";
  }

  function initToggle() {
    const toggle = document.getElementById("themeToggle");
    if (!toggle) return;

    toggle.addEventListener("change", function () {
      const newTheme = toggle.checked ? "dark" : "light";
      localStorage.setItem(THEME_KEY, newTheme);
      applyTheme(newTheme);
    });
  }

  // Initialize after DOM loads
  document.addEventListener("DOMContentLoaded", function () {
    loadTheme();
    initToggle();
  });
})();
