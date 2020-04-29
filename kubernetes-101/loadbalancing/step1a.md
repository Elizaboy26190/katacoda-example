## Exposing our deployments

There are a number of ways to expose our deployments outside of the cluster. Although each Pod has a unique IP address, those IPs are not exposed outside the cluster without a Service.

These services allow our deployments to receive traffic outside teh cluster.

Services can be exposed in different ways by specifying a type in the ServiceSpec:

* **ClusterIP (default)** - Exposes the Service on an internal IP in the cluster. 
This type makes the Service only reachable from within the cluster.
* **NodePort** - Exposes the Service on the same port of each selected Node in the cluster using NAT. 
Makes a Service accessible from outside the cluster using <NodeIP>:<NodePort>. Superset of ClusterIP.

* **LoadBalancer** - Creates an external load balancer in the current cloud (if supported) and assigns a fixed, external IP to the Service. 
Superset of NodePort.

* **ExternalName** - Exposes the Service using an arbitrary name (specified by externalName in the spec) by returning a CNAME record with the name. 
No proxy is used. This type requires v1.7 or higher of kube-dns.
## Example - Creating a service using an external IP
With the deployment created, we can use **kubectl** to create a service which exposes the Pods on a particular port so that we can access it externally.

We can expose the container port `80` to the external port `8000` binding to the `external-ip` of the host.

We can expose our `http` deployment on port `80` by running `kubectl expose deployment http --external-ip="[[HOST_IP]]" --port=8000 --target-port=80`{{execute}}

You will then be able to ping the host and see the result from the HTTP service.

`curl http://[[HOST_IP]]:8000`{{execute}}

You can then see the response `<h1>This request was processed by host: http-768f8fdbc-fzqlr</h1>` where the **http-768f8fdbc-fzqlr** is replaced by the pod name found by running `kubectl get pods -l app=http`{{execute}}.

You should also now be able to see the new service under `kubectl get svc`{{execute}}.

## Example - Creating a service using a manifest

You can also create a service by creating a YAML manifest and starting the service that way.

Firstly, open the file `service.yaml`{{open}} then click `copy to editor` to copy the code into the file.

<pre class="file"
data-filename="service.yaml"
data-target="replace">
apiVersion: v1
kind: Service
metadata:
  labels:
    run: http
  name: http
spec:
  externalIPs: 
    - [[HOST_IP]]
  ports:
  - port: 8001
    protocol: TCP
    targetPort: 80
  selector:
    run: http</pre>


You can then run `kubectl apply -f service.yaml`{{execute}}.

You should also now be able to see the new service under `kubectl get svc`{{execute}}.
