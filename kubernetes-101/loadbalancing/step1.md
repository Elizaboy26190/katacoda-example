To begin with we will start with a simple deployment using a docker http image.

`kubectl create deployment http --image=katacoda/docker-http-server:latest`{{execute}}

You can then use **kubectl** to view the status of the deployments

`kubectl get deployments`{{execute}}

To find out what Kubernetes created you can describe the deployment process.

`kubectl describe deployment http`{{execute}}
