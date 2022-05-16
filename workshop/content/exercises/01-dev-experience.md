With Application Toolkit, your Kubernetes platform is ready to receive web applications and shepherd them through the following workflow:
1. Obtain source code from a git repository
2. Build a container image and publish it to a registry
3. Deploy the application

**Create Workload**

Application Toolkit provides an abstraction layer to define application workloads and maintain a clean separation of concerns between developers and operators.

As a developer, you provide the values unique to your application, such as the git repo and branch.

Use the tanzu CLI to deploy a workload to the platform. The `--tail` option will stream logs to the terminal window.
```terminal:execute
command: |-
    tanzu apps workload create app-{{session_namespace}} \
          --git-repo https://github.com/ciberkleid/hello-go.git \
          --git-branch main \
          --label app.kubernetes.io/part-of=my-first-workload \
          --type web \
          --yes --tail
```

**Track Progress**

Application Toolkit includes a basic workflow for web applications that will immediately begin moving the workload from source to runtime.

Click the following action to check the status of the workload in the second terminal window.
```terminal:execute
command: tanzu apps workload get app-{{session_namespace}}
session: 2
```

You will likely see `type: Ready, status: Unknown` and that it is `waiting to read value [.status.latestImage] from resource [image.kpack.io/my-first-workload]`.

This simply means that the workload is still being processed.
It takes a few moments to build the container image.

In the meantime, in the first terminal window, you should see logging for the container build process.
Wait until you see the following log entries:
```shell
app-{{session_namespace}}-build-1-build-pod[completion] Build successful
Workload "app-{{session_namespace}}" is ready
```

Re-run the "get" command.
This time the status should be `type: eady, status: "True"` and you should see a URL for the application in the result.
```terminal:execute
command: tanzu apps workload get app-{{session_namespace}}
```

**Test Application**

To test the application, click on the URL in the output of the previous command, or execute the following command.

```terminal:execute
command: curl http://app-{{session_namespace}}.default.{{ ingress_domain }}
```

**Ongoing Workflow**

Now that the platform is aware of your workload, anytime you do a git commit on the source code repository, the workflow will build and deploy a new image.

**Easy Peasy**
That's it! With a simple command to install Application Toolkit, and another to deploy a Workload, you've got a process in place to automatically and continuously build and deploy your application on Kubernetes.

**Behind the Scenes**

Next, let's take a look behind the scenes to see how Application Toolkit made this possible.
