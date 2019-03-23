docker build -t viveksome/multi-client:latest -t viveksome/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t viveksome/multi-server:latest -t viveksome/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t viveksome/multi-worker:latest -t viveksome/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push viveksome/multi-client:latest
docker push viveksome/multi-server:latest
docker push viveksome/multi-worker:latest

docker push viveksome/multi-client:$SHA
docker push viveksome/multi-server:$SHA
docker push viveksome/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=viveksome/multi-server:$SHA
kubectl set image deployments/client-deployment client=viveksome/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=viveksome/multi-worker:$SHA