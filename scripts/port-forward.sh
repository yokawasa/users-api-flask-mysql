set -x -e
kubectl port-forward svc/usersapi-service 8080:5000
