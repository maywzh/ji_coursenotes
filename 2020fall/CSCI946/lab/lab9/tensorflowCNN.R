#Source: https://yetanotheriteration.netlify.app/2019/01/tensorflow-and-keras-with-r/

install.packages("keras")
install.packages("tensorflow")
library(keras)

# loading and preparing dataset
mnist <- dataset_mnist() 

# separate the datasets
x.train <- mnist$train$x
lbl.train <- mnist$train$y
x.test <-  mnist$test$x
lbl.test <-  mnist$test$y

# Redefine dimension of train/test inputs to 2D "tensors" (28x28x1)
x.train <- array_reshape(x.train, c(nrow(x.train), 28,28,1))
x.test  <- array_reshape(x.test,  c(nrow(x.test),  28,28,1))

# normalize values to be between 0.0 - 1.0
x.train <- x.train/255
x.test  <- x.test/255

# one hot encoding
y.train <- to_categorical(lbl.train,10)
y.test  <- to_categorical(lbl.test,10)


keras_model_sequential() %>% 
  layer_conv_2d(input_shape=c(28,28,1), filters=20, kernel_size = c(5,5), activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2), strides = c(2,2)) %>% 
  layer_conv_2d(filters = 50, kernel_size = c(5,5), activation="relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2), strides = c(2,2) ) %>% 
  layer_dropout(rate=0.3) %>% 
  layer_flatten() %>% 
  layer_dense(units = 500, activation = "relu" ) %>% 
  layer_dropout(rate=0.3) %>% 
  layer_dense(units=10, activation = "softmax") -> model


# keras compile
model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_rmsprop(),
  metrics = c('accuracy')
)

# train the model and store the evolution history
history <- model %>% fit(
  x.train, y.train, epochs=30, batch_size=128,
  validation_split=0.3
)

# plot the network evolution
plot(history)

# evaluating the model
evaluate(model, x.test, y.test)

































