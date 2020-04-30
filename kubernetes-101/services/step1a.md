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
