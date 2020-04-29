## Ingress Rules

Ingress rules are an object type with Kubernetes. The rules can be based on a request host (domain), or the path of the request, or a combination of both.

<pre class="file"
data-filename="ingress.yaml"
data-target="replace">
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: kubernetes101ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
  - host: kubernetes101.info
    http:
      paths:
      - path: /
        backend:
          serviceName: webapp1
          servicePort: 8080</pre>
          
Create the Ingress resource by running the following command:
`kubectl apply -f example-ingress.yaml`{{execute}}

Verify the ingress resource is running by running `kubectl get ingress`{{execute}} 

`[[HOST_IP]]`