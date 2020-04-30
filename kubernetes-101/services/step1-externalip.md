
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
    app: http
  name: http2
spec:
  externalIPs:
  - [[HOST_IP]]
  ports:
  - port: 8001
    targetPort: 80
  selector:
    app: http</pre>


You can then run `kubectl apply -f service.yaml`{{execute}}.

You should also now be able to see the new service under `kubectl get svc`{{execute}}.

You will then be able to ping the host and see the result from the HTTP service.

`curl http://[[HOST_IP]]:8001`{{execute}}

You should then be able to see the same response as the previous service (as both point to the same underlying app)  `<h1>This request was processed by host: http-768f8fdbc-fzqlr</h1>` where the **http-768f8fdbc-fzqlr** is replaced by the pod name found by running `kubectl get pods -l app=http`{{execute}}.
