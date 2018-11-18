## 1. 通过运行这些命令获取应用程序URL:
  `export POD_NAME=$(kubectl get pods --namespace default -l "app=conjur-oss" -ojsonpath="{.items[0].metadata.name}")
  kubectl port-forward $POD_NAME 80:80 &
  sleep 3s
  echo "Press ENTER to continue..."
  `{{execute}}

访问 https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ 使用你在Kubernetes上的Conjur

## 2. 配置Conjur
  创建初始帐户作为“quickstart”并登录
  
  `export POD_NAME=$(kubectl get pods --namespace default -l "app=conjur-oss" -ojsonpath="{.items[0].metadata.name}")
  kubectl exec $POD_NAME conjurctl account create quickstart
  `{{execute}}

详细说明: https://www.conjur.org/get-started/install-conjur.html#install-and-configure

>请注意，conjurctl account create命令为您创建的帐户提供公钥和管理员API密钥。
>将它们备份在安全的位置。

## 3. 连接到Conjur

  `docker run --rm -it --entrypoint bash cyberark/conjur-cli:5`{{execute}}

## 4. 验证安装
  `conjur init -u [[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com -a quickstart`{{execute}}

  `conjur authn login -u admin`{{execute}}
  
  `conjur authn whoami`{{execute}}
  
退出Conjur CLI客户端：

`exit`{{execute}}

## 5. 安装完成！

恭喜！ Conjur已成功部署到Kubernetes！
