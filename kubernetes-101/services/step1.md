To begin with we will start with a simple deployment with 3 replicas (to demonstrate the load balancing).

You can view the content of the file by opening `deployment.yaml`{{open}}.

To apply this deployment we can just run 
`kubectl apply -f deployment.yaml`{{execute}}

You can then use **kubectl** to view the status of the deployments

`kubectl get deployments`{{execute}}

To find out what Kubernetes created you can describe the deployment process and see that we have 3 pods.

`kubectl describe deployment http`{{execute}}
