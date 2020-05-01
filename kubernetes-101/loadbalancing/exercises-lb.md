To practice what we have learnt we have created a set of exercises to help practice

To begin with, we need to set up our replication controller `exercise-nginx` which is in the `rc-exercise.yaml`{{open}} file by running `kubectl apply -f rc-exercise.yaml`.

**Exercise 1** 

Expose the docker image on port 5678 using the `LoadBalancer` type noting the target-port is `80` for the docker image.

In order to get access to the ip for our new load balancer we can run `export LoadBalancerExerciseIP=$(kubectl get services/http-service -o jsonpath='{.spec.clusterIP}')`{{execute}}.

To check the IP address we can run `echo LoadBalancerExerciseIP=$LoadBalancerExerciseIP`{{execute}} and can access the apps by running `curl $LoadBalancerExerciseIP:5678`{{execute}}

We should see `<h1>This request was processed by host: exercise-nginx-4vfzj</h1>`
(where the host is replaced by your pod names) returned.

We should see that each time we `curl` the server we can see that it balances the load across the apps to distribute the workload.