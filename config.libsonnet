local coredns = import 'github.com/povilasv/coredns-mixin/mixin.libsonnet';
local utils = import 'lib/utils.libsonnet';

coredns {
  _config+:: {
    // selector for metrics exposed by coredns plugin
    corednsSelector: 'k8s_app="node-local-dns"',
    // selector for metrics exposed by nodelocaldns pod
    nodelocaldnsSelector: 'name="node-local-dns-metrics"',
    podLabel: 'pod',
  },
} + {
  prometheusAlerts+::
    local addPrefix(rule) = rule {
      alert: std.strReplace(rule.alert, 'CoreDNS', 'NodeLocalDNS'),
    };
    utils.mapRuleGroups(addPrefix),
} + {
  prometheusAlerts+::
    local addTeam(rule) = rule {
      [if 'alert' in rule then 'annotations']+: {
        message: std.strReplace(rule.annotations.message, 'CoreDNS', 'NodeLocalDNS'),
      },
    };
    utils.mapRuleGroups(addTeam),
}
