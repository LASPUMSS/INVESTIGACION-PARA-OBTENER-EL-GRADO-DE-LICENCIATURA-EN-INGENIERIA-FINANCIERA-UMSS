import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

x_train = np.array(r.data["x"])
y_train = np.array(r.data["y"])


model = tf.keras.Sequential([
    tf.keras.layers.Dense(50, activation='relu', input_shape=(1,)),
    tf.keras.layers.Dense(100, activation='relu'),
    tf.keras.layers.Dense(100, activation='relu'),
    tf.keras.layers.Dense(50, activation='relu'),
    tf.keras.layers.Dense(1)
    ])

optimizer = tf.keras.optimizers.RMSprop(0.001)

model.compile(loss='mse',optimizer=optimizer,metrics=['mae', 'mse'])

model.fit(x_train, y_train, epochs=1000)

y_predic = model.predict(x_train)

plt.clf()
plt.plot(x_train, y_train, label ='y')
plt.plot(x_train, y_predic, '-.', label ='y_predic')

plt.xlabel("X")
plt.ylabel("Y")
plt.legend()
plt.title('Datos No Lineales')
plt.show()

