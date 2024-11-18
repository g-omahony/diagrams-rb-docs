---
title: Azure Machine Learning
parent: Examples
layout: page
nav_enabled: true
---

## Azure Machine Learning

This code:
~~~
require 'diagrams-rb'

module Diagrams
  Digraph.new(rankdir: 'LR', ranksep: 1.1, pad: 0.2) do
    node :acr, label: 'Azure\nContainer Registry', icon: Azure::Compute.container_registries
    node :amlc, label: 'Azure Machine\nLearning Compute', icon: Azure::Compute.vm_scale_sets
    node :asb, label: 'Azure\nStorage Blobs', icon: Azure::Database.blob_storage
    node :amls, label: 'Azure Machine\nLearning Service', icon: Azure::Ai.machine_learning
    node :dsvm, label: 'Data Science\nVirtual Machine', icon: Azure::Compute.vm

    edge :dsvm, to: :amls, taillabel: '"Training, test data & script"'
    edge :amls, to: :dsvm, label: '"Training Results"'
    edge :amls, to: :amlc, taillabel: '"Script execution\ncommands"'
    edge :amlc, to: :amls, taillabel: 'Status'
    edge :amlc, to: :asb, dir: 'both'
    edge :amls, to: :asb, dir: 'both'
    edge :amlc, to: :acr, dir: 'both'
    edge :amls, to: :acr, dir: 'both', label: '"Docker Container"'
    edge :asb, to: :acr, style: 'invis'
    edge :acr, to: :dsvm, style: 'invis'
  end
end
~~~
{: .language-ruby}

will produce the following image:

![]({{ '/assets/images/azure_machine_learning.png' | relative_url }})

Architecture diagram taken from the [Azure documentation](https://azure.microsoft.com/en-us/solutions/ai/data-scientist-resources)

