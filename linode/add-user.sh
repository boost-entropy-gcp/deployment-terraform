#!/bin/bash
# <UDF name="username" label="Username of new user in system" example="ubuntu"
# default="user">

if [[ -z "$1" ]]; then
	echo "Not username provided, using user"
	USERNAME=user
else
	USERNAME=$1
fi

useradd $USERNAME --create-home --user-group --shell /bin/bash --groups sudo

USER_HOME=/home/$USERNAME

mkdir -p $USER_HOME/.ssh
cp /root/.ssh/authorized_keys $USER_HOME/.ssh/
chown $USERNAME:$USERNAME $USER_HOME/.ssh/authorized_keys

cat << EOF > /etc/sudoers.d/90-cloud-init-users 
# User rules for $USERNAME
$USERNAME ALL=(ALL) NOPASSWD:ALL
EOF
