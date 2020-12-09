
 
from __future__ import print_function
import keras
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras import backend as K
 
batch_size = 128
num_classes = 10
epochs = 12
 
# input image dimensions
# 输入图像维度
img_rows, img_cols = 28, 28
 
# the data, shuffled and split between train and test sets
# 用于训练和测试的数据集，经过了筛选（清洗、数据样本顺序打乱）和分割（分割为训练和测试集）
(x_train, y_train), (x_test, y_test) = mnist.load_data()
 
if K.image_data_format() == 'channels_first': # Theano框架，图像通道在前
    x_train = x_train.reshape(x_train.shape[0], 1, img_rows, img_cols)
    x_test = x_test.reshape(x_test.shape[0], 1, img_rows, img_cols)
    input_shape = (1, img_rows, img_cols)
else: # TensorFlow框架，图像通道在后
    x_train = x_train.reshape(x_train.shape[0], img_rows, img_cols, 1)
    x_test = x_test.reshape(x_test.shape[0], img_rows, img_cols, 1)
    input_shape = (img_rows, img_cols, 1)
image_gen_train = ImageDataGenerator(
     rescale = 1/ 1.,
     rotation_range = 45,
     width_shift_range = .15,
     height_shift_range = .15,
     horizontal_flip = False,
     zoom_range = 0.5
)

image_gen_train.fit(x_train)
x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255
print('x_train shape:', x_train.shape)
print(x_train.shape[0], 'train samples')
print(x_test.shape[0], 'test samples')
 
# convert class vectors to binary class matrices
# 类别向量转为2分类矩阵
y_train = keras.utils.to_categorical(y_train, num_classes)
y_test = keras.utils.to_categorical(y_test, num_classes)
 
model = Sequential()
model.add(Conv2D(32, kernel_size=(3, 3),
                 activation='relu',
                 input_shape=input_shape))
model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(num_classes, activation='softmax'))
 
model.compile(loss=keras.losses.categorical_crossentropy,
              optimizer=keras.optimizers.Adadelta(),
              metrics=['accuracy'])
 
model.fit(x_train, y_train,
          batch_size=batch_size,
          epochs=epochs,
          verbose=1,
          validation_data=(x_test, y_test))
score = model.evaluate(x_test, y_test, verbose=0)
print('Test loss:', score[0])
print('Test accuracy:', score[1])
