return if skip_unsupported_platform

if node['java']['jdk_versions'].nil? || node['java']['jdk_versions'].empty?
  override['java']['jdk_versions'] = [node['java']['jdk_version']]
end

case node['platform']
when "debian", "ubuntu"
  include_recipe java
when "mac_os_x"
  include_recipe "java-crate::default_mac_os_x"
end
