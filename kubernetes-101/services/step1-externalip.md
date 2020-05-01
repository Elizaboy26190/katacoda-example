Another approach to making a service available outside of the cluster is via External IP addresses.

## Task
With the deployment created, we can use **kubectl** to create a service which exposes the Pods on a particular port so that we can access it externally.

We can expose the container port `80` to the external port `8002` binding to the `external-ip` of the host.

We can expose our `externalhttp` deployment on port `80` by running `kubectl expose deployment http --name=externalhttp --external-ip="[[HOST_IP]]" --port=8002 --target-port=80`{{execute}}

You will then be able to ping the host and see the result from the HTTP service.

`curl http://[[HOST_IP]]:8002`{{execute}}

You can then see the response `<h1>This request was processed by host: http-768f8fdbc-fzqlr</h1>` where the **http-768f8fdbc-fzqlr** is replaced by the pod name found by running `kubectl get pods -l app=http`{{execute}}.

By running this curl request multiple times this should cycle through the 3 pods.

You should also now be able to see the new service under `kubectl get svc`{{execute}}.

## Example - Creating a service using a manifest

You can also create a service by creating a YAML manifest and starting the service that way.

Firstly, open the file `external.yaml`{{open}} then click `copy to editor` to copy the code into the file.

<pre class="file"
data-filename="external.yaml"
data-target="replace">
apiVersion: v1
kind: Service
metadata:
  labels:
    app: http
  name: externalyaml
spec:
  externalIPs:
  - [[HOST_IP]]
  ports:
  - port: 8003
    targetPort: 80
  selector:
    app: http</pre>


You can then run `kubectl apply -f external.yaml`{{execute}}.

You should also now be able to see the new service under `kubectl get svc`{{execute}}.

You will then be able to ping the host and see the result from the HTTP service.

`curl http://[[HOST_IP]]:8003`{{execute}}

You should then be able to see the same response as the previous service (as both point to the same underlying app)  `<h1>This request was processed by host: http-768f8fdbc-fzqlr</h1>` where the **http-768f8fdbc-fzqlr** is replaced by the pod name found by running `kubectl get pods -l app=http`{{execute}}.

By running this curl request multiple times this should cycle through the 3 pods.