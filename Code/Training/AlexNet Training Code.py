#!/usr/bin/env python
# coding: utf-8

# 
# Transfer Learning
# ==========================

# In[1]:


import torch
import torch.nn as nn
import torch.optim as optim
from torch.optim import lr_scheduler
import numpy as np
from torchvision import datasets, models, transforms
import matplotlib.pyplot as plt
import time
import os
import copy

torch.cuda.empty_cache()
torch.manual_seed(0)     # for reproducibility


# Load Data
# ---------
# 
# We will use torchvision and torch.utils.data packages for loading the
# data.
# 

# In[2]:


# Data augmentation and normalization for training
# Just normalization for validation
data_transforms = {
    'train': transforms.Compose([
        transforms.Resize([224, 224]),
        transforms.ToTensor()
    ]),
    'val': transforms.Compose([
        transforms.Resize([224, 224]),
        transforms.ToTensor()
    ])
}

data_dir = 'D:\\data (augmented, 4 classes, tif)'
image_datasets = {x: datasets.ImageFolder(os.path.join(data_dir, x),
                                          data_transforms[x])
                  for x in ['train', 'val']}

batch_size = 128      # Need it as a global variable for computing average loss/accuracy per iteration
dataloaders = {x: torch.utils.data.DataLoader(image_datasets[x], batch_size=batch_size,
                                             shuffle=True, num_workers=4)
              for x in ['train', 'val']}
dataset_sizes = {x: len(image_datasets[x]) for x in ['train', 'val']}
class_names = image_datasets['train'].classes

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")


# Training the model
# ------------------
# 
# Now, let's write a general function to train a model. Here, we will
# illustrate:
# 
# -  Scheduling the learning rate
# -  Saving the best model
# 
# In the following, parameter ``scheduler`` is an LR scheduler object from
# ``torch.optim.lr_scheduler``.
# 
# 

# In[3]:


def train_model(model, criterion, optimizer, scheduler, num_epochs=25):
    since = time.time()

    best_model_wts = copy.deepcopy(model.state_dict())
    best_acc = 0.0
    
    epoch_numbers = []
    epoch_train_accuracies = []
    epoch_train_losses = []
    epoch_val_accuracies = []
    epoch_val_losses = []

    for epoch in range(num_epochs):
        epoch_numbers.append(epoch)             # for plotting
        print('Epoch {}/{}'.format(epoch, num_epochs - 1))
        print('-' * 10)

        # Each epoch has a training and validation phase
        for phase in ['train', 'val']:
            if phase == 'train':
                if scheduler != "":
                    scheduler.step()
                model.train()  # Set model to training mode
            else:
                model.eval()   # Set model to evaluate mode

            running_loss = 0.0
            running_corrects = 0

            # Iterate over data.
            for inputs, labels in dataloaders[phase]:      # The labels will correspond to the alphabetical order of the class names (https://discuss.pytorch.org/t/how-to-get-the-class-names-to-class-label-mapping/470).
                inputs = inputs.to(device)
                labels = labels.to(device)

                # zero the parameter gradients
                optimizer.zero_grad()

                # forward
                # track history if only in train
                with torch.set_grad_enabled(phase == 'train'):
                    outputs = model(inputs)
                    _, preds = torch.max(outputs, 1)
                    loss = criterion(outputs, labels)

                    # backward + optimize only if in training phase
                    if phase == 'train':
                        loss.backward()
                        optimizer.step()

                # statistics
                running_loss += loss.item() * inputs.size(0)
                running_corrects += torch.sum(preds == labels.data)

            epoch_loss = running_loss/dataset_sizes[phase]
            epoch_acc = running_corrects.double()/dataset_sizes[phase]
        
            print('{} Loss: {:.4f} Acc: {:.4f}'.format(
                phase, epoch_loss, epoch_acc))
            
            # For plotting
            if phase == 'train':
                epoch_train_accuracies.append(epoch_acc)
                epoch_train_losses.append(epoch_loss)
            else:
                epoch_val_accuracies.append(epoch_acc)
                epoch_val_losses.append(epoch_loss)
            
            # deep copy the model
            if phase == 'val' and epoch_acc > best_acc:
                best_acc = epoch_acc
                best_model_wts = copy.deepcopy(model.state_dict())

        print()

    # Plotting
    
    plt.title("Training Curve (Loss)")
    plt.plot(epoch_numbers, epoch_train_losses, label="Train")
    plt.plot(epoch_numbers, epoch_val_losses, label="Validation")
    plt.xlabel("Epochs")
    plt.ylabel("Loss")
    plt.legend(loc='best')
    plt.show()

    plt.title("Training Curve (Accuracy)")
    plt.plot(epoch_numbers, epoch_train_accuracies, label="Train")
    plt.plot(epoch_numbers, epoch_val_accuracies, label="Validation")
    plt.xlabel("Epochs")
    plt.ylabel("Accuracy")
    plt.legend(loc='best')
    plt.show()

    time_elapsed = time.time() - since
    print('Training complete in {:.0f}m {:.0f}s'.format(
        time_elapsed // 60, time_elapsed % 60))
    print('Best val Acc: {:4f}'.format(best_acc))
    
    # load best model weights
    model.load_state_dict(best_model_wts)
    return model


# Finetuning the convnet
# ----------------------
# 
# Load a pretrained model and reset final fully connected layer.
# 
# 
# 

# In[4]:


model_ft = models.alexnet(pretrained=True)
model_ft.classifier[6] = nn.Linear(4096, len(class_names))
model_ft.classifier.add_module("7", nn.Dropout())             # Comment this out if the AlexNet model did not include the last dropout layer.

model_ft = model_ft.to(device)

criterion = nn.CrossEntropyLoss()

# All the parameters are being optimized.
optimizer_ft = optim.SGD(model_ft.parameters(), lr=0.001, momentum=0.9)


# Train and evaluate
# 
# 

# In[ ]:


model_ft = train_model(model_ft, criterion, optimizer_ft, scheduler="",
                       num_epochs=30)


# In[ ]:


# Display the time and date when this is run (to use for saving the model).
dt = time.strftime("%Y%m%d-%H%M%S")
dt


# In[ ]:


# Save best model to disk for later (inference/testing)!
torch.save(model_ft.state_dict(), 'D:\\Models\\' + 'model_' + dt + '.pth')


# In[ ]:


# Play sound when code finishes.

import winsound
duration = 1500  # milliseconds
freq = 440  # Hz
winsound.Beep(freq, duration)

