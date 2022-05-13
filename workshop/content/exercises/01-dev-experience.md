As a developer, you want to submit your workload information (git repo and branch, primarily) and have the application running on the platform.

Luckily, Application Toolkit delivers what you need. The platform is ready to receive web applications and shepherd them through the following workflow:
1. Obtain the source code from a git repository
2. Build a container image and publish it to a registry
3. Deploy the application

**Create Workload**

Use the tanzu CLI to deploy this workload to the platform.
```terminal:execute
command: |-
    tanzu apps workload create my-first-workload \
          --git-repo {{ git_protocol }}://{{ git_host }}/hello-go.git \
          --git-branch main \
          --label app.kubernetes.io/part-of=my-first-workload \
          --type web \
          --yes --tail
```

**Track Progress**

Run the following command to check on the progress of this workflow.
```terminal:execute
command: tanzu apps workload get my-first-workload
```
