const rangeControl = document.getElementById('opacity-change');

rangeControl.addEventListener('input', (e) => {   
    const rangeInput = e.target;
    const percent = parseInt(rangeInput.value); 
    const opacityVal = percent/100;
    const lastImg = document.querySelector('.img_wrap > .img_mask');    
    
    rangeInput.nextElementSibling.innerHTML = opacityVal;        
    lastImg.style.opacity = opacityVal;
});