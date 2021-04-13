'''
Author       : maywzh
Date         : 2021-04-02 03:39:49
LastEditTime : 2021-04-12 23:53:31
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter2/GCN.PyTorch-master/train.py
License      : 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import argparse
import os
import torch
from datasets import load_data
from models.gcn import GCN
from models.utils import build_optimizer, get_loss, get_accuracy
from tensorboardX import SummaryWriter


parser = argparse.ArgumentParser()
parser.add_argument('--dataset', type=str,
                    default='citeseer', help='Dataset to train')
parser.add_argument('--init_lr', type=float, default=0.01,
                    help='Initial learing rate')
parser.add_argument('--epoches', type=int, default=200,
                    help='Number of traing epoches')
parser.add_argument('--hidden_dim', type=list, default=16,
                    help='Dimensions of hidden layers')
parser.add_argument('--dropout', type=float, default=0.5,
                    help='Dropout rate (1 - keep  probability)')
parser.add_argument('--weight_decay', type=float, default=5e-4,
                    help='Weight for l2 loss on embedding matrix')
parser.add_argument('--log_interval', type=int,
                    default=10, help='Print iterval')
parser.add_argument('--log_dir', type=str, default='experiments',
                    help='Train/val loss and accuracy logs')
parser.add_argument('--checkpoint_interval', type=int,
                    default=20, help='Checkpoint saved interval')
parser.add_argument('--checkpoint_dir', type=str,
                    default='checkpoints', help='Directory to save checkpoints')
args = parser.parse_args()


adj, features, y_train, y_val, y_test, train_mask, val_mask, test_mask = load_data(
    args.dataset)
model = GCN(features.shape[1], args.hidden_dim, y_train.shape[1], args.dropout)
optimizer = build_optimizer(model, args.init_lr, args.weight_decay)


def train():
    log_dir = os.path.join(args.log_dir, args.dataset)
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)
    writer = SummaryWriter(log_dir)
    saved_checkpoint_dir = os.path.join(args.checkpoint_dir, args.dataset)
    if not os.path.exists(saved_checkpoint_dir):
        os.makedirs(saved_checkpoint_dir)
    for epoch in range(args.epoches + 1):
        outputs = model(adj, features)
        loss = get_loss(outputs, y_train, train_mask)
        val_loss = get_loss(outputs, y_val, val_mask).detach().numpy()
        model.eval()
        outputs = model(adj, features)
        train_accuracy = get_accuracy(outputs, y_train, train_mask)
        val_accuracy = get_accuracy(outputs, y_val, val_mask)
        model.train()
        writer.add_scalars(
            'loss', {'train_loss': loss.detach().numpy(), 'val_loss': val_loss}, epoch)
        writer.add_scalars(
            'accuracy', {'train_ac': train_accuracy, 'val_ac': val_accuracy}, epoch)
        if epoch % args.log_interval == 0:
            print("Epoch: %d, train loss: %f, val loss: %f, train ac: %f, val ac: %f"
                  % (epoch, loss.detach().numpy(), val_loss, train_accuracy, val_accuracy))
        if epoch % args.checkpoint_interval == 0:
            torch.save(model.state_dict(), os.path.join(
                saved_checkpoint_dir, "gcn_%d.pth" % epoch))
        optimizer.zero_grad()  # Important
        loss.backward()
        optimizer.step()
    writer.close()


if __name__ == '__main__':
    train()
