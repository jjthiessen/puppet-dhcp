# == Define: dhcp::host
#
define dhcp::host (
  $ip,
  $mac,
  $options = {},
  $comment='',
  $ignored = false,
  $ddns_hostname = $name,
) {

  validate_string($ip, $mac, $comment, $ddns_hostname)
  validate_hash($options)
  validate_bool($ignored)

  $host = $name

  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_host_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.host.erb'),
    order   => '10',
  }
}
