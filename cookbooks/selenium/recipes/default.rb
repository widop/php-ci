include_recipe 'java::default'

package 'unzip'

node['selenium']['bindings'].each do |lang,ver|
  case lang
  when 'python'
    include_recipe 'python'

    python_pip 'selenium' do
      version ver
      action :install
    end
  when 'ruby'
    gem_package 'selenium' do
      version ver
      action :install
    end
  end
end
