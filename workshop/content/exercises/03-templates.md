How were these resources automatically configured and created?

Application Toolkit includes **Cartographer**, a Supply Chain Choreographer that allows you to create templates for stamping out arbitrary kinds of resources (for example, FluxCD GitRepository, kpack Image, and Knative Serving Service) and for passing outputs of one instance as inputs to another.

In addition, Application Toolkit includes pre-configured templates for GitRepository, Image, and Service, so you can get started deploying applications right away.

List the pre-configured templates.
```terminal:execute
command: kubectl get clustersourcetemplate,clusterimagetemplate,clustertemplate
```

Next, take some time to look through the configuration of each template.
Notice that:
- Some values are placeholders that Cartographer will dynamically populate with values from the developer workload.
- Some values are placeholders that Cartographer will populate with dynamic output (e.g. passing the output of GitRepository as input to Image, for example).
- The templates have a free-form "template" field that contains the YAML configuration that Cartographer should submit to the kubernetes API server to create the resources for an application workload
- The templates have different output fields—specifically, ClusterSourceTemplate outputs url and revision; ClusterImageTemplate outputs image, ClusterTemplate does not have outputs).
  The templates populate the output fields using the information specified in the corresponding "path" field (e.g. urlPath or imagePath). These "path" fields teach Cartographer where to pull the desired value from the status.

**Step 1 in the Workflow: ClusterSourceTemplate**
```terminal:execute
command: kubectl get clustersourcetemplate git-repository
```

**Step 2 in the Workflow: ClusterImageTemplate**
```terminal:execute
command: kubectl get clusterimagetemplate image
```

**Step 3 in the Workflow: ClusterTemplate**
```terminal:execute
command: kubectl get clustertemplate app
```
