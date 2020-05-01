Cluster IP is the default approach when creating a Kubernetes Service. The service is allocated an internal IP that other components can use to access the pods.

By having a single IP address, it enables the service to be load balanced across multiple Pods (which we will cover in more detail in a different scenario).

## Task

Let's start by exposing our http deployment using a default service.

This can be done via kubectl by running `kubectl expose deployment/http`{{execute}}.

This will then expose our http deployment and create a service called `http`.

We can get the cluster's IP address by running 
`export CLUSTER_IP=$(kubectl get services/http -o go-template='{{(index .spec.clusterIP)}}')`{{execute}}

and can view it by running
`echo CLUSTER_IP=$CLUSTER_IP`{{execute}}

To verify our service is running we can send a request to the service.
`curl $CLUSTER_IP`{{execute}}

You should see a response similar to `<h1>This request was processed by host: http-768f8fdbc-fzqlr</h1>` where the exact pod name is replaced with the pod name assigned for you by the deployment.

If we run the `curl` command multiple times, you should be able to see each of the 3 pods being cycled showing that the clusterIP is balancing the load across the pods.

## Task

We can also expose our service using a YAML manifest as before.

Begin by opening the `cluster.yaml`{{open}}.

You should see the yaml code to create our service, but if it doesn't work you can click `copy to editor` to copy the following code over.

<pre class="file"
data-filename="cluster.yaml"
data-target="replace">
apiVersion: v1
kind: Service
metadata:
  labels:
    app: http
  name: clusterhttp
spec:
  ports:
  - port: 80
  selector:
    app: http</pre>

We can run this command to create a new service called `clusterhttp` by running `kubectl apply -f cluster.yaml`{{execute}}

We can check that this has also successfully been deployed by running `kubectl get svc`{{execute}}.

We can get the cluster's IP address by running 
`export CLUSTER_YAML_IP=$(kubectl get services/clusterhttp -o go-template='{{(index .spec.clusterIP)}}')`{{execute}}

and can view it by running
`echo CLUSTER_YAML_IP=$CLUSTER_YAML_IP`{{execute}}

To verify our service is running we can send a request to the service.
`curl $CLUSTER_YAML_IP`{{execute}}.

By running this curl request multiple times this should cycle through the 3 pods.