# remove ubuntu-bionic entry
sed -e '/^.*ubuntu-bionic.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.60.11  controller-1
192.168.60.12  controller-2
192.168.60.13  controller-3
EOFgit