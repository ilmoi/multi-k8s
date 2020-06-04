docker build -t imoisejevs/multi-client:latest -t imoisejevs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t imoisejevs/multi-server:latest -t imoisejevs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t imoisejevs/multi-worker:latest -t imoisejevs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push imoisejevs/multi-client:latest
docker push imoisejevs/multi-server:latest
docker push imoisejevs/multi-worker:latest
docker push imoisejevs/multi-client:$SHA
docker push imoisejevs/multi-server:$SHA
docker push imoisejevs/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=imoisejevs/multi-client:$SHA
kubectl set image deployments/server-deployment server=imoisejevs/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=imoisejevs/multi-worker:$SHA
