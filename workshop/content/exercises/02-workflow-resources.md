Let's start by walking through the resources that handled the workflow from beginning to end.

**Step 1: Obtain the source code from a git repository**

To obtain source code, the workflow created a FluxCD GitRepository resource for your workload.

For convenience, export the GitRepository resource's details to a file.
```terminal:execute
command: kubectl get GitRepository my-first-workload -o yaml > ~/exercises/my-first-workload-step-1-source.yaml
```

Open the file in the editor and look through the details.
Notice that several fields were dynamically populated with information from your workload (name, url, branch).
Notice also that this resource configured FluxCD to check the repo every minute for new commits.
```editor:open-file
file: ~/exercises/my-first-workload-step-1-source.yaml
```

Next, take a look at the status.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-1-source.yaml
text: "status: "
before: 0
after: 100
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

To build the container image, the workflow created a kpack Image resource for your workload.

> Side bar: Why kpack?
>
> kpack utilizes Cloud Native Buildpacks (CNBs) to turn application source code into OCI images. CNBs provide a structured way to build images without requiring custom scripts, such as Dockerfiles. With Cloud Native Buildpacks, you can ensure that all applications across your organization are being built in a consistent, secure, auditable manner, including deep language-specific expertise. kpack adds the ability to maintain images up-to-date at scale, rebuilding or rebasing images as needed automatically.

For convenience, export the Image resource's details to a file.
```terminal:execute
command: kubectl get imgs my-first-workload -o yaml > ~/exercises/my-first-workload-step-2-image.yaml
```

Open the file in the editor and look through the details.
Notice, again, that several fields were dynamically populated with information from your workload (name, tag).
```editor:open-file
file: ~/exercises/my-first-workload-step-1-source.yaml
```

Notice that the value of `.status.artifact.url` from the GitRepository resource was automatically provided as the source url for the Image resource.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-1-source.yaml
text: "source: "
before: 0
after: 0
```

Next, take a look at the status.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-1-source.yaml
text: "status: "
before: 0
after: 100
```

Again, notice the conditions state `type: Ready` and `status: "True"`, indicating the resource was successful in building a new image.

Notice also that the field `.status.latestImage` contains the tag of the new image.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-1-source.yaml
text: "latestImage"
before: 0
after: 0
```

This latestImage field contains the image we want to deploy.

**Step 3: Deploy the application**

Finally, to deploy the container image, the workflow created a Knative Serving Service resource for your workload.

> Side bar: Why Knative Serving?
> 
> With relatively simple configuration, Knative Serving provides a sophisticated deployment of your application, including the ability to auto-scale, scale to zero instances, weight traffic between revisions, roll back to previous revisions, and easily expose the application.
Compared to configuring a basic Deployment, Service, and Ingress, Knative Serving provides much richer functionality with simpler configuration.

For convenience, export the Service resource's details to a file.
```terminal:execute
command: kubectl get kservice my-first-workload -o yaml > ~/exercises/my-first-workload-step-3-app.yaml
```

Open the file in the editor and look through the details.
```editor:open-file
file: ~/exercises/my-first-workload-step-3-app.yaml
```

Notice that the value of `.status.latestImagel` from the Image resource was automatically provided as the source image for the Service resource.
```editor:select-matching-text
file: ~/exercises/my-first-workload-step-3-app.yaml
text: "- image: "
before: 0
after: 0
```
