set -e -x

cwd=`dirname "$0"`
expr "$0" : "/.*" > /dev/null || cwd=`(cd "$cwd" && pwd)`

echo "Creating KIND cluster"
cd ${cwd}/../kubernetes/kind-cluster
./create.sh

echo "Building mysql container and loading it to KIND cluster"
cd ${cwd}/../mysql
docker build . -t mysql:5.7
kind load docker-image mysql:5.7 --name kind

echo "Building app container and loading it to KIND cluster"
cd ${cwd}/app-v1
./build.sh
kind load docker-image flask-api:v1 --name kind
cd ${cwd}/app-v2
./build.sh
kind load docker-image flask-api:v2 --name kind

echo "Deploying app to KIND cluster"
kubectl apply -f ${cwd}/../kubernetes/mysql-pv.yml
kubectl apply -f ${cwd}/../kubernetes/mysql-deployment.yml
kubectl apply -f ${cwd}/../kubernetes/app-secrets.yml
kubectl apply -f ${cwd}/app-v1/app-deployment.yml
kubectl apply -f ${cwd}/app-v2/app-deployment.yml
sleep 5

echo "Checking deployed kuberenetes resources"
kubectl get all





echo "Deploy Kuberentes services"
cd ${cwd}/../kubernetes



