import csv
import random
import math
import numpy as np


def load_csv(filename):
    """

    :param filename: name of csv file
    :return: data set as a 2 dimensional list where each row in a list
    """
    lines = csv.reader(open(filename, 'r'))
    dataset = list(lines)
    for i in range(len(dataset)):
        dataset[i] = [float(x) for x in dataset[i]]
    return dataset


# data = load_csv('pima-indians-diabetes.data.csv')
# print(data)

def split_dataset(dataset, ratio):
    """
    split dataset into training and testing
    :param dataset: Two dimensional list
    :param ratio: Percentage of data to go into the training set
    :return: Training set and testing set
    """
    size_of_training_set = int(len(dataset) * ratio)
    train_set = []
    test_set = list(dataset)

    while len(train_set) < size_of_training_set:
        index = random.randrange(len(test_set))
        train_set.append(test_set.pop(index))

    return [train_set, test_set]


# training_set, testing_set = split_dataset(data, 0.67)
# print(training_set)
# print(testing_set)


def separate_by_label(dataset):
    """

    :param dataset: two dimensional list of data values
    :return: dictionary where labels are keys and
    values are the data points with that label
    """
    separated = {}
    for x in range(len(dataset)):
        row = dataset[x]
        if row[-1] not in separated:
            separated[row[-1]] = []
        separated[row[-1]].append(row)

    return separated


# separated = separate_by_label(data)
# print(separated)
# print(separated[1])
# print(separated[0])


def calc_mean(lst):
    return sum(lst) / float(len(lst))


def calc_standard_deviation(lst):
    avg = calc_mean(lst)
    variance = sum([pow(x - avg, 2) for x in lst]) / float(len(lst) - 1)

    return math.sqrt(variance)


# numbers = [1, 2, 3, 4, 5]
# print(calc_mean(numbers))
# print(calc_standard_deviation(numbers))


def summarize_data(lst):
    """
    Calculate the mean and standard deviation for each attribute
    :param lst: list
    :return: list with mean and standard deviation for each attribute
    """

    summaries = [(calc_mean(attribute), calc_standard_deviation(attribute)) for attribute in zip(*lst)]
    del summaries[-1]
    return summaries


# summarize_me = [[1, 20, 0], [2, 21, 1], [3, 22, 0]]
# print(summarize_data(summarize_me))


def summarize_by_label(data):
    """
    Method to summarize the attributes for each label

    :param data:
    :return: dict label: [(atr mean, atr stdv), (atr mean, atr stdv)....]
    """
    separated_data = separate_by_label(data)
    summaries = {}
    for label, instances in separated_data.items():
        summaries[label] = summarize_data(instances)
    return summaries

# fake_data = [[1, 20, 1], [2, 21, 0], [3, 22, 1], [4,22,0]]
# fake_summary = summarize_by_label(fake_data)


def calc_probability(x, mean, standard_deviation):
    """

    :param x: value
    :param mean: average
    :param standard_deviation: standard deviation
    :return: probability of that value given a normal distribution
    """
    # e ^ -(y - mean)^2 / (2 * (standard deviation)^2)
    exponent = math.exp(-(math.pow(x - mean, 2) / (2 * math.pow(standard_deviation, 2))))
    # ( 1 / sqrt(2π) ^ exponent
    return (1 / (math.sqrt(2 * math.pi) * standard_deviation)) * exponent


# x = 57
# mean = 50
# stand_dev = 5
# print(calc_probability(x, mean, stand_dev))


def calc_label_probabilities(summaries, input_vector):
    """
    the probability of a given data instance is calculated by multiplying together
    the attribute probabilities for each class. The result is a map of class values
    to probabilities.

    :param summaries:
    :param input_vector:
    :return: dict
    """
    probabilities = {}
    for label, label_summaries in summaries.items():
        probabilities[label] = 1
        for i in range(len(label_summaries)):
            mean, standard_dev = label_summaries[i]
            x = input_vector[i]
            probabilities[label] *= calc_probability(x, mean, standard_dev)

    return probabilities

# fake_input_vec = [1.1, 2.3]
# fake_probabilities = calc_label_probabilities(fake_summary, fake_input_vec)
# print(fake_probabilities)


def predict(summaries, input_vector):
    """
    Calculate the probability of a data instance belonging
    to each label. We look for the largest probability and return
    the associated class.
    :param summaries:
    :param input_vector:
    :return:
    """
    probabilities = calc_label_probabilities(summaries, input_vector)
    best_label, best_prob = None, -1
    for label, probability in probabilities.items():
        if best_label is None or probability > best_prob:
            best_prob = probability
            best_label = label

    return best_label

# summaries = {'A': [(1, 0.5)], 'B': [(20, 5.0)]}
# inputVector = 1.1
# print(predict(summaries, inputVector))


def get_predictions(summaries, test_set):
    """
     Make predictions for each data instance in our
     test dataset
    """

    predictions = []
    for i in range(len(test_set)):
        result = predict(summaries, test_set[i])
        predictions.append(result)

    return predictions

# summaries = {'A': [(1, 0.5)], 'B': [(20, 5.0)]}
# testSet = [1.1, 19.1]
# predictions = get_predictions(summaries, testSet)
# print(predictions)


def get_accuracy(test_set, predictions):
    """
    Compare predictions to class labels in the test dataset
    and get our classification accuracy
    """
    correct = 0
    for i in range(len(test_set)):
        if test_set[i][-1] == predictions[i]:
            correct += 1

    return (correct / float(len(test_set))) * 100


# fake_testSet = [[1, 1, 1, 'a'], [2, 2, 2, 'a'], [3, 3, 3, 'b']]
# fake_predictions = ['a', 'a', 'a']
# fake_accuracy = get_accuracy(fake_testSet, fake_predictions)
# print(fake_accuracy)

def main(filename, split_ratio):
    data = load_csv(filename)
    training_set, testing_set = split_dataset(data, split_ratio)
    print("Size of Training Set: ", len(training_set))
    print("Size of Testing Set: ", len(testing_set))

    # create model
    summaries = summarize_by_label(training_set)

    # test mode
    predictions = get_predictions(summaries, testing_set)
    accuracy = get_accuracy(testing_set, predictions)
    print('Accuracy: {0}%'.format(accuracy))


main('pima-indians-diabetes.data.csv', 0.90)

