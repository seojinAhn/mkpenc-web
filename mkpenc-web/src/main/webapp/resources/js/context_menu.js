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
  const comX = e.clientX + $("#mouse_area").outerWidth() > window.innerWidth ? window.innerWidth - $("#mouse_area").outerWidth() : e.clientX;
  const comY = e.clientY + $("#mouse_area").outerHeight() > window.innerHeight ? window.innerHeight - $("#mouse_area").outerHeight() : e.clientY;      	  
  const origin = {
    left: comX,
    top: comY
  };
  setPosition(origin);
  return false;
});