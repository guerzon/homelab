
# Kubeadm

## Install

## Tools

### PostgreSQL

```bash
kubectl create ns postgres
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

Storage:
```bash
cat <<EOF > 1.md |---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: postgresql-pv
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"
```

```bash
helm upgrade -i -n postgres postgres \
  oci://registry-1.docker.io/bitnamicharts/postgresql
```
