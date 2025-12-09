kubectl rollout status deploy/emailservice
kubectl rollout status deploy/checkoutservice
kubectl rollout status deploy/recommendationservice
kubectl rollout status deploy/frontend
kubectl rollout status deploy/paymentservice
kubectl rollout status deploy/productcatalogservice
kubectl rollout status deploy/cartservice
kubectl rollout status deploy/loadgenerator
kubectl rollout status deploy/currencyservice
kubectl rollout status deploy/shippingservice
kubectl rollout status deploy/redis-cart
kubectl rollout status deploy/adservice

grpcurl -plaintext -proto ./demo.proto $GATEWAY:80 hipstershop.CurrencyService/GetSupportedCurrencies | jq
grpcurl -plaintext -proto ./demo.proto $GATEWAY:80 hipstershop.ProductCatalogService/ListProducts | jq
