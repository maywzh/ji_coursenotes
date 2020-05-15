# lab 9 Report

## Data

We load MNIST dataset through``datasets.mnist.load_data``, we set train size as 60000 ann test size as 10000，the dimension of train picture is 28x28 with the channels of 1
## Preprocess
We normalize the pixel value from 0-255 to 0-1

## Model
The model is a 3 layer CNN，

The first layer is a convolutional layer with 32 3x3 convolution kernel and RELU activation function,  the pooling layer is MaxPooling with the pooling size of 2x2.
The second layer is a convolutional layer with 64 3x3 convolution kernel and RELU activation function,  the pooling layer is MaxPooling with the pooling size of 2x2.
The third layer is a convolutional layer with 64 3x3 convolution kernel and RELU activation function,  the output layer use softmax to normalize its output.

## Training
```bash
Model: "sequential"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
conv2d (Conv2D)              (None, 26, 26, 32)        320       
_________________________________________________________________
max_pooling2d (MaxPooling2D) (None, 13, 13, 32)        0         
_________________________________________________________________
conv2d_1 (Conv2D)            (None, 11, 11, 64)        18496     
_________________________________________________________________
max_pooling2d_1 (MaxPooling2 (None, 5, 5, 64)          0         
_________________________________________________________________
conv2d_2 (Conv2D)            (None, 3, 3, 64)          36928     
_________________________________________________________________
flatten (Flatten)            (None, 576)               0         
_________________________________________________________________
dense (Dense)                (None, 64)                36928     
_________________________________________________________________
dense_1 (Dense)              (None, 10)                650       
=================================================================
Total params: 93,322
Trainable params: 93,322
Non-trainable params: 0
_________________________________________________________________
Train on 60000 samples
Epoch 1/5
 9888/60000 [===>..........................] - ETA: 13s - loss: 0.4502 - accuracy: 0.8639 
Epoch 00001: saving model to ./ckpt/cp-0001.ckpt
19904/60000 [========>.....................] - ETA: 10s - loss: 0.2855 - accuracy: 0.9129
Epoch 00001: saving model to ./ckpt/cp-0001.ckpt
29888/60000 [=============>................] - ETA: 7s - loss: 0.2225 - accuracy: 0.9319 
Epoch 00001: saving model to ./ckpt/cp-0001.ckpt
39968/60000 [==================>...........] - ETA: 5s - loss: 0.1855 - accuracy: 0.9433
Epoch 00001: saving model to ./ckpt/cp-0001.ckpt
49888/60000 [=======================>......] - ETA: 2s - loss: 0.1619 - accuracy: 0.9502
Epoch 00001: saving model to ./ckpt/cp-0001.ckpt
60000/60000 [==============================] - 16s 261us/sample - loss: 0.1460 - accuracy: 0.9552
Epoch 2/5
   32/60000 [..............................] - ETA: 17s - loss: 0.0533 - accuracy: 0.9688
Epoch 00002: saving model to ./ckpt/cp-0002.ckpt
10048/60000 [====>.........................] - ETA: 13s - loss: 0.0522 - accuracy: 0.9840
Epoch 00002: saving model to ./ckpt/cp-0002.ckpt
19936/60000 [========>.....................] - ETA: 10s - loss: 0.0510 - accuracy: 0.9840
Epoch 00002: saving model to ./ckpt/cp-0002.ckpt
29920/60000 [=============>................] - ETA: 7s - loss: 0.0519 - accuracy: 0.9842 
Epoch 00002: saving model to ./ckpt/cp-0002.ckpt
40096/60000 [===================>..........] - ETA: 5s - loss: 0.0503 - accuracy: 0.9844
Epoch 00002: saving model to ./ckpt/cp-0002.ckpt
50048/60000 [========================>.....] - ETA: 2s - loss: 0.0493 - accuracy: 0.9847
Epoch 00002: saving model to ./ckpt/cp-0002.ckpt
60000/60000 [==============================] - 16s 264us/sample - loss: 0.0476 - accuracy: 0.9854
Epoch 3/5
   32/60000 [..............................] - ETA: 15s - loss: 0.0016 - accuracy: 1.0000
Epoch 00003: saving model to ./ckpt/cp-0003.ckpt
10048/60000 [====>.........................] - ETA: 13s - loss: 0.0340 - accuracy: 0.9893
Epoch 00003: saving model to ./ckpt/cp-0003.ckpt
20128/60000 [=========>....................] - ETA: 10s - loss: 0.0362 - accuracy: 0.9881
Epoch 00003: saving model to ./ckpt/cp-0003.ckpt
30048/60000 [==============>...............] - ETA: 7s - loss: 0.0350 - accuracy: 0.9885 
Epoch 00003: saving model to ./ckpt/cp-0003.ckpt
40096/60000 [===================>..........] - ETA: 5s - loss: 0.0340 - accuracy: 0.9891
Epoch 00003: saving model to ./ckpt/cp-0003.ckpt
50208/60000 [========================>.....] - ETA: 2s - loss: 0.0344 - accuracy: 0.9893
Epoch 00003: saving model to ./ckpt/cp-0003.ckpt
60000/60000 [==============================] - 16s 264us/sample - loss: 0.0339 - accuracy: 0.9893
Epoch 4/5
  224/60000 [..............................] - ETA: 15s - loss: 0.0116 - accuracy: 0.9955
Epoch 00004: saving model to ./ckpt/cp-0004.ckpt
10208/60000 [====>.........................] - ETA: 13s - loss: 0.0199 - accuracy: 0.9937
Epoch 00004: saving model to ./ckpt/cp-0004.ckpt
20096/60000 [=========>....................] - ETA: 10s - loss: 0.0239 - accuracy: 0.9927
Epoch 00004: saving model to ./ckpt/cp-0004.ckpt
30272/60000 [==============>...............] - ETA: 7s - loss: 0.0239 - accuracy: 0.9929 
Epoch 00004: saving model to ./ckpt/cp-0004.ckpt
40224/60000 [===================>..........] - ETA: 5s - loss: 0.0249 - accuracy: 0.9925
Epoch 00004: saving model to ./ckpt/cp-0004.ckpt
50272/60000 [========================>.....] - ETA: 2s - loss: 0.0260 - accuracy: 0.9923
Epoch 00004: saving model to ./ckpt/cp-0004.ckpt
60000/60000 [==============================] - 16s 267us/sample - loss: 0.0260 - accuracy: 0.9921
Epoch 5/5
  224/60000 [..............................] - ETA: 15s - loss: 0.0100 - accuracy: 0.9955
Epoch 00005: saving model to ./ckpt/cp-0005.ckpt
10272/60000 [====>.........................] - ETA: 13s - loss: 0.0157 - accuracy: 0.9945
Epoch 00005: saving model to ./ckpt/cp-0005.ckpt
20352/60000 [=========>....................] - ETA: 10s - loss: 0.0166 - accuracy: 0.9947
Epoch 00005: saving model to ./ckpt/cp-0005.ckpt
30368/60000 [==============>...............] - ETA: 7s - loss: 0.0170 - accuracy: 0.9946 
Epoch 00005: saving model to ./ckpt/cp-0005.ckpt
40256/60000 [===================>..........] - ETA: 5s - loss: 0.0187 - accuracy: 0.9944
Epoch 00005: saving model to ./ckpt/cp-0005.ckpt
50432/60000 [========================>.....] - ETA: 2s - loss: 0.0195 - accuracy: 0.9942
Epoch 00005: saving model to ./ckpt/cp-0005.ckpt
60000/60000 [==============================] - 16s 267us/sample - loss: 0.0206 - accuracy: 0.9937
10000/10000 [==============================] - 0s 46us/sample - loss: 0.0339 - accuracy: 0.9890
准确率: 0.9890，共测试了10000张图片 
```

## Test
It got 0.989 accuracy in a 10000 size of dataset.