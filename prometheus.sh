#!/bin/bash

# C. Constants
NS=monitoring
NOW="--grace-period=0 --force"

# 0. Re-create namespace
kubectl delete ns $NS $NOW
kubectl create ns $NS

# 1. Load cluster role as well as cluster role binding
kubectl replace -f clusterRole.yaml --force

# 2. Load config map
kubectl replace -f config-map.yaml --force

# 3. Load deployment
kubectl replace -f prometheus-deployment.yaml --force

# 4. Load server
kubectl replace -f prometheus-service.yaml --force

# 5. Load ingress
# kubectl replace -f prometheus-ingress.yaml --force

# 6. Grafana datasource
kubectl replace -f grafana-datasource-config.yaml --force

# 7. Grafana deployment
kubectl replace -f grafana-deployment.yaml --force

# 8. Grafana service
kubectl replace -f grafana-service.yaml --force

# 9. Show everything
kubectl get all -n $NS
echo

# 10. Prometheus link
IP=$(kubectl get node -o jsonpath="{.items[0].status.addresses[*].address}"|tr " " "\n"|grep -E '[0-9]+.[0-9]+.[0-9]+.[0-9]+')
echo "Go to link: http://$IP:30000"

# 11. Grafana link
echo "Go to link: http://$IP:32000"

