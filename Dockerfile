FROM ubuntu:18.04
WORKDIR /windscribe
COPY requirements.txt .
COPY windscribe-autologin.py .
COPY entrypoint.sh . 
RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	dirmngr \
	gnupg \
	ca-certificates \
	apt-transport-https && \
	APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key adv --no-tty --keyserver keyserver.ubuntu.com --recv-key FDC247B7 && \
	echo 'deb https://repo.windscribe.com/debian buster main' > /etc/apt/sources.list.d/windscribe-repo.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends windscribe-cli iptables resolvconf- python3 python3-pip && \
	pip3 install -r requirements.txt && \
	chmod +x entrypoint.sh && \
 	rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./entrypoint.sh"]
