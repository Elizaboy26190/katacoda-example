For our next exercises to test the ingress controller we wil begin by using the same katacoda image for our first deployment/

## Task

Create a deployment entitled `web` using our standard image.

`kubectl create deployment web --image=katacoda/docker-http-server:latest`{{execute}}

Expose our deployment using the NodePort type

`kubectl expose deployment web --type=NodePort --port=8080`{{execute}}

Verify the Service is created and is available on a node port:

`kubectl get service web`{{execute}}

Verify the service via NodePort:

`minikube service web --url`{{execute}}