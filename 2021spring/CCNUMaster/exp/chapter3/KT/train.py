'''
Author       : maywzh
Date         : 2021-04-01 13:08:26
LastEditTime : 2021-04-11 20:33:15
LastEditors  : maywzh
Description  : 
FilePath     : /ji_coursenotes/2021spring/CCNUMaster/exp/chapter3/KT/train.py
License      : 
Copyright (c) 2017 maywzh.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'''
import config
from ltmti import LTMTI
from utmti import UTMTI
from saint import SAINT
from ssakt import SSAKT
from dataset import DKTDataset, get_dataloaders

import torch
from torch import nn
import pytorch_lightning as pl
from pytorch_lightning.callbacks import ModelCheckpoint


class SAKTModel(pl.LightningModule):
    def __init__(self, model_args, model="saint"):
        super().__init__()
        if model == "ltmti":
            self.model = LTMTI(**model_args)
        elif model == "utmti":
            self.model = UTMTI(**model_args)
        elif model == "ssakt":
            self.model = SSAKT(**model_args)
        elif model == "saint":
            self.model = SAINT(**model_args)

    def forward(self, exercise, category, response, etime):
        return self.model(exercise, category, response, etime)

    def configure_optimizers(self):
        return torch.optim.Adam(self.parameters(), lr=1e-3)

    def training_step(self, batch, batch_idx):
        inputs, target_ids, target = batch
        output = self(inputs["input_ids"], inputs["input_cat"],
                      target_ids, inputs["input_rtime"])
        target_mask = (target_ids != 0)
        output = torch.masked_select(output.squeeze(), target_mask)
        target = torch.masked_select(target, target_mask)
        loss = nn.BCEWithLogitsLoss()(output.float(), target.float())
        return {"loss": loss, "output": output, "target": target}

    def validation_step(self, batch, batch_idx):
        inputs, target_ids, target = batch
        output = self(inputs["input_ids"], inputs["input_cat"],
                      target_ids, inputs["input_rtime"])
        target_mask = (target_ids != 0)
        output = torch.masked_select(output.squeeze(), target_mask)
        target = torch.masked_select(target, target_mask)
        loss = nn.BCEWithLogitsLoss()(output.float(), target.float())
        return {"val_loss": loss, "output": output, "target": target}


train_loader, val_loader = get_dataloaders()

ARGS = {"n_dims": config.EMBED_DIMS,
        'n_encoder': config.NUM_ENCODER,
        'n_decoder': config.NUM_DECODER,
        'enc_heads': config.ENC_HEADS,
        'dec_heads': config.DEC_HEADS,
        'total_ex': config.TOTAL_EXE,
        'total_cat': config.TOTAL_CAT,
        'total_responses': config.TOTAL_EXE,
        'seq_len': config.MAX_SEQ}

########### TRAINING AND SAVING MODEL #######
checkpoint = ModelCheckpoint(filename="{epoch}_model",
                             verbose=True,
                             save_top_k=1,
                             monitor="val_loss")

sakt_model = SAKTModel(model="ltmti", model_args=ARGS)
trainer = pl.Trainer(progress_bar_refresh_rate=21,
                     max_epochs=1, callbacks=[checkpoint])
trainer.fit(model=sakt_model,
            train_dataloader=train_loader, val_dataloaders=val_loader)
trainer.save_checkpoint("model_sakt.pt")
