docker build -t 1after/multi-client:latest -t 1after/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 1after/multi-server:latest -t 1after/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 1after/multi-worker:latest -t 1after/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push 1after/multi-client:latest
docker push 1after/multi-server:latest
docker push 1after/multi-worker:latest
docker push 1after/multi-client:$SHA
docker push 1after/multi-server:$SHA
docker push 1after/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=1after/multi-server:$SHA
kubectl set image deployments/client-deployment client=1after/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=1after/multi-worker:$SHA