'''
Author       : maywzh
Date         : 2021-04-04 17:02:49
LastEditTime : 2021-04-04 17:07:06
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter3/Deep-Knowledge-Tracing-master/deepkt/metrics.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import tensorflow as tf

from deepkt import data_util


class BinaryAccuracy(tf.keras.metrics.BinaryAccuracy):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(BinaryAccuracy, self).update_state(y_true=true,
                                                 y_pred=pred,
                                                 sample_weight=sample_weight)


class AUC(tf.keras.metrics.AUC):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(AUC, self).update_state(y_true=true,
                                      y_pred=pred,
                                      sample_weight=sample_weight)


class Precision(tf.keras.metrics.Precision):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(Precision, self).update_state(y_true=true,
                                            y_pred=pred,
                                            sample_weight=sample_weight)


class Recall(tf.keras.metrics.Recall):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(Recall, self).update_state(y_true=true,
                                         y_pred=pred,
                                         sample_weight=sample_weight)


class SensitivityAtSpecificity(tf.keras.metrics.SensitivityAtSpecificity):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(SensitivityAtSpecificity, self).update_state(y_true=true,
                                                           y_pred=pred,
                                                           sample_weight=sample_weight)


class SpecificityAtSensitivity(tf.keras.metrics.SpecificityAtSensitivity):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(SpecificityAtSensitivity, self).update_state(y_true=true,
                                                           y_pred=pred,
                                                           sample_weight=sample_weight)


class FalseNegatives(tf.keras.metrics.FalseNegatives):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(FalseNegatives, self).update_state(y_true=true,
                                                 y_pred=pred,
                                                 sample_weight=sample_weight)


class FalsePositives(tf.keras.metrics.FalsePositives):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(FalsePositives, self).update_state(y_true=true,
                                                 y_pred=pred,
                                                 sample_weight=sample_weight)


class TrueNegatives(tf.keras.metrics.TrueNegatives):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(TrueNegatives, self).update_state(y_true=true,
                                                y_pred=pred,
                                                sample_weight=sample_weight)


class TruePositives(tf.keras.metrics.TruePositives):
    def update_state(self, y_true, y_pred, sample_weight=None):
        true, pred = data_util.get_target(y_true, y_pred)
        super(TrueNegatives, self).update_state(y_true=true,
                                                y_pred=pred,
                                                sample_weight=sample_weight)
