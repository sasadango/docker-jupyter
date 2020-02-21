# docker-jupyter

# Feature
jupyter lab


# Usage
## コンテナを起動
```
docker-compose up --build
```
`http://127.0.0.1:8888/?token=hogehuga` と表示される  
ブラウザでアクセスして、トークンを入力するとnotebook展開される

```
docker exec --rm -it -v `pwd`:/home/jovyan/work -p 10000:8888 --name jupyter
```
- -v : ホストにあるファイルをコンテナ内にマウント {ホストのパス}:{コンテナのパス}
- -p : ポートフォワード設定 {外部からアクセスするポート}:{コンテナ側のポート}

## パスワードの設定
JupyterLab上で以下を実行する
```
from IPython.lib import passwd
passwd()
```
任意のパスワードを入力すると `SHA1` 文字列が得られる  
この文字列を `.env` に定義し `docker-compose.yml` に渡してあげることでパスワードによるアクセスが可能になる  
```
# docker-compsose.yml

version: "3"

services:
    jupyterlab:
        container_name: "jupyter_lab"
        build:
            context: .
            dockerfile: ./Dockerfile
        ports:
            - "10000:8888"
        volumes:
            - "./work:/home/jovyan/work"
        environment: 
            NB_UID: 501
            GRANT_SUDO: "yes"
        command: start.sh jupyter lab --NotebookApp.password=${NOTEBOOK_PASS}
        tty: true
```
```
# .env
NOTEBOOK_PASS='sha1:hogehuga......'
```
最後にコンテナを再起動
```
docker-compose up -d
```


## コンテナへアクセス (パスワードの設定後)
```
docker-jupyter % docker exec -it jupyter_lab bash
```

`docker-compose.yml` にて `work` ディレクトリを作成しているので、任意のソースやデータを配置して使用する


# Note
[Dockerを使って5分でJupyter環境を構築する](https://qiita.com/fuku_tech/items/6752b00770552bf4f46b)

[Dockerで基本的なData Science環境(Jupyter, Python, R, Julia, 定番ライブラリ)を構築する。](https://qiita.com/y4m3/items/c2703d4e131e05084b7b)

[サーバーのDockerで起動したJupyter Notebookを他のパソコンからアクセスできるようにした話](https://qiita.com/yamasakih/items/d23ac0bf773e9b1b4d9d)

[数学科が独学でDockerの理解度チェックとしてJupyterLabの環境構築](https://qiita.com/kiwamizamurai/items/1cf2bcae7df2cd396767)

[DockerでJupyterLabを構築する](https://qiita.com/muk-ai/items/a147cfd2cafc57420b15)
