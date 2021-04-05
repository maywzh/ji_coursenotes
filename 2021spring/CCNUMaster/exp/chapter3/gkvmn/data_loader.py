from os import path

import pandas as pd
import numpy as np
from sklearn.model_selection import KFold
import math
import pickle
from tqdm import tqdm


class DATA(object):
    def __init__(self, n_question, seqlen, separate_char, name="data"):
        # In the ASSISTments2009 dataset:
        # param: n_queation = 110
        #        seqlen = 200
        self.separate_char = separate_char
        self.n_question = n_question
        """
        self.seqlen = seqlen+1
        """
        self.seqlen = seqlen

    # data format
    # 15
    # 1,1,1,1,7,7,9,10,10,10,10,11,11,45,54
    # 0,1,1,1,1,1,0,0,1,1,1,1,1,0,0
    def load_data(self, path):
        f_data = open(path, 'r')
        q_data = []
        qa_data = []
        for lineID, line in enumerate(f_data):
            line = line.strip()
            # lineID starts from 0
            if lineID % 3 == 1:
                Q = line.split(self.separate_char)
                if len(Q[len(Q)-1]) == 0:
                    Q = Q[:-1]
                # print(len(Q))
            elif lineID % 3 == 2:
                A = line.split(self.separate_char)
                if len(A[len(A)-1]) == 0:
                    A = A[:-1]
                # print(len(A),A)

                # start split the data
                n_split = 1
                # print('len(Q):',len(Q))
                if len(Q) > self.seqlen:
                    n_split = math.floor(len(Q) / self.seqlen)
                    if len(Q) % self.seqlen:
                        n_split = n_split + 1
                # print('n_split:',n_split)
                for k in range(n_split):
                    question_sequence = []
                    answer_sequence = []
                    if k == n_split - 1:
                        endINdex = len(A)
                    else:
                        endINdex = (k+1) * self.seqlen
                    for i in range(k * self.seqlen, endINdex):
                        if len(Q[i]) > 0:
                            # int(A[i]) is in {0,1}
                            Xindex = int(Q[i]) + int(A[i]) * self.n_question
                            question_sequence.append(int(Q[i]))
                            answer_sequence.append(Xindex)
                        else:
                            print(Q[i])
                    #print('instance:-->', len(instance),instance)
                    q_data.append(question_sequence)
                    qa_data.append(answer_sequence)
        f_data.close()
        ### data: [[],[],[],...] <-- set_max_seqlen is used
        # convert data into ndarrays for better speed during training
        q_dataArray = np.zeros((len(q_data), self.seqlen))
        for j in range(len(q_data)):
            dat = q_data[j]
            q_dataArray[j, :len(dat)] = dat

        qa_dataArray = np.zeros((len(qa_data), self.seqlen))
        for j in range(len(qa_data)):
            dat = qa_data[j]
            qa_dataArray[j, :len(dat)] = dat
        # dataArray: [ array([[],[],..])] Shape: (3633, 200)
        return q_dataArray, qa_dataArray


