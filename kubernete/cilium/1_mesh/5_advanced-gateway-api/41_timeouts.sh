kubectl apply -f 39_load-balancing-http-route.yaml

kubectl -n gamma exec -it client -- curl http://echo/v1

kubectl apply -f 40_load-balancing-http-route.yaml

kubectl -n gamma exec -it client -- curl http://echo/v1
