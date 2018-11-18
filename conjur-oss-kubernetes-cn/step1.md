## 1. 安装Helm和Cyber​​Ark Chart

Helm是一个单独的二进制文件，用于管理将图表部署到Kubernetes。 Chart是kubernetes软件的打包单元。可以从https://github.com/kubernetes/helm/releases下载

`curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.8.2-linux-amd64.tar.gz
tar -xvf helm-v2.8.2-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/`{{execute}}

安装后，初始化更新本地缓存以将最新可用软件包与环境同步。

`helm init`{{execute}}

追加 Cyber​​Ark Helm repo

`helm repo add cyberark https://cyberark.github.io/helm-charts
helm repo update`{{execute}}

## 2. 查看和检查 Cyber​​Ark Chart (optional)

查看所有 Cyber​​Ark Chart

`helm search -r 'cyberark/*'`{{execute}}

安装 Cyber​​Ark Chart

`helm inspect cyberark/conjur-oss`{{execute}}

## 3. 使用Helm安装Conjur

`helm install \
  --set dataKey="$(docker run --rm cyberark/conjur data-key generate)" \
  cyberark/conjur-oss`{{execute}}
