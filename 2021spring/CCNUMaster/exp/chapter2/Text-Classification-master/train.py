'''
Author       : maywzh
Date         : 2021-04-07 16:33:00
LastEditTime : 2021-04-07 19:15:39
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter2/Text-Classification-master/train.py
symbol_custom_string_obkoro1: 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import torch
import torch.backends.cudnn as cudnn
import torch.optim as optim
import models
from training.trainer import Trainer
from datasets.dataloader import load_data
from utils import *
from utils.common import load_checkpoint
import utils.opts as opts
import torch.nn as nn


# set to true only if inputs to model are fixed size; otherwise lot of computational overhead
cudnn.benchmark = True
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")


def set_trainer(config):

    # load a checkpoint
    if config.checkpoint is not None:
        # load data
        train_loader = load_data(config, 'train', False)
        model, optimizer, word_map, start_epoch = load_checkpoint(
            config.checkpoint, device)
        print('\nLoaded checkpoint from epoch %d.\n' % (start_epoch - 1))

    # or initialize model
    else:
        start_epoch = 0

        # load data
        train_loader, embeddings, emb_size, word_map, n_classes, vocab_size = load_data(
            config, 'train', True)

        model = models.setup(
            config=config,
            n_classes=n_classes,
            vocab_size=vocab_size,
            embeddings=embeddings,
            emb_size=emb_size
        )

        optimizer = optim.Adam(
            params=filter(lambda p: p.requires_grad, model.parameters()),
            lr=config.lr
        )

    # loss functions
    loss_function = nn.CrossEntropyLoss()

    # move to device
    model = model.to(device)
    loss_function = loss_function.to(device)

    trainer = Trainer(
        num_epochs=config.num_epochs,
        start_epoch=start_epoch,
        train_loader=train_loader,
        model=model,
        model_name=config.model_name,
        loss_function=loss_function,
        optimizer=optimizer,
        lr_decay=config.lr_decay,
        dataset_name=config.dataset,
        word_map=word_map,
        grad_clip=config.grad_clip,
        print_freq=config.print_freq,
        checkpoint_path=config.checkpoint_path,
        checkpoint_basename=config.checkpoint_basename,
        tensorboard=config.tensorboard,
        log_dir=config.log_dir
    )

    return trainer


if __name__ == '__main__':

    config = opts.parse_opt()
    trainer = set_trainer(config)
    trainer.run_train()
