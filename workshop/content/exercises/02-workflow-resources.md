Let's start by walking through the resources that handled the workflow from beginning to end.

**Step 1: Obtain the source code from a git repository**

To obtain source code, the workflow created a FluxCD _GitRepository_ resource for your workload.

For convenience, export the resource details to a file.
```terminal:execute
command: kubectl get GitRepository my-first-workload -o yaml > ~/exercises/my-first-workload-step-1-source.yaml
```

Open the file in the editor and look through the details.
You will see it includes the resource configuration as well as its status.
```editor:open-file
file: ~/exercises/my-first-workload-step-1-source.yaml
```
Notice that several fields—name, url, and branch—were dynamically populated with information from your workload.
Notice also that this resource is configured to check the source code repository every minute for new commits.

Next, take a look at the status.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-1-source.yaml
text: "status: "
before: 0
after: 1
```

Notice the conditions state `type: Ready` and `status: "True"`, indicating the resource was successful in obtaining a new git commit.

Notice also that the field `.status.artifact.url` contains a reference to a downloaded archive of the specific commit of code.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-1-source.yaml
text: "url: http://source-controller(.*)/[0-9](.*)"
isRegex: true
```

This url contains the code we want to build and deploy.

**Step 2: Build a container image and publish it to a registry**

To build the container image, the workflow created a kpack _Image_ resource for your workload.

> Side bar: Why kpack?
>
> kpack utilizes Cloud Native Buildpacks (CNBs) to turn application source code into OCI images. CNBs provide a structured way to build images without requiring custom scripts, such as Dockerfiles. With Cloud Native Buildpacks, you can ensure that all applications across your organization are being built in a consistent, secure, auditable manner, including deep language-specific expertise. kpack adds the ability to maintain images up-to-date at scale, automatically rebuilding or rebasing images as needed.

For convenience, export the resource details to a file.
```terminal:execute
command: kubectl get imgs my-first-workload -o yaml > ~/exercises/my-first-workload-step-2-image.yaml
```

Open the file in the editor and look through the details.
```editor:open-file
file: ~/exercises/my-first-workload-step-2-image.yaml
```

Notice, again, that a couple of fields—name and tag—were dynamically populated with information from your workload.

Notice that the value of `.status.artifact.url` from the GitRepository resource was automatically provided as the source url for the Image resource.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-2-image.yaml
text: "source: "
before: 0
after: 2
```

Next, take a look at the status.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-2-image.yaml
text: "status:"
before: 0
after: 100
```

The conditions should state `type: Ready` and `status: "True"`, indicating the resource was successful in building a new image.

Notice also that the field `.status.latestImage` contains the tag of the new image.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-2-image.yaml
text: "latestImage"
before: 0
after: 0
```

This latestImage field contains the image we want to deploy.

**Step 3: Deploy the application**

Finally, to deploy the container image, the workflow created a Knative Serving _Service_ resource for your workload.

> Side bar: Why Knative Serving?
> 
> With relatively simple configuration, Knative Serving provides a sophisticated deployment of your application, including the ability to auto-scale, scale to zero instances, weight traffic between revisions, roll back to previous revisions, and easily expose the application.
Compared to configuring a basic Deployment, Service, and Ingress, Knative Serving provides much richer functionality with simpler configuration.

For convenience, export the resource details to a file.
```terminal:execute
command: kubectl get kservice my-first-workload -o yaml > ~/exercises/my-first-workload-step-3-app.yaml
```

Open the file in the editor and look through the details.
```editor:open-file
file: ~/exercises/my-first-workload-step-3-app.yaml
```

Notice that the value of `.status.latestImage` from the Image resource was automatically provided as the source image for the Service resource.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-3-app.yaml
text: "- image: "
before: 0
after: 0
```

**Perpetual cycle**

These three resources will continue to exist in the Kubernetes cluster after this version of the application is deployed.
Anytime a developer commits new code, the change will be automatically detected and a new image will be built and deployed.

However... there must be another actor in actor at play here. Who created these three resources, and who is passing the outputs of one resource as input to the next?

That's where Cartographer comes in...
Continue to the next step to learn more.
