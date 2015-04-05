# Class: motd
#
# This module manages the /etc/motd file using a template
#
# Parameters:
#
# [*template*]
#   Sets the path to the template to use as content for main motd file
# [*$show_classes*]
#   Disable ehxibition of classes used by puppet
#   
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
  $show_classes = true,
) {

  validate_bool($puppet_info, $hardware_info, $show_classes)

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
