local coredns = import 'coredns-mixin/mixin.libsonnet';

coredns {
  _config+:: {
    // selector for metrics exposed by coredns plugin
    corednsSelector: 'k8s_app="node-local-dns"',
    // selector for metrics exposed by nodelocaldns pod
    nodelocaldnsSelector: 'name="node-local-dns-metrics"',
    podLabel: 'pod',
  },
}
