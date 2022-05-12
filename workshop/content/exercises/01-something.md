Something...

```terminal:execute
command: |-
    git clone $GIT_PROTOCOL://$GIT_HOST/cartographer-concepts.git ~/cartographer-concepts
    ln -sf ~/cartographer-concepts/layout-2 ~/intro
    yq intro/01_manual/source.yaml intro/01_manual/image.yaml intro/01_manual/app-deploy.yaml 
```