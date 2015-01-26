# Class: motd
#
# This module manages the /etc/motd file using a template
#
# Parameters:
#
# [*template*]
#   Sets the path to the template to use as content for main motd file
#   If defined, main motd file has: content => content("$template")
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  include motd
#
# [Remember: No empty lines between comments and class definition]
class motd(
  $puppet_info = true,
  $hardware_info = true,
  $template = 'motd/motd.erb',
) {

  validate_bool($puppet_info, $hardware_info)

  $motd_group = $::operatingsystem ? {
    solaris => 'sys',
    default => '0',
  }

  file { '/etc/motd':
    ensure  => file,
    content => template($template),
    owner   => '0',
    group   => $motd_group,
    mode    => '0644',
  }
}
