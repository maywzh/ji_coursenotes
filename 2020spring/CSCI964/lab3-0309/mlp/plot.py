import numpy as np
import matplotlib.pyplot as plt
from matplotlib import animation

fig, ax = plt.subplots()

x = np.arange(0, 10, 0.1)
line, = ax.plot(x, np.sin(x))


def animat(i):
    line.set_ydata(np.sin(x + i / 100))
    return line,


def initial():
    line.set_ydata(np.cos(x))
    return line,


ani = animation.FuncAnimation(fig=fig, func=animat, frames=100, init_func=initial, interval=20, blit=False)

plt.show()