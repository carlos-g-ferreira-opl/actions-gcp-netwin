## IAM - First Install Instructions

1) Run DB Creation with SQL script

   1) **Oracle** Script File: [ORACLE_CREATE_TABLESPACES.sql](automation/base/files/ORACLE_CREATE_TABLESPACES.sql)
   2) **PostgreSQL** Script File: [POSTGRESQL_CREATE_DB.sql](automation/base/files/POSTGRESQL_CREATE_DB.sql)
      1) (Run only if automatic database install fails)


2) Configure vars
        
   1) Base config File: [configmaps.yaml](automation/base/configmaps.yaml)
      1) **Note** This file is ReadOnly, an Overlay is necessary. Examples can be found in [overlays](automation/overlays/)


3) Apply Kustomize

        kubectl kustomize automation/overlays/iam | kubectl apply -f -

4) **DEPRECATED!** A Job was created to automatically run this. Please check [job-update-csv.yaml](automation/base/job-update-csv.yaml) ~~Export/Update Credentials (Needs iam-service running)~~

        kubectl exec --stdin --tty deployment.apps/iam-service -- ansible-playbook -vv --diff -i /opt/ptin/automation/iam/inventory/sample /opt/ptin/automation/iam/import_csv_generate_credentials.yml --skip-tags iam_yum --vault-password-file /opt/ptin/iam/conf/kube/vault-password-file -e @/opt/ptin/iam/conf/kube/ansiblevars.yaml
        
5) Configure the auto provisioning script

        kubectl exec --stdin --tty deployment.apps/iam-service -- ansible-playbook -vv --diff -i /opt/ptin/automation/iam/inventory/sample /opt/ptin/automation/iam/config_iam_scripts.yml --skip-tags iam_yum --vault-password-file /opt/ptin/iam/conf/kube/vault-password-file -e @/opt/ptin/iam/conf/kube/ansiblevars.yaml

6) Login into IAM with default credentials

            User: super-admin
            PW: admin


## IAM - Upgrade Instructions

1) Configure vars
        
      Config File: [configmaps.yaml](automation/base/configmaps.yaml)

2) Apply Kustomize

        kubectl kustomize automation/overlays/iam | kubectl apply -f -

3) Export/Update Credentials (Needs iam-service running | Only if IAM URL changes) 

        kubectl exec --stdin --tty deployment.apps/iam-service -- ansible-playbook -vv --diff -i /opt/ptin/automation/iam/inventory/sample /opt/ptin/automation/iam/import_csv_generate_credentials.yml --skip-tags iam_yum --vault-password-file /opt/ptin/iam/conf/kube/vault-password-file -e @/opt/ptin/iam/conf/kube/ansiblevars.yaml

