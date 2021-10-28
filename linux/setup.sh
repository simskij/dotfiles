xargs sudo add-apt-repository -y <repos.txt
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D1742AD60D811D58 

sudo apt update
xargs sudo apt install -y <packages.txt

sudo systemctl mask \
  suspend.target \
  hibernate.target \
  hybrid-sleep.target
