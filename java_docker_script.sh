cat <<EOF > java_docker_script.sh
#!/bin/bash
#update and install Java
sudo apt update
sudo apt install openjdk-17-jre -y
#install Docker
sudo apt install docker.io -y
#add user to Docker group so they can
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
EOF 
chmod +x java_docker_script.sh