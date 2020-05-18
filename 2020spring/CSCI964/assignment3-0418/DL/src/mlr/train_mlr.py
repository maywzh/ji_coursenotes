import tensorflow as tf
import datetime
mnist = tf.keras.datasets.mnist

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

train_dataset = tf.data.Dataset.from_tensor_slices((x_train, y_train))
test_dataset = tf.data.Dataset.from_tensor_slices((x_test, y_test))

model = tf.keras.models.Sequential([
    tf.keras.layers.Flatten(input_shape=(28, 28)),
    tf.keras.layers.Dense(128, activation='relu'),
    tf.keras.layers.Dropout(0.2),
    tf.keras.layers.Dense(10)
])

#For each example the model returns a vector of "logits" or "log-odds" scores, one for each class.

predictions = model(x_train[:1]).numpy()

#The tf.nn.softmax function converts these logits to "probabilities" for each class:
tf.nn.softmax(predictions).numpy()

#The losses.SparseCategoricalCrossentropy loss takes a vector of logits and a True index and returns a scalar loss for each example.
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)

model.compile(optimizer='Adagrad', loss=loss_fn, metrics=['accuracy'])

#The Model.fit method adjusts the model parameters to minimize the loss:

log_dir = "./logs/fit" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir,
                                                      histogram_freq=1)

model.fit(x_train,
          y_train,
          epochs=5,
          batch_size=100,
          validation_data=(x_test, y_test),
          callbacks=[tensorboard_callback])

#The Model.evaluate method checks the models performance, usually on a "Validation-set" or "Test-set".
model.evaluate(x_test, y_test, verbose=2)
