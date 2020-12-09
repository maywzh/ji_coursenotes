require(mxnet)
require(imager)
model = mx.model.load("Inception/Inception_BN", iteration=39)