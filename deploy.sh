docker build -t an071093/multi-client:latest -t an071093/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t an071093/multi-server:latest -t an071093/multi-server:$SHA -f ./server/DockerFile ./server
docker build -t an071093/multi-worker:latest -t an071093/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push an071093/multi-client:latest
docker push an071093/multi-server:latest
docker push an071093/multi-worker:latest

docker push an071093/multi-client:latest:$SHA 
docker push an071093/multi-server:latest:$SHA 
docker push an071093/multi-worker:latest:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=an071093/multi-server:$SHA
kubectl set image deployments/client-deployment client=an071093/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=an071093/multi-worker:$SHA