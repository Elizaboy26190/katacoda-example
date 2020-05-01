While TargetPort and ClusterIP make it available to inside the cluster, the NodePort exposes the service on each Node’s IP via the defined static port. No matter which Node within the cluster is accessed, the service will be reachable based on the port number defined which can make it easier to track apps and be confident of th port of the deployment.

## Task

Let's start by exposing our http deployment using a default service.

This can be done via kubectl by running `kubectl expose deployment http --name=nodeporthttp --type=NodePort`{{execute}}.

This will then expose our http deployment and create a service called `nodeporthttp`.

We can get the cluster's assigned Nodeport by running 
`export NODEPORT=$(kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services nodeporthttp)`{{execute}}

and can view it by running
`echo NODEPORT=$NODEPORT`{{execute}}

To verify our service is running we can send a request to the service from our node's IP on the target port.
`curl [[HOST_IP]]:$NODEPORT`{{execute}}

If we run the `curl` command multiple times, you should be able to see each of the 3 pods being cycled showing that the clusterIP is balancing the load across the pods.

## Task

We can also expose our service using a YAML manifest as before.

Begin by opening the `nodeport.yaml`{{open}}.

You should see the yaml code to create our service, but if it doesn't work you can click `copy to editor` to copy the following code over.

<pre class="file"
data-filename="nodeport.yaml"
data-target="replace">
apiVersion: v1
kind: Service
metadata:
  labels:
    app: http
  name: nodeportyaml
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: http</pre>

We can run this command to create a new service called `nodeportyaml` by running `kubectl apply -f nodeport.yaml`{{execute}}

We can check that this has also successfully been deployed by running `kubectl get svc`{{execute}}.

To verify our service is running we can send a request to the service on our Node's ip on the given nodeport.
`curl [[HOST_IP]]:30080`{{execute}}

By running this curl request multiple times this should cycle through the 3 pods.