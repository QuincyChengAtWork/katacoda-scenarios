

## 1. 配置Conjur
  創建初始帳戶作為“quickstart”並登錄
  
  `export POD_NAME=$(kubectl get pods --namespace default -l "app=conjur-oss" -ojsonpath="{.items[0].metadata.name}")
  kubectl exec $POD_NAME conjurctl account create quickstart
  `{{execute}}

詳細說明: https://www.conjur.org/get-started/install-conjur.html#install-and-configure

>請注意，conjurctl account create命令為您創建的帳戶提供公鑰和管理員API密鑰。
>將它們備份在安全的位置。

## 2. 連接到Conjur

  `docker run --rm -it --entrypoint bash cyberark/conjur-cli:5`{{execute}}

## 3. 驗證安裝
  `conjur init -u [[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com -a quickstart`{{execute}}

  `conjur authn login -u admin`{{execute}}
  
  `conjur authn whoami`{{execute}}
  
退出Conjur CLI客戶端：

`exit`{{execute}}

## 4. 安裝完成！

恭喜！ Conjur已成功部署到Kubernetes！
