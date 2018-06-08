#!/usr/bin/env bash

python -c "import tensorflow as tf;tf.Session()"

date

echo "Copy the pretrained weights from the network mount"
mkdir -p experiments/1
cp /mnt/synology/cxr/temp/erdi/CheXNet-weights/weights.h5 experiments/1/best_weights.h5

ls ./data/images/* || \
( echo "copying the data files" && \
  cp -R /mnt/synology/cxr/temp/erdi/ChestXray14 data/images && \
  echo "copied the data files" || \
  ( echo "error copying files, sleeping for 5 mins and returning 1" && sleep 300 && return 1 ) \
)

date

echo "finding the number of copied png files"
echo "ls ./data/*png | wc -l"
ls ./data/ | grep png | wc -l

date
echo "starting training script"

python3.6 train.py
python3.6 test.py
python3.6 cam.py