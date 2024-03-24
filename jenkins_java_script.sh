cat <<EOF > Jenkins_java_script.sh
#!/bin/bash
#update and install Java
sudo apt update
sudp apt install openjdk-17-jre -y
#install Jenkins    
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install jenkins -y
sudo apt update
sudo systemctl start jenkins
sudo systemctl enable jenkins
EOF 
chmod +x jenkins_java_script.sh