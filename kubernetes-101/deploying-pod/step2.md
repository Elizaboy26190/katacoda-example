## Task

The following command will launch a pod called http which will start a container based on the Docker Image.

`kubectl run --generator=run-pod/v1 http --image=katacoda/docker-http-server:latest`{{execute}}

<details>
    <summary>What does `--generator` do?</summary>
    <p>A <em>generator</em> is a what k8s uses to decide what type of resource to create, such as a pod, a deployment, a job, etc.</p>
    <p>This was deprecated in k8s v1.17 and defaults to `run-pod/v1`.</p>
    <p>
        More info:
        <ul>
            <li><a href="https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run" target="_blank">kubectl run documentation</a>
            <li><a href="https://kubernetes.io/docs/reference/kubectl/conventions/#generators" target="_blank">kubectl convernsions: generators</a></li>
            <li><a href="https://v1-17.docs.kubernetes.io/docs/reference/kubectl/conventions/#generators" target="_blank">Deprecated list of generators</a></li>
        </ul>
</details>

You can then use kubectl to view the status of the pod

`kubectl get pods`{{execute}}

To find out what Kubernetes created you can describe the deployment process.

`kubectl describe pod http`{{execute}}

The description includes labels specified and the events associated with the pod. These events will highlight any problems and errors that might have occurred.

In the next step we'll show you how to create the same pod directly from code.
