ssh root@host01 'for i in {1..200}; do oc policy add-role-to-user system:image-puller system:anonymous && break || sleep 1; done'
ssh root@host01 'oc adm policy add-cluster-role-to-group sudoer system:authenticated'
ssh root@host01 "~/.setup-volumes"
ssh root@host01 "~/.setup-templates"

git clone https://github.com/QuincyChengAtWork/conjur-oss-openshift-authn-katacoda.git
cd conjur-oss-openshift-authn-katacoda
clear
launch.sh
