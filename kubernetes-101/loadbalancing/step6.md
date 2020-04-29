To test ability of our ingress controller to divert traffic to the correct pod we will create a second pod.

`kubectl run web2 --image=gcr.io/google-samples/hello-app:2.0`{{execute}}

and expose the deployment again `kubectl expose deployment web2 --target-port=8080 --type=NodePort`{{execute}}

## Task

Open the `ingress.yaml`{{open}} file and add the following code to the end of the file
<pre>      - path: /v2/*
             backend:
               serviceName: web2
               servicePort: 8080</pre>
               
and apply the changes `kubectl apply -f ingress.yaml`{{execute}}.

This will divert all traffic with the path `/v2/*` to the web2 app and all other traffic to the `web` app.

>If the yaml file has been corrupted click on `show solution` to view the complete yaml and click `copy to editor`