class DATA_RAW(object):
    def __init__(self, n_question, seqlen, separate_char, name="data"):
        # In the ASSISTments2009 dataset:
        # param: n_queation = 110
        #        seqlen = 200
        self.separate_char = separate_char
        self.n_question = n_question
        """
        self.seqlen = seqlen+1
        """
        self.seqlen = seqlen

    def max_len_adjust(self, students, num_steps):
        '''
        将超过num_steps长度的做题序列分割为数段

        students:  np.array([List_s1[[],[],[]],List_s2[[][][]]],...,List_s3[[][]]])
        num_steps: 最大序列长度
        '''
        students_expand = []
        for s in students:
            # 将超过长度的做题序列分割
            if len(s) > num_steps:
                segs = int(np.ceil(len(s) / num_steps))
                for seg in range(segs):
                    new_s = s[seg * num_steps: (seg + 1) * num_steps]
                    students_expand.append(new_s)
            else:
                students_expand.append(s)
        return students_expand

    def get_q_qa(self, students, all_skills, num_skills):
        '''
        获取 q 和 qa 关系

        students:  np.array([List_s1[[skill_id],[correct],[user_id]],List_s2[[][][]]],...,List_s3[[][]]])
        all_skills: List of skill id
        num_skills: len(all_skills) + 1
        '''
        all_qa = []
        all_q = []

        for s in students:
            qs = []
            qas = []
            for attempt in s:
                # 找出skill_id在all_skills数组中的位置
                q = all_skills.index(int(attempt[0])) + 1
                # 找出答对+位置 未答对不加
                qa = q + num_skills * int(attempt[1])
                qs.append(q)
                qas.append(qa)
            all_q.append(qs)
            all_qa.append(qas)

        # convert data into ndarrays for better speed during training
        q_dataArray = np.zeros((len(all_q), self.seqlen))
        for j in range(len(all_q)):
            dat = all_q[j]
            q_dataArray[j, :len(dat)] = dat

        qa_dataArray = np.zeros((len(all_qa), self.seqlen))
        for j in range(len(all_qa)):
            dat = all_qa[j]
            qa_dataArray[j, :len(dat)] = dat
        # dataArray: [ array([[],[],..])] Shape: (3633, 200)

        return q_dataArray, qa_dataArray

    def get_q_qa_with_bh(self, students, all_skills, num_skills):
        '''
        获取 q 和 qa 关系 包含行为信息

        students:  np.array([List_s1[[skill_id],[correct],[user_id]],List_s2[[][][]]],...,List_s3[[][]]])
        all_skills: List of skill id
        num_skills: len(all_skills) + 1
        '''
        all_qa = []
        all_q = []
        all_bh1 = []
        all_bh2 = []
        all_bh3 = []
        for s in students:
            qs = []
            qas = []
            bh1s, bh2s, bh3s = [], [], []
            for attempt in s:
                # 找出skill_id在all_skills数组中的位置
                q = all_skills.index(int(attempt[0])) + 1
                # 找出答对+位置 未答对不加
                qa = q + num_skills * int(attempt[1])
                bh1 = int(attempt[3])
                bh2 = int(attempt[4])
                bh3 = int(attempt[5])
                qs.append(q)
                qas.append(qa)
                bh1s.append(bh1)
                bh2s.append(bh2)
                bh3s.append(bh3)
            all_q.append(qs)
            all_qa.append(qas)
            all_bh1.append(bh1s)
            all_bh2.append(bh2s)
            all_bh3.append(bh3s)
        # convert data into ndarrays for better speed during training
        q_dataArray = np.zeros((len(all_q), self.seqlen))
        for j in range(len(all_q)):
            dat = all_q[j]
            q_dataArray[j, :len(dat)] = dat

        qa_dataArray = np.zeros((len(all_qa), self.seqlen))
        for j in range(len(all_qa)):
            dat = all_qa[j]
            qa_dataArray[j, :len(dat)] = dat
        # dataArray: [ array([[],[],..])] Shape: (3633, 200)
        bh1_dataArray = np.zeros((len(all_bh1), self.seqlen))
        for j in range(len(all_bh1)):
            dat = all_bh1[j]
            bh1_dataArray[j, :len(dat)] = dat
        bh2_dataArray = np.zeros((len(all_bh2), self.seqlen))
        for j in range(len(all_bh2)):
            dat = all_bh2[j]
            bh2_dataArray[j, :len(dat)] = dat
        bh3_dataArray = np.zeros((len(all_bh3), self.seqlen))
        for j in range(len(all_bh3)):
            dat = all_bh3[j]
            bh3_dataArray[j, :len(dat)] = dat
        return q_dataArray, qa_dataArray, bh1_dataArray, bh2_dataArray, bh3_dataArray

    def get_processed_data(self, file_name):
        '''
        获取专用于kt的序列
        '''
        all_students, all_skills, num_steps = self.load_raw_data(file_name)
        num_skills = len(all_skills) + 1
        kf = KFold(n_splits=5, shuffle=True, random_state=3)
        num_steps = 200
        all_data = []

        for train_indexes, test_indexes in kf.split(all_students):

            train_students = all_students[train_indexes].tolist()
            test_students = all_students[test_indexes].tolist()

            # Truncated BPTT
            train_students = self.max_len_adjust(train_students, num_steps)
            test_students = self.max_len_adjust(test_students, num_steps)

            train_q, train_qa = self.get_q_qa(
                train_students, all_skills, num_skills)
            test_q, test_qa = self.get_q_qa(
                test_students, all_skills, num_skills)

            all_data.append((train_q, train_qa, test_q, test_qa))

        return all_data

    def get_processed_data_with_bh(self, file_name):
        '''
        获取专用于kt的序列
        '''
        all_students, all_skills, num_steps = self.load_raw_data(file_name)
        num_skills = len(all_skills) + 1
        kf = KFold(n_splits=5, shuffle=True, random_state=3)
        num_steps = 200
        all_data = []
        with open("assist2009_fixed_bh.csv") as f:

            pass
        for train_indexes, test_indexes in kf.split(all_students):

            train_students = all_students[train_indexes].tolist()
            test_students = all_students[test_indexes].tolist()

            # Truncated BPTT
            train_students = self.max_len_adjust(train_students, num_steps)
            test_students = self.max_len_adjust(test_students, num_steps)

            train_q, train_qa, train_bh1, train_bh2, train_bh3 = self.get_q_qa_with_bh(
                train_students, all_skills, num_skills)
            test_q, test_qa, test_bh1, test_bh2, test_bh3 = self.get_q_qa_with_bh(
                test_students, all_skills, num_skills)

            all_data.append((train_q, train_qa, train_bh1, train_bh2,
                             train_bh3, test_q, test_qa, test_bh1, test_bh2, test_bh3))

        return all_data

    def load_raw_data(self, file_name):
        '''
        获取原始数据

        '''
        pickle_data = {}
        students = {}
        students_list = []
        skills = []
        users_id = []
        max_steps = -1
        min_steps = float('inf')
        features = ['assignment_id', 'assistment_id', 'problem_id', 'user_id', 'original', 'correct', 'attempt_count',
                    'ms_first_response',
                    'skill_id', 'hint_count', 'hint_total', 'first_action', 'bottom_hint']

        selected_features = ['skill_id', 'correct',
                             'user_id', 'ms_first_response', 'attempt_count', 'hint_count']
        if not path.exists('students.pickle'):
            print('Pickle file not found, creating one...')
            all_data = pd.read_csv(file_name, encoding='ISO-8859-1')
            filtered_data = all_data.dropna(
                axis=0, how='any', subset=selected_features)[features]
            filtered_data = filtered_data[filtered_data['ms_first_response'] > 0]
            filtered_data = filtered_data.fillna(-1)

            for index, row in tqdm(filtered_data.iterrows()):
                if row['skill_id'] == -1:
                    continue
                if row['skill_id'] not in skills:
                    skills.append(int(row['skill_id']))
                if row['user_id'] not in users_id:
                    users_id.append(int(row['user_id']))
                if row['user_id'] in students:
                    students[row['user_id']].append(
                        row[selected_features].values.tolist())
                else:
                    students[row['user_id']] = [
                        row[selected_features].values.tolist()]

            # for user_id in users_id:
            #     students[user_id] = sorted(students[user_id], key=cmp_to_key(custom_sort), reverse=True)
            pickle_data['students'] = students
            pickle_data['skills'] = skills
            pickle_data['users_id'] = users_id
            pickling_on = open("students.pickle", "wb")
            pickle.dump(pickle_data, pickling_on)
            pickling_on.close()
        else:
            print('Load data from pickle file...')
            pickle_off = open("students.pickle", "rb")
            pickle_data = pickle.load(pickle_off)
            students = pickle_data['students']
            skills = pickle_data['skills']
            users_id = pickle_data['users_id']

        for user_id in users_id:
            user_log = students[user_id]
            len_user_log = len(user_log)
            if len_user_log > max_steps:
                max_steps = len_user_log
            if len_user_log < min_steps:
                min_steps = len_user_log
            if len_user_log <= 2:
                del students[user_id]
            else:
                students_list.append(user_log)

        print('Max step:', max_steps)
        print('Num of skills:', len(skills))
        print('Num of students:', len(users_id))
        # np.array([List_s1[[],[],[]],List_s2[[][][]]],...,List_s3[[][]]])
        return np.array(students_list), skills, max_steps
