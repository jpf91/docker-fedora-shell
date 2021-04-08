# https://fedoramagazine.org/building-smaller-container-images/
FROM docker.io/jpf91/ipa-client

RUN microdnf install \
    zsh rsync openssh-clients openssh-server \
    findutils hostname iputils \
    sudo dnf && \
    microdnf clean all

RUN systemctl disable rdisc.service sshd.socket

# Base packages
RUN dnf group install 'Fedora Server Edition' 'C Development Tools and Libraries' 'D Development Tools and Libraries' 'D Development Tools and Libraries' 'Development Tools' 'System Tools'

# Keys are in key folder, but ipa client generates some in /etc/ssh if they are not there...
RUN ln -s /etc/ssh/keys/ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key && \
    ln -s /etc/ssh/keys/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub && \
    ln -s /etc/ssh/keys/ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key && \
    ln -s /etc/ssh/keys/ssh_host_ed25519_key.pub /etc/ssh/ssh_host_ed25519_key.pub && \
    ln -s /etc/ssh/keys/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key && \
    ln -s /etc/ssh/keys/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
