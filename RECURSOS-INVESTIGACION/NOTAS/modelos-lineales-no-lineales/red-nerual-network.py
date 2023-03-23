import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

x_train = np.array(r.dataTrain["x_train"])
y_train = np.array(r.dataTrain["y_train"])

x_test = np.array(r.dataTest["x_test"])
y_test = np.array(r.dataTest["y_test"])

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

y_adj = model.predict(x_train)
y_adj = y_adj.reshape(-1)
y_predict = model.predict(x_test)
y_predict = y_predict.reshape(-1)


# GRAFICO
plt.clf()
plt.plot(x_train, y_train, label ='Observaciones')
plt.plot(x_train, y_adj, '-', label ='Modelo Ajustado')
plt.plot(x_test, y_test, label ='Observaciones Nuevas')
plt.plot(x_test, y_predict, label ='Prediciones')

plt.xlabel("X")
plt.ylabel("Y")
plt.legend()
plt.title('Datos No Lineales - Redes Neuronales')
plt.show()

