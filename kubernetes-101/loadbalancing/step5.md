Ingress rules are an object type with Kubernetes. The rules can be based on a request host (domain), or the path of the request, or a combination of both.

We have already created our template file in `ingress.yaml`{{open}} and you cna view the source code below.

<pre class="file"
data-filename="ingress.yaml"
data-target="replace">
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
  - host: kubernetes101.info
    http:
      paths:
      - path: /
        backend:
          serviceName: web
          servicePort: 8080</pre>
          
Create the Ingress resource by running the following command:
`kubectl apply -f ingress.yaml`{{execute}}

Verify the ingress resource is running by running `kubectl get ingress`{{execute}} and check the IP for minikube by running `minikube service web --url`{{execute}}. You should see the following output
`http://[[HOST_IP]]:[[NODE_PORT]]` in our case  `http://[[HOST_IP]]:30480`.

Add the following line to the bottom of the /etc/hosts file to add the host ip to the list of hosts.

`[[HOST_IP]] kubernetes101.info`. This can be done by running the following command `echo "[[HOST_IP]] kubernetes101.info">>/etc/hosts`{{execute}}

We can check our ingress controller is diverting traffic by running
`curl kubernetes101.info`{{execute}}

You should see a response similar to the one below with the hostname replaced by your podname.

<pre>
Hello, world!
Version: 1.0.0
Hostname: web-764b75c5d6-lwrh9
</pre>
>Note: If the request responds with `503` then wait for the deployment to be up and running by running `kubectl get pods -l app=web`