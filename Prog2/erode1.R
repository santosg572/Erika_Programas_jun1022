x = readImage(system.file("images", "shapes.png", package="EBImage"))
  kern = makeBrush(5, shape='diamond')  
  
  display(x)
  display(kern, title='Structuring element')
  display(erode(x, kern), title='Erosion of x')
  display(dilate(x, kern), title='Dilatation of x')

  ## makeBrush
  display(makeBrush(99, shape='diamond'))
  display(makeBrush(99, shape='disc', step=FALSE))
  display(2000*makeBrush(99, shape='Gaussian', sigma=10))
