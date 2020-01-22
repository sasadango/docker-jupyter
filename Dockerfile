FROM jupyter/datascience-notebook:7a0c7325e470

# requirements.txtに指定したパッケージをインストール
COPY requirements.txt ${PWD}
RUN pip install -r requirements.txt

RUN jupyter serverextension enable --py jupyterlab
WORKDIR /home/jovyan/work