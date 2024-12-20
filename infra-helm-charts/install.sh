helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade -i ngx-ingres ingress-nginx/ingress-nginx -f ingress.yaml