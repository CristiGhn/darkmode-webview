/*
<div id='darkmode-container'>
    <div class='darkmode-background'></div>
    <div id='blender' hidden></div>
</div>
*/

var container = document.createElement('div')
container.id = 'darkmode-container'
document.body.appendChild(container)

var background = document.createElement('div')
background.classList.add('darkmode-background')
container.appendChild(background)

var blender = document.createElement('div')
blender.id = 'blender'
blender.setAttribute('hidden', true)
container.appendChild(blender)
