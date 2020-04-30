For our next exercises to test the ingress controller we wil begin by using the same katacoda image for our first deployment/

## Task

Create a deployment entitled `web`.

`kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0`{{execute}}

Expose our deployment using the NodePort type

`kubectl expose deployment web --type=NodePort --port=8080`{{execute}}

Verify the Service is created and is available on a node port:

`kubectl get service web`{{execute}}

Verify the service via NodePort:

`minikube service web --url`{{execute}}

You should see the following output
`http://[[HOST_IP]]:[[NODE_PORT]]` in our case  `http://[[HOST_IP]]:30480`.