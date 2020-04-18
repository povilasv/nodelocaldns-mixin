local coredns = import 'github.com/povilasv/coredns-mixin/alerts/alerts.libsonnet';
local utils = import 'lib/utils.libsonnet';

coredns {
  _config+:: {
    // selector for metrics exposed by coredns plugin
    corednsSelector: 'k8s_app="node-local-dns",name!="node-local-dns-metrics"',
    // selector for metrics exposed by nodelocaldns pod
    nodelocaldnsSelector: 'name="node-local-dns-metrics"',
    instanceLabel: 'pod',

    grafanaDashboardIDs: {
      'nodelocaldns.json': 'ietaejooPhahp9lohc3azeuv7eiv0bootohN5toh',
    },

    pluginNameLabel: 'name',
    kubernetesPlugin: false,
    grafana: {
      dashboardNamePrefix: '',
      dashboardTags: ['nodelocaldns-mixin'],

      // The default refresh time for all dashboards, default to 10s
      refresh: '10s',
    },
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
