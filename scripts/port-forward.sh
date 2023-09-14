set -x -e
kubectl port-forward svc/flask-service 8080:5000
