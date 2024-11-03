---
layout: page
title: "Introduction"
nav_order: 0
---

# Introduction

This Ruby-based DSL allows you to create complex Graphviz DOT diagrams programmatically. With this DSL, you can define nodes, edges, and nested clusters that represent relationships and hierarchies visually.

### Features

- Define nodes with attributes like labels, images, shapes, and sizes.
- Easily create connections (edges) between nodes.
- Define nested clusters to group nodes hierarchically.
- Generates a Graphviz `.dot` file, compatible with Graphviz tools for rendering diagrams.

### Example DOT File Generated

The following Ruby code:

```Ruby

require 'diagrams-rb'

module Diagrams
  Digraph.new(rankdir: 'LR', format: 'dot') do
    node :client, label: 'Client', icon: Onprem::Client.client, labelloc: 'c'
    cluster 'AWS Cloud' do
      node :sqs, label: 'Amazon SQS', icon: Aws::Integration.simple_queue_service_sqs
      node :lambda, label: 'AWS Lambda', icon: Aws::Compute.lambda
    end
    edge :client, to: :sqs, dir: 'both'
    edge :sqs, to: :lambda, dir: 'back'
  end
end

```

will generate the following `.dot` file:

~~~
digraph G {
	graph [bb="0,0,427,159",
		fontcolor="#2D3436",
		fontname="Sans-Serif",
		fontsize=15,
		nodesep=0.60,
		pad=2.0,
		rankdir=LR,
		ranksep=0.75,
		splines=ortho
	];
	node [label="\N"];
	subgraph cluster_AWS_Cloud {
		graph [bb="147,8,419,151",
			bgcolor="#E5F5FD",
			label="AWS Cloud",
			labeljust=l,
			lheight=0.24,
			lp="196.5,138.5",
			lwidth=1.15,
			pencolor="#AEB6BE",
			shape=box,
			style=rounded
		];
		sqs	[fixedsize=true,
			fontcolor="#2D3436",
			fontname="Sans-Serif",
			fontsize=13,
			height=1.4028,
			image="~/.gem/ruby/3.1/gems/diagrams-rb-0.1.0/resources/aws/integration/simple-queue-service-sqs.png",
			imagescale=true,
			label="Amazon SQS",
			labelloc=b,
			penwidth=0,
			pos="205.5,67",
			shape=box,
			style=rounded,
			width=1.4028];
		lambda	[fixedsize=true,
			fontcolor="#2D3436",
			fontname="Sans-Serif",
			fontsize=13,
			height=1.4028,
			image="~/.gem/ruby/3.1/gems/diagrams-rb-0.1.0/resources/aws/compute/lambda.png",
			imagescale=true,
			label="AWS Lambda",
			labelloc=b,
			penwidth=0,
			pos="360.5,67",
			shape=box,
			style=rounded,
			width=1.4028];
		sqs -> lambda	[color="#7B8894",
			dir=back,
			fontcolor="#2D3436",
			fontname="Sans-Serif",
			fontsize=13,
			pos="s,256.25,67 266.25,67 266.25,67 309.9,67 309.9,67"];
	}
	client	[fixedsize=true,
		fontcolor="#2D3436",
		fontname="Sans-Serif",
		fontsize=13,
		height=1.4028,
		image="~/.gem/ruby/3.1/gems/diagrams-rb-0.1.0/resources/onprem/client/client.png",
		imagescale=true,
		label=Client,
		labelloc=c,
		penwidth=0,
		pos="50.5,67",
		shape=box,
		style=rounded,
		width=1.4028];
	client -> sqs	[color="#7B8894",
		dir=both,
		fontcolor="#2D3436",
		fontname="Sans-Serif",
		fontsize=13,
		pos="s,154.9,67 e,101.25,67 111.25,67 111.25,67 144.9,67 144.9,67"];
}
~~~
{: .language-dot}

which will produce the following image:

![]({{ '/images/aws_lambda.png' | relative_url }})
