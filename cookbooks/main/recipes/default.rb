git "/root/.oh-my-zsh" do
  repository "git://github.com/robbyrussell/oh-my-zsh.git"
  action :sync
end

git node[:main][:dotfiles_directory] do
  repository node[:main][:repository]
  reference node[:main][:branch]
  action :sync
end

bash "copy_main" do
  cwd node[:main][:home_directory]
  code <<-EOH
    cp #{node[:main][:dotfiles_directory]}/.zshrc     #{node[:main][:home_directory]}
    cp #{node[:main][:dotfiles_directory]}/.rspec     #{node[:main][:home_directory]}
    cp #{node[:main][:dotfiles_directory]}/.gitconfig #{node[:main][:home_directory]}
  EOH
end

directory node[:main][:dotfiles_directory] do
  action :delete
  recursive true
end

bash "make_zsh_default_shell" do
  cwd node[:main][:home_directory]
  code "chsh -s `which zsh`"
end
