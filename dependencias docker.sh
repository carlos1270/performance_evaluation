sudo su

#Alterando fuso horário
tzselect

#Instalando o docker
apt update
apt install apt-transport-https ca-certificates curl software-properties-common net-tools
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt update
apt-cache policy docker-ce
apt install docker-ce
systemctl status docker

#Instalando docker compose
curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
