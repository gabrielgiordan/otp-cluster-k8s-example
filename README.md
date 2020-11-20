# OTP cluster with K8s

A simple and pure `cowboy` server to show how an OTP cluster could be formed with [`libcluster`](https://github.com/bitwalker/libcluster) and **Kubernetes**.

[![asciicast](https://asciinema.org/a/350071.svg)](https://asciinema.org/a/350071)

## K8s

Build the container image:

`docker-compose build`

To run just the container image:

`docker run -it -e POD_IP=127.0.0.1 gabrielgiordan/app:dev`

Apply the K8s config:

`kubectl apply -f k8s/app.yml`

To destroy the deployment:

`kubectl delete -f k8s/app.yml`

To update the containter image:

`kubectl rollout restart deployment app-deploy`

See the replicas starting:

`kubectl get pod`

Check the current and connected nodes from the formed cluster load balanced with the K8s DNS:

`curl -i localhost:8000/nodes`

```json
HTTP/1.1 200 OK
cache-control: max-age=0, private, must-revalidate
content-length: 104
date: Fri, 20 Nov 2020 02:27:01 GMT
server: Cowboy

{"connected_nodes":["app@10.1.0.203","app@10.1.0.204","app@10.1.0.205"],"current_node":"app@10.1.0.202"}
```
# Gossip

To start a gossip cluster:

`PORT=4000 iex --sname app0 -S mix app.start`

`PORT=4001 iex --sname app1 -S mix app.start`

`PORT=4002 iex --sname app2 -S mix app.start`

Check the current and connected nodes from the first node:

`curl -i localhost:4000/nodes`

```json
HTTP/1.1 200 OK
cache-control: max-age=0, private, must-revalidate
content-length: 105
date: Fri, 20 Nov 2020 02:43:43 GMT
server: Cowboy

{"connected_nodes":["app1@PC","app2@PC"],"current_node":"app0@PC"}
```