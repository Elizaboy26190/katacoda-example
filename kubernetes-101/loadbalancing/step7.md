We now should have both our deployments running and our ingress controller should be able to divert traffic.

Access the first `web` app by running `curl kubernetes101.info`{{execute}}.

You should see the request returns a response similar to the one below (with the hostname replaced by your pod name) showing the request hit the `web` app.

<pre>
Hello, world!
Version: 1.0.0
Hostname: web-764b75c5d6-lwrh9
</pre>

This time if we request to a url with /v2 at the root by running `curl kubernetes101.info/v2`{{execute}} we should see a different response similar to below.

<pre>
Hello, world!
Version: 2.0.0
Hostname: web2-6c595b99d4-slcfx
</pre>
>Note: If the v2 url isn't working, again verify that the web2 app is running and exposed.

This shows that the request was sent to the `web2` app and our ingress rule is successful.