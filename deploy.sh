docker build -t eddie0228/multi-client:latest -t eddie0228/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eddie0228/multi-server:latest -t eddie0228/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eddie0228/multi-worker:latest -t eddie0228/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eddie0228/multi-client:latest
docker push eddie0228/multi-server:latest
docker push eddie0228/multi-worker:latest

docker push eddie0228/multi-client:$SHA
docker push eddie0228/multi-server:$SHA
docker push eddie0228/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=eddie0228/multi-server:$SHA
kubectl set image deployments/client-deployment client=eddie0228/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=eddie0228/multi-worker:$SHA