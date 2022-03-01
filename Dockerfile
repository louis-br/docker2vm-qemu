FROM alpine:latest
RUN apk add --no-cache linux-lts
RUN echo "root:root" | chpasswd
RUN apk add --no-cache alpine-conf udev openrc bash vim nano curl gnupg
RUN rc-update add udev sysinit && rc-update add hwdrivers sysinit
RUN sed -i 's/tty1.*/tty1::respawn:\/entrypoint.sh/' /etc/inittab
RUN apk add --no-cache openssh qemu-system-x86_64
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "X11Forwarding yes" >> /etc/ssh/sshd_config && \
    echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config
RUN rc-update add sshd default
RUN wget -O - https://tailscale.com/install.sh | sh
COPY overlayRoot.sh /sbin/
COPY curl.key /curl.key
COPY tailscale-url/curl.sh /curl.sh
COPY entrypoint.sh /entrypoint.sh