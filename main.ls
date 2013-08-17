canvas = document.getElementById 'canvas'
ctx = canvas.getContext '2d'

reset = !->
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
    ctx.clearRect 0, 0, canvas.width, canvas.height

window.addEventListener 'resize', reset, false
reset!

draw-contour = (contour) ->
    ctx.beginPath!
    ctx.moveTo contour[0][0], contour[0][1]
    for i from 1 to contour.length-1
        ctx.lineTo contour[i][0], contour[i][1]
    ctx.stroke!

draw-shape = (x, y, scale, shape) ->
    ctx.save!
    ctx.translate x, y
    ctx.scale scale, scale
    ctx.lineWidth = 1.0/scale
    draw-contour shape.contour
    ctx.restore!

steps = [
    -> square
    -> concat-shape it, square
    -> concat-shape it, square
    -> concat-shape it, triangle
    -> rotate-shape it
    -> concat-shape it, triangle
    -> rotate-shape it
    -> concat-shape it, triangle
    -> rotate-shape it
    -> concat-shape it, (translate-shape triangle, [1 0])
]

for step in steps
    crazy = step crazy
    draw-shape 50, 50, 20, crazy
    ctx.translate (crazy.size[0]+1) * 20, 0
