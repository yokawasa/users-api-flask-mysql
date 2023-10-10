set -x -e
kubectl port-forward svc/flask-service-v2 8082:5000
