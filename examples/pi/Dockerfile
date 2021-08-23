FROM debian:buster as builder

RUN apt update && apt install -y --no-install-recommends \
			g++ \
			libopenmpi-dev \
			&& rm -rf /var/lib/apt/lists/*

COPY pi.cc /src/pi.cc
RUN mpic++ /src/pi.cc -o /pi


FROM debian:buster

RUN apt update && apt install -y --no-install-recommends \
			openmpi-bin \
			openssh-server \
			openssh-client \
			&& rm -rf /var/lib/apt/lists/*
RUN sed -i 's/[ #]\(.*StrictHostKeyChecking \).*/ \1no/g' /etc/ssh/ssh_config

# Add priviledge separation directoy to run sshd as root.
RUN mkdir -p /var/run/sshd

RUN useradd -m mpiuser
# Add capability and other configurations to run sshd as non-root.
RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/sbin/sshd
COPY --chown=mpiuser sshd_config /opt/ssh/sshd_config
RUN chown mpiuser:mpiuser /opt/ssh

WORKDIR /home/mpiuser
COPY --from=builder /pi /opt/mpi/pi