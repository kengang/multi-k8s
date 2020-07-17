docker build -t kenmei/multi-client:latest -t kenmei/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kenmei/multi-server:latest -t kenmei/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kenmei/multi-worker:latest -t kenmei/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kenmei/multi-client:latest
docker push kenmei/multi-server:latest
docker push kenmei/multi-worker:latest
docker push kenmei/multi-client:$SHA
docker push kenmei/multi-server:$SHA
docker push kenmei/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kenmei/multi-server:$SHA
kubectl set image deployments/client-deployment client=kenmei/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kenmei/multi-worker:$SHA