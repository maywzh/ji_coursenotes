# %%
from sko.operators import ranking, selection, crossover, mutation
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import math
from sko.GA import GA, GA_TSP


# %% step1: define your own operator:
def selection_tournament(algorithm, tourn_size):
    FitV = algorithm.FitV
    sel_index = []
    for i in range(algorithm.size_pop):
        aspirants_index = np.random.choice(range(algorithm.size_pop),
                                           size=tourn_size)
        sel_index.append(max(aspirants_index, key=lambda i: FitV[i]))
    algorithm.Chrom = algorithm.Chrom[sel_index, :]  # next generation
    return algorithm.Chrom


# %% step2: import package and build ga, as usual.

demo_func = lambda x: x[0] + 10 * math.sin(5 * x[0]) + 7 * math.cos(4 * x[0])

ga = GA(func=demo_func,
        n_dim=1,
        size_pop=100,
        max_iter=500,
        lb=[0],
        ub=[10],
        precision=[1e-7])

# %% step3: register your own operator
ga.register(operator_name='selection',
            operator=selection_tournament,
            tourn_size=3)
# %% Or import the operators scikit-opt already defined.

ga.register(operator_name='ranking', operator=ranking.ranking). \
    register(operator_name='crossover', operator=crossover.crossover_2point). \
    register(operator_name='mutation', operator=mutation.mutation)
# %% Run ga
best_x, best_y = ga.run()
Y_history = pd.DataFrame(ga.all_history_Y)
fig, ax = plt.subplots(2, 1)
ax[0].plot(Y_history.index, Y_history.values, '.', color='red')
Y_history.min(axis=1).cummin().plot(kind='line')
plt.show()

# %% show result
print('best_x:', best_x, '\n', 'best_y:', best_y)
