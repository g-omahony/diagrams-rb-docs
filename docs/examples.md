---
layout: page
title: "Examples"
permalink: "docs/examples"
nav_order: 1
---

# Examples

The following examples illustrate how `diagrams-rb` can be used to quickly generate complex cloud architecture diagrams using the included resource icons of which a complete list can be found on the [sources](./sources.html) page.

Diagrams are composed of nodes, clusters & edges defined within the Digraph block.

The defaults set on the Digraph are:
```
pad: '2.0'
splines: 'ortho'
nodesep: '0.60'
ranksep: '0.75'
rankdir: 'TB'
fontname: 'Sans-Serif'
fontsize: '15'
fontcolor: '#2D3436'
```

These defaults can be overridden by passing as parameters when initialising the new Digraph and any of the available Graph attributes as outlined in the [documentation](https://graphviz.org/docs/graph/) can be passed in the parameter hash.

Nodes are required to de defined with a symbol identifier. All other parameters are optional and the defaults set on the node are:
```
shape: 'box'
style: 'rounded'
fixedsize: 'true'
width: '1.4'
height: '1.4'
labelloc: 'b'
imagescale: 'true'
penwidth: '0'
fontname: 'Sans-Serif'
fontsize: '13'
fontcolor: '#2D3436'
```
These defaults can be overridden in the same manner as the Digraph by passing as parameters when creating the new node and any of the available Node attributes as outlined in the [documentation](https://graphviz.org/docs/nodes/) can be passed in the parameter hash. The signature of the node method is ```id, label: '', icon: nil, **kwargs``` so the attributes should be passed accordingly. Node icons can be found on the [sources](./sources.html) page.

Clusters can be defined with an optional label and the defaults are:
```
shape: 'box'
style: 'rounded'
labeljust: 'l'
pencolor: '#AEB6BE'
```
Any of the available Cluster attributes as outlined in the [documentation](https://graphviz.org/docs/clusters/) can be passed in the parameter hash. The signature of the cluster method is ```label = '', **kwargs``` so the attributes should be passed accordingly.

Edges are a node symbol/s to another node symbol/s. The edge defaults are:
```
color: '#7B8894'
fontcolor: '#2D3436'
fontname: 'Sans-Serif'
fontsize: '13'
```
Any of the available Edge attributes as outlined in the [documentation](https://graphviz.org/docs/edges/) can be passed in the parameter hash. The signature of the edge method is ```from, to:, **kwargs``` so the attributes should be passed accordingly.

The following examples illustrates their usage.

