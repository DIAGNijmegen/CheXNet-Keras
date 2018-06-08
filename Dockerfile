### start from tensorflow:1.5.0-gpu and install python 3.6 and other requirements. ###
### ### tensorflow:1.5.0-gpu-py3 comes with python 3.5 and that does not fit the project requirements ###
FROM tensorflow/tensorflow:1.5.0-gpu

### install python 3.6 ###
RUN add-apt-repository ppa:deadsnakes/ppa \
&& apt-get update -qq \
&& apt-get install --no-install-recommends -y\
    python3.6 \
    wget \
    libsm6 \
    libxext6 \
    libxrender-dev

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.6 get-pip.py

### copy project files ###
RUN mkdir -p models data/default_split/

COPY *.py *.ini *.sh *.txt ./
COPY data/default_split/* data/default_split/
COPY models/* models/

### install project requirements ###
RUN python3.6 -m pip install -r requirements.txt

### copy data files and run training script ###
ENTRYPOINT bash ./entrypoint.sh