# IAM

## PostgreSQL on POD

```bash
$ kustomize build vivo-sso/k8s_pgsql_ssl_server-spc -o iam-pgsql.yaml
```

## IAM

```bash
$ kustomize build vivo-sso/automation/overlays/iam-spc -o iam.yaml
```
