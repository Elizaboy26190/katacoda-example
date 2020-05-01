On occasions, where multiple containers may by default expose the same port within a cluster it may prove useful to expose the service using a particular port. 

One way to do this is to specify the port when exposing the service.

## Task
With the deployment created, we can use **kubectl** to create a service which exposes the Pods on a particular port so that we can access it externally.

We can expose the container port `80` to the external port `8000` of the host.

We can expose our `targetporthttp` deployment on port `80` by running `kubectl expose deployment http --name=targetporthttp --port=8000 --target-port=80`{{execute}}
>Note the use of the `name` argument so that we can provide a new name for the service as we have already created a service called `http`

You will then be able to ping the host and see the result from the HTTP service.
We can get the cluster's IP address by running 
`export CLUSTER_TARGETPORT_IP=$(kubectl get services/targetporthttp -o go-template='{{(index .spec.clusterIP)}}')`{{execute}}

and can view it by running
`echo CLUSTER_TARGETPORT_IP=$CLUSTER_TARGETPORT_IP`{{execute}}

To verify our service is running we can send a request to the service.
`curl $CLUSTER_TARGETPORT_IP:8000`{{execute}}
You can then see the response `<h1>This request was processed by host: http-768f8fdbc-fzqlr</h1>` where the **http-768f8fdbc-fzqlr** is replaced by the pod name found by running `kubectl get pods -l app=http`{{execute}}.

By running this curl request multiple times this should cycle through the 3 pods.

You should also now be able to see the new service under `kubectl get svc`{{execute}}.

## Example - Creating a service using a manifest

You can also create a service by creating a YAML manifest and starting the service that way.

Firstly, open the file `targetport.yaml`{{open}} then click `copy to editor` to copy the code into the file.

<pre class="file"
data-filename="targetport.yaml"
data-target="replace">
apiVersion: v1
kind: Service
metadata:
  labels:
    app: http
  name: targetportyaml
spec:
  ports:
  - port: 8001
    targetPort: 80
  selector:
    app: http</pre>


You can then run `kubectl apply -f targetport.yaml`{{execute}}.

You should also now be able to see the new service under `kubectl get svc`{{execute}}.

You will then be able to ping the host and see the result from the HTTP service.

We can get the cluster's IP address by running 
`export CLUSTER_TARGETPORT_YAML_IP=$(kubectl get services/targetportyaml -o go-template='{{(index .spec.clusterIP)}}')`{{execute}}

and can view it by running
`echo CLUSTER_TARGETPORT_YAML_IP=$CLUSTER_TARGETPORT_YAML_IP`{{execute}}

To verify our service is running we can send a request to the service.
`curl $CLUSTER_TARGETPORT_YAML_IP:8001`{{execute}}

By running this curl request multiple times this should cycle through the 3 pods.

You should then be able to see the same response as the previous service (as both point to the same underlying app)  `<h1>This request was processed by host: http-768f8fdbc-fzqlr</h1>` where the **http-768f8fdbc-fzqlr** is replaced by the pod name found by running `kubectl get pods -l app=http`{{execute}}.
