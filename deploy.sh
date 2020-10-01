docker build -t da1kun/multi-client:latest -t da1kun/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t da1kun/multi-server:latest -t da1kun/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t da1kun/multi-worker:latest -t da1kun/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push da1kun/multi-client:latest
docker push da1kun/multi-server:latest
docker push da1kun/multi-worker:latest

docker push da1kun/multi-client:$SHA
docker push da1kun/multi-server:$SHA
docker push da1kun/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=da1kun/multi-server:$SHA
kubectl set image deployments/client-deployment client=da1kun/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=da1kun/multi-worker:$SHA