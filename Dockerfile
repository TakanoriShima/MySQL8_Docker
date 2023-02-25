FROM mysql:8.0.14

# 基本設定
RUN apt-get update && \
    apt-get install -y locales && \
    rm -rf /var/lib/apt/lists/* && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    su
ENV LC_ALL ja_JP.UTF-8

# viのインストール
RUN apt-get update && \
    apt -y install vim

# 日本時間（JST）の設定
RUN DEBIAN_FRONTEND=noninteractive apt -y install tzdata
RUN echo 'Asia/Tokyo' > /etc/timezone
ENV TZ Asia/Tokyo

USER root
WORKDIR /root/environment

# MySQL 日本語化
RUN { \
    echo '[mysqld]'; \
    echo 'character-set-server=utf8mb4'; \
    echo 'collation-server=utf8mb4_general_ci'; \
    echo '[client]'; \
    echo 'default-character-set=utf8mb4'; \
} > /etc/mysql/conf.d/charset.cnf