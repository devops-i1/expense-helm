#if [ "$1" == "install" ]; then
#  kubectl create namespace argocd
#  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
##  kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
#
#  sleep 10
#
#    echo URL - https://$(kubectl get svc -n argocd argocd-server | awk '{print $4}' | tail -1)
#    echo Username - admin
#    echo Password - $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
#
#fi

#if [ "$1" == "jobs" ]; then
  argocd login $(kubectl get ingress -A | grep argocd | awk '{print $4}') --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo) --insecure --grpc-web

  for app in backend frontend ; do
     argocd app create ${app}  --repo https://github.com/devops-i1/expense-helm --path chart --dest-namespace default --dest-server https://kubernetes.default.svc --grpc-web --values ../values/${app}.yaml
  done

#fi