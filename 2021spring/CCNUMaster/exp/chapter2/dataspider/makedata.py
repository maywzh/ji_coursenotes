'''
Author       : maywzh
Date         : 2021-04-01 19:11:05
LastEditTime : 2021-04-01 20:14:22
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter2/dataspider/makedata.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import pandas as pd
import os
import re
import nlpcda as nc
from sklearn.preprocessing import MultiLabelBinarizer


def readcate_labels(filename):
    data = pd.read_csv(filename)
    return data


cl = readcate_labels("./data/labels.csv")


def txtpreprocess(txt):
    return re.sub(r'[^\u4e00-\u9fa5]', '', txt).replace("答案解析", "")


def readexercisefiles(path):
    df = pd.DataFrame(columns=["exercise_text", 'labels'])
    for i in range(1373, 1394):
        predf_labels = cl.iloc[i-1373][1]
        print(predf_labels)
        fn = path + str(i)
        if os.path.exists(fn):
            with open(fn) as f:
                ls = f.readlines()
                for l in ls:
                    df = df.append({"exercise_text": txtpreprocess(
                        l), "labels": predf_labels}, ignore_index=True)
    return df


tl = readexercisefiles("./data/senior_Math")
mlb = MultiLabelBinarizer()
mlb_result = mlb.fit_transform(
    [str(tl.loc[i, 'labels']).split('/') for i in range(len(tl))])
df_final = pd.concat([tl['exercise_text'], pd.DataFrame(
    mlb_result, columns=list(mlb.classes_))], axis=1)

df_final.to_csv("./data/candidate_exercises.csv", index=False)
