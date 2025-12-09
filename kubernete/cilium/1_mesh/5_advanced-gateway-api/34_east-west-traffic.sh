kubectl get -n gamma pods client

kubectl -n gamma exec -it client -- curl http://echo/v1

kubectl -n gamma exec -it client -- curl http://echo/v2
