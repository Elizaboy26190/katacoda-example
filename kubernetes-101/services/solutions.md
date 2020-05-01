Ensure our deployment is running by running `kubectl apply -f exercise.yaml`{{execute}}.

Verify the deployment is running by running `kubectl get deployments exercise`{{execute}}.

**Exercise 1**:-
Expose the `exercise` using cluster IP.

>Solution
>
>`kubectl expose deployment exercise`{{execute}}

You then should be able to test the deployment is exposed by running the following commands
`export EX_CLUSTER_IP=$(kubectl get services/exercise -o go-template='{{(index .spec.clusterIP)}}')
echo EX_CLUSTER_IP=$EX_CLUSTER_IP
curl $EX_CLUSTER_IP`{{execute}}

Verify that you see a response similar to the one below `<h1>This request was processed by host: exercise-768f8fdbc-fzqlr</h1> ` where the exact podname is replaced by the pod name created in the deployment.

**Exercise 2**:-
Expose the `exercise`on port `8006` using target port and the name `exercisetarget`.

>Solution
>
>`kubectl expose deployment exercuse --name=exercisetarget --port=8006 --target-port=80`{{execute}}

You then should be able to test the deployment is exposed by running the following commands
`export EX_TARGET_IP=$(kubectl get services/exercisetarget -o go-template='{{(index .spec.clusterIP)}}')
echo EX_TARGET_IP=$EX_TARGET_IP
curl $EX_TARGET_IP:8006`{{execute}}

Verify that you see a response similar to the one below `<h1>This request was processed by host: exercise-768f8fdbc-fzqlr</h1> ` where the exact podname is replaced by the pod name created in the deployment.

**Exercise 3**:-
Expose the `exercise`on port `8007` on the external-ip `[[HOST_IP]]` using the name `exerciseexternal` and external ip.

>Solution
>
>`kubectl expose deployment exercise --name=exerciseexternal --external-ip="[[HOST_IP]]" --port=8007 --target-port=80`{{execute}}

You then should be able to test the deployment is exposed by running the following commands
`export EX_EXTERNAL_IP=$(kubectl get services/exerciseexternal -o go-template='{{(index .spec.clusterIP)}}')
echo EX_EXTERNAL_IP=$EX_EXTERNAL_IP
curl $EX_EXTERNAL_IP:8007`{{execute}}

Verify that you see a response similar to the one below `<h1>This request was processed by host: exercise-768f8fdbc-fzqlr</h1> ` where the exact podname is replaced by the pod name created in the deployment.

**Exercise 4**:-
Expose the `exercise` using the name `exercisenodeport` and nodeport.
`kubectl expose deployment exercise --name=exercisenodeport --type=NodePort`{{execute}}

You can then get the nodeport by running the following command.
`export NODEPORT=$(kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services exercisenodeport)`{{execute}}

You then should be able to test the deployment is exposed by running the following commands
`export EX_NODEPORT_IP=$(kubectl get services/exercisenodeport -o go-template='{{(index .spec.clusterIP)}}')
echo NODEPORT=$NODEPORT
curl [[HOST_IP]]:$NODEPORT`{{execute}}

Verify that you see a response similar to the one below `<h1>This request was processed by host: exercise-768f8fdbc-fzqlr</h1> ` where the exact podname is replaced by the pod name created in the deployment.

