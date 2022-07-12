cat << 'EOF' >> $HOME/.ssh/config

Host ${hostname}
  HostName ${host_ip}
  User ${user}
  IdentityFile ${identityfile}
EOF