set -x -e
kubectl port-forward svc/flask-service-v1 8081:5000
