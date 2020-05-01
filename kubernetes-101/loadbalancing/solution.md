To practice what we have learnt we have created a set of exercises to help practice

To begin with, we need to set up 2 deployments named `exercise` and `exercise2` and expose them by running the following commands.

## Task

Create our first deployment by running
`kubectl create deployment exercise --image=gcr.io/google-samples/hello-app:1.0`{{execute}}

We then need to check that the deployment is running by running `kubectl get deployment exercise`{{execute}}.
and expose the deployment again `kubectl expose deployment exercise --type=NodePort --port=8080`{{execute}}

Create our second deployment by running
`kubectl create deployment exercise2 --image=gcr.io/google-samples/hello-app:2.0`{{execute}}

We then need to check that the deployment is running by running `kubectl get deployment exercise`{{execute}}.
and expose the deployment again `kubectl expose deployment exercise2 --type=NodePort --port=8080`{{execute}}

Verify that we have both running by checking `kubectl get deployments`{{execute}} and `kubectl get svc`.

**Exercise 1**

Open the `ingress-template.yaml`{{open}} file.

This file contains a starter template for the ingress rules.

Complete the file by replacing the fields that have  `...` with the neccessary details to create an ingress rule with the following properties:

* name: exercise
* hostname: exercise101.info
* service: exercise
* port: 8080

With the template created, run the file to generate the resources by running `kubectl apply -f ingress-template.yaml`{{execute}}

Verify the ingress resource is running by running `kubectl get ingress`{{execute}} and check the IP for minikube by running `minikube service exercise --url`{{execute}}. You should see the following output

Add the following line to the bottom of the /etc/hosts file to add the host ip to the list of hosts.

`[[HOST_IP]] exercise101.info`. This can be done by running the following command `echo "[[HOST_IP]] exercise101.info">>/etc/hosts`{{execute}}

We can check our ingress controller is diverting traffic by running
`curl exercise101.info`{{execute}} 

You should see the request returns a response similar to the one below (with the hostname replaced by your pod name) showing the request hit the `web` app.

<pre>
Hello, world!
Version: 1.0.0
Hostname: exercise-764b75c5d6-lwrh9
</pre>

**Exercise 2**

Edit the `ingress-template.yaml`{{open}} to modify the ingress rules so that a new rule is added so that any traffic with `/exercise/` at the root of the url divert to the `exercise2` app.

>Solution
<pre class="file"
data-filename="ingress-template.yaml"
data-target="replace">
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: exercise
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
  - host: exercise101.info
    http:
      paths:
      - path: /
        backend:
          serviceName: exercise
          servicePort: 8080
      - path: /exercise/*
        backend:
          serviceName: exercise2
          servicePort: 8080</pre>

Run `kubectl apply -f ingress-template.yaml`{{open}} to update the ingress rules.

Test that the rules are working by running the following commands.


Access the first `web` app by running `curl exercise101.info`{{execute}}.

You should see the request returns a response similar to the one below (with the hostname replaced by your pod name) showing the request hit the `web` app.

<pre>
Hello, world!
Version: 1.0.0
Hostname: exercise-764b75c5d6-lwrh9
</pre>

This time if we request to a url with /exercise at the root by running `curl exercise101.info/exercise`{{execute}} we should see a different response similar to below.

<pre>
Hello, world!
Version: 2.0.0
Hostname: exercise2-6c595b99d4-slcfx
</pre>
