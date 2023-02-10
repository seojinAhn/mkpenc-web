const menu = document.querySelector(".context_menu");
const menuOption = document.querySelector(".context_menu li");
let menuVisible = false;

const toggleMenu = command => {
  menu.style.display = command === "show" ? "block" : "none";
  menuVisible = !menuVisible;
};

const setPosition = ({ top, left }) => {
  menu.style.left = `${left}px`;
  menu.style.top = `${top}px`;
  toggleMenu("show");
};

window.addEventListener("click", e => {
  if (menuVisible) toggleMenu("hide");
});

menuOption.addEventListener("click", e => {
  console.log(".context_menu li", e.target.innerHTML);
});

window.addEventListener("contextmenu", e => {
  e.preventDefault();
  const origin = {
    left: e.pageX,
    top: e.pageY
  };
  setPosition(origin);
  return false;
});