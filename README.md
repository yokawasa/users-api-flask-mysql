# users-api-flask-mysql

Users API application with Flask and MySQL (a fork of [kubernetes-flask-mysql](https://github.com/Rikkraan/kubernetes-flask-mysql))

## Quickstart

Clone repository

```bash
git clone https://github.com/yokawasa/users-api-flask-mysql.git
```

Create KIND cluster

```bash
kind create cluster --image kindest/node:v1.30.0 --config=kubernetes/kind/cluster.yaml --wait 5m
```

Check if the cluster has been created as expected

```bash
$ kind get cluster

kind
```

Then, deploy all k8s resources to the cluster

```bash
kubectl apply -f kubernetes/users-api-all-in-one.yml

# Or you can apply one by one like this:
# kubectl apply -f mysql-pv.yml
# kubectl apply -f mysql-deployment.yml
# kubectl apply -f app-secrets.yml
# kubectl apply -f app-deployment.yml
```

Check all pods are running

```bash
kubectl get po

NAME                                   READY   STATUS    RESTARTS   AGE
flaskapi-deployment-59bcb745ff-sfdtf   1/1     Running   2          7m53s
mysql-6b47c788c6-blzlc                 1/1     Running   0          7m43s
```

Finally port porward svc/flask-service port of 5000 to localhost:8080

```bash
kubectl port-forward svc/flask-service 8080:5000
```

You can access the service

```bash
curl http://localhost:8080/users
```

## Custom Container Images

### Build & load Container Images

Build container images and load them to the KIND cluster

```bash
cd app
docker build . -t flask-api

cd ../mysql
docker build . -t mysql:5.7 --platform linux/x86_64

# load images to the KIND cluster
kind load docker-image flask-api --name kind
kind load docker-image mysql:5.7 --name kind
```

### Push container Images to GHCR

```bash
echo $PAT | docker login ghcr.io -u yokawasa --password-stdin
docker tag flask-api ghcr.io/yokawasa/users-api-flask-mysql/flask-api:0.0.1
docker tag mysql:5.7 ghcr.io/yokawasa/users-api-flask-mysql/mysql:5.7
docker push ghcr.io/yokawasa/users-api-flask-mysql/flask-api:0.0.1
docker push ghcr.io/yokawasa/users-api-flask-mysql/mysql:5.7
```

### Update container image in k8s manifests

Finally, update the container image property value in app-deployment.yml and mysql-deployment.yml with the new one:

> kubernetes/app-deployment.yml
```yaml
# image: ghcr.io/yokawasa/users-api-flask-mysql/flask-api:latest
image: flask-api
```

> kubernetes/mysql-deployment.yml
```yaml
# image: ghcr.io/yokawasa/users-api-flask-mysql/mysql:5.7
image: mysql:5.7
```
