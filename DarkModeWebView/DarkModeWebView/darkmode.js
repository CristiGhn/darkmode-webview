function injectCSS(css) {
    head = document.head || document.getElementsByTagName('head')[0],
    style = document.createElement('style');
    
    head.appendChild(style);
    
    style.type = 'text/css';
    if (style.styleSheet){
        // This is required for IE8 and below.
        style.styleSheet.cssText = css;
    } else {
        style.appendChild(document.createTextNode(css));
    }
}

function showDarkMode() {
    
    var blender = document.getElementById('blender')
    
    if (blender.hasAttribute("hidden")) {
        blender.removeAttribute("hidden")
    }
}

function showOriginalMode() {
    
    var blender = document.getElementById('blender')
    
    if (!blender.hasAttribute("hidden")) {
        blender.setAttribute("hidden", true)
    }
}
