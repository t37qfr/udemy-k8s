docker build -t gaborfeher/multi-client:latest -t gaborfeher/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gaborfeher/multi-worker:latest -t gaborfeher/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t gaborfeher/multi-server:latest -t gaborfeher/multi-server:$SHA -f ./server/Dockerfile ./server

docker push gaborfeher/multi-client:latest
docker push gaborfeher/multi-worker:latest
docker push gaborfeher/multi-server:latest

docker push gaborfeher/multi-client:$SHA
docker push gaborfeher/multi-worker:$SHA
docker push gaborfeher/multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=gaborfeher/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gaborfeher/multi-worker:$SHA
kubectl set image deployments/server-deployment server=gaborfeher/multi-server:$SHA