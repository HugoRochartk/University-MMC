import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt


print("TF version: ", tf.__version__)
print(tf.executing_eagerly())



def fizzbuzz(limit):
    print("Is limit a tensor? %s" %tf.is_tensor(limit))
    if(not tf.is_tensor(limit)):
        limit = tf.convert_to_tensor(limit)
        print("Is it a tensor now? %s" %tf.is_tensor(limit))
    

    to_print = ""
    for i in tf.range(1, limit+1):
        if i.numpy() % 3 == 0 and i.numpy() % 5 != 0:
            to_print += "Fizz\n"
        elif i.numpy() % 3 != 0 and i.numpy() % 5 == 0:
            to_print += "Buzz\n"
        elif i.numpy() % 3 == 0 and i.numpy() % 5 == 0:
            to_print += "FizzBuzz\n"
        else:
            to_print += f"{i.numpy()}\n"
    

    print(to_print)



#fizzbuzz(15)


#EX 1
'''
a, b = tf.constant(5), tf.constant(7)
if a>b:
    print(a+b)
else:
    print(a-b)
'''
#EX2
'''
a, b = tf.random.uniform([],minval=1,maxval=1), tf.random.uniform([],minval=-1,maxval=1)
if a<b:
    print(a,b,a+b)
elif a>b:
    print(a,b,a-b)
else:
    print(a,b,0)
'''

#EX3

'''
a = tf.Variable([[1,2,0], [3,0,2]])
b = tf.zeros([2,3], dtype=tf.int32)

equal_tensor = tf.equal(a, b)

print(equal_tensor)
'''


#EX4
'''
a = tf.random.uniform([1,20], minval=1, maxval=11)

bools = a > 7
result = tf.boolean_mask(a, bools)

print(a, result)

'''



(x_train, y_train), (x_test, y_test) = tf.keras.datasets.mnist.load_data()





print('Train data shape ', x_train.shape)
print('Test data shape ', x_test.shape)
print('Number of training samples ', (x_train.shape)[0])
print('Number of testing samples ', (x_test.shape)[0])


#plotting some numbers!
for i in range(25):
    plt.subplot(5,5,i+1) #Add a subplot as 5 x 5
    plt.xticks([]) #get rid of labels
    plt.yticks([]) #get rid of labels
    plt.imshow(x_test[i], cmap="gray")

plt.show()

#reshape the input to have a list of 784 (28*28) and normalize it (/255)
x_train = x_train.reshape(x_train.shape[0], x_train.shape[1]*x_train.shape[2])
x_train = x_train.astype('float32')/255
x_test = x_test.reshape(x_test.shape[0], x_test.shape[1]*x_test.shape[2])
x_test = x_test.astype('float32')/255


#building a three-layer sequential model
model = tf.keras.Sequential([
 tf.keras.layers.Dense(64, activation='relu'),
 tf.keras.layers.Dense(128, activation='relu'), #nr de neuronios
 tf.keras.layers.Dense(10, activation='softmax')
])

#compiling the model
model.compile(optimizer='adam',
 loss='sparse_categorical_crossentropy',
 metrics=['accuracy'])


#training it
model.fit(x_train, y_train)

#evaluating it
_, test_acc = model.evaluate(x_test, y_test)
print('\nTest accuracy:', test_acc)
#finally, generating predictions (the output of the last layer)
print('\nGenerating predictions for the first fifteen samples...')
predictions = model.predict(x_test[0:15])
print('Predictions shape:', predictions.shape)

for i, prediction in enumerate(predictions):
    #tf.argmax returns the INDEX with the largest value across axes of a tensor
    predicted_value = tf.argmax(prediction)
    label = y_test[i]
    print('Predicted a %d. Real value is %d.' %(predicted_value, label))
