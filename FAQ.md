# Frequently Asked Questions

- [Uninstall is stuck. How do I fix it?](#uninstall-is-stuck-how-do-i-fix-it)
- [The PSAT plugin is not working](#the-psat-plugin-is-not-working)

## Uninstall is stuck. How do I fix it?

If you uninstall the spiffe csi driver manually before removing the chart, pods can still be using the driver an are unable to unmount the csi volume.

To resolve, reinstall the chart before trying to remove it again. 

## The PSAT plugin is not working

The chart requires `Projected Service Account Tokens` which has to be enabled on your k8s api server. In most cases this is already done for you.

> **Note**: This is enabled by default with newer versions as shown by the existence of:
>
>        - --service-account-issuer
>        - --service-account-key-file
>        - --service-account-signing-key-file

See [Service Account Token Volume Projection](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#serviceaccount-token-volume-projection) in the Kubernetes docs for more details.

To enable Projected Service Account Tokens on Docker for Mac/Windows run the following
command to SSH into the Docker Desktop K8s VM.

```bash
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```
Then add the following to `/etc/kubernetes/manifests/kube-apiserver.yaml`
```yaml
spec:
  containers:
    - command:
        - kube-apiserver
        - --api-audiences=api,spire-server
        - --service-account-issuer=api,spire-agent
        - --service-account-key-file=/run/config/pki/sa.pub
        - --service-account-signing-key-file=/run/config/pki/sa.key
```
