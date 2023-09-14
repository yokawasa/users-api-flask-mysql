set -e -x
kind load docker-image flask-api --name kind
kind load docker-image mysql:5.7 --name kind

