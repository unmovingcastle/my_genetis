import matplotlib.pyplot as plt
import numpy as np

x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
y = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

new_x = [i * SCALE for i in x]




plt.plot(new_x, y)

plt.show()

plt.savefig('test_plot1')
