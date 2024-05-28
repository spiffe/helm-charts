In this introduction to SPIRE on Kubernetes you will learn how to:

* Deploy SPIRE and SPIFFE with helm in a non production ready configuration suitable for testing purposes.
* Configure a registration entry for a workload
* Fetch an x509-SVID over the SPIFFE Workload API
* Learn where to find resources for more complex installations

The steps in this guide have been tested on these versions:
- Kubernetes: 1.26
- Helm Chart: 0.10.1
- App: 1.7.0

{{< info >}}
If you are using Minikube to run this tutorial you should specify some special flags as described [here](#considerations-when-using-minikube).

# Obtain the Required Files

This guide requires a number of **.yaml** files. To obtain this directory of files clone **https://github.com/spiffe/spire-tutorials** and obtain the **.yaml** files from the **spire-tutorials/k8s/quickstart-helm** subdirectory. Remember to run all kubectl commands in the directory in which those files reside.

Set up a Kubernetes environment on a provider of your choice or use Minikube. Link the Kubernetes environment to the kubectl command.

# Install with Helm
    ```bash
    $ helm repo add spiffe https://spiffe.github.io/helm-charts/
    $ helm update
    $ helm -n spire install spire spiffe/spire -f values.yaml --create-namespace
    ```
# Verify
## Verify Namespace
 Run the following command and verify that *spire* is listed in the output:

    ```bash
    $ kubectl get namespaces
    ```
  ## Verify Statefulset
 This creates a statefulset called **spire-server** in the **spire** namespace and starts up a **spire-server** pod, as demonstrated in the output of the following commands:

```bash
$ kubectl get statefulset --namespace spire
@@ -107,26 +72,8 @@ $ kubectl get services --namespace spire
NAME           TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
spire-server   NodePort   10.107.205.29   <none>        8081:30337/TCP   88m

## Verify Agent
 This creates a daemonset called **spire-agent** in the **spire** namespace and starts up a **spire-agent** pod along side **spire-server**, as demonstrated in the output of the following commands:

```bash
$ kubectl get daemonset --namespace spire

As a daemonset, you'll see as many **spire-agent** pods as you have nodes.

# Register Workloads

In order to enable SPIRE to perform workload attestation -- which allows the agent to identify the workload to attest to its agent -- you must register the workload in the server. This tells SPIRE how to identify the workload and which SPIFFE ID to give it.

1. Create a new registration entry for the node, specifying the SPIFFE ID to allocate to the node:
> **Note** change -selector k8s_sat:cluster:demo-cluster to your cluster name

    ```shell
    $ kubectl exec -n spire spire-server-0 -- \

In this section, you configure a workload container to access SPIRE. Specifically, you are configuring the workload container to access the Workload API UNIX domain socket.

The **client-deployment.yaml** file configures a no-op container using the **spire-k8s** docker image used for the server and agent. Examine the `volumeMounts` and `volumes configuration` stanzas to see how the UNIX domain `spire-agent.sock` is bound in.

You can test that the agent socket is accessible from an application container by issuing the following commands:
