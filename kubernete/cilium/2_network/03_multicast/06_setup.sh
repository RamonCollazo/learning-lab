kubectl apply -f 04_bases.yaml

kubectl rollout status -f bases.yaml

kubectl apply -f 05_ships.yaml

kubectl get -f 05_ships.yaml -o wide --show-labels
