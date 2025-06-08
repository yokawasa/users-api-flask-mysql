set -e -x 
echo $PAT | docker login ghcr.io -u yokawasa --password-stdin
docker tag users-api ghcr.io/yokawasa/users-api-flask-mysql/users-api:0.0.1
docker tag mysql:5.7 ghcr.io/yokawasa/users-api-flask-mysql/mysql:5.7
docker push ghcr.io/yokawasa/users-api-flask-mysql/users-api:0.0.1
docker push ghcr.io/yokawasa/users-api-flask-mysql/mysql:5.7
