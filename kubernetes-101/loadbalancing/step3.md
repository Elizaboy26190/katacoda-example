## What is an Ingress Controller?
An ingress controller provides an HTTP gateway to applications in the cluster. We expose the ingress controller to the internet, and it will route requests to the applications based on hostname, path or other conditions.

An ingress controller can save us cost, as we don't need to get a public IP for every application we wish to expose.

It also lets us do more complicated request routing without having to add it to our application.

## Common Ingress Controllers

Here at Conde Nast we use a variety of Ingress controllers, but most commonly use Traefik

![Default Namespaces](./assets/traefik.png)

There are a number of other candidates that we can use for the controller.

* Nginx ingress controller
* HAProxy ingress controller
* Caddy
* Istio ingress gateway
* and many more!

## Task

For this environment, for simplicity we will use the minikube ingress controller.

To enable the NGINX Ingress controller, run the following command:
`minikube addons enable ingress`. This has been done for our scenario.

Verify that the NGINX Ingress controller is running
`kubectl get pods -n kube-system`{{execute}}
>Note: This may take a minute or longer
