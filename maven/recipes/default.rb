include_recipe "java"

case node.platform
when "redhat", "centos", "fedora"
  include_recipe "jpackage"
end

package "maven2" do
  action :install
end