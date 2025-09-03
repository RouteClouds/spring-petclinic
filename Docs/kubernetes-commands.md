# Kubernetes Commands for the PetClinic Project

This document provides a list of useful `kubectl` commands for managing the PetClinic application on the EKS cluster.

## Connecting to the EKS Cluster

To connect to the EKS cluster, you need to update your kubeconfig file. You can do this by running the following command:

```bash
aws eks update-kubeconfig --name petclinic-cluster --region us-east-1
```

This command will automatically configure your `~/.kube/config` file with the necessary credentials to connect to the cluster.

## Viewing Resources

### Pods

To view the status of the application pods, run the following command:

```bash
kubectl get pods
```

You should see a pod with a name like `petclinic-xxxxxxxxxx-xxxxx` in the `Running` state.

### Services

To view the status of the application service, run the following command:

```bash
kubectl get services
```

You should see a service named `petclinic` with a `LoadBalancer` type.

### Deployments

To view the status of the application deployment, run the following command:

```bash
kubectl get deployments
```

### Secrets

To view the database secrets, run the following command:

```bash
kubectl get secrets
```

## Interacting with Pods

### Getting a Shell to a Running Pod

To get a shell to a running pod, you first need to get the name of the pod by running `kubectl get pods`. Then, you can use the following command to get a shell to the pod:

```bash
kubectl exec -it <pod-name> -- /bin/bash
```

### Viewing the Logs of a Pod

To view the logs of a pod, you first need to get the name of the pod by running `kubectl get pods`. Then, you can use the following command to view the logs:

```bash
kubectl logs <pod-name>
```

## Applying Changes

To apply changes to the Kubernetes manifests, you can use the following command:

```bash
kubectl apply -f k8s/
```

This will apply all the manifests in the `k8s` directory to the cluster.
