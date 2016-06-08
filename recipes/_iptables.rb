# First pull in the global rules and "groups"
include_recipe 'sendgrid_iptables'
rfc1918 = node['sendgrid_iptables']['rfc1918']

simple_iptables_rule 'rabbitmq_in' do
  table 'raw'
  direction 'PREROUTING'
  rule [
    "--proto tcp --dport 5671 --source #{rfc1918}",
    "--proto tcp --dport 5672 --source #{rfc1918}",
    "--proto tcp --dport 4369 --source #{rfc1918}",
    "--proto tcp --dport 25672 --source #{rfc1918}"
  ]
  jump 'NOTRACK'
end

simple_iptables_rule 'rabbitmq_out' do
  table 'raw'
  direction 'OUTPUT'
  rule [
    "--proto tcp --sport 5671 --source #{rfc1918}",
    "--proto tcp --sport 5672 --source #{rfc1918}",
    "--proto tcp --sport 4369 --source #{rfc1918}",
    "--proto tcp --sport 25672 --source #{rfc1918}"
  ]
  jump 'NOTRACK'
end

simple_iptables_rule 'rabbitmqadmin' do
  chain 'INPUT'
  rule "--proto tcp --dport 15672 --source #{rfc1918}"
  jump 'ACCEPT'
end
