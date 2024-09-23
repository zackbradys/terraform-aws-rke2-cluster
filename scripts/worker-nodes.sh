#!/bin/bash

# Set Variables
export DOMAIN=${DOMAIN}
export TOKEN=${TOKEN}
export vRKE2=${vRKE2}

# Apply System Settings
cat << EOF >> /etc/sysctl.conf
# Modified System Settings
vm.swappiness=0
vm.panic_on_oom=0
vm.overcommit_memory=1
kernel.panic=10
kernel.panic_on_oops=1
vm.max_map_count = 262144
net.ipv4.ip_local_port_range=1024 65000
net.core.somaxconn=10000
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_fin_timeout=15
net.core.somaxconn=4096
net.core.netdev_max_backlog=4096
net.core.rmem_max=16777216
net.core.wmem_max=16777216
net.ipv4.tcp_max_syn_backlog=20480
net.ipv4.tcp_max_tw_buckets=400000
net.ipv4.tcp_no_metrics_save=1
net.ipv4.tcp_rmem=4096 87380 16777216
net.ipv4.tcp_syn_retries=2
net.ipv4.tcp_synack_retries=2
net.ipv4.tcp_wmem=4096 65536 16777216
net.ipv4.neigh.default.gc_thresh1=8096
net.ipv4.neigh.default.gc_thresh2=12288
net.ipv4.neigh.default.gc_thresh3=16384
net.ipv4.tcp_keepalive_time=600
net.ipv4.ip_forward=1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
fs.inotify.max_user_instances=8192
fs.inotify.max_user_watches=1048576
EOF
sysctl -p > /dev/null 2>&1

# Install Packages
yum install -y iptables container-selinux libnetfilter_conntrack libnfnetlink libnftnl policycoreutils-python-utils cryptsetup
yum install -y nfs-utils iscsi-initiator-utils; yum install -y zip zstd tree jq

# Modify Settings
echo "InitiatorName=$(/sbin/iscsi-iname)" > /etc/iscsi/initiatorname.iscsi && systemctl enable --now iscsid
systemctl stop firewalld; systemctl disable firewalld; systemctl stop nm-cloud-setup; systemctl disable nm-cloud-setup; systemctl stop nm-cloud-setup.timer; systemctl disable nm-cloud-setup.timer
echo -e "[keyfile]\nunmanaged-devices=interface-name:cali*;interface-name:flannel*" > /etc/NetworkManager/conf.d/rke2-canal.conf

# Setup RKE2 Agent
mkdir -p /etc/rancher/rke2/

# Configure RKE2 Config
cat << EOF >> /etc/rancher/rke2/config.yaml
profile: cis-1.23
selinux: true
write-kubeconfig-mode: 0600
kube-apiserver-arg:
- authorization-mode=RBAC,Node
kubelet-arg:
- protect-kernel-defaults=true
- read-only-port=0
- authorization-mode=Webhook
server: https://$DOMAIN:9345
token: $TOKEN
EOF

# Download and Install RKE2 Agent
curl -sfL https://get.rke2.io | INSTALL_RKE2_CHANNEL=$vRKE2 INSTALL_RKE2_TYPE=agent sh -

# Enable and Start RKE2 Agent
systemctl enable rke2-agent.service && systemctl start rke2-agent.service

# Verify End of Script
date >> /opt/rancher/COMPLETED
