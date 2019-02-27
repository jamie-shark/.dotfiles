sudo apt update && sudo apt upgrade -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
sudo apt update && sudo apt install terminator
export DISPLAY=:0.0
sudo sed -i 's$<listen>.*</listen>$<listen>tcp:host=localhost,port=0</listen>$' /etc/dbus-1/session.conf
terminator
