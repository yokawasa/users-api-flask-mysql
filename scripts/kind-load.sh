set -e -x
kind load docker-image users-api --name kind
kind load docker-image mysql:5.7 --name kind

