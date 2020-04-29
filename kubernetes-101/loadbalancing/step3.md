For our next exercises to test the loadBalancing, we shall use a pre-defined template called `deployments.yaml`{{open}} which creates 3 deployments with a service each.

We can deploy the services and pods by running `kubectl apply -f deployments.yaml`{{execute}}

The status can be viewed with `kubectl get deployment`{{execute}} to check on the progress.

You should now be able to see 3 deployments and should see 3 services whn running `kubectl get svc`{{execute}}

