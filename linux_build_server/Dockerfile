# ベースイメージとしてAmazon Linuxを使用
FROM amazonlinux:latest

# 必要なパッケージ
RUN yum update -y && \
    yum install -y openssh-server git docker && \
    yum clean all

# docker-compose導入
RUN curl -L "https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# 動作検証に必要なパッケージ
RUN yum install -y sudo tar vi procps net-tools iproute && \
    yum clean all

# Java ビルド用
RUN yum install -y java-17-amazon-corretto-devel maven && \
    yum clean all

# rootユーザー用のjenkins SSH公開キーを登録
COPY jenkins_rsa.pub /root/.ssh/
RUN mv /root/.ssh/jenkins_rsa.pub /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/authorized_keys

# SSHD 設定
# RUN update-crypto-policies --set LEGACY
RUN ssh-keygen -A && \
    sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config && \
    sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/" /etc/ssh/sshd_config


# ビルドスクリプト
RUN mkdir -p /root/work
COPY scripts/checkout.sh /root/work
COPY scripts/build.sh /root/work
RUN chmod 755 /root/work/checkout.sh /root/work/build.sh


# SSH用のポートを公開
EXPOSE 22

# SSHサーバーを起動するコマンドを設定
CMD ["/usr/sbin/sshd", "-D"]