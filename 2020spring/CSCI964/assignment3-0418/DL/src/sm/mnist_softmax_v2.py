"""A very simple MNIST classifier.
See extensive documentation at
http://tensorflow.org/tutorials/mnist/beginners/index.md
"""
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
# Import data
from input_data import read_data_sets
import tensorflow as tf

mnist = read_data_sets("/tmp/data/", one_hot=True)
sess = tf.compat.v1.InteractiveSession()
# Create the model
x = tf.compat.v1.placeholder(tf.float32, [None, 784])
W = tf.Variable(tf.zeros([784, 10]))
b = tf.Variable(tf.zeros([10]))
y = tf.nn.softmax(tf.matmul(x, W) + b)
# Define loss and optimizer
y_ = tf.compat.v1.placeholder(tf.float32, [None, 10])
cross_entropy = -tf.reduce_sum(input_tensor=y_ * tf.math.log(y))
train_step = tf.compat.v1.train.GradientDescentOptimizer(0.01).minimize(
    cross_entropy)
# Train
tf.compat.v1.initialize_all_variables().run()
for i in range(1000):
    batch_xs, batch_ys = mnist.train.next_batch(100)
    train_step.run({x: batch_xs, y_: batch_ys})
# Test trained model
correct_prediction = tf.equal(tf.argmax(input=y, axis=1),
                              tf.argmax(input=y_, axis=1))
accuracy = tf.reduce_mean(input_tensor=tf.cast(correct_prediction, tf.float32))
print(accuracy.eval({x: mnist.test.images, y_: mnist.test.labels}))