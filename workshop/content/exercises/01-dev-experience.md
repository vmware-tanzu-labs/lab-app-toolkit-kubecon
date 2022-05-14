With Application Toolkit, your Kubernetes platform is ready to receive web applications and shepherd them through the following workflow:
1. Obtain the source code from a git repository
2. Build a container image and publish it to a registry
3. Deploy the application

**Create Workload**

Application Toolkit provides an abstraction layer to define application workloads and maintain a clean separation of responsibilities between developers and operators.

As a developer, you provide the values unique to your application, such as the git repo and branch.

Use the tanzu CLI to deploy a workload to the platform.
```terminal:execute
command: |-
    tanzu apps workload create my-first-workload \
          --git-repo https://github.com/ciberkleid/hello-go.git \
          --git-branch main \
          --label app.kubernetes.io/part-of=my-first-workload \
          --type web \
          --yes
```

**Track Progress**

Application Toolkit includes a basic workflow for web applications that will immediately begin moving the workload from source to runtime.

Run the following command to check the status of the workload.
```terminal:execute
command: tanzu apps workload get my-first-workload
```

**Stream Logs**

Check the logs for more information.
```terminal:execute
command: tanzu apps workload tail my-first-workload
```

**Test Application**

Get the workload status again to see the URL of the deployed application.
```terminal:execute
command: tanzu apps workload get my-first-workload
```

To test the application, click on the URL in the output of the previous command, or execute the following command.

```terminal:execute
command: curl http://my-first-workload.{{ ingress_domain }}
```

**Behind the Scenes**

Let's take a look behind the scenes to see how Application Toolkit made this possible.
