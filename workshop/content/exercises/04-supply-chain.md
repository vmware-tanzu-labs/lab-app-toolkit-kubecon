Templates can be re-used for many applications because any workload-specific values are parameterized.

Templates can also be re-used for different workflows, because they are decoupled from the resource that defines the order in which they should be applied, and the precise mapping of outputs to inputs.

This configuration is done using a ClusterSupplyChain.

Application Toolkit includes a pre-configured supply chain that links the three templates together.

For convenience, save the supply chain configuration to a file.
```terminal:execute
command: kubectl get clustersupplychain source-to-url -o yaml > ~/exercises/supply-chain.yaml
```

Notice that this supply chain is intended for web applications.
It contains a selector whose value matches the `--type: web` field in the workload you created at the beginning of this workshop.
This value is used to determine which supply chain will apply to a given workload.
```editor:select-matching-text
file: ~/exercises/supply-chain.yaml
text: "selector:"
before: 0
after: 1
```

Next, notice the list of resources.
This list specifies which templates to use, and the order in which they should be applied.
```editor:select-matching-text
file: ~/exercises/supply-chain.yaml
text: "resources:"
before: 0
after: 100
```

Finally, notice that the second and third resources (for kpack and Knative Serving, respectively) contain input mapping.
For example, the input to the ClusterImageTemplate (kpack Image) comes from the source-provider declared just above it.
```editor:select-matching-text
file: ~/exercises/supply-chain.yaml
text: "  sources:"
before: 0
after: 2
```
