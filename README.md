# Prometheus Monitoring Mixin for NodeLocalDNS Cache
[![CircleCI](https://circleci.com/gh/povilasv/nodelocaldns-mixin/tree/master.svg?style=shield)](https://circleci.com/gh/povilasv/nodelocaldns-mixin)

A set of Grafana dashboards & Prometheus alerts for Node Local DNS Cache.

Example of generated alerts is located in [example/prometheus_alerts.yaml](https://github.com/povilasv/nodelocaldns-mixin/blob/master/example/prometheus_alerts.yaml)

## How to use

This mixin is designed to be vendored into the repo with your infrastructure config.
To do this, use [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler):


## Generate config files

You can manually generate the alerts, dashboards and rules files, but first you
must install some tools:

```
$ go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
$ brew install jsonnet
```

Then, grab the mixin and its dependencies:

```
$ git clone https://github.com/povilasv/nodelocaldns-mixin
$ cd nodelocaldns-mixin
$ jb install
```

Finally, build the mixin:

```
$ make prometheus_alerts.yaml
$ make dashboards_out
```

The `prometheus_alerts.yaml` file then need to passed
to your Prometheus server, and the files in `dashboards_out` need to be imported
into you Grafana server.  The exact details will depending on how you deploy your
monitoring stack.

## Background

* For more information about monitoring mixins, see this [design doc](https://docs.google.com/document/d/1A9xvzwqnFVSOZ5fD3blKODXfsat5fg6ZhnKu9LK3lB4/edit#).
* CoreDNS Prometheus metrics plugin [docs](https://github.com/coredns/coredns/tree/master/plugin/metrics)
* Kubernetes Node Local DNS Cache [blog post](https://povilasv.me/kubernetes-node-local-dns-cache/)
