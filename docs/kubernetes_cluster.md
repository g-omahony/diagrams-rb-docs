---
title: Kubernetes Cluster
parent: Examples
layout: page
nav_enabled: true
---

## Kubernetes Cluster

In this example the Digraph has a top to bottom direction as defined by the `rankdir` variable.

This code:
~~~
require 'diagrams-rb'

# Kubernetes Cluster
module Diagrams
  Digraph.new(rankdir: 'TB', ranksep: 1.1, pad: 0.1) do # rubocop:disable Metrics/BlockLength
    cluster 'CLUSTER', fontsize: '18', fontcolor: '"#326CE5"' do
      cluster 'Node 1', margin: 30 do
        node :node_n1, label: '', icon: K8s::Infra.node
        node :kubelet_n1, label: 'kubelet', icon: K8s::Controlplane.kubelet
        node :kube_proxy_n1, label: 'kube-proxy', icon: K8s::Controlplane.k_proxy
        cluster do
          node :pod1_n1, label: '', icon: K8s::Compute.pod
          node :pod2_n1, label: 'CRI', icon: K8s::Compute.pod, fontsize: '16', fontcolor: '"#326CE5"'
          node :pod3_n1, label: '', icon: K8s::Compute.pod
        end
      end

      cluster 'Node 2', margin: 30 do
        node :node_n2, label: '', icon: K8s::Infra.node
        node :kubelet_n2, label: 'kubelet', icon: K8s::Controlplane.kubelet
        node :kube_proxy_n2, label: 'kube-proxy', icon: K8s::Controlplane.k_proxy
        cluster do
          node :pod1_n2, label: 'CRI', icon: K8s::Compute.pod, fontsize: '16', fontcolor: '"#326CE5"'
        end
      end

      cluster 'CONTROL PLANE', fontsize: '18', fontcolor: '"#326CE5"' do
        node :ccm, label: 'cloud-control-manager', icon: K8s::Controlplane.c_c_m
        node :etcd, label: 'etcd', icon: K8s::Infra.etcd
        node :api, label: 'kube-api-server', icon: K8s::Controlplane.api
        node :sched, label: 'scheduler', icon: K8s::Controlplane.sched
        node :cm, label: 'Controller Manager', icon: K8s::Controlplane.c_m
      end
    end

    n1 = %i[kubelet_n1 kube_proxy_n1]
    n2 = %i[kubelet_n2 kube_proxy_n2]
    edge n1, to: :pod2_n1, constraint: 'false', rank: 'min'
    edge :kubelet_n1, to: :api, constraint: 'false'
    edge :kube_proxy_n1, to: :api, style: 'dashed', constraint: 'false'
    edge n2, to: :pod1_n2, constraint: 'false'
    edge :kubelet_n2, to: :api, constraint: 'false'
    edge :kube_proxy_n2, to: :api, style: 'dashed', constraint: 'false'
    edge :ccm, to: :api
    edge :etcd, to: :api
    edge :sched, to: :api
    edge :cm, to: :api
    edge :kubelet_n1, to: :kube_proxy_n1, style: 'invis'
    edge :kubelet_n2, to: :kube_proxy_n2, style: 'invis'
  end
end

~~~
{: .language-ruby}

will produce the following image:

![]({{ '/assets/images/k8s_cluster.png' | relative_url }})

Architecture diagram taken from the [Kubernetes documentation](https://kubernetes.io/docs/concepts/architecture/)
