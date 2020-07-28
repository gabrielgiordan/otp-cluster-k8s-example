# OTP cluster with K8s

A simple and pure `cowboy` server to show how an OTP cluster could be formed with [`libcluster`](https://github.com/bitwalker/libcluster) and **Kubernetes**.

[![asciicast](https://asciinema.org/a/350071.svg)](https://asciinema.org/a/350071)

## Usage

Build the container image:

`docker image build -t gabrielgiordan/app:libcluster .`

To run just the container image:

`docker run -it -e POD_IP=127.0.0.1 gabrielgiordan/app:libcluster`

Apply the K8s config:

`kubectl apply -f k8s/app.yml`

See the replicas starting:

`kubectl get pods`

Check the current and connected nodes from the formed cluster load balanced with the K8s DNS:

`curl localhost:8000`

```
Current node: :"app@10.1.0.38"
Connected nodes: [:"app@10.1.0.39", :"app@10.1.0.37", :"app@10.1.0.36"]
```
