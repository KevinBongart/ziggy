git node[:dotfiles][:dotfiles_directory] do
  repository node[:dotfiles][:repository]
  reference node[:dotfiles][:branch]
  action :sync
end

bash "copy_dotfiles" do
  cwd node[:dotfiles][:home_directory]
  code <<-EOH
    cp #{node[:dotfiles][:dotfiles_directory]}/.zshrc     #{node[:dotfiles][:home_directory]}
    cp #{node[:dotfiles][:dotfiles_directory]}/.rspec     #{node[:dotfiles][:home_directory]}
    cp #{node[:dotfiles][:dotfiles_directory]}/.gitconfig #{node[:dotfiles][:home_directory]}
  EOH
end

directory node[:dotfiles][:dotfiles_directory] do
  action :delete
  recursive true
end

bash "make_zsh_default_shell" do
  cwd node[:dotfiles][:home_directory]
  code "chsh -s `which zsh`"
end
