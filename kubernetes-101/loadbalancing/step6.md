To test ability of our ingress controller to divert traffic to the correct pod we will create a second pod.

`kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0`{{execute}}

We then need to check that the deployment is running by running `kubectl get deployment web2`{{execute}}.
and expose the deployment again `kubectl expose deployment web2 --type=NodePort --port=8080`{{execute}}

## Task
We can test our ability to divert traffic to this new app by adding a rule so that any url that begins with `/v2` gets sent to the new app.

Open the `ingress.yaml`{{open}} file and add the following code to the end of the file            
<pre class="file"
data-filename="ingress.yaml"
data-target="append">      - path: /v2/*
        backend:
          serviceName: web2
          servicePort: 8080</pre>
>**Note** YAML can be extremely sensitive to indentation so ensure that this path sits directly below the current path.

and apply the changes `kubectl apply -f ingress.yaml`{{execute}}.

This will divert all traffic with the path `/v2/*` to the web2 app and all other traffic to the `web` app.

>If the yaml file has been corrupted click on `show solution` to view the complete yaml and click `copy to editor`. 