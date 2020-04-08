# Terraform Multienv Template
This repo shows a minimal terraform configuration with Make wrapper. 
In order to deploy `dev` infrastructure run:

```shell script
make deploy
```

## TODO
This example shows code and infrastructure location, but doesn't show deployment of `app.py`

## Dependencies
- GNU Make
- envsubst
- terraform
