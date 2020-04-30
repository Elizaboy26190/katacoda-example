Open the following file `ingress.yaml`{{open}}

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
          servicePort: 8080
      - path: /v2/*
        backend:
          serviceName: web2
          servicePort: 8080</pre>
          
and apply the changes `kubectl apply -f ingress.yaml`{{execute}}.
