The Deployment and pods we have just created automatically add a label for our Pods.

You can check any of our labels by running the following command

`kubectl describe deployment -l app=http`{{execute}}

We can then use this label to query our pods.
 
 We’ll use the `kubectl get pods` command with `-l` as a parameter, followed by the label values:

`kubectl get pods -l app=http`{{execute}}

You can do the same to list the existing services (though we have none setup locally yet):

`kubectl get services -l app=http`{{execute}}

Get the name of the Pods and store it in the POD_NAMES environment variable:

`export POD_NAMES=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')`{{execute}}

We can then check the pod names by running
`echo Name of the Pods: $POD_NAMES`{{execute}}

To apply a new label we use the label command followed by the object type, object name and the new label:

`kubectl label pod $POD_NAMES customlabel=condenast`{{execute}}

This will apply a new label to our 3 http Pods (we pinned the application version to the Pod), and we can check it with the describe pod command:

`kubectl describe pods $POD_NAMES`{{execute}}

We see here that the label is attached now to our Pod. And we can query now the list of pods using the new label:

`kubectl get pods -l customlabel=condenast`{{execute}}

And we see the 3 Pods.