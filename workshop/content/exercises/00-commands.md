Something...

```terminal:execute
command: tanzu package available list -o yaml | yq '.[].display-name'
```

```terminal:execute
command: tanzu package installed list -A -o yaml | yq '.[].name'    
```

```terminal:execute
command: kubectl get clusterbuilder
```

```editor:execute
command: mv /opt/workshop/example ~
```

```editor:select-matching-text
file: /opt/workshop/example/source.yaml
text: "kind:"
before: 0
after: 0
```