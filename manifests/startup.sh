# Start server
echo "Starting apache server"
sudo apachectl start
sudo setenforce 0
sudo iptables -F

echo "==========================="
echo "MACHINE IS UP AND RUNNING"
echo "==========================="
