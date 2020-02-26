FROM jupyter/datascience-notebook:7a0c7325e470

# requirements.txtに指定したパッケージをインストール
COPY requirements.txt ${PWD}

USER root
RUN set -x \
    && apt-get update \
    && apt-get install -y vim --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER jovyan

RUN set -x \
    && pip install -r requirements.txt \
    && jupyter serverextension enable --py jupyterlab
WORKDIR /home/jovyan/work