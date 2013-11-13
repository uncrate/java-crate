return if skip_unsupported_platform

include_recipe "dmg"

node['java']['jdk_versions'].each do |jdk_version|
  if jdk_version == '6'
    download_path = node['java']['jdk'][jdk_version]['mac_os_x']['url']
    file_name_no_extension = File.basename(download_path, ".*")

    dmg_package "JavaForOSX" do
      dmg_name file_name_no_extension
      type 'pkg'
      volumes_dir "Java for OS X 2013-005"
      source node['java']['jdk']['6']['mac_os_x']['url']
      owner node['uncrate']['user']
      action :install
    end
  else
    if node['java']['oracle']['accept_oracle_download_terms']
      cookie = "gpw_e24=http%3A%2F%2Fwww.oracle.com"
      download_path = node['java']['jdk'][jdk_version]['mac_os_x']['url']
      file_name = File.basename(download_path)
      file_name_no_extension = File.basename(download_path, ".*")
      description = "download oracle tarball straight from the server"

      execute "downloading oracle dmg straight from the source" do
        cwd Chef::Config['file_cache_path']
        command "curl -b #{cookie} -O -L '#{download_path}'"
        not_if { ::File.exists?("#{Chef::Config['file_cache_path']}/#{file_name}")}
      end    

      directory "#{ENV['HOME']}"

      dmg_package "JDK 7 Update 45" do
        dmg_name file_name_no_extension
        type 'pkg'
        volumes_dir "JDK 7 Update 45"
        action :install
      end
    else
      Chef::Application.fatal!("You must set the attribute node['java']['oracle']['accept_oracle_download_terms'] to true if you want to download directly from the oracle site!")
    end
  end
end
