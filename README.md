# supabase-postgres-k8s
A standalone Helm chart for Supabase/Postgres

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [External ConfigMap](#external-configmap)

## Requirements
- Kubernetes 1.19+
- Helm 3.0+

## Installation

```bash
# Add the repository (if applicable)
helm repo add supabase https://supabase.github.io/supabase-postgres-k8s
helm repo update

# Install the chart
helm install my-postgres ./supabase-postgres
```

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `configMapName` | Name of the external ConfigMap containing postgresql.conf | `""` (uses image default) |
| `configKey` | Key in the ConfigMap containing postgresql.conf | `"postgresql.conf"` |
| `variant` | Database engine variant ("postgres", "orioledb") | `"postgres"` |
| `architecture.type` | Deployment architecture ("standalone", "ha") | `"standalone"` |
| `architecture.standalone.replicas` | Number of replicas for standalone mode (fixed at 1) | `1` |
| `architecture.ha.replicas` | Number of replicas in HA cluster | `3` |
| `image.pullPolicy` | Container image pull policy | `IfNotPresent` |
| `storage.size` | Size of the data volume | `"10Gi"` |
| `storage.className` | Storage class for the PVC | `""` (uses default) |
| `storage.subPath` | SubPath within the volume to mount | `"data"` |
| `auth.existingSecret` | Name of existing secret for password | `""` (creates new secret) |

## ConfigMap

The chart provides `postgresql.conf` via a ConfigMap. By default, the chart assumes the Supabase Postgres image includes `postgresql.conf` at `/etc/postgresql/postgresql.conf`. 

If you need to customize the configuration, you can provide an external ConfigMap:

### Creating a Custom ConfigMap

You can create a ConfigMap from a local file or a remote URL:

```bash
# From a local file
kubectl create configmap postgres-config \
  --from-file=postgresql.conf=./postgresql.conf

# From a remote URL
kubectl create configmap postgres-config \
  --from-file=postgresql.conf=https://raw.githubusercontent.com/postgres/postgres/master/postgresql.conf.sample
```

Or create via YAML:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-config
data:
  postgresql.conf: |
    listen_addresses = '*'
    port = 5432
    max_connections = 100
```

If using a different ConfigMap name, specify it during install:

```bash
helm install my-postgres ./supabase-postgres \
  --set configMapName=my-custom-config
```

Or provide a custom ConfigMap for HA deployments:

```bash
helm install my-postgres ./supabase-postgres \
  --set configMapName=my-custom-config \
  --set architecture.type=ha \
  --set architecture.ha.replicas=3
```
