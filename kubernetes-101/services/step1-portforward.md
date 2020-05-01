
## Forward a local port to a port on the Pod

On occassions where we just want to temporarily forward a local port to a pod on the pod, `kubectl port-forward` allows using resource name, such as a pod name, to select a matching pod to port forward to.

THis can be useful when you want to temporarily connect into a pod directly and interact with the pod.

To get the name of a pod in question, begin by running `kubectl get pods -l app=http` and see our pods.

We can then select the pods we wish to use by picking the first of those pods and runnign the following command `export TARGET_POD=$(kubectl get pods -l app=http -o jsonpath='{range .items[0]}{@.metadata.name}{"\n"}{end}')`{{execute}}

We can then run `kubectl port-forward $TARGET_PORT 1234:80`{{execute}} (where the pod name is replaced by one of the pods in question) and should see a response similar to below.

`Forwarding from 127.0.0.1:1234 -> 80
Forwarding from [::1]:1234 -> 80`

We can then open a new terminal (in katacoda this is done by pressing the `+` symbol beside the word `terminal` below to the right and then clicking `Open new terminal`)

In this new terminal, we can now connect straight to localhost and connect into our pod.

In our case this can be done by running `curl 127.0.0.1:1234`{{execute}} or `curl localhost:1234`{{execute}}.

