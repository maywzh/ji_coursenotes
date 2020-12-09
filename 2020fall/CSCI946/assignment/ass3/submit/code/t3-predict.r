require(mxnet)
require(imager)
model = mx.model.load("Inception/Inception_BN", iteration=39)
mean.img = as.array(mx.nd.load("Inception/mean_224.nd")[["mean_img"]])
im <- load.image(system.file("extdata/parrots.png", package="imager"))
plot(im)

preproc.image <- function(im, mean.image) {
    # crop the image
    shape <- dim(im)
    short.edge <- min(shape[1:2])
    xx <- floor((shape[1] - short.edge) / 2)
    yy <- floor((shape[2] - short.edge) / 2)
    cropped <- crop.borders(im, xx, yy)
    # resize to 224 x 224, needed by input of the model.
    resized <- resize(cropped, 224, 224)
    # convert to array (x, y, channel)
    arr <- as.array(resized) * 255
    dim(arr) <- c(224, 224, 3)
    # subtract the mean
    normed <- arr - mean.img
    # Reshape to format needed by mxnet (width, height, channel, num)
    dim(normed) <- c(224, 224, 3, 1)
    return(normed)
}

normed <- preproc.image(im, mean.img)
prob <- predict(model, X=normed)
dim(prob)
max.idx <- max.col(t(prob))
max.idx
synsets <- readLines("Inception/synset.txt")
print(paste0("Predicted Top-class: ", synsets  [[max.idx]]))