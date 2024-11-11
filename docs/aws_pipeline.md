---
title: AWS Data Pipeline
parent: Examples
layout: page
nav_enabled: true
---

## AWS Data Pipeline

In this example the Digraph has a left to right direction as defined by the `rankdir` variable. The separation between the nodes is defined by the `ranksep` parameter and minimal border padding around the image by `pad`.

This code:
~~~
require 'diagrams-rb'

module Diagrams
  Digraph.new(rankdir: 'LR', ranksep: 1, pad: 0.5) do
    node :elb, label: 'Elastic Load Balancing', icon: Aws::Network.elastic_load_balancing
    node :ecs, label: 'Amazon ECS', icon: Aws::Compute.elastic_container_service
    cluster margin: 10, style: 'dotted' do
      node :kafka, label: 'Amazon Managed\nStreaming of\nApache Kafka', icon: Aws::Analytics.managed_streaming_for_kafka
      node :kinesis, label: 'Amazon Kenisis\nData Streams', icon: Aws::Analytics.kinesis_data_streams
      node :s3, label: 'Amazon S3', icon: Aws::Storage.simple_storage_service_s3
    end
    node :emr, label: 'Amazon EMR Serverless', icon: Aws::Analytics.emr
    node :redshift, label: 'Amazon Redshift', icon: Aws::Analytics.redshift
    node :quicksight, label: 'Amazon QuickSight', icon: Aws::Analytics.quicksight

    streams = %i[kafka kinesis]
    edge :elb, to: :ecs
    edge :ecs, to: streams, style: 'dashed'
    edge :ecs, to: :s3, style: 'dashed'
    edge streams, to: :s3
    edge :s3, to: :emr
    edge :emr, to: :redshift
    edge :redshift, to: :quicksight
  end
end
~~~
{: .language-ruby}

will produce the following image:

![]({{ '/assets/images/data_pipeline.png' | relative_url }})

This can be extended to a more complex example which illustrates the use of some of the additional Graphviz attributes:

~~~

require 'diagrams-rb'

module Diagrams
  Digraph.new(rankdir: 'LR', ranksep: 1.1, pad: 0.2) do # rubocop:disable Metrics/BlockLength
    node :admin, label: 'Admin', icon: Aws::General.user
    cluster 'AWS Cloud', margin: 30 do # rubocop:disable Metrics/BlockLength
      node :cloudfront, label: 'Amazon CloudFront', icon: Aws::Network.cloudfront
      node :apigateway, label: 'Amazon API Gateway', icon: Aws::Mobile.api_gateway
      node :s3_a, label: 'Amazon S3', icon: Aws::Storage.simple_storage_service_s3
      node :lambda_a, label: 'Amazon Lambda', icon: Aws::Compute.lambda
      node :dynamodb, label: 'Amazon DynamoDB', icon: Aws::Database.dynamodb
      cluster 'OpenID Connect', style: 'dashed' do
        node :cognito, label: 'Amazon Cognito\nUser Pool', icon: Aws::Security.cognito
      end
      cluster 'Pipeline Orchestration', margin: 50, style: 'dotted' do
        node :pipeline_orchestration, label: '', icon: nil, style: 'invis'
        node :cloudformation, label: 'Amazon CloudFormation', icon: Aws::Management.cloudformation
        node :stepfunctions, label: 'Amazon Step Functions', icon: Aws::Integration.step_functions
        node :eventbridge, label: 'Amazon EventBridge', icon: Aws::Integration.eventbridge
        node :lambda_b, label: 'Amazon Lambda', icon: Aws::Compute.lambda
      end
      cluster 'Data Pipeline', margin: 30, style: 'dotted' do
        node :data_pipeline, label: '', icon: nil, style: 'invis'
        node :elb, label: 'Elastic Load Balancing', icon: Aws::Network.elastic_load_balancing
        node :ecs, label: 'Amazon ECS', icon: Aws::Compute.elastic_container_service
        cluster margin: 10, style: 'dotted' do
          node :kafka, label: 'Amazon Managed\nStreaming of\nApache Kafka', icon: Aws::Analytics.managed_streaming_for_kafka
          node :kinesis, label: 'Amazon Kenisis\nData Streams', icon: Aws::Analytics.kinesis_data_streams
          node :s3_b, label: 'Amazon S3', icon: Aws::Storage.simple_storage_service_s3
        end
        node :emr, label: 'Amazon EMR Serverless', icon: Aws::Analytics.emr
        node :redshift, label: 'Amazon Redshift', icon: Aws::Analytics.redshift
        node :quicksight, label: 'Amazon QuickSight', icon: Aws::Analytics.quicksight
      end
    end

    streams = %i[kafka kinesis]
    edge :admin, to: :cloudfront
    edge :cloudfront, to: :apigateway
    edge :apigateway, to: :cognito, taillabel: 'Authenticate', labeldistance: 0.5, arrowhead: 'none'
    edge :s3_a, to: :cognito, label: 'Login', lhead: 'cluster_OpenID_Connect'
    edge :apigateway, to: :lambda_a
    edge :cloudfront, to: :s3_a
    edge :lambda_a, to: :cloudformation, taillabel: 'Execute', labeldistance: 0.5, arrowhead: 'none'
    edge :lambda_a, to: :dynamodb
    edge :lambda_b, to: :dynamodb
    edge :elb, to: :ecs
    edge :ecs, to: streams, style: 'dashed'
    edge :ecs, to: :s3_b, style: 'dashed'
    edge streams, to: :s3_b
    edge :s3_b, to: :emr
    edge :emr, to: :redshift
    edge :redshift, to: :quicksight
    edge :cloudformation, to: :stepfunctions, style: 'invis'
    edge :stepfunctions, to: :eventbridge, style: 'invis'
    edge :eventbridge, to: :lambda_b, style: 'invis'
    edge :pipeline_orchestration, to: :data_pipeline
  end
end
~~~
{: .language-ruby}

will produce the following image:

![]({{ '/assets/images/data_pipeline_complex.png' | relative_url }})

Architecture diagram taken from the [AWS documentation](https://docs.aws.amazon.com/solutions/latest/clickstream-analytics-on-aws/architecture-overview.html)
