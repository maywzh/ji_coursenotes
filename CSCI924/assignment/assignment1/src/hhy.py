
from math import log
import operator

def readData(filepath):
    """
    Read Data from data.txt
    """
    datalist = []
    featurelist = []
    with open(filepath) as f:
        features = f.readline()
        featurelist = features.split()
        datalines = f.readlines()
        for dataline in datalines:
            datalist.append(dataline.split())
    return featurelist, datalist

def shanno(dataset):#计算香农商
    temp_l = len(dataset)
    labels = {}  # 定义字典存储标签
    for arrya_temp in dataset:
        temp_label = arrya_temp[-1]
        if temp_label not in labels:
            labels[temp_label] = 0
        labels[temp_label] += 1
    shanno_r = 0.0
    for key in labels:
        p = float(labels[key]) / temp_l
        shanno_r = -p * log(p, 2)
    return shanno_r


def sp_dataset(dataset, axis, value):#分割数据集
    dataset_r = []
    for arrya_temp in dataset:
        if arrya_temp[axis] == value:
            temp_set = arrya_temp[:axis]
            temp_set.extend(arrya_temp[axis + 1:])
            dataset_r.append(temp_set)
    return dataset_r


def choose(dataset):#选择分割
    num_f = len(dataset[0]) - 1
    base_shanno = shanno(dataset)
    best_gain = 0.0
    best_f = -1
    for i in range(num_f):
        feat_list = [example[i] for example in dataset]
        Val = set(feat_list)
        temp_ent = 0.0
        for value in Val:
            sub_dataset = sp_dataset(dataset, i, value)
            p = len(sub_dataset) / float(len(dataset))
            temp_ent  =temp_ent+ p * shanno(sub_dataset)
        info_gain = base_shanno - temp_ent
        if (info_gain > best_gain):
            best_gain = info_gain
            best_f = i
    return best_f


def m_cnt(class_list):
    class_count = {}
    for i in class_list:
        if i not in class_count.keys():
            class_count[i] = 0
        else:
            class_count[i] += 1
    sorted_classcount = sorted(class_count.iteritems(), key=operator.itemgetter(1), reverse=True)
    return sorted_classcount[0][0]


def create_tree(dataset, label):#建立 ID3决策树
    class_list = [example[-1] for example in dataset]
    if class_list.count(class_list[0]) == len(class_list):
        return '('+class_list[0]+')'
    if len(dataset[0]) == 1:
        return '('+m_cnt(class_list)+')'
    best_f = choose(dataset)
    best_f_l = label[best_f]
    rs=''
    tree = {best_f_l: {}}
    del (label[best_f])
    feat_values = [example[best_f] for example in dataset]
    unique_vals = set(feat_values)
    for value in unique_vals:
        rs_1='('+str(best_f_l)+' '+ str(value)
        sub_labels = label[:]  # copy all of labels, so trees don't mess up existing labels
        rs_1=rs_1+create_tree(sp_dataset(dataset,best_f,value),sub_labels)
        rs=rs+rs_1+')'
    return rs



def test():#测试函数 建立决策树。
    dataset, label = readData('data.txt')
    label2=label.copy()
    d=create_tree(dataset, label)  # Output decision tree model results
    attribute=[]
    for i in range(len(label2)):
        attribute.append([])
        for j in dataset:
            if j[i] not in attribute[i]:
                attribute[i].append(j[i])
    d='('+d+')'
    print(d)
test()